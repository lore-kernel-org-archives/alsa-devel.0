From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels capture and
 lrck-mode support
Date: Wed, 7 Oct 2015 10:27:14 +0100
Message-ID: <20151007092714.GZ12635@sirena.org.uk>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk>
 <5608F74C.3000104@rock-chips.com>
 <20150930184655.GX15635@sirena.org.uk>
 <5614D162.3020500@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IHnTmDFdF6qwEwEs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5614D162.3020500@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sugar <sugar.zhang@rock-chips.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--IHnTmDFdF6qwEwEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2015 at 04:01:38PM +0800, sugar wrote:
> =E5=9C=A8 10/1/2015 02:46, Mark Brown =E5=86=99=E9=81=93:

> >What makes you say that the symmetric_rates flag can't be used to cover
> >this case?  What you describe above is hte normal reason for needing to
> >enforce symmetric_rates.  The driver should be able to check if the flag
> >has been set just as well as the core is.

> Got it, How about the following modify?

> if (dai->symmetric_rates)
> 	regmap_update_bits(i2s->regmap, I2S_CKR,
>                            I2S_CKR_TRCM_MASK,
>                            I2S_CKR_TRCM(val));

Yes, something like that.  You'll need to check both links in the DAI
and the DAI link itself rather than just your own DAI but we should have
a helper function for that - I'll add one, look out for a patch shortly.

--IHnTmDFdF6qwEwEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFOVuAAoJECTWi3JdVIfQpWwH+QEtYFXR7TlM2waz18AqSecH
oCPwlGZQMG6DF8wnGqqD2dxAJRUDh73tcctlendT3ujXm8igpxMggR/znNMXU/az
PyghYkjBNQwaiQq4ZOG3r++5qa+yhaZxXZHz44VcH7UuHKnF716gLlfJeXsYf+Yc
ke5BdHR9VWIfCvWTkPpJSECJWrn1DSIcTpVpS5LLDhU88bLGhs5FihPZD1xjuEKE
DRgd92UISrlb6YCkRY6JS3WFIEnOfEX3PwyOLkOWQ4OrUvH1pQLDPWGJ4+LpD/Ae
EPifFseXtu95J1FnNITIWDjfDNCQUBa3RdcJ5XkQMVwhQUYCTQnhALo0UA75/io=
=B50Z
-----END PGP SIGNATURE-----

--IHnTmDFdF6qwEwEs--
