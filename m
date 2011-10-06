From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 08/11] ASoC: wm8971: Convert to snd_soc_write
Date: Fri, 07 Oct 2011 07:54:15 +0800
Message-ID: <1317945255.5579.14.camel@phoenix>
References: <1317944619.5579.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EAC26103B27
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 01:54:22 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so2614412ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 16:54:22 -0700 (PDT)
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
Cc: Kenneth Kiraly <kiraly@lab126.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Convert codec->hw_write to snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8971.c |   35 +++++++++++++++++++++++------------
 1 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 08ea6f8..2265e00 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -533,6 +533,26 @@ static int wm8971_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
+static void wm8971_sync_cache(struct snd_soc_codec *codec)
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
+		if (i == WM8971_RESET || cache[i] == wm8971_reg[i])
+			continue;
+		snd_soc_write(codec, i, cache[i]);
+	}
+	codec->cache_bypass = 0;
+	codec->cache_sync = 0;
+}
+
 static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
@@ -546,6 +566,9 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+			wm8971_sync_cache(codec);
+
 		/* mute dac and set vmid to 500k, enable VREF */
 		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
 		break;
@@ -605,20 +628,8 @@ static int wm8971_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int wm8971_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
 	u16 reg;
 
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(wm8971_reg); i++) {
-		if (i == WM8971_RESET)
-			continue;
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
-
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* charge wm8971 caps */
-- 
1.7.4.1
