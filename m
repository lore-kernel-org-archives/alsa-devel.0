From: sean.mcneil@ti.com
Subject: [PATCH - BT and FM audio for zoom2 1/2] Add clock-only
	codec to provide McBSP clock source.
Date: Mon,  3 Aug 2009 11:29:14 +0700
Message-ID: <1249273755-32620-1-git-send-email-sean.mcneil@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Sean McNeil <sean.mcneil@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Sean McNeil <sean.mcneil@ti.com>


Signed-off-by: Sean McNeil <sean.mcneil@ti.com>

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 818fb37..c343ceb 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -56,7 +56,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_AVTXL2PGA		(0xC)	*/
 	0x00, /* REG_AVTXR2PGA		(0xD)	*/
 	0x01, /* REG_AUDIO_IF		(0xE)	*/
-	0x00, /* REG_VOICE_IF		(0xF)	*/
+	0x04, /* REG_VOICE_IF		(0xF)	*/
 	0x00, /* REG_ARXR1PGA		(0x10)	*/
 	0x00, /* REG_ARXL1PGA		(0x11)	*/
 	0x6c, /* REG_ARXR2PGA		(0x12)	*/
@@ -118,25 +118,32 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_SW_SHADOW		(0x4A)	- Shadow, non HW register */
 };
 
+struct substream_item {
+	struct list_head started;
+	struct list_head configured;
+	struct snd_pcm_substream *substream;
+	int use256FS;
+};
+
 /* codec private data */
 struct twl4030_priv {
+	struct mutex mutex;
+
+	unsigned int extClock;
 	unsigned int bypass_state;
 	unsigned int codec_powered;
 	unsigned int codec_muted;
 
-	struct snd_pcm_substream *master_substream;
-	struct snd_pcm_substream *slave_substream;
-
-	unsigned int configured;
-	unsigned int rate;
-	unsigned int sample_bits;
-	unsigned int channels;
+	struct list_head started_list;
+	struct list_head config_list;
 
 	unsigned int sysclk;
 
 	/* Headset output state handling */
 	unsigned int hsl_enabled;
 	unsigned int hsr_enabled;
+
+	struct snd_pcm_hw_params params;
 };
 
 /*
@@ -966,7 +973,7 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned short val;
 	unsigned short mask, bitmask;
 
-	if (twl4030->configured) {
+	if (!list_empty(&twl4030->config_list)) {
 		printk(KERN_ERR "twl4030 operation mode cannot be "
 			"changed on-the-fly\n");
 		return -EBUSY;
@@ -1534,34 +1541,68 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static void twl4030_constraints(struct twl4030_priv *twl4030,
-				struct snd_pcm_substream *mst_substream)
+static unsigned int twl4030_rate_min(struct substream_item *item,
+	unsigned int rate)
 {
-	struct snd_pcm_substream *slv_substream;
-
-	/* Pick the stream, which need to be constrained */
-	if (mst_substream == twl4030->master_substream)
-		slv_substream = twl4030->slave_substream;
-	else if (mst_substream == twl4030->slave_substream)
-		slv_substream = twl4030->master_substream;
-	else /* This should not happen.. */
-		return;
+	static const unsigned int table[] = {
+			8000, 11025, 12000, 16000, 22050,
+			24000, 32000, 44100, 48000, 96000};
+	unsigned int value = rate;
+
+	if (item->use256FS) {
+		int i;
+		rate *= 256;
+		for (i = 0; i < ARRAY_SIZE(table); i++)
+			if (rate % table[i] == 0) {
+				value = table[i];
+				break;
+			}
+	}
+	return value;
+}
 
