From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_max98090_ti: Fix jack
	initialization" to the asoc tree
Date: Tue, 19 Sep 2017 14:45:21 +0100
Message-ID: <E1duIq1-00081K-L2@debutante>
References: <20170908051309.19028-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63D3C2671CF
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:45:33 +0200 (CEST)
In-Reply-To: <20170908051309.19028-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thierry Escande <thierry.escande@collabora.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3bbda5a38601f7675a214be2044e41d7749e6c7b Mon Sep 17 00:00:00 2001
From: Thierry Escande <thierry.escande@collabora.com>
Date: Fri, 8 Sep 2017 00:13:08 -0500
Subject: [PATCH] ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization

If the ts3a227e audio accessory detection hardware is present and its
driver probed, the jack needs to be created before enabling jack
detection in the ts3a227e driver. With this patch, the jack is
instantiated in the max98090 headset init function if the ts3a227e is
present. This fixes a null pointer dereference as the jack detection
enabling function in the ts3a driver was called before the jack is
created.

[minor correction to keep error handling on jack creation the same
as before by Pierre Bossart]

Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 45 +++++++++++++++++++---------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 442a81bf17b4..e5da091abe48 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -166,23 +166,19 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
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
 	if (ret) {
 		dev_err(runtime->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
@@ -257,6 +253,27 @@ static int cht_max98090_headset_init(struct snd_soc_component *component)
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
+	if (ret) {
+		dev_err(card->dev, "Headset Jack creation failed %d\n", ret);
+		return ret;
+	}
 
 	return ts3a227e_enable_jack_detect(component, &ctx->jack);
 }
-- 
2.14.1
