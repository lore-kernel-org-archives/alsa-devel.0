From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v7 3/3] ASoC: da7210: Add support for line
 input and mic
Date: Thu, 20 Oct 2011 20:12:51 +0530
Message-ID: <1319121771.24621.131.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id B79C2247C9
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 16:33:57 +0200 (CEST)
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

DA7210 has three line inputs (AUX1 Left, AUX1 Right and AUX2) and
a stereo MIC. This patch adds gain controls for MIC, AUX1, AUX2 as
well as INPGA. It also adds a control to set  MIC BIAS voltage.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v2:
- Removed static enable of mic and aux, as now DAPM will take care of
that

Changes since v1:
- Removed explicit setting of default gains
- Removed control to set mic bias voltage
---
 sound/soc/codecs/da7210.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index eaec60a..2f38b39 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -181,9 +181,14 @@
 
 /* AUX1_L bit fields */
 #define DA7210_AUX1_L_VOL		(0x3F << 0)
+#define DA7210_AUX1_L_EN		(1 << 7)
 
 /* AUX1_R bit fields */
 #define DA7210_AUX1_R_VOL		(0x3F << 0)
+#define DA7210_AUX1_R_EN		(1 << 7)
+
+/* AUX2 bit fields */
+#define DA7210_AUX2_EN			(1 << 3)
 
 /* Minimum INPGA and AUX1 volume to enable noise suppression */
 #define DA7210_INPGA_MIN_VOL_NS		0x0A  /* 10.5dB */
@@ -234,9 +239,19 @@ static const unsigned int mono_vol_tlv[] = {
 	0x3, 0x7, TLV_DB_SCALE_ITEM(-1800, 600, 0)
 };
 
+static const unsigned int aux1_vol_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0x0, 0x10, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
+	/* -48dB to 21dB */
+	0x11, 0x3f, TLV_DB_SCALE_ITEM(-4800, 150, 0)
+};
+
 static const DECLARE_TLV_DB_SCALE(eq_gain_tlv, -1050, 150, 0);
 static const DECLARE_TLV_DB_SCALE(adc_eq_master_gain_tlv, -1800, 600, 1);
 static const DECLARE_TLV_DB_SCALE(dac_gain_tlv, -7725, 75, 0);
+static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, -600, 600, 0);
+static const DECLARE_TLV_DB_SCALE(aux2_vol_tlv, -600, 600, 0);
+static const DECLARE_TLV_DB_SCALE(inpga_gain_tlv, -450, 150, 0);
 
 /* ADC and DAC high pass filter f0 value */
 static const char const *da7210_hpf_cutoff_txt[] = {
@@ -344,6 +359,17 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 	SOC_SINGLE_TLV("Mono Playback Volume", DA7210_OUT2, 0, 0x7, 0,
 		       mono_vol_tlv),
 
+	SOC_DOUBLE_R_TLV("Mic Capture Volume",
+			 DA7210_MIC_L, DA7210_MIC_R,
+			 0, 0x5, 0, mic_vol_tlv),
+	SOC_DOUBLE_R_TLV("Aux1 Capture Volume",
+			 DA7210_AUX1_L, DA7210_AUX1_R,
+			 0, 0x3f, 0, aux1_vol_tlv),
+	SOC_SINGLE_TLV("Aux2 Capture Volume", DA7210_AUX2, 0, 0x3, 0,
+		       aux2_vol_tlv),
+	SOC_DOUBLE_TLV("In PGA Capture Volume", DA7210_IN_GAIN, 0, 4, 0xF, 0,
+		       inpga_gain_tlv),
+
 	/* DAC Equalizer  controls */
 	SOC_SINGLE("DAC EQ Switch", DA7210_DAC_EQ5, 7, 1, 0),
 	SOC_SINGLE_TLV("DAC EQ1 Volume", DA7210_DAC_EQ1_2, 0, 0xf, 1,
@@ -928,6 +954,12 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, DA7210_OUT2, DA7210_OUT2_EN |
 		     DA7210_OUT2_OUTMIX_L | DA7210_OUT2_OUTMIX_R);
 
+	/* Enable Aux1 */
+	snd_soc_write(codec, DA7210_AUX1_L, DA7210_AUX1_L_EN);
+	snd_soc_write(codec, DA7210_AUX1_R, DA7210_AUX1_R_EN);
+	/* Enable Aux2 */
+	snd_soc_write(codec, DA7210_AUX2, DA7210_AUX2_EN);
+
 	/* Diable PLL and bypass it */
 	snd_soc_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);
 
-- 
1.7.1
