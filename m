From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8824: new codec driver
Date: Wed, 1 Feb 2017 17:40:54 +0000
Message-ID: <20170201174054.egdzu5rvqyo3ka5o@sirena.org.uk>
References: <1485402489-31325-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3973288503295128074=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AA912266E0D
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 18:41:03 +0100 (CET)
In-Reply-To: <1485402489-31325-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3973288503295128074==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ursu6d5c7xjbioxw"
Content-Disposition: inline


--ursu6d5c7xjbioxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 11:48:09AM +0800, John Hsu wrote:

This looks mostly good, a few fairly small things below:

> +       SOC_SINGLE_TLV("Speaker Right Volume from DACR",
> +               NAU8824_REG_CLASSD_GAIN_1, 8, 0x1f, 0, spk_vol_tlv),

Names for volume controls need to end with Volume for userspace to
understand them properly, give these the same names that the DAPM mixer
controls have but end with Volume instead of Switch and then userspace
will be able to combine them when displaying.

> +       case SND_SOC_DAPM_POST_PMU:
> +               /* Prevent startup click by letting charge pump to ramp u=
p */
> +               usleep_range(10000, 11000);

I believe the current preference is to do this as just msleep(10).

> +static int nau8824_codec_probe(struct snd_soc_codec *codec)
> +{
> +       struct nau8824 *nau8824 =3D snd_soc_codec_get_drvdata(codec);
> +       struct snd_soc_dapm_context *dapm =3D snd_soc_codec_get_dapm(code=
c);
> +
> +       nau8824->dapm =3D dapm;
> +       snd_soc_dapm_sync(nau8824->dapm);

This sync shouldn't do anything, just remove it.

> +static int __maybe_unused nau8824_suspend(struct snd_soc_codec *codec)
> +{
> +       struct nau8824 *nau8824 =3D snd_soc_codec_get_drvdata(codec);
> +
> +       if (nau8824->irq) {
> +               disable_irq(nau8824->irq);
> +               snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
> +       }

Why are we disabling the IRQ here? =20

> +       if (nau8824->irq) {
> +               nau8824_sema_acquire(nau8824, 0);
> +               enable_irq(nau8824->irq);
> +       }

We didn't drop this sempahore in the suspend path?  This stuff could at
least use better comments.

> +       /* Boost FEPGA 20dB */
> +       regmap_update_bits(regmap, NAU8824_REG_FEPGA_II,
> +               NAU8824_FEPGA_GAINL_MASK | NAU8824_FEPGA_GAINR_MASK,
> +               0xa | (0xa << NAU8824_FEPGA_GAINR_SFT));

Possibly something that should be controllable from userspace?

> +       nau8824_reset_chip(nau8824->regmap);
> +       ret =3D regmap_read(nau8824->regmap, NAU8824_REG_I2C_DEVICE_ID, &=
value);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to read device id from the NAU8824: =
%d\n",
> +                       ret);
> +               return ret;
> +       }

Perhaps check the device ID before resetting the chip (and verify that
the device ID is what's expected)?  That way if the system is
misconfigured then the check will be less disruptive.

--ursu6d5c7xjbioxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliSHaYACgkQJNaLcl1U
h9AohQf+OqswPzcCQztjL0EEKwBn4Or/8YrHHUOeQjAUl4FLyo9PpwgHpRIaLVee
siyf2to42v+OltffOWLfU2qrBoYToqiAm40fbuR1tihT5Dva/iWxWIMWmBKnFeOs
DY49V3eJFfB4xYYg9CTMkixkp+pbK4qUSImaiZjVHdUfexjJ5DOt3YIpKOgm35E2
zrC19M8niWwyhHZnYG7E7mOfFxnFx+iFItKiyOiwApOnIvgHuBgxXZ7iWXUM9rK8
mJn5+BdwRweD8MTFZLh+2r+UAH8Ak0gn/rgLA//IVF8DL4IHTA8ZsHHegwnAkWpV
BlQIqLKJ1c5crQenIiQ9BvkN+T9tyw==
=66H+
-----END PGP SIGNATURE-----

--ursu6d5c7xjbioxw--

--===============3973288503295128074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3973288503295128074==--
