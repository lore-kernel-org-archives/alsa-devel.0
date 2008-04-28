From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] soc - wm9712 - checkpatch fixes
Date: Mon, 28 Apr 2008 14:15:28 +0100
Message-ID: <1209388528-13195-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E859B24615
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Apr 2008 15:15:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9712.c |   62 +++++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index d2d79e1..76c1e2d 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -37,23 +37,23 @@ static int ac97_write(struct snd_soc_codec *codec,
  * WM9712 register cache
  */
 static const u16 wm9712_reg[] = {
-	0x6174, 0x8000, 0x8000, 0x8000, // 6
-	0x0f0f, 0xaaa0, 0xc008, 0x6808, // e
-	0xe808, 0xaaa0, 0xad00, 0x8000, // 16
-	0xe808, 0x3000, 0x8000, 0x0000, // 1e
-	0x0000, 0x0000, 0x0000, 0x000f, // 26
-	0x0405, 0x0410, 0xbb80, 0xbb80, // 2e
-	0x0000, 0xbb80, 0x0000, 0x0000, // 36
-	0x0000, 0x2000, 0x0000, 0x0000, // 3e
-	0x0000, 0x0000, 0x0000, 0x0000, // 46
-	0x0000, 0x0000, 0xf83e, 0xffff, // 4e
-	0x0000, 0x0000, 0x0000, 0xf83e, // 56
-	0x0008, 0x0000, 0x0000, 0x0000, // 5e
-	0xb032, 0x3e00, 0x0000, 0x0000, // 66
-	0x0000, 0x0000, 0x0000, 0x0000, // 6e
-	0x0000, 0x0000, 0x0000, 0x0006, // 76
-	0x0001, 0x0000, 0x574d, 0x4c12, // 7e
-	0x0000, 0x0000 // virtual hp mixers
+	0x6174, 0x8000, 0x8000, 0x8000, /*  6 */
+	0x0f0f, 0xaaa0, 0xc008, 0x6808, /*  e */
+	0xe808, 0xaaa0, 0xad00, 0x8000, /* 16 */
+	0xe808, 0x3000, 0x8000, 0x0000, /* 1e */
+	0x0000, 0x0000, 0x0000, 0x000f, /* 26 */
+	0x0405, 0x0410, 0xbb80, 0xbb80, /* 2e */
+	0x0000, 0xbb80, 0x0000, 0x0000, /* 36 */
+	0x0000, 0x2000, 0x0000, 0x0000, /* 3e */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 46 */
+	0x0000, 0x0000, 0xf83e, 0xffff, /* 4e */
+	0x0000, 0x0000, 0x0000, 0xf83e, /* 56 */
+	0x0008, 0x0000, 0x0000, 0x0000, /* 5e */
+	0xb032, 0x3e00, 0x0000, 0x0000, /* 66 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 6e */
+	0x0000, 0x0000, 0x0000, 0x0006, /* 76 */
+	0x0001, 0x0000, 0x574d, 0x4c12, /* 7e */
+	0x0000, 0x0000 /* virtual hp mixers */
 };
 
 /* virtual HP mixers regs */
@@ -94,7 +94,7 @@ static const struct snd_kcontrol_new wm9712_snd_ac97_controls[] = {
 SOC_DOUBLE("Speaker Playback Volume", AC97_MASTER, 8, 0, 31, 1),
 SOC_SINGLE("Speaker Playback Switch", AC97_MASTER, 15, 1, 1),
 SOC_DOUBLE("Headphone Playback Volume", AC97_HEADPHONE, 8, 0, 31, 1),
-SOC_SINGLE("Headphone Playback Switch", AC97_HEADPHONE,15, 1, 1),
+SOC_SINGLE("Headphone Playback Switch", AC97_HEADPHONE, 15, 1, 1),
 SOC_DOUBLE("PCM Playback Volume", AC97_PCM, 8, 0, 31, 1),
 
 SOC_SINGLE("Speaker Playback ZC Switch", AC97_MASTER, 7, 1, 0),
@@ -165,7 +165,8 @@ static int wm9712_add_controls(struct snd_soc_codec *codec)
 
 	for (i = 0; i < ARRAY_SIZE(wm9712_snd_ac97_controls); i++) {
 		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm9712_snd_ac97_controls[i],codec, NULL));
+				  snd_soc_cnew(&wm9712_snd_ac97_controls[i],
+					       codec, NULL));
 		if (err < 0)
 			return err;
 	}
