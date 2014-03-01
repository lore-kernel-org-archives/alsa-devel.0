From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: neo1973_wm8753: Post gta01 support
	removal cleanup
Date: Sat,  1 Mar 2014 16:17:02 +0100
Message-ID: <1393687023-17584-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 68D4F265338
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 16:16:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

With GTA01 support gone from the driver there is no need to keep a separate
initilization routine for the GTA02 specific bits.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/neo1973_wm8753.c | 116 ++++++++++++-------------------------
 1 file changed, 37 insertions(+), 79 deletions(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 98a04c1..0125d9d 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -192,44 +192,6 @@ static struct snd_soc_ops neo1973_voice_ops = {
 	.hw_free = neo1973_voice_hw_free,
 };
 
-/* Shared routes and controls */
-
-static const struct snd_soc_dapm_widget neo1973_wm8753_dapm_widgets[] = {
-	SND_SOC_DAPM_LINE("GSM Line Out", NULL),
-	SND_SOC_DAPM_LINE("GSM Line In", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Handset Mic", NULL),
-};
-
-static const struct snd_soc_dapm_route neo1973_wm8753_routes[] = {
-	/* Connections to the GSM Module */
-	{"GSM Line Out", NULL, "MONO1"},
-	{"GSM Line Out", NULL, "MONO2"},
-	{"RXP", NULL, "GSM Line In"},
-	{"RXN", NULL, "GSM Line In"},
-
-	/* Connections to Headset */
-	{"MIC1", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "Headset Mic"},
-
-	/* Call Mic */
-	{"MIC2", NULL, "Mic Bias"},
-	{"MIC2N", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "Handset Mic"},
-
-	/* Connect the ALC pins */
-	{"ACIN", NULL, "ACOP"},
-};
-
-static const struct snd_kcontrol_new neo1973_wm8753_controls[] = {
-	SOC_DAPM_PIN_SWITCH("GSM Line Out"),
-	SOC_DAPM_PIN_SWITCH("GSM Line In"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Handset Mic"),
-};
-
-/* GTA02 specific routes and controls */
-
 static int gta02_speaker_enabled;
 
 static int lm4853_set_spk(struct snd_kcontrol *kcontrol,
@@ -257,7 +219,34 @@ static int lm4853_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const struct snd_soc_dapm_route neo1973_gta02_routes[] = {
+static const struct snd_soc_dapm_widget neo1973_wm8753_dapm_widgets[] = {
+	SND_SOC_DAPM_LINE("GSM Line Out", NULL),
+	SND_SOC_DAPM_LINE("GSM Line In", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Handset Mic", NULL),
+	SND_SOC_DAPM_SPK("Handset Spk", NULL),
+	SND_SOC_DAPM_SPK("Stereo Out", lm4853_event),
+};
+
+static const struct snd_soc_dapm_route neo1973_wm8753_routes[] = {
+	/* Connections to the GSM Module */
+	{"GSM Line Out", NULL, "MONO1"},
+	{"GSM Line Out", NULL, "MONO2"},
+	{"RXP", NULL, "GSM Line In"},
+	{"RXN", NULL, "GSM Line In"},
+
+	/* Connections to Headset */
+	{"MIC1", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Headset Mic"},
+
+	/* Call Mic */
+	{"MIC2", NULL, "Mic Bias"},
+	{"MIC2N", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Handset Mic"},
+
+	/* Connect the ALC pins */
+	{"ACIN", NULL, "ACOP"},
+
 	/* Connections to the amp */
 	{"Stereo Out", NULL, "LOUT1"},
 	{"Stereo Out", NULL, "ROUT1"},
@@ -267,7 +256,11 @@ static const struct snd_soc_dapm_route neo1973_gta02_routes[] = {
 	{"Handset Spk", NULL, "ROUT2"},
 };
 
-static const struct snd_kcontrol_new neo1973_gta02_wm8753_controls[] = {
+static const struct snd_kcontrol_new neo1973_wm8753_controls[] = {
+	SOC_DAPM_PIN_SWITCH("GSM Line Out"),
+	SOC_DAPM_PIN_SWITCH("GSM Line In"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Handset Mic"),
 	SOC_DAPM_PIN_SWITCH("Handset Spk"),
 	SOC_DAPM_PIN_SWITCH("Stereo Out"),
 
@@ -276,39 +269,6 @@ static const struct snd_kcontrol_new neo1973_gta02_wm8753_controls[] = {
 		lm4853_set_spk),
 };
 
-static const struct snd_soc_dapm_widget neo1973_gta02_wm8753_dapm_widgets[] = {
-	SND_SOC_DAPM_SPK("Handset Spk", NULL),
-	SND_SOC_DAPM_SPK("Stereo Out", lm4853_event),
-};
-
-static int neo1973_gta02_wm8753_init(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	ret = snd_soc_dapm_new_controls(dapm, neo1973_gta02_wm8753_dapm_widgets,
-			ARRAY_SIZE(neo1973_gta02_wm8753_dapm_widgets));
-	if (ret)
-		return ret;
-
-	ret = snd_soc_dapm_add_routes(dapm, neo1973_gta02_routes,
-			ARRAY_SIZE(neo1973_gta02_routes));
-	if (ret)
-		return ret;
-
-	ret = snd_soc_add_card_controls(codec->card, neo1973_gta02_wm8753_controls,
-			ARRAY_SIZE(neo1973_gta02_wm8753_controls));
-	if (ret)
-		return ret;
-
-	snd_soc_dapm_disable_pin(dapm, "Stereo Out");
-	snd_soc_dapm_disable_pin(dapm, "Handset Spk");
-	snd_soc_dapm_ignore_suspend(dapm, "Stereo Out");
-	snd_soc_dapm_ignore_suspend(dapm, "Handset Spk");
-
-	return 0;
-}
-
 static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
@@ -344,18 +304,16 @@ static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_disable_pin(dapm, "GSM Line In");
 	snd_soc_dapm_disable_pin(dapm, "Headset Mic");
 	snd_soc_dapm_disable_pin(dapm, "Handset Mic");
+	snd_soc_dapm_disable_pin(dapm, "Stereo Out");
+	snd_soc_dapm_disable_pin(dapm, "Handset Spk");
 
 	/* allow audio paths from the GSM modem to run during suspend */
 	snd_soc_dapm_ignore_suspend(dapm, "GSM Line Out");
 	snd_soc_dapm_ignore_suspend(dapm, "GSM Line In");
 	snd_soc_dapm_ignore_suspend(dapm, "Headset Mic");
 	snd_soc_dapm_ignore_suspend(dapm, "Handset Mic");
-
-	if (machine_is_neo1973_gta02()) {
-		ret = neo1973_gta02_wm8753_init(codec);
-		if (ret)
-			return ret;
-	}
+	snd_soc_dapm_ignore_suspend(dapm, "Stereo Out");
+	snd_soc_dapm_ignore_suspend(dapm, "Handset Spk");
 
 	return 0;
 }
-- 
1.8.0
