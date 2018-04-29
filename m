From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 13/13] ALSA: dice: remove local frag of
	force_two_pcms
Date: Sun, 29 Apr 2018 15:50:32 +0900
Message-ID: <20180429065032.13869-14-o-takashi@sakamocchi.jp>
References: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D1E2267653
 for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2018 08:51:28 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id a11so4438329pfn.9
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 23:51:28 -0700 (PDT)
In-Reply-To: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

At present, to add PCM substreams for each of available tx/rx streams,
this driver uses a condition based on model-name. This is not enough
to support unknown models.

In former commits, this driver gains cache of stream formats. For models
which support protocol extension, all of available steam formats are
cached. For known models, hard-coded stream formats are used to generate
the cache. For unknown models, stream formats at current mode of sampling
transmission frequency is cached.

Anyway, at least, the cached formats are used to expose constrains of PCM
substreams for userspace applications. Thus, The cached data can be also
used to add PCM substreams themselves, instead of the name-based
conditions.

This commit obsoletes local frag of force_two_pcms.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c | 38 ++++++++------------------------------
 sound/firewire/dice/dice.c     | 38 --------------------------------------
 sound/firewire/dice/dice.h     |  2 --
 3 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index d0c323e16a39..8e06f7234e82 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -425,40 +425,18 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
-	unsigned int i, max_capture, max_playback, capture, playback;
+	unsigned int capture, playback;
+	int i, j;
 	int err;
 
-	/* Check whether PCM substreams are required. */
-	if (dice->force_two_pcms) {
-		max_capture = max_playback = 2;
-	} else {
-		int j;
-		max_capture = max_playback = 0;
-		for (i = 0; i < MAX_STREAMS; ++i) {
-			for (j = 0; j < 3; ++j) {
-				if (dice->tx_pcm_chs[i][j] > 0) {
-					++max_capture;
-					break;
-				}
-			}
-
-			for (j = 0; j < 3; ++j) {
-				if (dice->rx_pcm_chs[i][j] > 0) {
-					++max_playback;
-					break;
-				}
-			}
-		}
-	}
-
 	for (i = 0; i < MAX_STREAMS; i++) {
 		capture = playback = 0;
-		if (i < max_capture)
-			capture = 1;
-		if (i < max_playback)
-			playback = 1;
-		if (capture == 0 && playback == 0)
-			break;
+		for (j = 0; j < 3; ++j) {
+			if (dice->tx_pcm_chs[i][j] > 0)
+				capture = 1;
+			if (dice->rx_pcm_chs[i][j] > 0)
+				playback = 1;
+		}
 
 		err = snd_pcm_new(dice->card, "DICE", i, playback, capture,
 				  &pcm);
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 6d55a62ec89e..40f7a32e4893 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -24,36 +24,6 @@ MODULE_LICENSE("GPL v2");
 
 #define MODEL_ALESIS_IO_BOTH	0x000001
 
-/*
- * Some models support several isochronous channels, while these streams are not
- * always available. In this case, add the model name to this list.
- */
-static bool force_two_pcm_support(struct fw_unit *unit)
-{
-	static const char *const models[] = {
-		/* TC Electronic models. */
-		"StudioKonnekt48",
-		/* Focusrite models. */
-		"SAFFIRE_PRO_40",
-		"LIQUID_SAFFIRE_56",
-		"SAFFIRE_PRO_40_1",
-	};
-	char model[32];
-	unsigned int i;
-	int err;
-
-	err = fw_csr_string(unit->directory, CSR_MODEL, model, sizeof(model));
-	if (err < 0)
-		return false;
-
-	for (i = 0; i < ARRAY_SIZE(models); i++) {
-		if (strcmp(models[i], model) == 0)
-			break;
-	}
-
-	return i < ARRAY_SIZE(models);
-}
-
 static int check_dice_category(struct fw_unit *unit)
 {
 	struct fw_device *device = fw_parent_device(unit);
@@ -79,11 +49,6 @@ static int check_dice_category(struct fw_unit *unit)
 		}
 	}
 
-	if (vendor == OUI_FOCUSRITE || vendor == OUI_TCELECTRONIC) {
-		if (force_two_pcm_support(unit))
-			return 0;
-	}
-
 	if (vendor == OUI_WEISS)
 		category = WEISS_CATEGORY_ID;
 	else if (vendor == OUI_LOUD)
@@ -190,9 +155,6 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		return;
 
-	if (force_two_pcm_support(dice->unit))
-		dice->force_two_pcms = true;
-
 	err = snd_dice_transaction_init(dice);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 7b1e2396eadc..0f5927e89bc9 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -106,8 +106,6 @@ struct snd_dice {
 	bool global_enabled;
 	struct completion clock_accepted;
 	unsigned int substreams_counter;
-
-	bool force_two_pcms;
 };
 
 enum snd_dice_addr_type {
-- 
2.14.1
