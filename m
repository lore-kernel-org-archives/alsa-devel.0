From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: s6105-ipcam: Convert to table based DAPM
	setup
Date: Sat,  8 Mar 2014 15:54:36 +0100
Message-ID: <1394290476-1057-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-020.synserver.de
 [212.40.185.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B60B72654FD
 for <alsa-devel@alsa-project.org>; Sat,  8 Mar 2014 15:54:04 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the DAPM widgets and routes. This on one hand
makes the code a bit shorter and cleaner and on the other hand the board level
DAPM elements get registered in the card's DAPM context rather than in the
CODEC's DAPM context.

While we are at it also remove the snd_soc_dapm_enable_pin() in the init
callback, since pins are enabled by default. Also drop the snd_soc_dapm_sync()
calls, since they are ignored by the core anyway until the card has been fully
instantiated.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/s6000/s6105-ipcam.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index 945e8ab..b2fb37c 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -104,8 +104,8 @@ static int output_type_get(struct snd_kcontrol *kcontrol,
 static int output_type_put(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = kcontrol->private_data;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = kcontrol->private_data;
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 	unsigned int val = (ucontrol->value.enumerated.item[0] != 0);
 	char *differential = "Audio Out Differential";
 	char *stereo = "Audio Out Stereo";
@@ -137,13 +137,7 @@ static int s6105_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* Add s6105 specific widgets */
-	snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
-				  ARRAY_SIZE(aic3x_dapm_widgets));
-
-	/* Set up s6105 specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
+	struct snd_soc_card *card = rtd->card;
 
 	/* not present */
 	snd_soc_dapm_nc_pin(dapm, "MONO_LOUT");
@@ -157,17 +151,10 @@ static int s6105_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "RLOUT");
 	snd_soc_dapm_nc_pin(dapm, "HPRCOM");
 
-	/* always connected */
-	snd_soc_dapm_enable_pin(dapm, "Audio In");
-
 	/* must correspond to audio_out_mux.private_value initializer */
-	snd_soc_dapm_disable_pin(dapm, "Audio Out Differential");
-	snd_soc_dapm_sync(dapm);
-	snd_soc_dapm_enable_pin(dapm, "Audio Out Stereo");
-
-	snd_soc_dapm_sync(dapm);
+	snd_soc_dapm_disable_pin(&card->dapm, "Audio Out Differential");
 
-	snd_ctl_add(codec->card->snd_card, snd_ctl_new1(&audio_out_mux, codec));
+	snd_ctl_add(card->snd_card, snd_ctl_new1(&audio_out_mux, card));
 
 	return 0;
 }
@@ -190,6 +177,11 @@ static struct snd_soc_card snd_soc_card_s6105 = {
 	.owner = THIS_MODULE,
 	.dai_link = &s6105_dai,
 	.num_links = 1,
+
+	.dapm_widgets = aic3x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aic3x_dapm_widgets),
+	.dapm_routes = audio_map, 
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct s6000_snd_platform_data s6105_snd_data __initdata = {
-- 
1.8.0
