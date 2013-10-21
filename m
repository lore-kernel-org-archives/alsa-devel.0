From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [11/29] ALSA: dice: fix device detection for other vendors
Date: Mon, 21 Oct 2013 21:26:53 +0200
Message-ID: <52657FFD.3050504@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

DICE devices do not have a unique specifier ID in their unit directory
(it's always the same as the device vendor's ID), so rely on just the
version ID for driver loading, and use a heuristic in the probe callback
to detect actual DICE devices.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |  102 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 1da1dde..b4827ff 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -827,28 +827,93 @@ static void dice_card_free(struct snd_card *card)
 	mutex_destroy(&dice->mutex);
 }

+#define DICE_CATEGORY_ID 0x04
+
+static int dice_interface_check(struct fw_unit *unit)
+{
+	static const int min_values[10] = {
+		10, 0x64 / 4,
+		10, 0x18 / 4,
+		10, 0x18 / 4,
+		0, 0,
+		0, 0,
+	};
+	struct fw_device *device = fw_parent_device(unit);
+	struct fw_csr_iterator it;
+	int key, value, vendor = -1, model = -1, err;
+	unsigned int i;
+	__be32 pointers[ARRAY_SIZE(min_values)];
+	__be32 version;
+
+	/*
+	 * Check that GUID and unit directory are constructed according to DICE
+	 * rules, i.e., that the specifier ID is the GUID's OUI, and that the
+	 * GUID chip ID consists of the 8-bit DICE category ID, the 10-bit
+	 * product ID, and a 22-bit serial number.
+	 */
+	fw_csr_iterator_init(&it, unit->directory);
+	while (fw_csr_iterator_next(&it, &key, &value)) {
+		switch (key) {
+		case CSR_SPECIFIER_ID:
+			vendor = value;
+			break;
+		case CSR_MODEL:
+			model = value;
+			break;
+		}
+	}
+	if (device->config_rom[3] != ((vendor << 8) | DICE_CATEGORY_ID) ||
+	    device->config_rom[4] >> 22 != model)
+		return -ENODEV;
+
+	/*
+	 * Check that the sub address spaces exist and are located inside the
+	 * private address space.  The minimum values are chosen so that all
+	 * minimally required registers are included.
+	 */
+	err = snd_fw_transaction(unit, TCODE_READ_BLOCK_REQUEST,
+				 DICE_PRIVATE_SPACE,
+				 pointers, sizeof(pointers));
+	if (err < 0)
+		return -ENODEV;
+	for (i = 0; i < ARRAY_SIZE(pointers); ++i) {
+		value = be32_to_cpu(pointers[i]);
+		if (value < min_values[i] || value >= 0x40000)
+			return -ENODEV;
+	}
+
+	/*
+	 * Check that the implemented DICE driver specification major version
+	 * number matches.
+	 */
+	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
+				 DICE_PRIVATE_SPACE +
+				 be32_to_cpu(pointers[0]) * 4 + GLOBAL_VERSION,
+				 &version, 4);
+	if (err < 0)
+		return -ENODEV;
+	if ((version & cpu_to_be32(0xff000000)) != cpu_to_be32(0x01000000)) {
+		dev_err(&unit->device,
+			"unknown DICE version: 0x%08x\n", be32_to_cpu(version));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int dice_init_offsets(struct dice *dice)
 {
 	__be32 pointers[6];
-	unsigned int global_size, rx_size;
 	int err;

 	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
-				 DICE_PRIVATE_SPACE, &pointers, 6 * 4);
+				 DICE_PRIVATE_SPACE,
+				 pointers, sizeof(pointers));
 	if (err < 0)
 		return err;

 	dice->global_offset = be32_to_cpu(pointers[0]) * 4;
-	global_size = be32_to_cpu(pointers[1]);
 	dice->rx_offset = be32_to_cpu(pointers[4]) * 4;
-	rx_size = be32_to_cpu(pointers[5]);
-
-	/* some sanity checks to ensure that we actually have a DICE */
-	if (dice->global_offset < 10 * 4 || global_size < 0x168 / 4 ||
-	    dice->rx_offset < 10 * 4 || rx_size < 0x120 / 4) {
-		dev_err(&dice->unit->device, "invalid register pointers\n");
-		return -ENXIO;
-	}

 	return 0;
 }
@@ -881,8 +946,8 @@ static void dice_card_strings(struct dice *dice)
 	strcpy(model, "?");
 	fw_csr_string(dice->unit->directory, CSR_MODEL, model, sizeof(model));
 	snprintf(card->longname, sizeof(card->longname),
-		 "%s %s, GUID %08x%08x at %s, S%d",
-		 vendor, model, dev->config_rom[3], dev->config_rom[4],
+		 "%s %s (serial %u) at %s, S%d",
+		 vendor, model, dev->config_rom[4] & 0x3fffff,
 		 dev_name(&dice->unit->device), 100 << dev->max_speed);

 	strcpy(card->mixername, "DICE");
@@ -895,6 +960,10 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	__be32 clock_sel;
 	int err;

+	err = dice_interface_check(unit);
+	if (err < 0)
+		return err;
+
 	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*dice), &card);
 	if (err < 0)
 		return err;
@@ -1020,15 +1089,12 @@ static void dice_bus_reset(struct fw_unit *unit)
 	mutex_unlock(&dice->mutex);
 }

-#define TC_OUI		0x000166
 #define DICE_INTERFACE	0x000001

 static const struct ieee1394_device_id dice_id_table[] = {
 	{
-		.match_flags  = IEEE1394_MATCH_SPECIFIER_ID |
-				IEEE1394_MATCH_VERSION,
-		.specifier_id = TC_OUI,
-		.version      = DICE_INTERFACE,
+		.match_flags = IEEE1394_MATCH_VERSION,
+		.version     = DICE_INTERFACE,
 	},
 	{ }
 };

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
