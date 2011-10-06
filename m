From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 05/10] ASoC: wm8776: Convert to
	snd_soc_cache_sync
Date: Thu, 06 Oct 2011 14:16:38 +0800
Message-ID: <1317881798.13399.9.camel@phoenix>
References: <1317881417.13399.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 55738103A97
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 08:16:47 +0200 (CEST)
Received: by yxk8 with SMTP id 8so2673118yxk.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 23:16:46 -0700 (PDT)
In-Reply-To: <1317881417.13399.1.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Convert to snd_soc_cache_sync for sync reg_cache with the hardware.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8776.c |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 00d8846..4f24446 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -37,6 +37,17 @@ struct wm8776_priv {
 	int sysclk[2];
 };
 
+static int wm8776_volatile_register(struct snd_soc_codec *codec,
+				    unsigned int reg)
+{
+	switch (reg) {
+	case WM8776_RESET:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static const u16 wm8776_reg[WM8776_CACHEREGNUM] = {
 	0x79, 0x79, 0x79, 0xff, 0xff,  /* 4 */
 	0xff, 0x00, 0x90, 0x00, 0x00,  /* 9 */
@@ -301,6 +312,8 @@ static int wm8776_set_sysclk(struct snd_soc_dai *dai,
 static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	int ret;
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -308,6 +321,11 @@ static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			ret = snd_soc_cache_sync(codec);
+			if (ret < 0) {
+				dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
+				return ret;
+			}
 			/* Disable the global powerdown; DAPM does the rest */
 			snd_soc_update_bits(codec, WM8776_PWRDOWN, 1, 0);
 		}
@@ -379,21 +397,7 @@ static int wm8776_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int wm8776_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(wm8776_reg); i++) {
-		if (cache[i] == wm8776_reg[i])
-			continue;
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
-
 	wm8776_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 #else
@@ -451,6 +455,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
 	.reg_cache_size = ARRAY_SIZE(wm8776_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8776_reg,
+	.volatile_register = wm8776_volatile_register,
 };
 
 static const struct of_device_id wm8776_of_match[] = {
-- 
1.7.4.1
