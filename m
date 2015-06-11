From: Zidan Wang <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 4/4] ASoC: wm8960: the enum of "DAC Polarity" should be wm8960_enum[1]
Date: Thu, 11 Jun 2015 19:14:36 +0800
Message-ID: <a080e557e707453b09f7be7e027f1e4db15cb257.1434020423.git.zidan.wang@freescale.com>
References: <cover.1434020423.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434020423.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

the enum of "DAC Polarity" should be wm8960_enum[1].

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 62246f1..d482c0f 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -254,7 +254,7 @@ SOC_SINGLE("PCM Playback -6dB Switch", WM8960_DACCTL1, 7, 1, 0),
 SOC_ENUM("ADC Polarity", wm8960_enum[0]),
 SOC_SINGLE("ADC High Pass Filter Switch", WM8960_DACCTL1, 0, 1, 0),
 
-SOC_ENUM("DAC Polarity", wm8960_enum[2]),
+SOC_ENUM("DAC Polarity", wm8960_enum[1]),
 SOC_SINGLE_BOOL_EXT("DAC Deemphasis Switch", 0,
 		    wm8960_get_deemph, wm8960_put_deemph),
 
-- 
1.9.1
