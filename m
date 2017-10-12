From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ASoC: cht_bsw_max98090_ti: Fix NULL pointer dereference while accessing jack
Date: Thu, 12 Oct 2017 12:28:59 -0700
Message-ID: <1507836539-26587-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Mengdong Lin <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guenter Roeck <groeck@chromium.org>

Commit f2ed6b07645e ("ASoC: Make aux_dev more like a generic component")
caused a regression on this driver, since now a kernel oops is seen
when the driver is loaded, or more specifically when
ts3a227e_enable_jack_detect() is called.

That commit changed the probing of aux_devs before checking new DAI links,
so cht_max98090_headset_init is now called before cht_codec_init. The
kernel crashes due a NULL pointer dereference in cht_max98090_headset_init
since there is a call that tries to access the jack pointer which has not
been allocated yet.

This patch moves the new jack object creation from cht_codec_init to
cht_max98090_headset_init, making sure the jack is created before is
accessed.

Also see upstream commit 5f22449344d9 ("ASoC: rockchip-max98090: Fix NULL
pointer dereference while accessing to jack.") for a similar fix in the
rockchip-max98090 driver.

Fixes: f2ed6b07645e ("ASoC: Make aux_dev more like a generic component")
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 55 ++++++++++++++--------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 20755ecc7f9e..c1518db7bb61 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -111,37 +111,12 @@ static struct notifier_block cht_jack_nb = {
 
 static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
-	int ret;
-	int jack_type;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
-	struct snd_soc_jack *jack = &ctx->jack;
-
-	/**
-	* TI supports 4 butons headset detection
-	* KEY_MEDIA
-	* KEY_VOICECOMMAND
-	* KEY_VOLUMEUP
-	* KEY_VOLUMEDOWN
-	*/
-	if (ctx->ts3a227e_present)
-		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-					SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-					SND_JACK_BTN_2 | SND_JACK_BTN_3;
-	else
-		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
-
-	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
-					jack_type, jack, NULL, 0);
-
-	if (ret) {
-		dev_err(runtime->dev, "Headset Jack creation failed %d\n", ret);
-		return ret;
-	}
 
 	if (ctx->ts3a227e_present)
-		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
+		snd_soc_jack_notifier_register(&ctx->jack, &cht_jack_nb);
 
-	return ret;
+	return 0;
 }
 
 static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -188,8 +163,32 @@ static int cht_max98090_headset_init(struct snd_soc_component *component)
 {
 	struct snd_soc_card *card = component->card;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
+	struct snd_soc_jack *jack = &ctx->jack;
+	int jack_type;
+	int ret;
+
+	/*
+	 * TI supports 4 butons headset detection
+	 * KEY_MEDIA
+	 * KEY_VOICECOMMAND
+	 * KEY_VOLUMEUP
+	 * KEY_VOLUMEDOWN
+	 */
+	if (ctx->ts3a227e_present)
+		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+					SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					SND_JACK_BTN_2 | SND_JACK_BTN_3;
+	else
+		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
+
+	ret = snd_soc_card_jack_new(card, "Headset Jack", jack_type, jack,
+				    NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Headset Jack creation failed %d\n", ret);
+		return ret;
+	}
 
-	return ts3a227e_enable_jack_detect(component, &ctx->jack);
+	return ts3a227e_enable_jack_detect(component, jack);
 }
 
 static const struct snd_soc_ops cht_aif1_ops = {
-- 
2.7.4
