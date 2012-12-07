From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH] ASoC: cs42l73: Add DAPM events for power down.
Date: Fri, 7 Dec 2012 14:53:43 -0600
Message-ID: <1354913625-11350-2-git-send-email-Paul.Handrigan@cirrus.com>
References: <1354913625-11350-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CB8D265141
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 22:13:44 +0100 (CET)
In-Reply-To: <1354913625-11350-1-git-send-email-Paul.Handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: brian.austin@cirrus.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Add power down delays between setting PDN and MCLKDIS for spk amp, spklo amp, and ear amp.

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |   80 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 2c08c4c..9447200 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -40,6 +40,7 @@ struct  cs42l73_private {
 	u32 sysclk;
 	u8 mclksel;
 	u32 mclk;
+	int shutdwn_delay;
 };
 
 static const struct reg_default cs42l73_reg_defaults[] = {
@@ -588,6 +589,57 @@ static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
 	SOC_ENUM("XSPOUT Mono/Stereo Select", xsp_output_mux_enum),
 };
 
+static int cs42l73_spklo_spk_amp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMD:
+		/* 150 ms delay between setting PDN and MCLKDIS */
+		priv->shutdwn_delay = 150;
+		break;
+	default:
+		pr_err("Invalid event = 0x%x\n", event);
+	}
+	return 0;
+}
+
+static int cs42l73_ear_amp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMD:
+		/* 50 ms delay between setting PDN and MCLKDIS */
+		if (priv->shutdwn_delay < 50)
+			priv->shutdwn_delay = 50;
+		break;
+	default:
+		pr_err("Invalid event = 0x%x\n", event);
+	}
+	return 0;
+}
+
+
+static int cs42l73_hp_amp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMD:
+		/* 30 ms delay between setting PDN and MCLKDIS */
+		if (priv->shutdwn_delay < 30)
+			priv->shutdwn_delay = 30;
+		break;
+	default:
+		pr_err("Invalid event = 0x%x\n", event);
+	}
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LINEINA"),
 	SND_SOC_DAPM_INPUT("LINEINB"),
@@ -674,16 +726,20 @@ static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("SPK DAC", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("ESL DAC", SND_SOC_NOPM, 0, 0, NULL, 0),
 
-	SND_SOC_DAPM_SWITCH("HP Amp", CS42L73_PWRCTL3, 0, 1,
-			    &hp_amp_ctl),
+	SND_SOC_DAPM_SWITCH_E("HP Amp",  CS42L73_PWRCTL3, 0, 1,
+			    &hp_amp_ctl, cs42l73_hp_amp_event,
+			SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SWITCH("LO Amp", CS42L73_PWRCTL3, 1, 1,
 			    &lo_amp_ctl),
-	SND_SOC_DAPM_SWITCH("SPK Amp", CS42L73_PWRCTL3, 2, 1,
-			    &spk_amp_ctl),
-	SND_SOC_DAPM_SWITCH("EAR Amp", CS42L73_PWRCTL3, 3, 1,
-			    &ear_amp_ctl),
-	SND_SOC_DAPM_SWITCH("SPKLO Amp", CS42L73_PWRCTL3, 4, 1,
-			    &spklo_amp_ctl),
+	SND_SOC_DAPM_SWITCH_E("SPK Amp", CS42L73_PWRCTL3, 2, 1,
+			&spk_amp_ctl, cs42l73_spklo_spk_amp_event,
+			SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SWITCH_E("EAR Amp", CS42L73_PWRCTL3, 3, 1,
+			    &ear_amp_ctl, cs42l73_ear_amp_event,
+			SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SWITCH_E("SPKLO Amp", CS42L73_PWRCTL3, 4, 1,
+			    &spklo_amp_ctl, cs42l73_spklo_spk_amp_event,
+			SND_SOC_DAPM_POST_PMD),
 
 	SND_SOC_DAPM_OUTPUT("HPOUTA"),
 	SND_SOC_DAPM_OUTPUT("HPOUTB"),
@@ -1167,6 +1223,14 @@ static int cs42l73_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_OFF:
 		snd_soc_update_bits(codec, CS42L73_PWRCTL1, PDN, 1);
+		if (cs42l73->shutdwn_delay > 0) {
+			mdelay(cs42l73->shutdwn_delay);
+			cs42l73->shutdwn_delay = 0;
+		} else {
+			mdelay(15); /* Min amount of time requred to power
+				     * down.
+				     */
+		}
 		snd_soc_update_bits(codec, CS42L73_DMMCC, MCLKDIS, 1);
 		break;
 	}
-- 
1.7.0.4
