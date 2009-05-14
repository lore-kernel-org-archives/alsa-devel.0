From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 10/13] Codec for STAC9766 used on
	the	Efika
Date: Thu, 14 May 2009 12:03:10 +0100
Message-ID: <20090514110310.GH28291@sirena.org.uk>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015920.28145.62172.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 67FA82435A
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 13:03:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090514015920.28145.62172.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 09:59:20PM -0400, Jon Smirl wrote:

This looks mostly good - a lot of the issues below are fairly nitpicky,
though the issue with the of_simple integration needs to be dealt with.

>  	select SND_SOC_SSM2602 if I2C
> +	select SND_SOC_STAC9766
>  	select SND_SOC_TLV320AIC23 if I2C

This needs to be '... if SND_SOC_AC97_BUS' as for all the other AC97
CODECs.

> +{
> +	u16 *cache = codec->reg_cache;
> +
> +	if (reg > AC97_STAC_PAGE0) {
> +		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
> +		soc_ac97_ops.write(codec->ac97, reg, val);
> +		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
> +		return 0;

This could use a comment explaining what's going on with the paging -
I'd expect page 0 to be the default page.

> +static int ac97_digital_prepare(struct snd_pcm_substream *substream,
> +                                struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	unsigned short reg, vra;
> +
> +	stac9766_ac97_write(codec, AC97_SPDIF, 0x2002);
> +
> +	vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
> +
> +	vra |= 0x5; /* Enable VRA and SPDIF out */
> +	printk("var is %x\n", vra);

This looks like debug code that can be removed or turned into a
pr_debug()?

> +static int ac97_digital_trigger(struct snd_pcm_substream *substream,
> +								int cmd, struct snd_soc_dai *dai)

Another indentation problem?

> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
> +		vra &= !0x04;
> +		//stac9766_ac97_write(codec, AC97_EXTENDED_STATUS, vra);
> +		break;

Debug code that could be cleaned up?

> +static int stac9766_set_bias_level(struct snd_soc_codec *codec,
> +                                enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON: /* full On */
> +		stac9766_ac97_write(codec, AC97_POWERDOWN, 0x0000);
> +		break;
> +	case SND_SOC_BIAS_PREPARE: /* partial On */
> +		stac9766_ac97_write(codec, AC97_POWERDOWN, 0x0000);
> +		break;

You could skip the writes here - they're just doing the same thing as
standby.

> +static int stac9766_codec_resume(struct platform_device *pdev)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +	u16 id;
> +
> +	/* give the codec an AC97 warm reset to start the link */
> +	codec->ac97->bus->ops->warm_reset(codec->ac97);
> +	id = soc_ac97_ops.read(codec->ac97, AC97_VENDOR_ID2);
> +	if (id != 0x4c13) {
> +		printk(KERN_ERR "stac9766 failed to resume");
> +		return -EIO;
> +	}

Shouldn't this use the reset function?

> +		.rates = SNDRV_PCM_RATE_8000_48000,
> +		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
> +				SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,

Should use the standard define for AC97 formats here, and for the other
DAIs.

> +	snd_soc_add_controls(codec, stac9766_snd_ac97_controls, ARRAY_SIZE(
> +	                                stac9766_snd_ac97_controls));

Odd place to wrap...

> +static int __init stac9766_probe(struct platform_device *pdev)
> +{
> +	snd_soc_register_dais(stac9766_dai, ARRAY_SIZE(stac9766_dai));

The same issues as apply to the WM9712 change apply here.
