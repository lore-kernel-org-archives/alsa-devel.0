From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] ASoC: ab8500-codec: Move control lock to
	the driver level
Date: Sun,  9 Nov 2014 17:00:57 +0100
Message-ID: <1415548864-27203-2-git-send-email-lars@metafoo.de>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id F0B5226054C
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 17:01:03 +0100 (CET)
In-Reply-To: <1415548864-27203-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org

The ab8500 driver uses a driver specific lock to protect concurrent access
to some of the control put/get handlers and uses the snd_soc_codec mutex for
some others. This patch updates the driver to consistently use the driver
specific lock for all controls. This will allow us to eventually remove the
snd_soc_codec mutex.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ab8500-codec.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index fd43827..7dfbc99 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -126,13 +126,13 @@ struct ab8500_codec_drvdata_dbg {
 /* Private data for AB8500 device-driver */
 struct ab8500_codec_drvdata {
 	struct regmap *regmap;
+	struct mutex ctrl_lock;
 
 	/* Sidetone */
 	long *sid_fir_values;
 	enum sid_state sid_status;
 
 	/* ANC */
-	struct mutex anc_lock;
 	long *anc_fir_values;
 	long *anc_iir_values;
 	enum anc_state anc_status;
@@ -1129,9 +1129,9 @@ static int sid_status_control_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&drvdata->ctrl_lock);
 	ucontrol->value.integer.value[0] = drvdata->sid_status;
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&drvdata->ctrl_lock);
 
 	return 0;
 }
@@ -1154,7 +1154,7 @@ static int sid_status_control_put(struct snd_kcontrol *kcontrol,
 		return -EIO;
 	}
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&drvdata->ctrl_lock);
 
 	sidconf = snd_soc_read(codec, AB8500_SIDFIRCONF);
 	if (((sidconf & BIT(AB8500_SIDFIRCONF_FIRSIDBUSY)) != 0)) {
@@ -1185,7 +1185,7 @@ static int sid_status_control_put(struct snd_kcontrol *kcontrol,
 	drvdata->sid_status = SID_FIR_CONFIGURED;
 
 out:
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&drvdata->ctrl_lock);
 
 	dev_dbg(codec->dev, "%s: Exit\n", __func__);
 
@@ -1198,9 +1198,9 @@ static int anc_status_control_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&drvdata->ctrl_lock);
 	ucontrol->value.integer.value[0] = drvdata->anc_status;
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&drvdata->ctrl_lock);
 
 	return 0;
 }
@@ -1217,7 +1217,7 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 
 	dev_dbg(dev, "%s: Enter.\n", __func__);
 
-	mutex_lock(&drvdata->anc_lock);
+	mutex_lock(&drvdata->ctrl_lock);
 
 	req = ucontrol->value.integer.value[0];
 	if (req >= ARRAY_SIZE(enum_anc_state)) {
@@ -1244,9 +1244,7 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 	}
 	snd_soc_dapm_sync(&codec->dapm);
 
-	mutex_lock(&codec->mutex);
 	anc_configure(codec, apply_fir, apply_iir);
-	mutex_unlock(&codec->mutex);
 
 	if (apply_fir) {
 		if (drvdata->anc_status == ANC_IIR_CONFIGURED)
@@ -1265,7 +1263,7 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 	snd_soc_dapm_sync(&codec->dapm);
 
 cleanup:
-	mutex_unlock(&drvdata->anc_lock);
+	mutex_unlock(&drvdata->ctrl_lock);
 
 	if (status < 0)
 		dev_err(dev, "%s: Unable to configure ANC! (status = %d)\n",
@@ -1294,14 +1292,15 @@ static int filter_control_get(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ab8500_codec_drvdata *drvdata = snd_soc_codec_get_drvdata(codec);
 	struct filter_control *fc =
 			(struct filter_control *)kcontrol->private_value;
 	unsigned int i;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&drvdata->ctrl_lock);
 	for (i = 0; i < fc->count; i++)
 		ucontrol->value.integer.value[i] = fc->value[i];
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&drvdata->ctrl_lock);
 
 	return 0;
 }
@@ -1310,14 +1309,15 @@ static int filter_control_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ab8500_codec_drvdata *drvdata = snd_soc_codec_get_drvdata(codec);
 	struct filter_control *fc =
 			(struct filter_control *)kcontrol->private_value;
 	unsigned int i;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&drvdata->ctrl_lock);
 	for (i = 0; i < fc->count; i++)
 		fc->value[i] = ucontrol->value.integer.value[i];
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&drvdata->ctrl_lock);
 
 	return 0;
 }
@@ -2545,7 +2545,7 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 
 	(void)snd_soc_dapm_disable_pin(&codec->dapm, "ANC Configure Input");
 
-	mutex_init(&drvdata->anc_lock);
+	mutex_init(&drvdata->ctrl_lock);
 
 	return status;
 }
-- 
1.8.0