-	/* Set the constraints according to the already configured stream */
-	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
-				SNDRV_PCM_HW_PARAM_RATE,
-				twl4030->rate,
-				twl4030->rate);
-
-	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
-				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-				twl4030->sample_bits,
-				twl4030->sample_bits);
-
-	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
-				SNDRV_PCM_HW_PARAM_CHANNELS,
-				twl4030->channels,
-				twl4030->channels);
+static unsigned int twl4030_rate_max(struct substream_item *item,
+	unsigned int rate)
+{
+	static const unsigned int table[] = {
+			96000, 48000, 44100, 32000, 24000,
+			22050, 16000, 12000, 11025, 8000};
+	unsigned int value = rate;
+
+	if (item->use256FS) {
+		int i;
+		rate *= 256;
+		for (i = 0; i < ARRAY_SIZE(table); i++)
+			if (rate % table[i] == 0) {
+				value = table[i];
+				break;
+			}
+	}
+	return value;
+}
+
+static void twl4030_constraints(struct twl4030_priv *twl4030)
+{
+	struct substream_item *item;
+	unsigned int value;
+
+	list_for_each_entry(item, &twl4030->started_list, started) {
+
+		/* Set constraints according to the already configured stream */
+		value = params_rate(&twl4030->params);
+		if (value)
+			snd_pcm_hw_constraint_minmax(item->substream->runtime,
+					SNDRV_PCM_HW_PARAM_RATE,
+					twl4030_rate_min(item, value),
+					twl4030_rate_max(item, value));
+
+		value = hw_param_interval(&twl4030->params,
+					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
+		if (value && !item->use256FS)
+			snd_pcm_hw_constraint_minmax(item->substream->runtime,
+					SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+					value, value);
+	}
 }
 
 /* In case of 4 channel mode, the RX1 L/R for playback and the TX2 L/R for
@@ -1586,6 +1627,53 @@ static void twl4030_tdm_enable(struct snd_soc_codec *codec, int direction,
 	twl4030_write(codec, TWL4030_REG_OPTION, reg);
 }
 
+static int twl4030_new_substream(struct twl4030_priv *twl4030,
+		struct snd_pcm_substream *substream, int use256FS)
+{
+	struct substream_item *item;
+
+	item = kzalloc(sizeof(struct snd_pcm_substream), GFP_KERNEL);
+	if (!item)
+		return -ENOMEM;
+
+	item->substream = substream;
+	item->use256FS = use256FS;
+
+	mutex_lock(&twl4030->mutex);
+	list_add_tail(&item->started, &twl4030->started_list);
+	twl4030->extClock += item->use256FS;
+	mutex_unlock(&twl4030->mutex);
+
+	return 0;
+}
+
+static void twl4030_del_substream(struct twl4030_priv *twl4030,
+		struct snd_pcm_substream *substream)
+{
+	struct substream_item *item;
+
+	mutex_lock(&twl4030->mutex);
+
+	list_for_each_entry(item, &twl4030->config_list, configured) {
+		if (item->substream == substream) {
+			printk(KERN_ERR "TWL4030 deleted substream still configured!\n");
+			list_del(&item->configured);
+			break;
+		}
+	}
+
+	list_for_each_entry(item, &twl4030->started_list, started) {
+		if (item->substream == substream) {
+			list_del(&item->started);
+			twl4030->extClock -= item->use256FS;
+			kfree(item);
+			break;
+		}
+	}
+
+	mutex_unlock(&twl4030->mutex);
+}
+
 static int twl4030_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
@@ -1594,82 +1682,45 @@ static int twl4030_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct twl4030_priv *twl4030 = codec->private_data;
 
-	if (twl4030->master_substream) {
-		twl4030->slave_substream = substream;
-		/* The DAI has one configuration for playback and capture, so
-		 * if the DAI has been already configured then constrain this
-		 * substream to match it. */
-		if (twl4030->configured)
-			twl4030_constraints(twl4030, twl4030->master_substream);
-	} else {
-		if (!(twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE) &
-			TWL4030_OPTION_1)) {
-			/* In option2 4 channel is not supported, set the
-			 * constraint for the first stream for channels, the
-			 * second stream will 'inherit' this cosntraint */
-			snd_pcm_hw_constraint_minmax(substream->runtime,
-						SNDRV_PCM_HW_PARAM_CHANNELS,
-						2, 2);
-		}
-		twl4030->master_substream = substream;
+	if (!(twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE) &
+		TWL4030_OPTION_1)) {
+		/* In option2 4 channel is not supported, set the
+		 * constraint for the first stream for channels, the
+		 * second stream will 'inherit' this cosntraint */
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+					SNDRV_PCM_HW_PARAM_CHANNELS,
+					2, 2);
 	}
 
