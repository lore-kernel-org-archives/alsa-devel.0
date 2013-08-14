From: Ma Haijun <mahaijuns@gmail.com>
Subject: [PATCH 1/2] ASoC: wm8960: Fix ADC volume bits
Date: Wed, 14 Aug 2013 09:15:38 +0800
Message-ID: <1376442946-2803-1-git-send-email-mahaijuns@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ma Haijun <mahaijuns@gmail.com>
---
 sound/soc/codecs/wm8960.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 0a4ffdd..368d39f 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -263,8 +263,8 @@ SOC_SINGLE("ALC Attack", WM8960_ALC3, 0, 15, 0),
 SOC_SINGLE("Noise Gate Threshold", WM8960_NOISEG, 3, 31, 0),
 SOC_SINGLE("Noise Gate Switch", WM8960_NOISEG, 0, 1, 0),
 
-SOC_DOUBLE_R("ADC PCM Capture Volume", WM8960_LINPATH, WM8960_RINPATH,
-	0, 127, 0),
+SOC_DOUBLE_R_TLV("ADC PCM Capture Volume", WM8960_LADC, WM8960_RADC,
+	0, 255, 0, adc_tlv),
 
 SOC_SINGLE_TLV("Left Output Mixer Boost Bypass Volume",
 	       WM8960_BYPASS1, 4, 7, 1, bypass_tlv),
-- 
1.8.1.2
