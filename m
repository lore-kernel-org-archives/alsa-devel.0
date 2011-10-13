From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v2 3/9] ASoC: da7210: Add support for ADC & DAC
 equalizers
Date: Thu, 13 Oct 2011 19:36:45 +0530
Message-ID: <1318514805.12107.475.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id 13E66103A5A
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 15:56:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for ADC and DAC five band equalizers
available on DA7210 codec.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 87b9ae5..7e36ed6 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -38,10 +38,16 @@
 #define DA7210_INMIX_R			0x0E
 #define DA7210_ADC_HPF			0x0F
 #define DA7210_ADC			0x10
+#define DA7210_ADC_EQ1_2		0X11
+#define DA7210_ADC_EQ3_4		0x12
+#define DA7210_ADC_EQ5			0x13
 #define DA7210_DAC_HPF			0x14
 #define DA7210_DAC_L			0x15
 #define DA7210_DAC_R			0x16
 #define DA7210_DAC_SEL			0x17
+#define DA7210_DAC_EQ1_2		0x19
+#define DA7210_DAC_EQ3_4		0x1A
+#define DA7210_DAC_EQ5			0x1B
 #define DA7210_OUTMIX_L			0x1C
 #define DA7210_OUTMIX_R			0x1D
 #define DA7210_OUT1_L			0x1E
@@ -181,6 +187,8 @@ static const DECLARE_TLV_DB_SCALE(dac_gain_tlv, -7725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(aux2_vol_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(inpga_gain_tlv, -450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(eq_gain_tlv, -1050, 150, 0);
+static const DECLARE_TLV_DB_SCALE(adc_eq_master_gain_tlv, -1800, 600, 1);
 
 static const unsigned int lineout_vol_tlv[] = {
 	TLV_DB_RANGE_HEAD(2),
@@ -231,6 +239,34 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 
 	SOC_DOUBLE_TLV("In PGA Capture Volume", DA7210_IN_GAIN, 0, 4, 0xF, 0,
 		       inpga_gain_tlv),
+
+	/* DAC Equalizer  controls */
+	SOC_SINGLE("DAC EQ Switch", DA7210_DAC_EQ5, 7, 1, 0),
+	SOC_SINGLE_TLV("DAC EQ1 Volume", DA7210_DAC_EQ1_2, 0, 0xf, 1,
+		       eq_gain_tlv),
+	SOC_SINGLE_TLV("DAC EQ2 Volume", DA7210_DAC_EQ1_2, 4, 0xf, 1,
+		       eq_gain_tlv),
+	SOC_SINGLE_TLV("DAC EQ3 Volume", DA7210_DAC_EQ3_4, 0, 0xf, 1,
+		       eq_gain_tlv),
+	SOC_SINGLE_TLV("DAC EQ4 Volume", DA7210_DAC_EQ3_4, 4, 0xf, 1,
+		       eq_gain_tlv),
+	SOC_SINGLE_TLV("DAC EQ5 Volume", DA7210_DAC_EQ5, 0, 0xf, 1,
+		       eq_gain_tlv),
+
+	/* ADC Equalizer  controls */
+	SOC_SINGLE("ADC EQ Switch", DA7210_ADC_EQ5, 7, 1, 0),
+	SOC_SINGLE_TLV("ADC EQ Master Volume", DA7210_ADC_EQ5, 4, 0x3,
+		       1, adc_eq_master_gain_tlv),
+	SOC_SINGLE_TLV("ADC EQ1 Volume", DA7210_ADC_EQ1_2, 0, 0xf, 1,
+		       eq_gain_tlv),
+	SOC_SINGLE_TLV("ADC EQ2 Volume", DA7210_ADC_EQ1_2, 4, 0xf, 1,
+		       eq_gain_tlv),
+	SOC_SINGLE_TLV("ADC EQ3 Volume", DA7210_ADC_EQ3_4, 0, 0xf, 1,
+		       eq_gain_tlv),
+	SOC_SINGLE_TLV("ADC EQ4 Volume", DA7210_ADC_EQ3_4, 4, 0xf, 1,
+		       eq_gain_tlv),
+	SOC_SINGLE_TLV("ADC EQ5 Volume", DA7210_ADC_EQ5, 0, 0xf, 1,
+		       eq_gain_tlv),
 };
 
 /* Codec private data */
-- 
1.7.1