-	return 0;
+	return twl4030_new_substream(twl4030, substream, 0);
 }
 
 static void twl4030_shutdown(struct snd_pcm_substream *substream,
-			     struct snd_soc_dai *dai)
+		   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct twl4030_priv *twl4030 = codec->private_data;
 
-	if (twl4030->master_substream == substream)
-		twl4030->master_substream = twl4030->slave_substream;
-
-	twl4030->slave_substream = NULL;
-
-	/* If all streams are closed, or the remaining stream has not yet
-	 * been configured than set the DAI as not configured. */
-	if (!twl4030->master_substream)
-		twl4030->configured = 0;
-	 else if (!twl4030->master_substream->runtime->channels)
-		twl4030->configured = 0;
+	twl4030_del_substream(twl4030, substream);
 
 	 /* If the closing substream had 4 channel, do the necessary cleanup */
 	if (substream->runtime->channels == 4)
 		twl4030_tdm_enable(codec, substream->stream, 0);
 }
 
-static int twl4030_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *params,
-			   struct snd_soc_dai *dai)
+int twl4030_set_rate(struct snd_soc_codec *codec,
+		   struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct twl4030_priv *twl4030 = codec->private_data;
-	u8 mode, old_mode, format, old_format;
+	u8 mode, old_mode;
 
-	 /* If the substream has 4 channel, do the necessary setup */
-	if (params_channels(params) == 4) {
-		format = twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF);
-		mode = twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE);
-
-		/* Safety check: are we in the correct operating mode and
-		 * the interface is in TDM mode? */
-		if ((mode & TWL4030_OPTION_1) &&
-		    ((format & TWL4030_AIF_FORMAT) == TWL4030_AIF_FORMAT_TDM))
-			twl4030_tdm_enable(codec, substream->stream, 1);
-		else
-			return -EINVAL;
+	if (params_rate(&twl4030->params) &&
+		params_rate(&twl4030->params) != params_rate(params)) {
+		return -EBUSY;
 	}
 
-	if (twl4030->configured)
-		/* Ignoring hw_params for already configured DAI */
-		return 0;
-
 	/* bit rate */
 	old_mode = twl4030_read_reg_cache(codec,
 			TWL4030_REG_CODEC_MODE) & ~TWL4030_CODECPDZ;
@@ -1712,6 +1763,8 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	params_rate(&twl4030->params) = params_rate(params);
+
 	if (mode != old_mode) {
 		/* change rate and set CODECPDZ */
 		twl4030_codec_enable(codec, 0);
@@ -1719,10 +1772,51 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		twl4030_codec_enable(codec, 1);
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(twl4030_set_rate);
+
+int twl4030_get_clock_divisor(struct snd_soc_codec *codec,
+		   struct snd_pcm_hw_params *params)
+{
+	struct twl4030_priv *twl4030 = codec->private_data;
+	int clock, divisor;
+
+	clock = params_rate(&twl4030->params) * 256;
+	divisor = clock / params_rate(params);
+	divisor /= params_channels(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_S8:
+		divisor /= 8;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		divisor /= 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		divisor /= 24;
+		break;
+	default:
+		printk(KERN_ERR "TWL4030 get_clock_divisor: unknown format %d\n",
+				params_format(params));
+		return -EINVAL;
+	}
+
+	return divisor;
+}
+EXPORT_SYMBOL_GPL(twl4030_get_clock_divisor);
+
+static int twl4030_set_format(struct snd_soc_codec *codec,
+		   struct snd_pcm_hw_params *params)
+{
+	struct twl4030_priv *twl4030 = codec->private_data;
+	u8 format, old_format;
+
 	/* sample size */
 	old_format = twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF);
-	format = old_format;
-	format &= ~TWL4030_DATA_WIDTH;
+	format = old_format & ~TWL4030_DATA_WIDTH;
+
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		format |= TWL4030_DATA_WIDTH_16S_16W;
@@ -1736,31 +1830,96 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (format != old_format) {
+	if (format == old_format)
+		return 0;
 
-		/* clear CODECPDZ before changing format (codec requirement) */
-		twl4030_codec_enable(codec, 0);
+	if (params_format(&twl4030->params) &&
+		params_format(&twl4030->params) != params_format(params))
+		return -EBUSY;
 
-		/* change format */
-		twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
+	*hw_param_mask(&twl4030->params, SNDRV_PCM_HW_PARAM_FORMAT) =
+		*hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 
-		/* set CODECPDZ afterwards */
-		twl4030_codec_enable(codec, 1);
+	/* clear CODECPDZ before changing format (codec requirement) */
+	twl4030_codec_enable(codec, 0);
+
+	/* change format */
+	twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
+
+	/* set CODECPDZ afterwards */
+	twl4030_codec_enable(codec, 1);
+
+	return 0;
+}
+
+static int twl4030_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+	int rval;
+
+	mutex_lock(&twl4030->mutex);
+
+	 /* If the substream has 4 channel, do the necessary setup */
+	if (params_channels(params) == 4) {
+		/* Safety check: are we in the correct operating mode? */
+		if ((twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE) &
+			TWL4030_OPTION_1)) {
+			twl4030_tdm_enable(codec, substream->stream, 1);
+		} else {
+			mutex_unlock(&twl4030->mutex);
+			return -EINVAL;
+		}
 	}
 
