From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v3 09/10] ASoC: wm8974: Convert to snd_soc_cache_sync
Date: Fri, 07 Oct 2011 21:52:42 +0800
Message-ID: <1317995562.9906.16.camel@phoenix>
References: <1317994508.9906.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317994508.9906.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert to snd_soc_cache_sync for sync reg_cache with the hardware.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8974.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 8e3bfc1..9352f1e 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -530,6 +530,8 @@ static int wm8974_set_bias_level(struct snd_soc_codec *codec,
 		power1 |= WM8974_POWER1_BIASEN | WM8974_POWER1_BUFIOEN;
 
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			snd_soc_cache_sync(codec);
+
 			/* Initial cap charge at VMID 5k */
 			snd_soc_write(codec, WM8974_POWER1, power1 | 0x3);
 			mdelay(100);
@@ -589,18 +591,7 @@ static int wm8974_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
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
