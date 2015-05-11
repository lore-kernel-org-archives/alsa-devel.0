From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] ASoC: ab8500: Replace direct
	snd_soc_codec dapm field access
Date: Mon, 11 May 2015 09:42:27 +0200
Message-ID: <1431330156-16706-2-git-send-email-lars@metafoo.de>
References: <1431330156-16706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-107.synserver.de (smtp-out-107.synserver.de
 [212.40.185.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E629260690
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 09:42:46 +0200 (CEST)
In-Reply-To: <1431330156-16706-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Rongjun Ying <rongjun.ying@csr.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ab8500-codec.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 88ca9cb..c7d243d 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -1209,6 +1209,7 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 	struct device *dev = codec->dev;
 	bool apply_fir, apply_iir;
@@ -1234,15 +1235,14 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 	apply_fir = req == ANC_APPLY_FIR || req == ANC_APPLY_FIR_IIR;
 	apply_iir = req == ANC_APPLY_IIR || req == ANC_APPLY_FIR_IIR;
 
-	status = snd_soc_dapm_force_enable_pin(&codec->dapm,
-					"ANC Configure Input");
+	status = snd_soc_dapm_force_enable_pin(dapm, "ANC Configure Input");
 	if (status < 0) {
 		dev_err(dev,
 			"%s: ERROR: Failed to enable power (status = %d)!\n",
 			__func__, status);
 		goto cleanup;
 	}
-	snd_soc_dapm_sync(&codec->dapm);
+	snd_soc_dapm_sync(dapm);
 
 	anc_configure(codec, apply_fir, apply_iir);
 
@@ -1259,8 +1259,8 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 			drvdata->anc_status =  ANC_IIR_CONFIGURED;
 	}
 
-	status = snd_soc_dapm_disable_pin(&codec->dapm, "ANC Configure Input");
-	snd_soc_dapm_sync(&codec->dapm);
+	status = snd_soc_dapm_disable_pin(dapm, "ANC Configure Input");
+	snd_soc_dapm_sync(dapm);
 
 cleanup:
 	mutex_unlock(&drvdata->ctrl_lock);
@@ -1947,6 +1947,7 @@ static int ab8500_audio_init_audioblock(struct snd_soc_codec *codec)
 static int ab8500_audio_setup_mics(struct snd_soc_codec *codec,
 			struct amic_settings *amics)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	u8 value8;
 	unsigned int value;
 	int status;
@@ -1973,15 +1974,15 @@ static int ab8500_audio_setup_mics(struct snd_soc_codec *codec,
 	dev_dbg(codec->dev, "%s: Mic 1a regulator: %s\n", __func__,
 		amic_micbias_str(amics->mic1a_micbias));
 	route = &ab8500_dapm_routes_mic1a_vamicx[amics->mic1a_micbias];
-	status = snd_soc_dapm_add_routes(&codec->dapm, route, 1);
+	status = snd_soc_dapm_add_routes(dapm, route, 1);
 	dev_dbg(codec->dev, "%s: Mic 1b regulator: %s\n", __func__,
 		amic_micbias_str(amics->mic1b_micbias));
 	route = &ab8500_dapm_routes_mic1b_vamicx[amics->mic1b_micbias];
-	status |= snd_soc_dapm_add_routes(&codec->dapm, route, 1);
+	status |= snd_soc_dapm_add_routes(dapm, route, 1);
 	dev_dbg(codec->dev, "%s: Mic 2 regulator: %s\n", __func__,
 		amic_micbias_str(amics->mic2_micbias));
 	route = &ab8500_dapm_routes_mic2_vamicx[amics->mic2_micbias];
-	status |= snd_soc_dapm_add_routes(&codec->dapm, route, 1);
+	status |= snd_soc_dapm_add_routes(dapm, route, 1);
 	if (status < 0) {
 		dev_err(codec->dev,
 			"%s: Failed to add AMic-regulator DAPM-routes (%d).\n",
@@ -2461,6 +2462,7 @@ static void ab8500_codec_of_probe(struct device *dev, struct device_node *np,
 
 static int ab8500_codec_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct device *dev = codec->dev;
 	struct device_node *np = dev->of_node;
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
@@ -2541,7 +2543,7 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 		&ab8500_filter_controls[AB8500_FILTER_SID_FIR].private_value;
 	drvdata->sid_fir_values = (long *)fc->value;
 
-	(void)snd_soc_dapm_disable_pin(&codec->dapm, "ANC Configure Input");
+	snd_soc_dapm_disable_pin(dapm, "ANC Configure Input");
 
 	mutex_init(&drvdata->ctrl_lock);
 
-- 
1.8.0