-	/* Store the important parameters for the DAI configuration and set
-	 * the DAI as configured */
-	twl4030->configured = 1;
-	twl4030->rate = params_rate(params);
-	twl4030->sample_bits = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
-	twl4030->channels = params_channels(params);
+	rval = twl4030_set_rate(codec, params);
+	if (rval < 0) {
+		mutex_unlock(&twl4030->mutex);
+		return rval;
+	}
 
-	/* If both playback and capture streams are open, and one of them
+	rval = twl4030_set_format(codec, params);
+	if (rval < 0) {
+		mutex_unlock(&twl4030->mutex);
+		return rval;
+	}
+
+	/* If any other streams are currently open, and one of them
 	 * is setting the hw parameters right now (since we are here), set
-	 * constraints to the other stream to match the current one. */
-	if (twl4030->slave_substream)
-		twl4030_constraints(twl4030, substream);
+	 * constraints to the other stream(s) to match the current one. */
+	twl4030_constraints(twl4030);
+
+	mutex_unlock(&twl4030->mutex);
+
+	return 0;
+}
+
+static int twl4030_hw_free(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+	struct substream_item *item;
+
+	mutex_lock(&twl4030->mutex);
+
+	list_for_each_entry(item, &twl4030->config_list, configured) {
+		if (item->substream == substream) {
+			list_del(&item->configured);
+			break;
+		}
+	}
+
+	if (list_empty(&twl4030->config_list))
+		memset(&twl4030->params, 0, sizeof(twl4030->params));
+
+	mutex_unlock(&twl4030->mutex);
 
 	return 0;
 }
@@ -1797,10 +1956,39 @@ static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int twl4030_set_ext_clock(struct snd_soc_codec *codec, int enable)
+{
+	u8 old_format, format;
+
+	/* get format */
+	old_format = twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF);
+
+	if (enable)
+		format = old_format | TWL4030_CLK256FS_EN;
+	else
+		format = old_format & ~TWL4030_CLK256FS_EN;
+
+	if (format != old_format) {
+
+		/* clear CODECPDZ before changing format (codec requirement) */
+		twl4030_codec_enable(codec, 0);
+
+		/* change format */
+		twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
+
+		/* set CODECPDZ afterwards */
+		twl4030_codec_enable(codec, 1);
+	}
+
+	return 0;
+}
+
 static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			     unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+	int use256FS = 0;
 	u8 old_format, format;
 
 	/* get format */
@@ -1811,11 +1999,10 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
 		format &= ~(TWL4030_AIF_SLAVE_EN);
-		format &= ~(TWL4030_CLK256FS_EN);
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		format |= TWL4030_AIF_SLAVE_EN;
-		format |= TWL4030_CLK256FS_EN;
+		use256FS = 1;
 		break;
 	default:
 		return -EINVAL;
@@ -1846,7 +2033,7 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		twl4030_codec_enable(codec, 1);
 	}
 
-	return 0;
+	return twl4030_set_ext_clock(codec, use256FS | twl4030->extClock);
 }
 
 static int twl4030_set_tristate(struct snd_soc_dai *dai, int tristate)
