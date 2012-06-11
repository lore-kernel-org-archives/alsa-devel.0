From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Ux500: Add machine-driver
Date: Mon, 11 Jun 2012 13:34:34 +0800
Message-ID: <20120611053432.GP4218@opensource.wolfsonmicro.com>
References: <1339070437-15150-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7822701050029305734=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AF7E324B44
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 07:34:47 +0200 (CEST)
In-Reply-To: <1339070437-15150-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7822701050029305734==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YyxzkC/DtE3JUx8+"
Content-Disposition: inline


--YyxzkC/DtE3JUx8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 07, 2012 at 02:00:37PM +0200, Ola Lilja wrote:

> +	mop500_ab8500_remove(mop500_card);
> +
> +	snd_soc_unregister_card(mop500_card);

These seem the wrong way round - we're starting to tear down the card
before we've destroyed the core and hence userspace so something might
still be using it.

> +	platform_set_drvdata(pdev, NULL);

No need to do this, it's a waste of time.

> +static inline const char *get_mclk_str(enum mclk mclk_sel)
> +{
> +	switch (mclk_sel) {
> +	case MCLK_SYSCLK:
> +		return "MCLK_SYSCLK";
> +	case MCLK_ULPCLK:
> +		return "MCLK_ULPCLK";

Why not just drop the MCLK_ from the strings?  I'd expect that'll be
implied by the context...

> +static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct mop500_ab8500_drvdata *drvdata =
> +				snd_soc_card_get_drvdata(codec->card);
> +	unsigned int val;
> +
> +	val = (ucontrol->value.enumerated.item[0] != 0);

Given that this is an enumeration not a bool we should be rejecting out
of bounds values rather than silently fixing them up, this would also
avoid issues if we do add new options for the clock later on for some
reason.

> +	/* Digital interface - Clocks */
> +	SOC_SINGLE("Digital Interface Master Generator Switch",
> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENMASTGEN,
> +		1, 0),

This enables and disables a 256fs (or similar ratio) clock output from
the device?

> +	SOC_SINGLE("Digital Interface 0 Bit-clock Switch",
> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK0,
> +		1, 0),
> +	SOC_SINGLE("Digital Interface 1 Bit-clock Switch",
> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK1,
> +		1, 0),

I suspect that these are doing what DAIFMT_CONT is for...

> +int mop500_ab8500_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +
> +	/* Set audio-clock source */
> +	return mop500_ab8500_set_mclk(rtd->card->dev,
> +				snd_soc_card_get_drvdata(rtd->card));

Should we be blocking MCLK changes while the interface is active?
> +	/* Setup codec depending on driver-mode */
> +	driver_mode = (channels == 8) ?
> +		DRIVERMODE_CODEC_ONLY : DRIVERMODE_NORMAL;

Ugh, just use an if or switch statement.

> +	sw_codec = (driver_mode == DRIVERMODE_NORMAL) ? sw_cpu : 20;

Again, if statement please.

--YyxzkC/DtE3JUx8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1YNiAAoJEBus8iNuMP3dKfUP/0QIzKNYOEV2Mp0L0qAqtGjg
fR71ikwqMl8Y79jY1UGAeVJ4WqKKGkaZdOYIIh5teN93wDhFUjn2PQLiztrLJeTx
L7LVCWrMlOhRgKdtpdRF/j54dsa4AAeNO+z4YC/r5oWmS0s84aChKtFVPh3gFFnC
avHHe2OokfvcwmJ83FKEXAKIt6bKX51muNuDzlvclPbjdJVGbZviGINLpr9GlcQy
UDWFMR/TXaQz9SS9/C2y6/fn+3VYUvvBKPvUKLv41ksMON/vNccxptmAGur9T3QZ
M005K1xJP0ze7XK8vIhAyh9rptjSV17saeFi5VOWmgbUm3rFq4TIvonA8Yu0NlP+
ZCMR7Owzp4qNheH6UL51YLnz/IWd/AyRIxM9eG39dSPZUUfJnyhMz+Koi0Y8pEFR
V23y/hpXBIKedXlObm4J7T4tm8wEcNPGobZZCfUA1Wep2cf8Qq+wAmry5ifVAHCV
nA/LpgiDVRectmk7//Q6wVH9/JvTQxDHz+AAqQ7Z60JTLctyad8GgsIiDu1SQaNt
bbP3+/KryHwDnxOoz4EHapjShY36++kBWzQPhgjP+sBhAWQPKMlWUL33us9u3B2H
1kuey9ZgUrnjhF0h8iNjQc+1owuy3feb8UFsF1P1G9NLWar0upBlSbwjgrG3EV3M
iYwHQviH/fuE6bwdn37z
=dO9Y
-----END PGP SIGNATURE-----

--YyxzkC/DtE3JUx8+--

--===============7822701050029305734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7822701050029305734==--
