From: Zidan Wang <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 3/4] ASoC: wm8960: add kcontrol to select ADC data output
Date: Thu, 11 Jun 2015 19:14:35 +0800
Message-ID: <e7e1d4817ea6d4a1140a31ed21c5860cbaaaad3c.1434020423.git.zidan.wang@freescale.com>
References: <cover.1434020423.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434020423.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

add kcontrol to select ADC data output.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index c1be15c..62246f1 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -141,6 +141,12 @@ static const char *wm8960_3d_upper_cutoff[] = {"High", "Low"};
 static const char *wm8960_3d_lower_cutoff[] = {"Low", "High"};
 static const char *wm8960_alcfunc[] = {"Off", "Right", "Left", "Stereo"};
 static const char *wm8960_alcmode[] = {"ALC", "Limiter"};
+static const char *wm8960_adc_data_sel[] = {
+	"ldata = left ADC; rdata = right ADC",
+	"ldata = left ADC; rdata = left ADC",
+	"ldata = right ADC; rdata = right ADC",
+	"ldata = right ADC; rdata = left ADC",
+};
 
 static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
@@ -149,6 +155,7 @@ static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_3D, 5, 2, wm8960_3d_lower_cutoff),
 	SOC_ENUM_SINGLE(WM8960_ALC1, 7, 4, wm8960_alcfunc),
 	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
+	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 4, wm8960_adc_data_sel),
 };
 
 static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
@@ -279,6 +286,8 @@ SOC_SINGLE_TLV("Right Output Mixer Boost Bypass Volume",
 	       WM8960_BYPASS2, 4, 7, 1, bypass_tlv),
 SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
 	       WM8960_ROUTMIX, 4, 7, 1, bypass_tlv),
+
+SOC_ENUM("ADC Data Output Select", wm8960_enum[6]),
 };
 
 static const struct snd_kcontrol_new wm8960_lin_boost[] = {
-- 
1.9.1
