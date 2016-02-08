From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: add rt5514 SPI driver
Date: Mon, 8 Feb 2016 17:17:11 +0000
Message-ID: <20160208171711.GL7265@sirena.org.uk>
References: <1454647333-10696-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0511888224947819392=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 748BA2605C1
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 18:17:20 +0100 (CET)
In-Reply-To: <1454647333-10696-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0511888224947819392==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuT04sMzYDXq8et0"
Content-Disposition: inline


--WuT04sMzYDXq8et0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2016 at 12:42:13PM +0800, Oder Chiou wrote:

> The patch adds the rt5514 SPI driver for loading the firmware of DSP and
> retrieving the voice data after the system is waked up by voice.

Please have words with your hardware designers about having devices with
multiple control interfaces :/

>  config SND_SOC_RT5514
>  	tristate
> +	default y if SND_SOC_RT5514_SPI=y
> +	default m if SND_SOC_RT5514_SPI=m
> +
> +config SND_SOC_RT5514_SPI
> +	tristate
> +	depends on SPI_MASTER

This is really confused and probably broken.  I'm surprised that having
a default for a hidden symbol like SND_SOC_RT5514 would do anything and
there's nothing here that ensures that the dependencies are correct with
respect to I2C.

> +static int rt5514_spi_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct rt5514_dsp *rt5514_dsp =
> +			snd_soc_platform_get_drvdata(rtd->platform);
> +
> +	rt5514_dsp->dma_offset = 0;
> +	rt5514_dsp->dsp_offset = 0;
> +	rt5514_spi_read_addr(RT5514_BUFFER_VOICE_BASE, &rt5514_dsp->buf_base);
> +	rt5514_spi_read_addr(RT5514_BUFFER_VOICE_LIMIT, &rt5514_dsp->buf_limit);
> +	rt5514_spi_read_addr(RT5514_BUFFER_VOICE_RP, &rt5514_dsp->buf_rp);
> +	rt5514_spi_read_addr(RT5514_BUFFER_VOICE_SIZE, &rt5514_dsp->buf_size);
> +
> +	if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
> +		rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
> +		schedule_delayed_work(&rt5514_dsp->copy_work, 0);

Scheduling this work in prepare() seems wrong - it's going to start
doing things before we trigger anything.  I'd expect this to be done on
trigger (which is fine).

> +		x[0].len = 5;
> +		x[0].tx_buf = write_buf;
> +		spi_message_add_tail(&x[0], &message);
> +
> +		x[1].len = 4;
> +		x[1].tx_buf = write_buf;
> +		spi_message_add_tail(&x[1], &message);
> +
> +		x[2].len = end;
> +		x[2].rx_buf = rxbuf + offset;
> +		spi_message_add_tail(&x[2], &message);

This all looks a lot like a regmap...  only funny thing is the command
byte on the front of everything which we could add support for, AFAICT
we could just use burst I/O for everything.

> +		offset += RT5514_SPI_BUF_LEN;

Is this a limitation of the device?

> +EXPORT_SYMBOL_GPL(rt5514_spi_burst_read);

Why are all these symbols exported?

> +static void rt5514_enable_dsp_clock(struct rt5514_priv *rt5514)
> +{
> +	/* Reset */
> +	regmap_write(rt5514->i2c_regmap, 0x18002000, 0x000010ec);
> +	/* LDO_I_limit */
> +	regmap_write(rt5514->i2c_regmap, 0x18002200, 0x00028604);
> +	/* (for reset DSP) mini-core reset */
> +	regmap_write(rt5514->i2c_regmap, 0x18002f00, 0x0005514b);

This looks like it's doing rather more than enabling the clock, there
looks to be quite a bit of use case specific stuff in here...

> +		request_firmware(&fw, "0x4ff60000.dat", codec->dev);
> +		if (fw) {

That needs a *much* more sensible filename, at least put the firmware in
a directory for the CODEC.

> +	SOC_SINGLE_EXT("DSP Control", SND_SOC_NOPM, 0, 1, 0,
> +		rt5514_dsp_mode_get, rt5514_dsp_mode_put),

It's not clear what this is intended to mean to userspace...  looks like
it might be intended to be an on/off switch but that's more a DAPM
thing.

> +		if (snd_soc_codec_get_bias_level(codec) ==
> +			SND_SOC_BIAS_STANDBY) {
> +			if (rt5514->dsp_mode) {
> +				rt5514->dsp_mode = 0;

So we reset the value for dsp_mode when powering up...  that's
confusing?

--WuT04sMzYDXq8et0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuM2WAAoJECTWi3JdVIfQfxMH/jpSDGYAlcSblJ7Ue8giSNcT
3wBYrf3EY0oRvqpYwUXOz6qa8UYdGmWm+uz2ykk8aTLPE2HoQ1Rf6yeYG2p/aPzB
S5DnKjBmi++0GAfgtY7bHPkyAEgovZkUBFZHTm+h7O1FKDAGdzIyP3ZtFNibv9VE
1G2Q8/7+CQf7s0EBEeZMNsQa1ox6K1EBhWrk5Cd2Pb//HWNLsKvmYG3h59532nXl
7IZc8uLVTF8CMHDA4fN1yPrgJoPNPLbvXW0cqwYoUuGAWBI73C9aSZGPHycIED8F
zAZBiJWpaBcslAot58XqZCX3HzWJpshLHAVa8E3fP/3NjiDkGBm4tDU6RoJznJ0=
=+BKS
-----END PGP SIGNATURE-----

--WuT04sMzYDXq8et0--

--===============0511888224947819392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0511888224947819392==--
