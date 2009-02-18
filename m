From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Add digital loopback support
Date: Wed, 18 Feb 2009 14:39:05 +0200
Message-ID: <1234960745-18604-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1234960745-18604-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 964BB10388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:39:17 +0100 (CET)
In-Reply-To: <1234960745-18604-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the digital loopback/bypass support for twl4030 codec.

The digital loopback will let the digimic0 (routed in the TX1 capture path
inside of TWL4030) data to be routed back to the RX2 playback path
(I2S stereo). It can also route the analog capture date routed through the
TX1 back to RX2.

Effectively the digital loopback is routing the audio from the TX1 capture path
to the RX2 playback path.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   57 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c26854b..1691829 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -504,6 +504,25 @@ static const struct snd_kcontrol_new twl4030_dapm_abypassr2_control =
 static const struct snd_kcontrol_new twl4030_dapm_abypassl2_control =
 	SOC_DAPM_SINGLE("Switch", TWL4030_REG_ARXL2_APGA_CTL, 2, 1, 0);
 
+/* Digital bypass gain, 0 mutes the bypass */
+static const unsigned int twl4030_dapm_dbypass_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 3, TLV_DB_SCALE_ITEM(-2400, 0, 1),
+	4, 7, TLV_DB_SCALE_ITEM(-1800, 600, 0),
+};
+
+/* Digital bypass left (TX1L -> RX2L) */
+static const struct snd_kcontrol_new twl4030_dapm_dbypassl_control =
+	SOC_DAPM_SINGLE_TLV("Volume",
+			TWL4030_REG_ATX2ARXPGA, 3, 7, 0,
+			twl4030_dapm_dbypass_tlv);
+
+/* Digital bypass right (TX1R -> RX2R) */
+static const struct snd_kcontrol_new twl4030_dapm_dbypassr_control =
+	SOC_DAPM_SINGLE_TLV("Volume",
+			TWL4030_REG_ATX2ARXPGA, 0, 7, 0,
+			twl4030_dapm_dbypass_tlv);
+
 static int micpath_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -608,12 +627,23 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
 	unsigned char reg;
 
 	reg = twl4030_read_reg_cache(w->codec, m->reg);
-	if (reg & (1 << m->shift))
-		twl4030->bypass_state |=
-			(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
-	else
-		twl4030->bypass_state &=
-			~(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
+
+	if (m->reg <= TWL4030_REG_ARXR2_APGA_CTL) {
+		/* Analog bypass */
+		if (reg & (1 << m->shift))
+			twl4030->bypass_state |=
+				(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
+		else
+			twl4030->bypass_state &=
+				~(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
+	} else {
+		/* Digital bypass */
+		if (reg & (0x7 << m->shift))
+			twl4030->bypass_state |= (1 << (m->shift ? 5 : 4));
+		else
+			twl4030->bypass_state &= ~(1 << (m->shift ? 5 : 4));
+		
+	}
 
 	if (w->codec->bias_level == SND_SOC_BIAS_STANDBY) {
 		if (twl4030->bypass_state)
@@ -934,6 +964,14 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 			&twl4030_dapm_abypassl2_control,
 			bypass_event, SND_SOC_DAPM_POST_REG),
 
+	/* Digital bypasses */
+	SND_SOC_DAPM_SWITCH_E("Left Digital Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_dbypassl_control, bypass_event,
+			SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("Right Digital Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_dbypassr_control, bypass_event,
+			SND_SOC_DAPM_POST_REG),
+
 	SND_SOC_DAPM_MIXER("Analog R1 Playback Mixer", TWL4030_REG_AVDAC_CTL,
 			0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("Analog L1 Playback Mixer", TWL4030_REG_AVDAC_CTL,
@@ -1118,6 +1156,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Analog R2 Playback Mixer", NULL, "Right2 Analog Loopback"},
 	{"Analog L2 Playback Mixer", NULL, "Left2 Analog Loopback"},
 
+	/* Digital bypass routes */
+	{"Right Digital Loopback", "Volume", "TX1 Capture Route"},
+	{"Left Digital Loopback", "Volume", "TX1 Capture Route"},
+
+	{"Analog R2 Playback Mixer", NULL, "Right Digital Loopback"},
+	{"Analog L2 Playback Mixer", NULL, "Left Digital Loopback"},
+
 };
 
 static int twl4030_add_widgets(struct snd_soc_codec *codec)
-- 
1.6.1.3
