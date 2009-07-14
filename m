From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MAX9877: add MAX9877 amp driver
Date: Tue, 14 Jul 2009 10:54:26 +0100
Message-ID: <20090714095426.GA16295@rakim.wolfsonmicro.main>
References: <4A5C2829.50402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C3DD24733
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 11:54:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A5C2829.50402@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 14, 2009 at 03:39:37PM +0900, Joonyoung Shim wrote:

Overall this looks great, thanks.  Clearly it's not an ideal approach
but it gets the job done and it can be adapted to use core features as
they're added.

A couple of relatively nitpicky issues below:

> +++ b/sound/soc/codecs/Kconfig
> @@ -188,3 +188,7 @@ config SND_SOC_WM9712
>  
>  config SND_SOC_WM9713
>  	tristate
> +
> +# Amp
> +config SND_SOC_MAX9877
> +	tristate

I'd add it to SND_SOC_ALL_CODECS too - while it's not strictly a CODEC
the point of the Kconfig option is to get build coverage and this driver
will benefit from that as much as others.

> +static const char *max9877_osc_mode[] = {
> +	"1176KHz",
> +	"1100KHz",
> +	"700KHz",
> +};

Would this be better as platform data for the device?

> +static const struct snd_kcontrol_new max9877_controls[] = {
> +	SOC_SINGLE_EXT_TLV("MAX9877 Amp HP Left Playback Volume",
> +			MAX9877_HPL_VOLUME, 0, 31, 0,
> +			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
> +	SOC_SINGLE_EXT_TLV("MAX9877 Amp HP Right Playback Volume",
> +			MAX9877_HPR_VOLUME, 0, 31, 0,
> +			max9877_get_reg, max9877_set_reg, max9877_output_tlv),

Ideally these would be a SOC_DOUBLE_EXT_TLV() but we don't have that yet
- would you mind sending a patch for that?

> +/* This function is called from ASoC machine driver */
> +int max9877_add_controls(struct snd_soc_codec *codec)
> +{
> +	return snd_soc_add_controls(codec, max9877_controls,
> +			ARRAY_SIZE(max9877_controls));
> +}
> +

This should have an EXPORT_SYMBOL_GPL() to allow it to be used from
machine drivers which are built modular.
