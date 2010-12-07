From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add ADC high pass filter support to
	WM8994
Date: Tue,  7 Dec 2010 13:59:19 +0000
Message-ID: <1291730359-8337-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB15C103A6A
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:59:31 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Uk Kim <w0806.kim@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Uk Kim <w0806.kim@samsung.com>
---
 sound/soc/codecs/wm8994.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b37e95c..78b96f6 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -310,6 +310,19 @@ static const char *sidetone_hpf_text[] = {
 static const struct soc_enum sidetone_hpf =
 	SOC_ENUM_SINGLE(WM8994_SIDETONE, 7, 7, sidetone_hpf_text);
 
+static const char *adc_hpf_text[] = {
+	"HiFi", "Voice 1", "Voice 2", "Voice 3"
+};
+
+static const struct soc_enum aif1adc1_hpf =
+	SOC_ENUM_SINGLE(WM8994_AIF1_ADC1_FILTERS, 13, 4, adc_hpf_text);
+
+static const struct soc_enum aif1adc2_hpf =
+	SOC_ENUM_SINGLE(WM8994_AIF1_ADC2_FILTERS, 13, 4, adc_hpf_text);
+
+static const struct soc_enum aif2adc_hpf =
+	SOC_ENUM_SINGLE(WM8994_AIF2_ADC_FILTERS, 13, 4, adc_hpf_text);
+
 static const DECLARE_TLV_DB_SCALE(aif_tlv, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -7200, 75, 1);
 static const DECLARE_TLV_DB_SCALE(st_tlv, -3600, 300, 0);
@@ -812,6 +825,15 @@ SOC_SINGLE_TLV("DAC2 Left Sidetone Volume", WM8994_DAC2_MIXER_VOLUMES,
 SOC_ENUM("Sidetone HPF Mux", sidetone_hpf),
 SOC_SINGLE("Sidetone HPF Switch", WM8994_SIDETONE, 6, 1, 0),
 
+SOC_ENUM("AIF1ADC1 HPF Mode", aif1adc1_hpf),
+SOC_DOUBLE("AIF1ADC1 HPF Switch", WM8994_AIF1_ADC1_FILTERS, 12, 11, 1, 0),
+
+SOC_ENUM("AIF1ADC2 HPF Mode", aif1adc2_hpf),
+SOC_DOUBLE("AIF1ADC2 HPF Switch", WM8994_AIF1_ADC2_FILTERS, 12, 11, 1, 0),
+
+SOC_ENUM("AIF2ADC HPF Mode", aif2adc_hpf),
+SOC_DOUBLE("AIF2ADC HPF Switch", WM8994_AIF2_ADC_FILTERS, 12, 11, 1, 0),
+
 SOC_DOUBLE_R_TLV("DAC1 Volume", WM8994_DAC1_LEFT_VOLUME,
 		 WM8994_DAC1_RIGHT_VOLUME, 1, 96, 0, digital_tlv),
 SOC_DOUBLE_R("DAC1 Switch", WM8994_DAC1_LEFT_VOLUME,
-- 
1.7.1
