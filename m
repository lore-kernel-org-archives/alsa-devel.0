From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8960: Use snd_soc_update_bits for
	read-modify-write
Date: Thu, 08 Dec 2011 11:09:15 +0800
Message-ID: <1323313755.20937.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 41511248F9
	for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2011 04:09:29 +0100 (CET)
Received: by yenm9 with SMTP id m9so1181165yen.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2011 19:09:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8960.c |   67 ++++++++++++++-------------------------------
 1 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 6a9c41d..2315b86 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -543,30 +543,24 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 static int wm8960_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8960_DACCTL1) & 0xfff7;
 
 	if (mute)
-		snd_soc_write(codec, WM8960_DACCTL1, mute_reg | 0x8);
+		snd_soc_update_bits(codec, WM8960_DACCTL1, 0x8, 0x8);
 	else
-		snd_soc_write(codec, WM8960_DACCTL1, mute_reg);
+		snd_soc_update_bits(codec, WM8960_DACCTL1, 0x8, 0);
 	return 0;
 }
 
 static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 				      enum snd_soc_bias_level level)
 {
-	u16 reg;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
 		/* Set VMID to 2x50k */
-		reg = snd_soc_read(codec, WM8960_POWER1);
-		reg &= ~0x180;
-		reg |= 0x80;
-		snd_soc_write(codec, WM8960_POWER1, reg);
+		snd_soc_update_bits(codec, WM8960_POWER1, 0x180, 0x80);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -579,23 +573,19 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 				      WM8960_BUFDCOPEN | WM8960_BUFIOEN);
 
 			/* Enable & ramp VMID at 2x50k */
-			reg = snd_soc_read(codec, WM8960_POWER1);
-			reg |= 0x80;
-			snd_soc_write(codec, WM8960_POWER1, reg);
+			snd_soc_update_bits(codec, WM8960_POWER1, 0x80, 0x80);
 			msleep(100);
 
 			/* Enable VREF */
-			snd_soc_write(codec, WM8960_POWER1, reg | WM8960_VREF);
+			snd_soc_update_bits(codec, WM8960_POWER1, WM8960_VREF,
+					    WM8960_VREF);
 
 			/* Disable anti-pop features */
 			snd_soc_write(codec, WM8960_APOP1, WM8960_BUFIOEN);
 		}
 
 		/* Set VMID to 2x250k */
-		reg = snd_soc_read(codec, WM8960_POWER1);
-		reg &= ~0x180;
-		reg |= 0x100;
-		snd_soc_write(codec, WM8960_POWER1, reg);
+		snd_soc_update_bits(codec, WM8960_POWER1, 0x180, 0x100);
 		break;
 
 	case SND_SOC_BIAS_OFF:
@@ -787,10 +777,8 @@ static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 
 	/* Disable the PLL: even if we are changing the frequency the
 	 * PLL needs to be disabled while we do so. */
-	snd_soc_write(codec, WM8960_CLOCK1,
-		     snd_soc_read(codec, WM8960_CLOCK1) & ~1);
-	snd_soc_write(codec, WM8960_POWER2,
-		     snd_soc_read(codec, WM8960_POWER2) & ~1);
+	snd_soc_update_bits(codec, WM8960_CLOCK1, 0x1, 0);
+	snd_soc_update_bits(codec, WM8960_POWER2, 0x1, 0);
 
 	if (!freq_in || !freq_out)
 		return 0;
@@ -809,11 +797,9 @@ static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	snd_soc_write(codec, WM8960_PLL1, reg);
 
 	/* Turn it on */
-	snd_soc_write(codec, WM8960_POWER2,
-		     snd_soc_read(codec, WM8960_POWER2) | 1);
+	snd_soc_update_bits(codec, WM8960_POWER2, 0x1, 0x1);
 	msleep(250);
-	snd_soc_write(codec, WM8960_CLOCK1,
-		     snd_soc_read(codec, WM8960_CLOCK1) | 1);
+	snd_soc_update_bits(codec, WM8960_CLOCK1, 0x1, 0x1);
 
 	return 0;
 }
@@ -913,7 +899,6 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	struct wm8960_data *pdata = dev_get_platdata(codec->dev);
 	int ret;
-	u16 reg;
 
 	wm8960->set_bias_level = wm8960_set_bias_level_out3;
 
@@ -944,26 +929,16 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
-	reg = snd_soc_read(codec, WM8960_LINVOL);
-	snd_soc_write(codec, WM8960_LINVOL, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_RINVOL);
-	snd_soc_write(codec, WM8960_RINVOL, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_LADC);
-	snd_soc_write(codec, WM8960_LADC, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_RADC);
-	snd_soc_write(codec, WM8960_RADC, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_LDAC);
-	snd_soc_write(codec, WM8960_LDAC, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_RDAC);
-	snd_soc_write(codec, WM8960_RDAC, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_LOUT1);
-	snd_soc_write(codec, WM8960_LOUT1, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_ROUT1);
-	snd_soc_write(codec, WM8960_ROUT1, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_LOUT2);
-	snd_soc_write(codec, WM8960_LOUT2, reg | 0x100);
-	reg = snd_soc_read(codec, WM8960_ROUT2);
-	snd_soc_write(codec, WM8960_ROUT2, reg | 0x100);
+	snd_soc_update_bits(codec, WM8960_LINVOL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_RINVOL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_LADC, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_RADC, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_LDAC, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_RDAC, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_LOUT1, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_ROUT1, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_LOUT2, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8960_ROUT2, 0x100, 0x100);
 
 	snd_soc_add_controls(codec, wm8960_snd_controls,
 				     ARRAY_SIZE(wm8960_snd_controls));
-- 
1.7.5.4
