From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/20] ALSA: isa: Use SNDRV_DEV_CARD for card
	objects
Date: Wed, 12 Feb 2014 11:52:11 +0100
Message-ID: <1392202347-11774-5-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CC0B22651AC
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C1CC3ABF8
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

... instead of SNDRV_DEV_LOWLEVEL.
No functional change at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/ad1816a/ad1816a_lib.c | 2 +-
 sound/isa/es1688/es1688_lib.c   | 2 +-
 sound/isa/es18xx.c              | 2 +-
 sound/isa/gus/gus_main.c        | 2 +-
 sound/isa/msnd/msnd_pinnacle.c  | 2 +-
 sound/isa/sb/sb_common.c        | 2 +-
 sound/isa/wss/wss_lib.c         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index f0fd98e695e3..c51f8ed7e34f 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -645,7 +645,7 @@ int snd_ad1816a_create(struct snd_card *card,
 	snd_ad1816a_init(chip);
 
 	/* Register device */
-	if ((error = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((error = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_ad1816a_free(chip);
 		return error;
 	}
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index b3b4f15e45ba..9c9a544c7099 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -700,7 +700,7 @@ int snd_es1688_create(struct snd_card *card,
 		goto exit;
 
 	/* Register device */
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 exit:
 	if (err)
 		snd_es1688_free(chip);
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 1c16830af3d8..fab372543d1a 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1831,7 +1831,7 @@ static int snd_es18xx_new_device(struct snd_card *card,
 		snd_es18xx_free(card);
 		return -ENODEV;
 	}
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		snd_es18xx_free(card);
 		return err;
diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index 4490ee442ff4..cf47edd254c4 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -220,7 +220,7 @@ int snd_gus_create(struct snd_card *card,
 	gus->gf1.pcm_channels = pcm_channels;
 	gus->gf1.volume_ramp = 25;
 	gus->gf1.smooth_pan = 1;
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, gus, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, gus, &ops)) < 0) {
 		snd_gus_free(gus);
 		return err;
 	}
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 5016bf957f51..78425fea9206 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -578,7 +578,7 @@ static int snd_msnd_attach(struct snd_card *card)
 		goto err_release_region;
 
 	/* Register device */
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0)
 		goto err_release_region;
 
diff --git a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
index 3ef990602cdd..bf4303de0252 100644
--- a/sound/isa/sb/sb_common.c
+++ b/sound/isa/sb/sb_common.c
@@ -285,7 +285,7 @@ int snd_sbdsp_create(struct snd_card *card,
 		snd_sbdsp_free(chip);
 		return err;
 	}
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_sbdsp_free(chip);
 		return err;
 	}
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 360b08b03e1d..fe40a7d884f0 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1884,7 +1884,7 @@ int snd_wss_create(struct snd_card *card,
 #endif
 
 	/* Register device */
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		snd_wss_free(chip);
 		return err;
-- 
1.8.5.2
