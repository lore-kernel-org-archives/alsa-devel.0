From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Implement WM8994/58 DAC and ADC
	oversampling control
Date: Thu,  9 Dec 2010 12:13:24 +0000
Message-ID: <1291896804-15253-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43D55103C80
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 13:13:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The oversampling rate of the DAC and ADC can be controlled to optimise
for either low power consumption or maximum performance.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b599616..af104ac 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -558,6 +558,16 @@ static const struct soc_enum aif2dacl_src =
 static const struct soc_enum aif2dacr_src =
 	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 14, 2, aif_chan_src_text);
 
+static const char *osr_text[] = {
+	"Low Power", "High Performance",
+};
+
+static const struct soc_enum dac_osr =
+	SOC_ENUM_SINGLE(WM8994_OVERSAMPLING, 0, 2, osr_text);
+
+static const struct soc_enum adc_osr =
+	SOC_ENUM_SINGLE(WM8994_OVERSAMPLING, 1, 2, osr_text);
+
 static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -834,6 +844,9 @@ SOC_DOUBLE("AIF1ADC2 HPF Switch", WM8994_AIF1_ADC2_FILTERS, 12, 11, 1, 0),
 SOC_ENUM("AIF2ADC HPF Mode", aif2adc_hpf),
 SOC_DOUBLE("AIF2ADC HPF Switch", WM8994_AIF2_ADC_FILTERS, 12, 11, 1, 0),
 
+SOC_ENUM("ADC OSR", adc_osr),
+SOC_ENUM("DAC OSR", dac_osr),
+
 SOC_DOUBLE_R_TLV("DAC1 Volume", WM8994_DAC1_LEFT_VOLUME,
 		 WM8994_DAC1_RIGHT_VOLUME, 1, 96, 0, digital_tlv),
 SOC_DOUBLE_R("DAC1 Switch", WM8994_DAC1_LEFT_VOLUME,
-- 
1.7.1
