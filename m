From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: pcm3168a: Add driver for
 pcm3168a codec
Date: Fri, 27 Nov 2015 12:54:11 +0000
Message-ID: <20151127125411.GR1929@sirena.org.uk>
References: <1448376224-23964-3-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5429099748730146566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA25F2608ED
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2015 13:54:31 +0100 (CET)
In-Reply-To: <1448376224-23964-3-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Kumar Gala <galak@codeaurora.org>, Charles Keepax <ckeepax@gmail.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, James Hartley <james.hartley@imgtec.com>, Thomas Niederprum <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org


--===============5429099748730146566==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/rMgauiyHIRVABE"
Content-Disposition: inline


--J/rMgauiyHIRVABE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 02:43:44PM +0000, Damien Horsley wrote:
> From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
>=20
> Add driver for Texas Instruments pcm3168a codec

Please try to keep your CC lists reasonable - only CC people who have an
interest in the patch you're posting.  The CC list you have here is far
too broad, I can't figure out why a lot of the people there ended up
there.  If you've got 10 people that's generally a warning sign.

Overall this looks good but there are a few smallish issues below:

> +	if ((!slave_mode || (fmt & PCM3168A_FMT_DSP_MASK)) &&
> +			(format =3D=3D SNDRV_PCM_FORMAT_S24_3LE)) {
> +		dev_err(codec->dev, "48-bit frames not supported in master mode or sla=
ve mode using DSP(A/B)\n");

You've got a lot of weird indentation with the second line of multi-line
if conditionals massively further indented than I'd expect.  These
conditionals all also seem more complex than they should be - the fact
that you're using so many !slave_modes makes me think that you should
have a flag for master mode and...

> +	if ((!slave_mode || ((fmt !=3D PCM3168A_FMT_RIGHT_J) &&
> +			(fmt !=3D PCM3168A_FMT_LEFT_J))) &&
> +			(format =3D=3D SNDRV_PCM_FORMAT_S16)) {

=2E..especially with things like this the indentation makes it hard to
tell what bits go together.

> +	val =3D slave_mode ? 0 : ((i + 1) << shift);

Please write normal if statements unless there's a strong reason to use
the ternery operator.

> +	/*
> +	 * Justification has no effect for S32 and S16 as the whole frame
> +	 * is filled with the samples, but the register field
> +	 * must be set to a specific value for correct operation
> +	 */
> +	if ((fmt =3D=3D PCM3168A_FMT_RIGHT_J) &&
> +			(format =3D=3D SNDRV_PCM_FORMAT_S32)) {
> +		fmt =3D PCM3168A_FMT_LEFT_J;
> +	} else if (format =3D=3D SNDRV_PCM_FORMAT_S16) {
> +		fmt =3D PCM3168A_FMT_RIGHT_J_16;
> +	}

Being in right justified mode *does* have an effect - it changes where
the audio data starts relative to LRCLK.  It is true that if the frame
has exactly the right number of clocks left and right justified are
identical but extra clocks are in general permitted so it looks like
your right justified case above just isn't something the device really
supports.

> +	pcm3168a->scki =3D devm_clk_get(dev, "scki");
> +	if (IS_ERR(pcm3168a->scki)) {
> +		if (PTR_ERR(pcm3168a->scki) !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to acquire clock 'scki'\n");

Please print the error code as well, it may help people understand the
problem.

> +	ret =3D snd_soc_register_codec(dev, &pcm3168a_driver, pcm3168a_dais,
> +			ARRAY_SIZE(pcm3168a_dais));
> +	if (ret) {
> +		dev_err(dev, "failed to register codec: %d\n", ret);
> +		goto err_regulator;
> +	}
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_idle(dev);

You should enable runtime PM before registering the CODEC since the core
can do runtime PM operations and if it tries before runtime PM is
enabled things will get unbalanced.

> +#define PCM3168A_DOUBLE_STS(xname, reg, shift_left, shift_right, max, in=
vert) \
> +{									\
> +	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D (xname),		\
> +	.info =3D snd_soc_info_volsw, .get =3D snd_soc_get_volsw,		\
> +	.put =3D snd_soc_put_volsw,					\
> +	.access =3D SNDRV_CTL_ELEM_ACCESS_READ |				\
> +		SNDRV_CTL_ELEM_ACCESS_VOLATILE,				\
> +	.private_value =3D SOC_DOUBLE_VALUE(reg, shift_left, shift_right,	\
> +	max, invert, 0)							\
> +}

This doesn't look like it should be driver specific - what's driver
specific about it?

--J/rMgauiyHIRVABE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWWFJyAAoJECTWi3JdVIfQm2QH/1LX1P27caTJ90CDeok58Q3i
oVhsbqFypIf0JCGwouVIEkQDtWbIDaI1BTOFwyBAApZF3ZXRgO9IZ8qkkSxeI/A9
Xbxso4nVvWe7MdU4cUS4aS3/pVfwPbekCISG5fTbO3CDnmDKkpK4COyXamIV+/5W
lBgj41bjjcNhV8d4PUS6mT7aGfGa+0BsGTLTkJUZB1RXOwaE2HNioapLEXtvjzR1
wRnH5sSJpu4WY4WoGaM+JScOo3k82h8YHcIVF7hGbkhCh/HNwLcWGQ2+3HeniNkz
yKBChaAiiLfOfeA4iLdZKm7b3nhN2SafYqXd9WULeMNDSsfz4vA8OBnMGHJ7Emo=
=fnGC
-----END PGP SIGNATURE-----

--J/rMgauiyHIRVABE--

--===============5429099748730146566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5429099748730146566==--
