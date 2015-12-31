From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: dice: split subaddress check from
	category check
Date: Thu, 31 Dec 2015 13:58:11 +0900
Message-ID: <1451537894-28366-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1451537894-28366-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C16C261A0D
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 05:58:24 +0100 (CET)
In-Reply-To: <1451537894-28366-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Before allocating an instance of sound card, ALSA dice driver checks
chip_ID_hi in Bus information block of Config ROM, then also checks
subaddresses. The former operation reads cache of Config ROM in Linux
FireWire subsystem, while the latter operation sends read transaction.
The latter can be merged into initialization of transaction system.

This commit splits these two operations to reduce needless transactions
in probe processing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-transaction.c | 90 ++++++++++++++++++++++++++--------
 sound/firewire/dice/dice.c             | 72 +++------------------------
 2 files changed, 78 insertions(+), 84 deletions(-)

diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index aee7461..fdb7841 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -331,39 +331,60 @@ int snd_dice_transaction_reinit(struct snd_dice *dice)
 	return register_notification_address(dice, false);
 }
 
-int snd_dice_transaction_init(struct snd_dice *dice)
+static int get_subaddrs(struct snd_dice *dice)
 {
-	struct fw_address_handler *handler = &dice->notification_handler;
+	static const int min_values[10] = {
+		10, 0x64 / 4,
+		10, 0x18 / 4,
+		10, 0x18 / 4,
+		0, 0,
+		0, 0,
+	};
 	__be32 *pointers;
+	__be32 version;
+	u32 data;
+	unsigned int i;
 	int err;
 
-	/* Use the same way which dice_interface_check() does. */
-	pointers = kmalloc(sizeof(__be32) * 10, GFP_KERNEL);
+	pointers = kmalloc_array(ARRAY_SIZE(min_values), sizeof(__be32),
+				 GFP_KERNEL);
 	if (pointers == NULL)
 		return -ENOMEM;
 
-	/* Get offsets for sub-addresses */
+	/*
+	 * Check that the sub address spaces exist and are located inside the
+	 * private address space.  The minimum values are chosen so that all
+	 * minimally required registers are included.
+	 */
 	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
-				 DICE_PRIVATE_SPACE,
-				 pointers, sizeof(__be32) * 10, 0);
+				 DICE_PRIVATE_SPACE, pointers,
+				 sizeof(__be32) * ARRAY_SIZE(min_values), 0);
 	if (err < 0)
 		goto end;
 
-	/* Allocation callback in address space over host controller */
-	handler->length = 4;
-	handler->address_callback = dice_notification;
-	handler->callback_data = dice;
-	err = fw_core_add_address_handler(handler, &fw_high_memory_region);
-	if (err < 0) {
-		handler->callback_data = NULL;
-		goto end;
+	for (i = 0; i < ARRAY_SIZE(min_values); ++i) {
+		data = be32_to_cpu(pointers[i]);
+		if (data < min_values[i] || data >= 0x40000) {
+			err = -ENODEV;
+			goto end;
+		}
 	}
 
-	/* Register the address space */
-	err = register_notification_address(dice, true);
-	if (err < 0) {
-		fw_core_remove_address_handler(handler);
-		handler->callback_data = NULL;
+	/*
+	 * Check that the implemented DICE driver specification major version
+	 * number matches.
+	 */
+	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
+				 DICE_PRIVATE_SPACE +
+				 be32_to_cpu(pointers[0]) * 4 + GLOBAL_VERSION,
+				 &version, sizeof(version), 0);
+	if (err < 0)
+		goto end;
+
+	if ((version & cpu_to_be32(0xff000000)) != cpu_to_be32(0x01000000)) {
+		dev_err(&dice->unit->device,
+			"unknown DICE version: 0x%08x\n", be32_to_cpu(version));
+		err = -ENODEV;
 		goto end;
 	}
 
@@ -380,3 +401,32 @@ end:
 	kfree(pointers);
 	return err;
 }
