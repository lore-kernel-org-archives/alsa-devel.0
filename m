From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 10/11] ASoC: wm8988: Convert to snd_soc_write
Date: Fri, 07 Oct 2011 07:55:53 +0800
Message-ID: <1317945353.5579.16.camel@phoenix>
References: <1317944619.5579.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4562C103B2C
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 01:56:00 +0200 (CEST)
Received: by ywn1 with SMTP id 1so3637237ywn.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 16:55:59 -0700 (PDT)
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
 sound/soc/codecs/wm8988.c |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 1c6f8bf..33584e0 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -55,7 +55,6 @@ struct wm8988_priv {
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 };
 
-
 #define wm8988_reset(c)	snd_soc_write(c, WM8988_RESET, 0)
 
 /*
@@ -660,6 +659,26 @@ static int wm8988_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
+static void wm8988_sync_cache(struct snd_soc_codec *codec)
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
+		if (i == WM8988_RESET || cache[i] == wm8988_reg[i])
+			continue;
+		snd_soc_write(codec, i, cache[i]);
+	}
+	codec->cache_bypass = 0;
+	codec->cache_sync = 0;
+}
+
 static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -676,6 +695,8 @@ static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			wm8988_sync_cache(codec);
+
 			/* VREF, VMID=2x5k */
 			snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x1c1);
 
@@ -736,21 +757,7 @@ static int wm8988_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int wm8988_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < WM8988_NUM_REG; i++) {
-		if (i == WM8988_RESET)
-			continue;
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
-
 	wm8988_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
-- 
1.7.4.1
