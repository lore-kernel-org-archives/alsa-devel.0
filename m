From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/8] ASoC: pxa: magician: Convert to table
	based DAPM and control setup
Date: Sat,  1 Mar 2014 15:48:17 +0100
Message-ID: <1393685300-5307-5-git-send-email-lars@metafoo.de>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-192.synserver.de
 [212.40.185.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 745532654A4
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 15:47:56 +0100 (CET)
In-Reply-To: <1393685300-5307-1-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the controls and DAPM widgets and routes. This
on one hand makes the code a bit shorter and cleaner and on the other hand the
board level DAPM elements get registered in the card's DAPM context rather than
in the CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/magician.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 41ab6678..6296059 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -41,10 +41,8 @@ static int magician_hp_switch;
 static int magician_spk_switch = 1;
 static int magician_in_sel = MAGICIAN_MIC;
 
-static void magician_ext_control(struct snd_soc_codec *codec)
+static void magician_ext_control(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
 	snd_soc_dapm_mutex_lock(dapm);
 
 	if (magician_spk_switch)
@@ -75,10 +73,9 @@ static void magician_ext_control(struct snd_soc_codec *codec)
 static int magician_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
 
 	/* check the jack status at stream startup */
-	magician_ext_control(codec);
+	magician_ext_control(&rtd->card->dapm);
 
 	return 0;
 }
@@ -277,13 +274,13 @@ static int magician_get_hp(struct snd_kcontrol *kcontrol,
 static int magician_set_hp(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (magician_hp_switch == ucontrol->value.integer.value[0])
 		return 0;
 
 	magician_hp_switch = ucontrol->value.integer.value[0];
-	magician_ext_control(codec);
+	magician_ext_control(&card->dapm);
 	return 1;
 }
 
@@ -297,13 +294,13 @@ static int magician_get_spk(struct snd_kcontrol *kcontrol,
 static int magician_set_spk(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (magician_spk_switch == ucontrol->value.integer.value[0])
 		return 0;
 
 	magician_spk_switch = ucontrol->value.integer.value[0];
-	magician_ext_control(codec);
+	magician_ext_control(&card->dapm);
 	return 1;
 }
 
@@ -400,7 +397,6 @@ static int magician_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int err;
 
 	/* NC codec pins */
 	snd_soc_dapm_nc_pin(dapm, "VOUTLHP");
@@ -410,19 +406,6 @@ static int magician_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "VINL");
 	snd_soc_dapm_nc_pin(dapm, "VINR");
 
-	/* Add magician specific controls */
-	err = snd_soc_add_codec_controls(codec, uda1380_magician_controls,
-				ARRAY_SIZE(uda1380_magician_controls));
-	if (err < 0)
-		return err;
-
-	/* Add magician specific widgets */
-	snd_soc_dapm_new_controls(dapm, uda1380_dapm_widgets,
-				  ARRAY_SIZE(uda1380_dapm_widgets));
-
-	/* Set up magician specific audio path interconnects */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -456,6 +439,12 @@ static struct snd_soc_card snd_soc_card_magician = {
 	.dai_link = magician_dai,
 	.num_links = ARRAY_SIZE(magician_dai),
 
+	.controls = uda1380_magician_controls,
+	.num_controls = ARRAY_SIZE(uda1380_magician_controls),
+	.dapm_widgets = uda1380_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(uda1380_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *magician_snd_device;
-- 
1.8.0
