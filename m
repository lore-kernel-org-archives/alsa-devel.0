From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: ASoc: TLV320AIC3X: ad SPI
	and	clock on GPIO2 or BCLK
Date: Sat, 2 Apr 2011 09:26:04 +0100
Message-ID: <20110402082604.GE21737@sirena.org.uk>
References: <1300949648-15078-1-git-send-email-horms@verge.net.au>
	<1300949648-15078-2-git-send-email-horms@verge.net.au>
	<4D8B1AFD.5060508@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 908951037FC
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 10:26:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4D8B1AFD.5060508@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal Ji?? <jiri.prchal@aksignal.cz>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 24, 2011 at 11:20:45AM +0100, Prchal Ji?? wrote:
> Hi,
> this patch ads SPI communication for codecs TLV320AIC3X and clock input on GPIO2 or BCLK.
> Tested on TLV320AIC3106 and AT91SAM9260.
> TODO: Set the model in SPI probe the right way. I don't know how.

Register two SPI drivers with different names.

> This codec communicates on SPI in 1st byte: 7 MSB is register address, 1 LSB is read/write, 2nd byte data. For this
> reason there is new functions in soc-cache.c snd_soc_7_8_*.

This looks mostly good but there's some cleanups needed, mostly from
extra stuff which snuck in there, and you need to rebase against current
code.

As covered in SubmittingPatches you should always CC maintainers on
patches.

>  config SND_SOC_AD73311
>  	tristate
> -
> +

Random whitespace change, should be removed.

>   * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
> + *              Jiri Prchal, <jiri.prchal@aksignal.cz

If you're going to do this you probably want a > in there.

>  {
>  	struct snd_soc_codec *codec = codec_dai->codec;
>  	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
> +	u8 data;
> +
> +	/* set external clock on GPIO2 or BCLK */
> +	data = snd_soc_read(codec, AIC3X_CLKGEN_CTRL_REG);
> +	data &= 0x0f;
> +	data |= ((clk_id << PLLCLK_IN_SHIFT) | (clk_id << CLKDIV_IN_SHIFT));
> +	snd_soc_write(codec, AIC3X_CLKGEN_CTRL_REG, data);

This looks like an unrelated change which is specific to your board.
You should add an interface for configuring this functionality .

>  	if (ret != 0) {
> -		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);

Why are you decapitalising th estart of the sentance here?

> +static struct spi_driver aic3x_spi_driver = {
> +	.driver = {
> +		.name	= "tlv320aic3x-codec",
> +		.owner	= THIS_MODULE,

Remove the -codec from the driver name.

> +/* special functions for codecs with 7 bit register address and LSB read/write (like TLV320AIC3X) */
> +static unsigned int snd_soc_7_8_read(struct snd_soc_codec *codec,
> +				     unsigned int reg)
> +{
> +	int ret;
> +	unsigned int val;

This won't apply against the current kernel and should be a separate
patch, it's a generic thing rather than part of the CODEC driver.
