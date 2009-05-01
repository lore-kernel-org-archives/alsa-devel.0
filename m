From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 2/2] ASoC: TWL4030: Add voice digital loopback:
	sidetone
Date: Thu, 30 Apr 2009 21:48:08 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F63E0BA8@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CC522479D
	for <alsa-devel@alsa-project.org>;
	Fri,  1 May 2009 04:48:17 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

This patch add voice digital loopback (sidetone) to the twl4030
driver. It mixes voice uplink attenuated (by sidetone gain) with
voice downlink when the codec is working in option2 (voice/audio
mode).

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index efb371f..23bae74 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -491,6 +491,18 @@ static const struct snd_kcontrol_new twl4030_dapm_dbypassr_control =
 			TWL4030_REG_ATX2ARXPGA, 0, 7, 0,
 			twl4030_dapm_dbypass_tlv);
 
+/*
+ * Voice Sidetone GAIN volume control:
+ * from -51 to -10 dB in 1 dB steps (mute instead of -51 dB)
+ */
+static DECLARE_TLV_DB_SCALE(twl4030_dapm_dbypassv_tlv, -5100, 100, 1);
+
+/* Digital bypass voice: sidetone (VUL -> VDL)*/
+static const struct snd_kcontrol_new twl4030_dapm_dbypassv_control =
+	SOC_DAPM_SINGLE_TLV("Volume",
+			TWL4030_REG_VSTPGA, 0, 0x29, 0,
+			twl4030_dapm_dbypassv_tlv);
+
 static int micpath_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -607,12 +619,18 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
 			twl4030->bypass_state |= (1 << 4);
 		else
 			twl4030->bypass_state &= ~(1 << 4);
+	} else if (m->reg == TWL4030_REG_VSTPGA) {
+		/* Voice digital bypass */
+		if (reg)
+			twl4030->bypass_state |= (1 << 5);
+		else
+			twl4030->bypass_state &= ~(1 << 5);
 	} else {
 		/* Digital bypass */
 		if (reg & (0x7 << m->shift))
-			twl4030->bypass_state |= (1 << (m->shift ? 6 : 5));
+			twl4030->bypass_state |= (1 << (m->shift ? 7 : 6));
 		else
-			twl4030->bypass_state &= ~(1 << (m->shift ? 6 : 5));
+			twl4030->bypass_state &= ~(1 << (m->shift ? 7 : 6));
 	}
 
 	/* Enable master analog loopback mode if any analog switch is enabled*/
@@ -991,6 +1009,9 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH_E("Right Digital Loopback", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_dbypassr_control, bypass_event,
 			SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("Voice Digital Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_dbypassv_control, bypass_event,
+			SND_SOC_DAPM_POST_REG),
 
 	SND_SOC_DAPM_MIXER("Analog R1 Playback Mixer", TWL4030_REG_AVDAC_CTL,
 			0, 0, NULL, 0),
@@ -1203,9 +1224,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* Digital bypass routes */
 	{"Right Digital Loopback", "Volume", "TX1 Capture Route"},
 	{"Left Digital Loopback", "Volume", "TX1 Capture Route"},
+	{"Voice Digital Loopback", "Volume", "TX2 Capture Route"},
 
 	{"Analog R2 Playback Mixer", NULL, "Right Digital Loopback"},
 	{"Analog L2 Playback Mixer", NULL, "Left Digital Loopback"},
+	{"Analog Voice Playback Mixer", NULL, "Voice Digital Loopback"},
 
 };
 
-- 
1.5.4.3