@@ -1890,6 +2077,7 @@ static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
 	u8 infreq;
 	u8 mode;
 
@@ -1917,7 +2105,7 @@ static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return 0;
+	return twl4030_new_substream(twl4030, substream, 1);
 }
 
 static void twl4030_voice_shutdown(struct snd_pcm_substream *substream,
@@ -1926,6 +2114,9 @@ static void twl4030_voice_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+
+	twl4030_del_substream(twl4030, substream);
 
 	/* Enable voice digital filters */
 	twl4030_voice_enable(codec, substream->stream, 0);
@@ -1937,15 +2128,18 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
 	u8 old_mode, mode;
 
 	/* Enable voice digital filters */
 	twl4030_voice_enable(codec, substream->stream, 1);
 
+	mutex_lock(&twl4030->mutex);
+
 	/* bit rate */
-	old_mode = twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE)
-		& ~(TWL4030_CODECPDZ);
-	mode = old_mode;
+	old_mode = twl4030_read_reg_cache(codec,
+			TWL4030_REG_CODEC_MODE) & ~TWL4030_CODECPDZ;
+	mode = old_mode & ~TWL4030_APLL_RATE;
 
 	switch (params_rate(params)) {
 	case 8000:
@@ -1955,6 +2149,7 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 		mode |= TWL4030_SEL_16K;
 		break;
 	default:
+		mutex_unlock(&twl4030->mutex);
 		printk(KERN_ERR "TWL4030 voice hw params: unknown rate %d\n",
 			params_rate(params));
 		return -EINVAL;
@@ -1967,6 +2162,7 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 		twl4030_codec_enable(codec, 1);
 	}
 
+	mutex_unlock(&twl4030->mutex);
 	return 0;
 }
 
@@ -1996,19 +2192,22 @@ static int twl4030_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+	int use256FS = 0;
 	u8 old_format, format;
 
 	/* get format */
 	old_format = twl4030_read_reg_cache(codec, TWL4030_REG_VOICE_IF);
-	format = old_format;
+	format = old_format & ~TWL4030_VIF_TRI_EN;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBS_CFM:
 		format &= ~(TWL4030_VIF_SLAVE_EN);
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		format |= TWL4030_VIF_SLAVE_EN;
+		use256FS = 1;
 		break;
 	default:
 		return -EINVAL;
@@ -2033,7 +2232,59 @@ static int twl4030_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		twl4030_codec_enable(codec, 1);
 	}
 
-	return 0;
+	return twl4030_set_ext_clock(codec, use256FS | twl4030->extClock);
+}
+
+static int twl4030_clock_startup(struct snd_pcm_substream *substream,
+		   struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+
+	return twl4030_new_substream(twl4030, substream, 1);
+}
+
+static int twl4030_clock_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+	int rval;
+
+	mutex_lock(&twl4030->mutex);
+
+	rval = twl4030_set_rate(codec, params);
+
+	/* See if we are a multiple of the current FS. If so, then still OK. */
+	if (rval) {
+		int divisor = twl4030_get_clock_divisor(codec, params);
+		int clock = params_rate(&twl4030->params) * 256;
+		int remainder = clock % params_rate(params);
+
+		if (remainder == 0 && divisor <= 256)
+			rval = 0;
+	}
+
+	/* If any other streams are currently open, and one of them
+	 * is setting the hw parameters right now (since we are here), set
+	 * constraints to the other stream(s) to match the current one. */
+	twl4030_constraints(twl4030);
+
+	mutex_unlock(&twl4030->mutex);
+
+	return rval;
+}
+
+static int twl4030_clock_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+
+	return twl4030_set_ext_clock(codec, 1);
 }
 
 static int twl4030_voice_set_tristate(struct snd_soc_dai *dai, int tristate)
