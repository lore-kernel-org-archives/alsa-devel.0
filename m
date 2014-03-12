From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 05/12] ASoC: omap: rx51: Convert to table
	based control and DAPM setup
Date: Wed, 12 Mar 2014 15:27:33 +0100
Message-ID: <1394634460-15889-6-git-send-email-lars@metafoo.de>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id E3DDC264F10
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 15:27:15 +0100 (CET)
In-Reply-To: <1394634460-15889-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the controls and DAPM widgets and routes. This
on one hand makes the code a bit shorter and cleaner and on the other hand the
board level DAPM elements get registered in the card's DAPM context rather than
in the CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/rx51.c | 47 +++++++----------------------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 7fb3d4b..2b46411 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -237,9 +237,6 @@ static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", rx51_hp_event),
 	SND_SOC_DAPM_MIC("HS Mic", NULL),
 	SND_SOC_DAPM_LINE("FM Transmitter", NULL),
-};
-
-static const struct snd_soc_dapm_widget aic34_dapm_widgetsb[] = {
 	SND_SOC_DAPM_SPK("Earphone", NULL),
 };
 
@@ -253,9 +250,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	{"DMic Rate 64", NULL, "Mic Bias"},
 	{"Mic Bias", NULL, "DMic"},
-};
 
-static const struct snd_soc_dapm_route audio_mapb[] = {
 	{"b LINE2R", NULL, "MONO_LOUT"},
 	{"Earphone", NULL, "b HPLOUT"},
 
@@ -281,9 +276,6 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 	SOC_ENUM_EXT("Jack Function", rx51_enum[2],
 		     rx51_get_jack, rx51_set_jack),
 	SOC_DAPM_PIN_SWITCH("FM Transmitter"),
-};
-
-static const struct snd_kcontrol_new aic34_rx51_controlsb[] = {
 	SOC_DAPM_PIN_SWITCH("Earphone"),
 };
 
@@ -298,19 +290,6 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "MIC3R");
 	snd_soc_dapm_nc_pin(dapm, "LINE1R");
 
-	/* Add RX-51 specific controls */
-	err = snd_soc_add_card_controls(rtd->card, aic34_rx51_controls,
-				   ARRAY_SIZE(aic34_rx51_controls));
-	if (err < 0)
-		return err;
-
-	/* Add RX-51 specific widgets */
-	snd_soc_dapm_new_controls(dapm, aic34_dapm_widgets,
-				  ARRAY_SIZE(aic34_dapm_widgets));
-
-	/* Set up RX-51 specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	err = tpa6130a2_add_controls(codec);
 	if (err < 0)
 		return err;
@@ -333,24 +312,6 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
-static int rx51_aic34b_init(struct snd_soc_dapm_context *dapm)
-{
-	int err;
-
-	err = snd_soc_add_card_controls(dapm->card, aic34_rx51_controlsb,
-				   ARRAY_SIZE(aic34_rx51_controlsb));
-	if (err < 0)
-		return err;
-
-	err = snd_soc_dapm_new_controls(dapm, aic34_dapm_widgetsb,
-					ARRAY_SIZE(aic34_dapm_widgetsb));
-	if (err < 0)
-		return 0;
-
-	return snd_soc_dapm_add_routes(dapm, audio_mapb,
-				       ARRAY_SIZE(audio_mapb));
-}
-
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link rx51_dai[] = {
 	{
@@ -371,7 +332,6 @@ static struct snd_soc_aux_dev rx51_aux_dev[] = {
 	{
 		.name = "TLV320AIC34b",
 		.codec_name = "tlv320aic3x-codec.2-0019",
-		.init = rx51_aic34b_init,
 	},
 };
 
@@ -392,6 +352,13 @@ static struct snd_soc_card rx51_sound_card = {
 	.num_aux_devs = ARRAY_SIZE(rx51_aux_dev),
 	.codec_conf = rx51_codec_conf,
 	.num_configs = ARRAY_SIZE(rx51_codec_conf),
+
+	.controls = aic34_rx51_controls,
+	.num_controls = ARRAY_SIZE(aic34_rx51_controls),
+	.dapm_widgets = aic34_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aic34_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *rx51_snd_device;
-- 
1.8.0
