From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: omap3pandora: Convert to table based
	DAPM setup
Date: Sat,  8 Mar 2014 19:16:56 +0100
Message-ID: <1394302616-15991-3-git-send-email-lars@metafoo.de>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-043.synserver.de
 [212.40.185.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A2058265513
 for <alsa-devel@alsa-project.org>; Sat,  8 Mar 2014 19:16:28 +0100 (CET)
In-Reply-To: <1394302616-15991-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the controls and DAPM widgets and routes. This
on one hand makes the code a bit shorter and cleaner and on the other hand the
board level DAPM elements get registered in the card's DAPM context rather than
in the CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/omap3pandora.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index cf604a2..02181bb 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -121,7 +121,7 @@ static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
  *  |A| <~~clk~~+
  *  |P| <--- TWL4030 <--------- Line In and MICs
  */
-static const struct snd_soc_dapm_widget omap3pandora_out_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget omap3pandora_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC_E("PCM DAC", "HiFi Playback", SND_SOC_NOPM,
 			   0, 0, omap3pandora_dac_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -130,22 +130,18 @@ static const struct snd_soc_dapm_widget omap3pandora_out_dapm_widgets[] = {
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_LINE("Line Out", NULL),
-};
 
-static const struct snd_soc_dapm_widget omap3pandora_in_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Mic (internal)", NULL),
 	SND_SOC_DAPM_MIC("Mic (external)", NULL),
 	SND_SOC_DAPM_LINE("Line In", NULL),
 };
 
-static const struct snd_soc_dapm_route omap3pandora_out_map[] = {
+static const struct snd_soc_dapm_route omap3pandora_map[] = {
 	{"PCM DAC", NULL, "APLL Enable"},
 	{"Headphone Amplifier", NULL, "PCM DAC"},
 	{"Line Out", NULL, "PCM DAC"},
 	{"Headphone Jack", NULL, "Headphone Amplifier"},
-};
 
-static const struct snd_soc_dapm_route omap3pandora_in_map[] = {
 	{"AUXL", NULL, "Line In"},
 	{"AUXR", NULL, "Line In"},
 
@@ -160,7 +156,6 @@ static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
 
 	/* All TWL4030 output pins are floating */
 	snd_soc_dapm_nc_pin(dapm, "EARPIECE");
@@ -174,20 +169,13 @@ static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "HFR");
 	snd_soc_dapm_nc_pin(dapm, "VIBRA");
 
-	ret = snd_soc_dapm_new_controls(dapm, omap3pandora_out_dapm_widgets,
-				ARRAY_SIZE(omap3pandora_out_dapm_widgets));
-	if (ret < 0)
-		return ret;
-
-	return snd_soc_dapm_add_routes(dapm, omap3pandora_out_map,
-		ARRAY_SIZE(omap3pandora_out_map));
+	return 0;
 }
 
 static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
 
 	/* Not comnnected */
 	snd_soc_dapm_nc_pin(dapm, "HSMIC");
@@ -195,13 +183,7 @@ static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "DIGIMIC0");
 	snd_soc_dapm_nc_pin(dapm, "DIGIMIC1");
 
-	ret = snd_soc_dapm_new_controls(dapm, omap3pandora_in_dapm_widgets,
-				ARRAY_SIZE(omap3pandora_in_dapm_widgets));
-	if (ret < 0)
-		return ret;
-
-	return snd_soc_dapm_add_routes(dapm, omap3pandora_in_map,
-		ARRAY_SIZE(omap3pandora_in_map));
+	return 0;
 }
 
 static struct snd_soc_ops omap3pandora_ops = {
@@ -241,6 +223,11 @@ static struct snd_soc_card snd_soc_card_omap3pandora = {
 	.owner = THIS_MODULE,
 	.dai_link = omap3pandora_dai,
 	.num_links = ARRAY_SIZE(omap3pandora_dai),
+
+	.dapm_widgets = omap3pandora_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(omap3pandora_dapm_widgets),
+	.dapm_routes = omap3pandora_map,
+	.num_dapm_routes = ARRAY_SIZE(omap3pandora_map),
 };
 
 static struct platform_device *omap3pandora_snd_device;
-- 
1.8.0