@@ -2056,6 +2307,7 @@ static struct snd_soc_dai_ops twl4030_dai_ops = {
 	.startup	= twl4030_startup,
 	.shutdown	= twl4030_shutdown,
 	.hw_params	= twl4030_hw_params,
+	.hw_free = twl4030_hw_free,
 	.set_sysclk	= twl4030_set_dai_sysclk,
 	.set_fmt	= twl4030_set_dai_fmt,
 	.set_tristate	= twl4030_set_tristate,
@@ -2065,26 +2317,38 @@ static struct snd_soc_dai_ops twl4030_dai_voice_ops = {
 	.startup	= twl4030_voice_startup,
 	.shutdown	= twl4030_voice_shutdown,
 	.hw_params	= twl4030_voice_hw_params,
+	.hw_free = twl4030_hw_free,
 	.set_sysclk	= twl4030_voice_set_dai_sysclk,
 	.set_fmt	= twl4030_voice_set_dai_fmt,
 	.set_tristate	= twl4030_voice_set_tristate,
 };
 
+static struct snd_soc_dai_ops twl4030_dai_clock_ops = {
+	.startup	= twl4030_clock_startup,
+	.shutdown	= twl4030_shutdown,
+	.hw_params	= twl4030_clock_hw_params,
+	.hw_free = twl4030_hw_free,
+	.set_sysclk = twl4030_set_dai_sysclk,
+	.set_fmt = twl4030_clock_set_dai_fmt,
+};
+
 struct snd_soc_dai twl4030_dai[] = {
 {
 	.name = "twl4030",
 	.playback = {
 		.stream_name = "HiFi Playback",
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 4,
 		.rates = TWL4030_RATES | SNDRV_PCM_RATE_96000,
-		.formats = TWL4030_FORMATS,},
+		.formats = TWL4030_FORMATS,
+	},
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 4,
 		.rates = TWL4030_RATES,
-		.formats = TWL4030_FORMATS,},
+		.formats = TWL4030_FORMATS,
+	},
 	.ops = &twl4030_dai_ops,
 },
 {
@@ -2092,17 +2356,37 @@ struct snd_soc_dai twl4030_dai[] = {
 	.playback = {
 		.stream_name = "Voice Playback",
 		.channels_min = 1,
-		.channels_max = 1,
+		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
 	.ops = &twl4030_dai_voice_ops,
 },
+{
+	.name = "twl4030 Clock",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = TWL4030_RATES,
+		.formats = SNDRV_PCM_FMTBIT_U8 | TWL4030_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = TWL4030_RATES,
+		.formats = SNDRV_PCM_FMTBIT_U8 | TWL4030_FORMATS,
+	},
+	.ops = &twl4030_dai_clock_ops,
+},
 };
 EXPORT_SYMBOL_GPL(twl4030_dai);
 
@@ -2220,6 +2504,9 @@ static int twl4030_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	mutex_init(&twl4030->mutex);
+	INIT_LIST_HEAD(&twl4030->started_list);
+	INIT_LIST_HEAD(&twl4030->config_list);
 	codec->private_data = twl4030;
 	socdev->card->codec = codec;
 	mutex_init(&codec->mutex);
@@ -2257,13 +2544,13 @@ EXPORT_SYMBOL_GPL(soc_codec_dev_twl4030);
 
 static int __init twl4030_modinit(void)
 {
-	return snd_soc_register_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
+	return snd_soc_register_dais(twl4030_dai, ARRAY_SIZE(twl4030_dai));
 }
 module_init(twl4030_modinit);
 
 static void __exit twl4030_exit(void)
 {
-	snd_soc_unregister_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
+	snd_soc_unregister_dais(twl4030_dai, ARRAY_SIZE(twl4030_dai));
 }
 module_exit(twl4030_exit);
 
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 2b4bfa2..fa23613 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -267,10 +267,15 @@
 
 #define TWL4030_DAI_HIFI		0
 #define TWL4030_DAI_VOICE		1
+#define TWL4030_DAI_CLOCK		2
 
-extern struct snd_soc_dai twl4030_dai[2];
+extern struct snd_soc_dai twl4030_dai[];
 extern struct snd_soc_codec_device soc_codec_dev_twl4030;
 
+extern int twl4030_set_rate(struct snd_soc_codec *, struct snd_pcm_hw_params *);
+extern int twl4030_get_clock_divisor(struct snd_soc_codec *,
+	struct snd_pcm_hw_params *);
+
 struct twl4030_setup_data {
 	unsigned int ramp_delay_value;
 	unsigned int sysclk;
-- 
1.6.0.4
