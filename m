From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: dice: force to add two pcm devices
	for listed models
Date: Mon,  7 Mar 2016 22:35:45 +0900
Message-ID: <1457357745-24756-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1457357745-24756-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id B0DA226155D
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 14:35:49 +0100 (CET)
In-Reply-To: <1457357745-24756-1-git-send-email-o-takashi@sakamocchi.jp>
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

Some models reduce the number of available isochronous streams for higher
sampling transfer frequency. Such models bring an issue about how to add
PCM substreams. When at lower sampling transfer frequency, the
models reports whole available streams, thus this driver can add enough
number of PCM substreams at probing time. On the other hand, at higher
sampling transfer frequency, this driver can just add reduced number of
PCM substreams. After probed, even if the sampling transfer frequency is
changed to lower rate, fewer PCM substreams are actually available. This
is inconvenience.

For the reason, this commit adds a list so that this driver assume models
on the list to have two pairs of PCM substreams. This list keeps the name
of model in which the number of available streams differs depending on
sampling transfer frequency.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c | 24 +++++++++++++++---------
 sound/firewire/dice/dice.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice.h     |  2 ++
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 05e2e18..4aa0249 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -332,16 +332,22 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 	int err;
 
 	/* Check whether PCM substreams are required. */
-	max_capture = max_playback = 0;
-	err = snd_dice_transaction_read_tx(dice, TX_NUMBER, &reg, sizeof(reg));
-	if (err < 0)
-		return err;
-	max_capture = min_t(unsigned int, be32_to_cpu(reg), MAX_STREAMS);
+	if (dice->force_two_pcms) {
+		max_capture = max_playback = 2;
+	} else {
+		max_capture = max_playback = 0;
+		err = snd_dice_transaction_read_tx(dice, TX_NUMBER, &reg,
+						   sizeof(reg));
+		if (err < 0)
+			return err;
+		max_capture = min_t(unsigned int, be32_to_cpu(reg), MAX_STREAMS);
 
-	err = snd_dice_transaction_read_rx(dice, RX_NUMBER, &reg, sizeof(reg));
-	if (err < 0)
-		return err;
-	max_playback = min_t(unsigned int, be32_to_cpu(reg), MAX_STREAMS);
+		err = snd_dice_transaction_read_rx(dice, RX_NUMBER, &reg,
+						   sizeof(reg));
+		if (err < 0)
+			return err;
+		max_playback = min_t(unsigned int, be32_to_cpu(reg), MAX_STREAMS);
+	}
 
 	for (i = 0; i < MAX_STREAMS; i++) {
 		capture = playback = 0;
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index f7303a6..8b64aef 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -13,6 +13,8 @@ MODULE_LICENSE("GPL v2");
 
 #define OUI_WEISS		0x001c6a
 #define OUI_LOUD		0x000ff2
+#define OUI_FOCUSRITE		0x00130e
+#define OUI_TCELECTRONIC	0x001486
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
@@ -20,6 +22,36 @@ MODULE_LICENSE("GPL v2");
 
 #define PROBE_DELAY_MS		(2 * MSEC_PER_SEC)
 
+/*
+ * Some models support several isochronous channels, while these streams are not
+ * always available. In this case, add the model name to this list.
+ */
+static bool force_two_pcm_support(struct fw_unit *unit)
+{
+	const char *const models[] = {
+		/* TC Electronic models. */
+		"StudioKonnekt48",
+		/* Focusrite models. */
+		"SAFFIRE_PRO_40",
+		"LIQUID_SAFFIRE_56",
+		"SAFFIRE_PRO_40_1",
+	};
+	char model[32];
+	unsigned int i;
+	int err;
+
+	err = fw_csr_string(unit->directory, CSR_MODEL, model, sizeof(model));
+	if (err < 0)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(models); i++) {
+		if (strcmp(models[i], model) == 0)
+			break;
+	}
+
+	return i < ARRAY_SIZE(models);
+}
+
 static int check_dice_category(struct fw_unit *unit)
 {
 	struct fw_device *device = fw_parent_device(unit);
@@ -44,6 +76,12 @@ static int check_dice_category(struct fw_unit *unit)
 			break;
 		}
 	}
+
+	if (vendor == OUI_FOCUSRITE || vendor == OUI_TCELECTRONIC) {
+		if (force_two_pcm_support(unit))
+			return 0;
+	}
+
 	if (vendor == OUI_WEISS)
 		category = WEISS_CATEGORY_ID;
 	else if (vendor == OUI_LOUD)
@@ -150,6 +188,9 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		return;
 
+	if (force_two_pcm_support(dice->unit))
+		dice->force_two_pcms = true;
+
 	err = snd_dice_transaction_init(dice);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 8fba87d..e6c0785 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -97,6 +97,8 @@ struct snd_dice {
 	bool global_enabled;
 	struct completion clock_accepted;
 	unsigned int substreams_counter;
+
+	bool force_two_pcms;
 };
 
 enum snd_dice_addr_type {
-- 
2.7.0
