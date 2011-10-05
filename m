From: Axel Lin <axel.lin@gmail.com>
Subject: [RFC][PATCH] ASoC: Fix sync reg_cache with the hardware in
 wm8990_resume
Date: Wed, 05 Oct 2011 18:16:49 +0800
Message-ID: <1317809809.2374.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Current code has off-by-one bug of checking WM8990_RESET.
Besides, according to wm8990 datasheet (2-wire serial control mode):
A control word consists of 24 bits. The first 8 bits are address bits,
the remaining 16 bits are data bits.
Current code uses 7 bits address bits and 9 bits data bits which is incorrect.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I'd appreciate if someone can test it.
I'm a little bit confused if this fix is correct, why there is no bug report so far.
If I'm wrong, please kindly let me know.
Thanks,
Axel
 sound/soc/codecs/wm8990.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 100aeee..5546f5a 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1320,16 +1320,17 @@ static int wm8990_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int wm8990_resume(struct snd_soc_codec *codec)
 {
 	int i;
-	u8 data[2];
+	u8 data[3];
 	u16 *cache = codec->reg_cache;
 
 	/* Sync reg_cache with the hardware */
 	for (i = 0; i < ARRAY_SIZE(wm8990_reg); i++) {
-		if (i + 1 == WM8990_RESET)
+		if (i == WM8990_RESET)
 			continue;
-		data[0] = ((i + 1) << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
+		data[0] = i;
+		data[1] = (cache[i] & 0xFF00) >> 8;
+		data[2] = cache[i] & 0x00FF;
+		codec->hw_write(codec->control_data, data, 3);
 	}
 
 	wm8990_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-- 
1.7.4.1
