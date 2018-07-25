From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v4 7/8] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Wed, 25 Jul 2018 17:17:45 +0530
Message-ID: <20180725114745.GN3661@vkoul-mobl>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 633782675D4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 13:47:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180725005055.18138-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On 24-07-18, 19:50, Pierre-Louis Bossart wrote:

> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(c) 2015-17 Intel Corporation.

17..?

this style is fine, so is the one on other patches but then these two
are different, so please stick to one style which you find better. FWIW
I would prefer it this way.

> +static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
> +				     unsigned int tx_mask, unsigned int rx_mask,
> +				     int slots, int slot_width)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct hdac_hda_priv *hda_pvt;
> +	struct hdac_hda_pcm *pcm;
> +
> +	hda_pvt = snd_soc_component_get_drvdata(component);

cant this lookup fail, would make sense to error check here

> +static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct hdac_hda_priv *hda_pvt;
> +	struct hda_pcm_stream *hda_stream;
> +	struct hda_pcm *pcm;
> +
> +	hda_pvt = snd_soc_component_get_drvdata(component);

here as well..

> +static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct hdac_hda_priv *hda_pvt;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct hdac_device *hdev;
> +	struct hda_pcm_stream *hda_stream;
> +	unsigned int format_val;
> +	struct hda_pcm *pcm;
> +	int ret = 0;
> +
> +	hda_pvt = snd_soc_component_get_drvdata(component);
> +	hdev = &hda_pvt->codec.core;
> +	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
> +	if (!pcm)
> +		return -EINVAL;
> +
> +	hda_stream = &pcm->stream[substream->stream];
> +
> +	format_val = snd_hdac_calc_stream_format(runtime->rate,
> +						 runtime->channels,
> +						 runtime->format,
> +						 hda_stream->maxbps,
> +						 0);
> +	if (!format_val) {
> +		dev_err(&hdev->dev,
> +			"invalid format_val, rate=%d, ch=%d, format=%d\n",
> +			runtime->rate, runtime->channels, runtime->format);
> +		return -EINVAL;
> +	}
> +
> +	ret = snd_hda_codec_prepare(&hda_pvt->codec, hda_stream,
> +			hda_pvt->pcm[dai->id].stream_tag[substream->stream],
> +			format_val, substream);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "codec prepare failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;

this can be:

        if (ret < 0)
                dev_err()

        return ret;

> +static int hdac_hda_dai_open(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct hdac_hda_priv *hda_pvt;
> +	struct hda_pcm_stream *hda_stream;
> +	struct hda_pcm *pcm;
> +	int ret = -ENODEV;
> +
> +	hda_pvt = snd_soc_component_get_drvdata(component);
> +	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
> +	if (!pcm)
> +		return -EINVAL;
> +
> +	snd_hda_codec_pcm_get(pcm);
> +
> +	hda_stream = &pcm->stream[substream->stream];
> +	if (hda_stream->ops.open)
> +		ret = hda_stream->ops.open(hda_stream, &hda_pvt->codec,
> +								substream);

are the ops not mandatory? Do you expect them to not be present?

> +static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)

aligning second line the opening brace of former will help readability

> +static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
> +						 struct snd_soc_dai *dai)

align here too please

> +{
> +	struct hda_codec *hcodec = &hda_pvt->codec;
> +	struct hda_pcm *cpcm;
> +	const char *pcm_name;
> +
> +	if (dai->id == HDAC_ANALOG_DAI_ID)
> +		pcm_name = "Analog";
> +	else if (dai->id == HDAC_DIGITAL_DAI_ID)
> +		pcm_name = "Digital";
> +	else
> +		pcm_name = "Alt Analog";

switch?

> +static int hdac_hda_codec_probe(struct snd_soc_component *component)
> +{
> +	struct hdac_hda_priv *hda_pvt =
> +			snd_soc_component_get_drvdata(component);
> +	struct snd_soc_dapm_context *dapm =
> +			snd_soc_component_get_dapm(component);
> +	struct hdac_device *hdev = &hda_pvt->codec.core;
> +	struct hda_codec *hcodec = &hda_pvt->codec;
> +	struct hdac_ext_link *hlink;
> +	hda_codec_patch_t patch;
> +	int ret;
> +
> +	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
> +	if (!hlink) {
> +		dev_err(&hdev->dev, "hdac link not found\n");
> +		return -EIO;
> +	}
> +
> +	snd_hdac_ext_bus_link_get(hdev->bus, hlink);

snd_hdac_ext_bus_get_link and snd_hdac_ext_bus_link_get, yeah naming is
hard ;-)

> +
> +	ret = snd_hda_codec_device_new(hcodec->bus,
> +			component->card->snd_card, hdev->addr, hcodec);
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "failed to create hda codec %d\n", ret);

you should drop the link reference grabbed in previous calls in error
here and rest of error returns?

> +		return ret;
> +	}
> +
> +	/*
> +	 * snd_hda_codec_device_new decrements the usage count so call get pm
> +	 * else the device will be powered off
> +	 */
> +	pm_runtime_get_noresume(&hdev->dev);

no error check for this?

> +static const struct snd_soc_component_driver hdac_hda_codec = {
> +	.probe		= hdac_hda_codec_probe,
> +	.remove		= hdac_hda_codec_remove,
> +	.idle_bias_on	= false,
> +	.dapm_widgets           = hdac_hda_dapm_widgets,
> +	.num_dapm_widgets       = ARRAY_SIZE(hdac_hda_dapm_widgets),
> +	.dapm_routes            = hdac_hda_dapm_routes,
> +	.num_dapm_routes        = ARRAY_SIZE(hdac_hda_dapm_routes),

is it diff or code shows table misaligned..?

> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright(c) 2015-17 Intel Corporation.
> + */

same patch different style ;/

> +static void load_codec_module(struct hda_codec *codec)
> +{
> +#ifdef MODULE
> +	char modalias[MODULE_NAME_LEN];
> +	const char *mod = NULL;
> +
> +	snd_hdac_codec_modalias(&codec->core, modalias, sizeof(modalias));
> +	mod = modalias;
> +	dev_dbg(&codec->core.dev, "loading %s codec module\n", mod);
> +	request_module(mod);

any reason why we dont want to use standard loading mechanisms for
these?

-- 
~Vinod
