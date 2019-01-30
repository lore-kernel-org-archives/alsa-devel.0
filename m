From: Danny Milosavljevic <dannym@scratchpost.org>
Subject: [PATCH v15 4/8] ASoC: sun4i-codec: Add Mic1 Boost
	Volume, Mic2 Boost Volume
Date: Wed, 30 Jan 2019 11:39:40 +0100
Message-ID: <20190130103945.26692-5-dannym@scratchpost.org>
References: <20190130103945.26692-1-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd26836.kasserver.com (dd26836.kasserver.com [85.13.145.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EB21267963
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 15:26:09 +0100 (CET)
In-Reply-To: <20190130103945.26692-1-dannym@scratchpost.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Danny Milosavljevic <dannym@scratchpost.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add Mic1 Boost Volume and Mic2 Boost Volume for Allwinner A10 and for
Allwinner A20.

Those controls are in different registers per chip model, so put the
Allwinner A10 controls and the Allwinner A20 controls into the newly
split sun4i_codec_controls and sun7i_codec_controls, respectively.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 52453c46b..9d509ede2 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -95,6 +95,8 @@
 #define SUN4I_CODEC_ADC_ACTL_PREG1EN			(29)
 #define SUN4I_CODEC_ADC_ACTL_PREG2EN			(28)
 #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
+#define SUN4I_CODEC_ADC_ACTL_PREG1			(25)
+#define SUN4I_CODEC_ADC_ACTL_PREG2			(23)
 #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
@@ -111,6 +113,9 @@
 /* Microphone controls (sun7i only) */
 #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1		(29)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2		(26)
+
 /*
  * sun6i specific registers
  *
@@ -676,6 +681,12 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
 			    0);
+static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
+			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+			    1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));
+static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
+			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
@@ -684,6 +695,12 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
+	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG1, 3, 0,
+		       sun4i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG2, 3, 0,
+		       sun4i_codec_micin_preamp_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun7i_codec_controls[] = {
@@ -693,6 +710,12 @@ static const struct snd_kcontrol_new sun7i_codec_controls[] = {
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
+	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1, 7, 0,
+		       sun7i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2, 7, 0,
+		       sun7i_codec_micin_preamp_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
