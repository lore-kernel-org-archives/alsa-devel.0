From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 04/14] ASoc: cht_bsw_max98090_ti: Fix jack
	initialization
Date: Tue, 22 Aug 2017 15:32:29 -0500
Message-ID: <20170822203239.19891-5-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 42150267035
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:12 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Thierry Escande <thierry.escande@collabora.com>
List-Id: alsa-devel@alsa-project.org

From: Thierry Escande <thierry.escande@collabora.com>

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
index 957bae2..7feaaa0 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -174,30 +174,21 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
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
 
 	if (ctx->mclk) {
 		/*
@@ -266,6 +257,25 @@ static int cht_max98090_headset_init(struct snd_soc_component *component)
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
2.9.3
