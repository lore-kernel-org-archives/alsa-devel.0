From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 09/11] ASoC: wm8974: Convert to snd_soc_write
Date: Fri, 07 Oct 2011 07:55:02 +0800
Message-ID: <1317945302.5579.15.camel@phoenix>
References: <1317944619.5579.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 32343103B27
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 01:55:09 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so2614956ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 16:55:08 -0700 (PDT)
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
 sound/soc/codecs/wm8974.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index ca646a8..7db3808 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -513,6 +513,26 @@ static int wm8974_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
+static void wm8974_sync_cache(struct snd_soc_codec *codec)
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
+		if (i == WM8974_RESET || cache[i] == wm8974_reg[i])
+			continue;
+		snd_soc_write(codec, i, cache[i]);
+	}
+	codec->cache_bypass = 0;
+	codec->cache_sync = 0;
+}
+
 /* liam need to make this lower power with dapm */
 static int wm8974_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
@@ -530,6 +550,8 @@ static int wm8974_set_bias_level(struct snd_soc_codec *codec,
 		power1 |= WM8974_POWER1_BIASEN | WM8974_POWER1_BUFIOEN;
 
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			wm8974_sync_cache(codec);
+
 			/* Initial cap charge at VMID 5k */
 			snd_soc_write(codec, WM8974_POWER1, power1 | 0x3);
 			mdelay(100);
@@ -589,18 +611,7 @@ static int wm8974_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int wm8974_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(wm8974_reg); i++) {
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
 	wm8974_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
-- 
1.7.4.1
