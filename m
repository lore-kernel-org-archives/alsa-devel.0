From: Thierry Escande <thierry.escande@collabora.com>
Subject: [PATCH 1/2] ASoc: cht_bsw_max98090_ti: Fix jack initialization
Date: Tue,  2 May 2017 12:11:08 +0200
Message-ID: <1493719869-16100-2-git-send-email-thierry.escande@collabora.com>
References: <1493719869-16100-1-git-send-email-thierry.escande@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493719869-16100-1-git-send-email-thierry.escande@collabora.com>
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If the ts3a227e audio accessory detection hardware is present and its
driver probed, the jack needs to be created before enabling jack
detection in the ts3a227e driver. With this patch, the jack is
instantiated in the max98090 headset init function if the ts3a227e is
present. This fixes a null pointer dereference as the jack detection
enabling function in the ts3a driver was called before the jack is
created.

Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 50 +++++++++++++++++-----------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 742bc0d..f17e474 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -128,30 +128,21 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 	struct snd_soc_jack *jack = &ctx->jack;
 
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
+	if (ctx->ts3a227e_present) {
+		/*
+		 * The jack has already been created in the
+		 * cht_max98090_headset_init() function.
+		 */
+		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
+		return 0;
+	}
+
+	jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
 
 	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
 					jack_type, jack, NULL, 0);
-
-	if (ret) {
+	if (ret)
 		dev_err(runtime->dev, "Headset Jack creation failed %d\n", ret);
-		return ret;
-	}
-
-	if (ctx->ts3a227e_present)
-		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
 
 	return ret;
 }
@@ -200,6 +191,25 @@ static int cht_max98090_headset_init(struct snd_soc_component *component)
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
+	jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+		    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+		    SND_JACK_BTN_2 | SND_JACK_BTN_3;
+
+	ret = snd_soc_card_jack_new(card, "Headset Jack", jack_type,
+				    jack, NULL, 0);
+	if (ret)
+		return ret;
 
 	return ts3a227e_enable_jack_detect(component, &ctx->jack);
 }
-- 
2.7.4
