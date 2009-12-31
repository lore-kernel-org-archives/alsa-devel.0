From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/5] ASoC: tlv320dac33: Change nsample switch
	to FIFO mode enum
Date: Thu, 31 Dec 2009 10:30:19 +0200
Message-ID: <1262248223-9335-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FD84103892
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 09:30:36 +0100 (CET)
In-Reply-To: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

In order to have support for more FIFO modes supported by
tlv320dac33, the switch for enabling/disabling the FIFO
use has to be replaced with an enum.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   49 ++++++++++++++++++++++++++--------------
 1 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 5037454..b67961d 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -59,6 +59,12 @@ enum dac33_state {
 	DAC33_FLUSH,
 };
 
+enum dac33_fifo_modes {
+	DAC33_FIFO_BYPASS = 0,
+	DAC33_FIFO_MODE1,
+	DAC33_FIFO_LAST_MODE,
+};
+
 #define DAC33_NUM_SUPPLIES 3
 static const char *dac33_supply_names[DAC33_NUM_SUPPLIES] = {
 	"AVDD",
@@ -82,7 +88,7 @@ struct tlv320dac33_priv {
 					 * this */
 	unsigned int nsample_max;	/* nsample should not be higher than
 					 * this */
-	unsigned int nsample_switch;	/* Use FIFO or bypass FIFO switch */
+	enum dac33_fifo_modes fifo_mode;/* FIFO mode selection */
 	unsigned int nsample;		/* burst read amount from host */
 
 	enum dac33_state state;
@@ -381,39 +387,48 @@ static int dac33_set_nsample(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-static int dac33_get_nsample_switch(struct snd_kcontrol *kcontrol,
+static int dac33_get_fifo_mode(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct tlv320dac33_priv *dac33 = codec->private_data;
 
-	ucontrol->value.integer.value[0] = dac33->nsample_switch;
+	ucontrol->value.integer.value[0] = dac33->fifo_mode;
 
 	return 0;
 }
 
-static int dac33_set_nsample_switch(struct snd_kcontrol *kcontrol,
+static int dac33_set_fifo_mode(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct tlv320dac33_priv *dac33 = codec->private_data;
 	int ret = 0;
 
-	if (dac33->nsample_switch == ucontrol->value.integer.value[0])
+	if (dac33->fifo_mode == ucontrol->value.integer.value[0])
 		return 0;
 	/* Do not allow changes while stream is running*/
 	if (codec->active)
 		return -EPERM;
 
 	if (ucontrol->value.integer.value[0] < 0 ||
-	    ucontrol->value.integer.value[0] > 1)
+	    ucontrol->value.integer.value[0] >= DAC33_FIFO_LAST_MODE)
 		ret = -EINVAL;
 	else
-		dac33->nsample_switch = ucontrol->value.integer.value[0];
+		dac33->fifo_mode = ucontrol->value.integer.value[0];
 
 	return ret;
 }
 
+/* Codec operation modes */
+static const char *dac33_fifo_mode_texts[] = {
+	"Bypass", "Mode 1"
+};
+
+static const struct soc_enum dac33_fifo_mode_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(dac33_fifo_mode_texts),
+			    dac33_fifo_mode_texts);
+
 /*
  * DACL/R digital volume control:
  * from 0 dB to -63.5 in 0.5 dB steps
@@ -436,8 +451,8 @@ static const struct snd_kcontrol_new dac33_snd_controls[] = {
 static const struct snd_kcontrol_new dac33_nsample_snd_controls[] = {
 	SOC_SINGLE_EXT("nSample", 0, 0, 5900, 0,
 		 dac33_get_nsample, dac33_set_nsample),
-	SOC_SINGLE_EXT("nSample Switch", 0, 0, 1, 0,
-		 dac33_get_nsample_switch, dac33_set_nsample_switch),
+	SOC_ENUM_EXT("FIFO Mode", dac33_fifo_mode_enum,
+		 dac33_get_fifo_mode, dac33_set_fifo_mode),
 };
 
 /* Analog bypass */
@@ -586,7 +601,7 @@ static void dac33_shutdown(struct snd_pcm_substream *substream,
 	unsigned int pwr_ctrl;
 
 	/* Stop pending workqueue */
-	if (dac33->nsample_switch)
+	if (dac33->fifo_mode)
 		cancel_work_sync(&dac33->work);
 
 	mutex_lock(&dac33->mutex);
@@ -714,7 +729,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 
 	dac33_oscwait(codec);
 
-	if (dac33->nsample_switch) {
+	if (dac33->fifo_mode) {
 		/* 50-51 : ASRC Control registers */
 		dac33_write(codec, DAC33_ASRC_CTRL_A, (1 << 4)); /* div=2 */
 		dac33_write(codec, DAC33_ASRC_CTRL_B, 1); /* ??? */
@@ -734,7 +749,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		dac33_write(codec, DAC33_ASRC_CTRL_B, 0); /* ??? */
 	}
 
-	if (dac33->nsample_switch)
+	if (dac33->fifo_mode)
 		fifoctrl_a &= ~DAC33_FBYPAS;
 	else
 		fifoctrl_a |= DAC33_FBYPAS;
@@ -742,13 +757,13 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 
 	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
 	reg_tmp = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
-	if (dac33->nsample_switch)
+	if (dac33->fifo_mode)
 		reg_tmp &= ~DAC33_BCLKON;
 	else
 		reg_tmp |= DAC33_BCLKON;
 	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, reg_tmp);
 
-	if (dac33->nsample_switch) {
+	if (dac33->fifo_mode) {
 		/* 20: BCLK divide ratio */
 		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 3);
 
@@ -828,7 +843,7 @@ static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (dac33->nsample_switch) {
+		if (dac33->fifo_mode) {
 			dac33->state = DAC33_PREFILL;
 			queue_work(dac33->dac33_wq, &dac33->work);
 		}
@@ -836,7 +851,7 @@ static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (dac33->nsample_switch) {
+		if (dac33->fifo_mode) {
 			dac33->state = DAC33_FLUSH;
 			queue_work(dac33->dac33_wq, &dac33->work);
 		}
@@ -1125,7 +1140,7 @@ static int dac33_i2c_probe(struct i2c_client *client,
 	dac33->irq = client->irq;
 	dac33->nsample = NSAMPLE_MAX;
 	/* Disable FIFO use by default */
-	dac33->nsample_switch = 0;
+	dac33->fifo_mode = DAC33_FIFO_BYPASS;
 
 	tlv320dac33_codec = codec;
 
-- 
1.6.6
