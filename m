From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 07/11] ASoC: wm8960: Convert to snd_soc_write
Date: Fri, 07 Oct 2011 07:53:18 +0800
Message-ID: <1317945198.5579.13.camel@phoenix>
References: <1317944619.5579.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6485D103B1C
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 01:53:25 +0200 (CEST)
Received: by gyg4 with SMTP id 4so3606536gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 16:53:24 -0700 (PDT)
In-Reply-To: <1317944619.5579.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Convert codec->hw_write to snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8960.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 831c20f..c043722 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -555,6 +555,26 @@ static int wm8960_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
+static void wm8960_sync_cache(struct snd_soc_codec *codec)
+{
+	short i;
+	u16 *cache;
+
+	if (!codec->cache_sync)
+		return;
+	codec->cache_only = 0;
+	codec->cache_bypass = 1;
+	/* restore cache */
+	cache = codec->reg_cache;
+	for (i = 0; i < codec->driver->reg_cache_size; i++) {
+		if (i == WM8960_RESET || cache[i] == wm8960_reg[i])
+			continue;
+		snd_soc_write(codec, i, cache[i]);
+	}
+	codec->cache_bypass = 0;
+	codec->cache_sync = 0;
+}
+
 static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 				      enum snd_soc_bias_level level)
 {
@@ -574,6 +594,8 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			wm8960_sync_cache(codec);
+
 			/* Enable anti-pop features */
 			snd_soc_write(codec, WM8960_APOP1,
 				      WM8960_POBCTRL | WM8960_SOFT_ST |
@@ -629,6 +651,8 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		switch (codec->dapm.bias_level) {
 		case SND_SOC_BIAS_STANDBY:
+			wm8960_sync_cache(codec);
+
 			/* Enable anti pop mode */
 			snd_soc_update_bits(codec, WM8960_APOP1,
 					    WM8960_POBCTRL | WM8960_SOFT_ST |
@@ -901,16 +925,6 @@ static int wm8960_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int wm8960_resume(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(wm8960_reg); i++) {
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
 
 	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
-- 
1.7.4.1
