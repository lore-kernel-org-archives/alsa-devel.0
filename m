From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 02/12] ASoC: ams-delta: Convert to table
	based DAPM and control setup
Date: Wed, 12 Mar 2014 15:27:30 +0100
Message-ID: <1394634460-15889-3-git-send-email-lars@metafoo.de>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id E9FD5264F07
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 15:27:13 +0100 (CET)
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

Use table based setup to register the controls and DAPM widgets and routes.
This on one hand makes the code a bit shorter and cleaner and on the other
hand the board level DAPM elements get registered in the card's DAPM context
rather than in the CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/ams-delta.c | 64 +++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 14718cd..46d83f4 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -38,7 +38,6 @@
 #include "omap-mcbsp.h"
 #include "../codecs/cx20442.h"
 
-
 /* Board specific DAPM widgets */
 static const struct snd_soc_dapm_widget ams_delta_dapm_widgets[] = {
 	/* Handset */
@@ -90,17 +89,23 @@ static const unsigned short ams_delta_audio_mode_pins[] = {
 
 static unsigned short ams_delta_audio_agc;
 
+/*
+ * Used for passing a codec structure pointer
+ * from the board initialization code to the tty line discipline.
+ */
+static struct snd_soc_codec *cx20442_codec;
+
 static int ams_delta_set_audio_mode(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 	struct soc_enum *control = (struct soc_enum *)kcontrol->private_value;
 	unsigned short pins;
 	int pin, changed = 0;
 
 	/* Refuse any mode changes if we are not able to control the codec. */
-	if (!codec->hw_write)
+	if (!cx20442_codec->hw_write)
 		return -EUNATCH;
 
 	if (ucontrol->value.enumerated.item[0] >= control->max)
@@ -166,8 +171,8 @@ static int ams_delta_set_audio_mode(struct snd_kcontrol *kcontrol,
 static int ams_delta_get_audio_mode(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 	unsigned short pins, mode;
 
 	pins = ((snd_soc_dapm_get_pin_status(dapm, "Mouthpiece") <<
@@ -272,12 +277,6 @@ static void cx81801_timeout(unsigned long data)
 		ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, 0);
 }
 
-/*
- * Used for passing a codec structure pointer
- * from the board initialization code to the tty line discipline.
- */
-static struct snd_soc_codec *cx20442_codec;
-
 /* Line discipline .open() */
 static int cx81801_open(struct tty_struct *tty)
 {
@@ -304,7 +303,7 @@ static int cx81801_open(struct tty_struct *tty)
 static void cx81801_close(struct tty_struct *tty)
 {
 	struct snd_soc_codec *codec = tty->disc_data;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &codec->card->dapm;
 
 	del_timer_sync(&cx81801_timer);
 
@@ -477,15 +476,14 @@ static void ams_delta_shutdown(struct snd_pcm_substream *substream)
 
 static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 	int ret;
 	/* Codec is ready, now add/activate board specific controls */
 
 	/* Store a pointer to the codec structure for tty ldisc use */
-	cx20442_codec = codec;
+	cx20442_codec = rtd->codec;
 
 	/* Set up digital mute if not provided by the codec */
 	if (!codec_dai->driver->ops) {
@@ -522,25 +520,6 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 		return 0;
 	}
 
-	/* Add board specific DAPM widgets and routes */
-	ret = snd_soc_dapm_new_controls(dapm, ams_delta_dapm_widgets,
-					ARRAY_SIZE(ams_delta_dapm_widgets));
-	if (ret) {
-		dev_warn(card->dev,
-				"Failed to register DAPM controls, "
-				"will continue without any.\n");
-		return 0;
-	}
-
-	ret = snd_soc_dapm_add_routes(dapm, ams_delta_audio_map,
-					ARRAY_SIZE(ams_delta_audio_map));
-	if (ret) {
-		dev_warn(card->dev,
-				"Failed to set up DAPM routes, "
-				"will continue with codec default map.\n");
-		return 0;
-	}
-
 	/* Set up initial pin constellation */
 	snd_soc_dapm_disable_pin(dapm, "Mouthpiece");
 	snd_soc_dapm_enable_pin(dapm, "Earpiece");
@@ -549,14 +528,6 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_disable_pin(dapm, "AGCIN");
 	snd_soc_dapm_disable_pin(dapm, "AGCOUT");
 
-	/* Add virtual switch */
-	ret = snd_soc_add_codec_controls(codec, ams_delta_audio_controls,
-					ARRAY_SIZE(ams_delta_audio_controls));
-	if (ret)
-		dev_warn(card->dev,
-				"Failed to register audio mode control, "
-				"will continue without it.\n");
-
 	return 0;
 }
 
@@ -578,6 +549,13 @@ static struct snd_soc_card ams_delta_audio_card = {
 	.owner = THIS_MODULE,
 	.dai_link = &ams_delta_dai_link,
 	.num_links = 1,
+
+	.controls = ams_delta_audio_controls,
+	.num_controls = ARRAY_SIZE(ams_delta_audio_controls),
+	.dapm_widgets = ams_delta_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ams_delta_dapm_widgets),
+	.dapm_routes = ams_delta_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(ams_delta_audio_map),
 };
 
 /* Module init/exit */
-- 
1.8.0
