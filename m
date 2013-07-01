From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: add ak4554 driver
Date: Mon, 01 Jul 2013 17:32:29 +0200
Message-ID: <51D1A10D.5000303@metafoo.de>
References: <87bo6mixuj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE5C2651B7
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 17:29:03 +0200 (CEST)
In-Reply-To: <87bo6mixuj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/01/2013 08:43 AM, Kuninori Morimoto wrote:
> +
> +static int ak4554_dai_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct ak4554_priv *priv = dev_get_drvdata(dai->dev);
> +
> +	if ((priv->usrcnt > 0) &&
> +	    (priv->rate != params_rate(params))) {
> +		dev_err(dai->dev, "asymmetric rate\n");
> +		return -EIO;
> +	}
> +
> +	priv->usrcnt++;
> +	priv->rate = params_rate(params);

Set the symmetric_rates field of the dai driver to 1 to enforce symmetric
rates. No need to implement this by hand.

> +
> +	return 0;
> +}
> +
[...]
> +
> +struct snd_soc_dai_driver ak4554_dai[] = {
> +	{
> +		.name = "ak4554-hifi-playback",
> +		.playback = {
> +			.stream_name = "Playback",
> +			.channels_min = 2,
> +			.channels_max = 2,
> +			.rates = SNDRV_PCM_RATE_8000_48000,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +		},
> +		.ops = &ak4554_dai_ops,
> +	}, {
> +		.name = "ak4554-hifi-capture",
> +		.capture = {
> +			.stream_name = "Capture",
> +			.channels_min = 2,
> +			.channels_max = 2,
> +			.rates = SNDRV_PCM_RATE_8000_48000,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +		},
> +		.ops = &ak4554_dai_ops,
> +	}
> +};
> +EXPORT_SYMBOL_GPL(ak4554_dai);

I don't think this needs to be exported and the struct should be static

> +
> +static int ak4554_probe(struct snd_soc_codec *codec)
> +{
> +	dev_info(codec->dev, "probed\n");
> +	return 0;
> +}
> +
> +static int ak4554_remove(struct snd_soc_codec *codec)
> +{
> +	dev_info(codec->dev, "removed\n");
> +	return 0;
> +}

Remove the two functions above, there is not much point in printing these messages.
