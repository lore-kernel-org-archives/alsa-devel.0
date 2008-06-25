From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [asoc-dev][RFC/PATCH 2/3] ASoC: TLV320AIC3X: Add
	support for digital microphone input
Date: Wed, 25 Jun 2008 14:58:46 +0300
Message-ID: <1214395127-7169-3-git-send-email-jarkko.nikula@nokia.com>
References: <1214395127-7169-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A0DB2436C
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 14:00:07 +0200 (CEST)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5PBxvtv008984
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 15:00:06 +0300
In-Reply-To: <1214395127-7169-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

AIC33 and AIC34 codecs in TLV320AIC3x family support digital microphone
input. When enabled, the codec ADC takes bitstream input to low-pass
filter from GPIO2 instead of its own delta-sigma modulator while providing
oversampling clock through GPIO1.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 29dc0ec..4f0bf26 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -455,6 +455,27 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("Right Line2R Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_right_line2_mux_controls),
 
+	/*
+	 * Not a real mic bias widget but similar function. This is for dynamic
+	 * control of GPIO1 digital mic modulator clock output function when
+	 * using digital mic.
+	 */
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "GPIO1 dmic modclk",
+			 AIC3X_GPIO1_REG, 4, 0xf,
+			 AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK,
+			 AIC3X_GPIO1_FUNC_DISABLED),
+
+	/*
+	 * Also similar function like mic bias. Selects digital mic with
+	 * configurable oversampling rate instead of ADC converter.
+	 */
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "DMic Rate 128",
+			 AIC3X_ASD_INTF_CTRLA, 0, 3, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "DMic Rate 64",
+			 AIC3X_ASD_INTF_CTRLA, 0, 3, 2, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "DMic Rate 32",
+			 AIC3X_ASD_INTF_CTRLA, 0, 3, 3, 0),
+
 	/* Mic Bias */
 	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2V",
 			 MICBIAS_CTRL, 6, 3, 1, 0),
@@ -570,6 +591,7 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Left PGA Mixer", "Mic3L Switch", "MIC3L"},
 
 	{"Left ADC", NULL, "Left PGA Mixer"},
+	{"Left ADC", NULL, "GPIO1 dmic modclk"},
 
 	/* Right Input */
 	{"Right Line1R Mux", "single-ended", "LINE1R"},
@@ -583,6 +605,7 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right PGA Mixer", "Mic3R Switch", "MIC3R"},
 
 	{"Right ADC", NULL, "Right PGA Mixer"},
+	{"Right ADC", NULL, "GPIO1 dmic modclk"},
 
 	/* Left PGA Bypass */
 	{"Left PGA Bypass Mixer", "Line Switch", "Left PGA Mixer"},
@@ -643,6 +666,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right Line Out", NULL, "Right Line2 Bypass Mixer"},
 	{"Mono Out", NULL, "Right Line2 Bypass Mixer"},
 	{"Right HP Out", NULL, "Right Line2 Bypass Mixer"},
+
+	/*
+	 * Logical path between digital mic enable and GPIO1 modulator clock
+	 * output function
+	 */
+	{"GPIO1 dmic modclk", NULL, "DMic Rate 128"},
+	{"GPIO1 dmic modclk", NULL, "DMic Rate 64"},
+	{"GPIO1 dmic modclk", NULL, "DMic Rate 32"},
 };
 
 static int aic3x_add_widgets(struct snd_soc_codec *codec)
-- 
1.5.5.4