@@ -363,7 +364,6 @@ static const char *audio_map[][3] = {
 	{"Left HP Mixer", "PCM Playback Switch",  "Left DAC"},
 	{"Left HP Mixer", "Mic Sidetone Switch",  "Mic PGA"},
 	{"Left HP Mixer", NULL,  "ALC Sidetone Mux"},
-	//{"Right HP Mixer", NULL, "HP Mixer"},
 
 	/* Right HP mixer */
 	{"Right HP Mixer", "PCBeep Bypass Switch", "PCBEEP"},
@@ -454,15 +454,13 @@ static int wm9712_add_widgets(struct snd_soc_codec *codec)
 {
 	int i;
 
-	for(i = 0; i < ARRAY_SIZE(wm9712_dapm_widgets); i++) {
+	for (i = 0; i < ARRAY_SIZE(wm9712_dapm_widgets); i++)
 		snd_soc_dapm_new_control(codec, &wm9712_dapm_widgets[i]);
-	}
 
-	/* set up audio path audio_mapnects */
-	for(i = 0; audio_map[i][0] != NULL; i++) {
+	/* set up audio path connects */
+	for (i = 0; audio_map[i][0] != NULL; i++)
 		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
-	}
+					   audio_map[i][1], audio_map[i][2]);
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
@@ -540,7 +538,8 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream)
 }
 
 #define WM9712_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
+		SNDRV_PCM_RATE_48000)
 
 struct snd_soc_codec_dai wm9712_dai[] = {
 {
@@ -577,8 +576,6 @@ EXPORT_SYMBOL_GPL(wm9712_dai);
 
 static int wm9712_dapm_event(struct snd_soc_codec *codec, int event)
 {
-	u16 reg;
-
 	switch (event) {
 	case SNDRV_CTL_POWER_D0: /* full On */
 	case SNDRV_CTL_POWER_D1: /* partial On */
@@ -633,7 +630,7 @@ static int wm9712_soc_resume(struct platform_device *pdev)
 	u16 *cache = codec->reg_cache;
 
 	ret = wm9712_reset(codec, 1);
-	if (ret < 0){
+	if (ret < 0) {
 		printk(KERN_ERR "could not reset AC97 codec\n");
 		return ret;
 	}
@@ -642,9 +639,9 @@ static int wm9712_soc_resume(struct platform_device *pdev)
 
 	if (ret == 0) {
 		/* Sync reg_cache with the hardware after cold reset */
-		for (i = 2; i < ARRAY_SIZE(wm9712_reg) << 1; i+=2) {
+		for (i = 2; i < ARRAY_SIZE(wm9712_reg) << 1; i += 2) {
 			if (i == AC97_INT_PAGING || i == AC97_POWERDOWN ||
-				(i > 0x58 && i != 0x5c))
+			    (i > 0x58 && i != 0x5c))
 				continue;
 			soc_ac97_ops.write(codec->ac97, i, cache[i>>1]);
 		}
@@ -757,7 +754,6 @@ struct snd_soc_codec_device soc_codec_dev_wm9712 = {
 	.suspend =	wm9712_soc_suspend,
 	.resume =	wm9712_soc_resume,
 };
-
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9712);
 
 MODULE_DESCRIPTION("ASoC WM9711/WM9712 driver");
-- 
1.5.5.1
