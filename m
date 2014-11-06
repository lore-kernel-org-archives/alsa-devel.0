From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: tfa9879: New driver for NXP Semiconductors
 TFA9879 amplifier.
Date: Thu, 06 Nov 2014 14:27:26 +0100
Message-ID: <545B773E.3020103@metafoo.de>
References: <1415278441-27866-1-git-send-email-peda@lysator.liu.se> <1415278441-27866-2-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415278441-27866-2-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/06/2014 01:54 PM, Peter Rosin wrote:
[...]
> +#define TFA9879_REG(codec, reg, field, value)				\
> +	snd_soc_update_bits(codec, TFA9879_ ## reg,			\
> +			    TFA9879_ ## field ## _MASK,			\
> +			    (value) << TFA9879_ ## field ## _SHIFT)
> +

I'm not sure I like this macro. Just using snd_soc_update_bits should make 
it easier to review the patch since people understand its sematnics.

[...]
> +static int tfa9879_probe(struct snd_soc_codec *codec)
> +{
> +	struct tfa9879_priv *tfa9879 = snd_soc_codec_get_drvdata(codec);
> +
> +	codec->control_data = tfa9879->regmap;

This is no longer necessary and won't even build with the latest ASoC tree.

> +
> +	return 0;
> +}
> +
[...]
> +static struct snd_soc_dai_ops tfa9879_dai_ops = {

const

> +	.prepare = tfa9879_prepare,
> +	.hw_params = tfa9879_hw_params,
> +	.shutdown = tfa9879_shutdown,
> +	.digital_mute = tfa9879_digital_mute,
> +	.set_fmt = tfa9879_set_fmt,
> +};
[...]
