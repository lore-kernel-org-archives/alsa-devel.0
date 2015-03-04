From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/30] ASoC: sn95031: Pass CODEC to
	sn95031_jack_detection()
Date: Wed,  4 Mar 2015 10:33:16 +0100
Message-ID: <1425461626-21103-2-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F300264F0A
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:51 +0100 (CET)
In-Reply-To: <1425461626-21103-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sean Cross <xobs@kosagi.com>, Dylan Reid <dgreid@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The sn95031 driver currently gets the CODEC implicitly from the jack that is
passed to sn95031_jack_detection(). But the codec field is going to be
removed from the snd_soc_jack struct, so refactor things to pass the CODEC
explicitly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sn95031.c     | 14 ++++++++------
 sound/soc/codecs/sn95031.h     |  3 ++-
 sound/soc/intel/mfld_machine.c | 13 +++++++------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 47b257e..1e5d264 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -783,19 +783,21 @@ static inline void sn95031_enable_jack_btn(struct snd_soc_codec *codec)
 	snd_soc_write(codec, SN95031_BTNCTRL2, 0x01);
 }
 
-static int sn95031_get_headset_state(struct snd_soc_jack *mfld_jack)
+static int sn95031_get_headset_state(struct snd_soc_codec *codec,
+	struct snd_soc_jack *mfld_jack)
 {
-	int micbias = sn95031_get_mic_bias(mfld_jack->codec);
+	int micbias = sn95031_get_mic_bias(codec);
 
 	int jack_type = snd_soc_jack_get_type(mfld_jack, micbias);
 
 	pr_debug("jack type detected = %d\n", jack_type);
 	if (jack_type == SND_JACK_HEADSET)
-		sn95031_enable_jack_btn(mfld_jack->codec);
+		sn95031_enable_jack_btn(codec);
 	return jack_type;
 }
 
-void sn95031_jack_detection(struct mfld_jack_data *jack_data)
+void sn95031_jack_detection(struct snd_soc_codec *codec,
+	struct mfld_jack_data *jack_data)
 {
 	unsigned int status;
 	unsigned int mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_HEADSET;
@@ -809,11 +811,11 @@ void sn95031_jack_detection(struct mfld_jack_data *jack_data)
 		status = SND_JACK_HEADSET | SND_JACK_BTN_1;
 	} else if (jack_data->intr_id & 0x4) {
 		pr_debug("headset or headphones inserted\n");
-		status = sn95031_get_headset_state(jack_data->mfld_jack);
+		status = sn95031_get_headset_state(codec, jack_data->mfld_jack);
 	} else if (jack_data->intr_id & 0x8) {
 		pr_debug("headset or headphones removed\n");
 		status = 0;
-		sn95031_disable_jack_btn(jack_data->mfld_jack->codec);
+		sn95031_disable_jack_btn(codec);
 	} else {
 		pr_err("unidentified interrupt\n");
 		return;
diff --git a/sound/soc/codecs/sn95031.h b/sound/soc/codecs/sn95031.h
index 20376d2..7651fe4 100644
--- a/sound/soc/codecs/sn95031.h
+++ b/sound/soc/codecs/sn95031.h
@@ -127,6 +127,7 @@ struct mfld_jack_data {
 	struct snd_soc_jack *mfld_jack;
 };
 
-extern void sn95031_jack_detection(struct mfld_jack_data *jack_data);
+extern void sn95031_jack_detection(struct snd_soc_codec *codec,
+	struct mfld_jack_data *jack_data);
 
 #endif
diff --git a/sound/soc/intel/mfld_machine.c b/sound/soc/intel/mfld_machine.c
index 90b7a57..d22b44d 100644
--- a/sound/soc/intel/mfld_machine.c
+++ b/sound/soc/intel/mfld_machine.c
@@ -228,10 +228,13 @@ static void mfld_jack_check(unsigned int intr_status)
 {
 	struct mfld_jack_data jack_data;
 
+	if (!mfld_codec)
+		return;
+
 	jack_data.mfld_jack = &mfld_jack;
 	jack_data.intr_id = intr_status;
 
-	sn95031_jack_detection(&jack_data);
+	sn95031_jack_detection(mfld_codec, &jack_data);
 	/* TODO: add american headset detection post gpiolib support */
 }
 
@@ -240,8 +243,6 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_dapm_context *dapm = &runtime->card->dapm;
 	int ret_val;
 
-	mfld_codec = runtime->codec;
-
 	/* default is earpiece pin, userspace sets it explcitly */
 	snd_soc_dapm_disable_pin(dapm, "Headphones");
 	/* default is lineout NC, userspace sets it explcitly */
@@ -254,7 +255,7 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_disable_pin(dapm, "LINEINR");
 
 	/* Headset and button jack detection */
-	ret_val = snd_soc_jack_new(mfld_codec, "Intel(R) MID Audio Jack",
+	ret_val = snd_soc_jack_new(runtime->codec, "Intel(R) MID Audio Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 |
 			SND_JACK_BTN_1, &mfld_jack);
 	if (ret_val) {
@@ -275,6 +276,8 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 		return ret_val;
 	}
 
+	mfld_codec = runtime->codec;
+
 	/* we want to check if anything is inserted at boot,
 	 * so send a fake event to codec and it will read adc
 	 * to find if anything is there or not */
@@ -359,8 +362,6 @@ static irqreturn_t snd_mfld_jack_detection(int irq, void *data)
 {
 	struct mfld_mc_private *mc_drv_ctx = (struct mfld_mc_private *) data;
 
-	if (mfld_jack.codec == NULL)
-		return IRQ_HANDLED;
 	mfld_jack_check(mc_drv_ctx->interrupt_status);
 
 	return IRQ_HANDLED;
-- 
1.8.0
