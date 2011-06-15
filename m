From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Wed, 15 Jun 2011 16:05:16 +0100
Message-ID: <20110615150516.GC2806@opensource.wolfsonmicro.com>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC7982489A
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 17:05:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308079626-31239-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2011 at 09:27:05PM +0200, Daniel Mack wrote:

> +/*
> + * The codec isn't really big-endian or little-endian, since the I2S
> + * interface requires data to be sent serially with the MSbit first.
> + * However, to support BE and LE I2S devices, we specify both here.  That
> + * way, ALSA will always match the bit patterns.
> + */

The core is supposed to be fixing this up for you...

> +#if 0
> +static const char *sta32x_pwm_output_mapping[] = {
> +	"Channel 1", "Channel 2", "Channel 3" };
> +#endif

Remove all the if 0 blocks in the driver or enable them.

> +static const char *sta32x_limiter_ac_release_thr[] = {
> +	"-inf", "-29dB", "-20dB", "-16dB", "-14dB", "-12dB", "-10dB", "-8dB",
> +	"-7dB", "-6dB", "-5dB", "-4dB", "-3dB", "-2dB", "-1dB", "0dB" };
> +static const char *sta32x_limiter_drc_attack_thr[] = {
> +	"-31dB", "-29dB", "-27dB", "-25dB", "-23dB", "-21dB", "-19dB", "-17dB",
> +	"-16dB", "-15dB", "-14dB", "-13dB", "-12dB", "-10dB", "-7dB", "-4dB" };
> +static const char *sta32x_limiter_drc_release_thr[] = {
> +	"-inf", "-38dB", "-36dB", "-33dB", "-31dB", "-30dB", "-28dB", "-26dB",
> +	"-24dB", "-22dB", "-20dB", "-18dB", "-15dB", "-12dB", "-9dB", "-6dB" };
> +

Doing these as regular volume TLVs will tend to work better in UIs.

> +SOC_SINGLE("Master Mute", STA32X_MMUTE, 0, 1, 0),
> +SOC_SINGLE("Ch1 Mute", STA32X_MMUTE, 1, 1, 0),
> +SOC_SINGLE("Ch2 Mute", STA32X_MMUTE, 2, 1, 0),
> +SOC_SINGLE("Ch3 Mute", STA32X_MMUTE, 3, 1, 0),

All Mutes should be replaced with Switch in control names.

> +		if (sta32x->format == SND_SOC_DAIFMT_I2S)
> +			confb |= 0x8;
> +		else if (sta32x->format == SND_SOC_DAIFMT_LEFT_J)
> +			confb |= 0x9;
> +		else if (sta32x->format == SND_SOC_DAIFMT_RIGHT_J)
> +			confb |= 0xa;

Looks like you want to use switch statements for these?

> +	ret = regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
> +				    sta32x->supplies);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
> +		goto err_get;
> +	}

If you enable the supplies when you go to standby you can just punt this
to when you set the bias level.

> +	/* read reg reset values into cache */
> +	for (i = 0; i < STA32X_REGISTER_COUNT; i++) {
> +		unsigned int val = codec->hw_read(codec, i);
> +

Does the chip not have a specified hardware state when it comes out of
reset?

> +		case STA32X_CONFA:
> +			/* FIXME enable thermal warning adjustment and recovery  */
> +			val &= ~(STA32X_CONFA_TWAB | STA32X_CONFA_TWRB);
> +			snd_soc_write(codec, i, val);
> +			break;

This would be much more legible if you just did an update bits to set
the values independantly of the cache init, both from the point of view
of the open coding and also for splitting out the default changes from
the cache init.

> +	snd_soc_add_controls(codec, sta32x_snd_controls,
> +			     ARRAY_SIZE(sta32x_snd_controls));
> +
> +	snd_soc_dapm_new_controls(dapm, sta32x_dapm_widgets,
> +				  ARRAY_SIZE(sta32x_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));

You should just add these arrays to the driver data structure and then
the core will add the controls and routes for you.

> +static const struct i2c_device_id sta32x_i2c_id[] = {
> +	{ "sta32x", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sta32x_i2c_id);

If you support a range of different devices then just list them here.

> +static struct i2c_driver sta32x_i2c_driver = {
> +	.driver = {
> +		.name = "sta32x-codec",

Drop the -codec from the name, it's redundant.