+
+int snd_dice_transaction_init(struct snd_dice *dice)
+{
+	struct fw_address_handler *handler = &dice->notification_handler;
+	int err;
+
+	err = get_subaddrs(dice);
+	if (err < 0)
+		return err;
+
+	/* Allocation callback in address space over host controller */
+	handler->length = 4;
+	handler->address_callback = dice_notification;
+	handler->callback_data = dice;
+	err = fw_core_add_address_handler(handler, &fw_high_memory_region);
+	if (err < 0) {
+		handler->callback_data = NULL;
+		return err;
+	}
+
+	/* Register the address space */
+	err = register_notification_address(dice, true);
+	if (err < 0) {
+		fw_core_remove_address_handler(handler);
+		handler->callback_data = NULL;
+	}
+
+	return err;
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 0cda05c..26271cc 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -18,27 +18,12 @@ MODULE_LICENSE("GPL v2");
 #define WEISS_CATEGORY_ID	0x00
 #define LOUD_CATEGORY_ID	0x10
 
-static int dice_interface_check(struct fw_unit *unit)
+static int check_dice_category(struct fw_unit *unit)
 {
-	static const int min_values[10] = {
-		10, 0x64 / 4,
-		10, 0x18 / 4,
-		10, 0x18 / 4,
-		0, 0,
-		0, 0,
-	};
 	struct fw_device *device = fw_parent_device(unit);
 	struct fw_csr_iterator it;
-	int key, val, vendor = -1, model = -1, err;
-	unsigned int category, i;
-	__be32 *pointers;
-	u32 value;
-	__be32 version;
-
-	pointers = kmalloc_array(ARRAY_SIZE(min_values), sizeof(__be32),
-				 GFP_KERNEL);
-	if (pointers == NULL)
-		return -ENOMEM;
+	int key, val, vendor = -1, model = -1;
+	unsigned int category;
 
 	/*
 	 * Check that GUID and unit directory are constructed according to DICE
@@ -64,51 +49,10 @@ static int dice_interface_check(struct fw_unit *unit)
 	else
 		category = DICE_CATEGORY_ID;
 	if (device->config_rom[3] != ((vendor << 8) | category) ||
-	    device->config_rom[4] >> 22 != model) {
-		err = -ENODEV;
-		goto end;
-	}
-
-	/*
-	 * Check that the sub address spaces exist and are located inside the
-	 * private address space.  The minimum values are chosen so that all
-	 * minimally required registers are included.
-	 */
-	err = snd_fw_transaction(unit, TCODE_READ_BLOCK_REQUEST,
-				 DICE_PRIVATE_SPACE, pointers,
-				 sizeof(__be32) * ARRAY_SIZE(min_values), 0);
-	if (err < 0) {
-		err = -ENODEV;
-		goto end;
-	}
-	for (i = 0; i < ARRAY_SIZE(min_values); ++i) {
-		value = be32_to_cpu(pointers[i]);
-		if (value < min_values[i] || value >= 0x40000) {
-			err = -ENODEV;
-			goto end;
-		}
-	}
+	    device->config_rom[4] >> 22 != model)
+		return -ENODEV;
 
-	/*
-	 * Check that the implemented DICE driver specification major version
-	 * number matches.
-	 */
-	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
-				 DICE_PRIVATE_SPACE +
-				 be32_to_cpu(pointers[0]) * 4 + GLOBAL_VERSION,
-				 &version, 4, 0);
-	if (err < 0) {
-		err = -ENODEV;
-		goto end;
-	}
-	if ((version & cpu_to_be32(0xff000000)) != cpu_to_be32(0x01000000)) {
-		dev_err(&unit->device,
-			"unknown DICE version: 0x%08x\n", be32_to_cpu(version));
-		err = -ENODEV;
-		goto end;
-	}
-end:
-	return err;
+	return 0;
 }
 
 static int highest_supported_mode_rate(struct snd_dice *dice,
@@ -254,9 +198,9 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	struct snd_dice *dice;
 	int err;
 
-	err = dice_interface_check(unit);
+	err = check_dice_category(unit);
 	if (err < 0)
-		goto end;
+		return -ENODEV;
 
 	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
 			   sizeof(*dice), &card);
-- 
2.5.0
