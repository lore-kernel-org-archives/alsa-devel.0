From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 11/12] ASoC: pxa: tosa: Convert to table
	based DAPM and control setup
Date: Wed, 12 Mar 2014 15:27:39 +0100
Message-ID: <1394634460-15889-12-git-send-email-lars@metafoo.de>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id DBA7326500A
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 15:27:26 +0100 (CET)
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
 sound/soc/pxa/tosa.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index cead165..4a956d1 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -44,9 +44,8 @@
 static int tosa_jack_func;
 static int tosa_spk_func;
 
-static void tosa_ext_control(struct snd_soc_codec *codec)
+static void tosa_ext_control(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	snd_soc_dapm_mutex_lock(dapm);
 
@@ -82,10 +81,9 @@ static void tosa_ext_control(struct snd_soc_codec *codec)
 static int tosa_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
 
 	/* check the jack status at stream startup */
-	tosa_ext_control(codec);
+	tosa_ext_control(&rtd->card->dapm);
 
 	return 0;
 }
@@ -104,13 +102,13 @@ static int tosa_get_jack(struct snd_kcontrol *kcontrol,
 static int tosa_set_jack(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (tosa_jack_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	tosa_jack_func = ucontrol->value.integer.value[0];
-	tosa_ext_control(codec);
+	tosa_ext_control(&card->dapm);
 	return 1;
 }
 
@@ -124,13 +122,13 @@ static int tosa_get_spk(struct snd_kcontrol *kcontrol,
 static int tosa_set_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (tosa_spk_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	tosa_spk_func = ucontrol->value.integer.value[0];
-	tosa_ext_control(codec);
+	tosa_ext_control(&card->dapm);
 	return 1;
 }
 
@@ -191,24 +189,10 @@ static int tosa_ac97_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int err;
 
 	snd_soc_dapm_nc_pin(dapm, "OUT3");
 	snd_soc_dapm_nc_pin(dapm, "MONOOUT");
 
-	/* add tosa specific controls */
-	err = snd_soc_add_codec_controls(codec, tosa_controls,
-				ARRAY_SIZE(tosa_controls));
-	if (err < 0)
-		return err;
-
-	/* add tosa specific widgets */
-	snd_soc_dapm_new_controls(dapm, tosa_dapm_widgets,
-				  ARRAY_SIZE(tosa_dapm_widgets));
-
-	/* set up tosa specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -239,6 +223,13 @@ static struct snd_soc_card tosa = {
 	.owner = THIS_MODULE,
 	.dai_link = tosa_dai,
 	.num_links = ARRAY_SIZE(tosa_dai),
+
+	.controls = tosa_controls,
+	.num_controls = ARRAY_SIZE(tosa_controls),
+	.dapm_widgets = tosa_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tosa_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static int tosa_probe(struct platform_device *pdev)
-- 
1.8.0
