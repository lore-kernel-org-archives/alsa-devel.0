From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/7] ASoC: simple-card: fix __asoc_simple_card_dai_init
Date: Mon, 27 Jan 2014 19:50:37 +0000
Message-ID: <20140127195037.GV11841@sirena.org.uk>
References: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
 <1390549386-4702-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1AtvaQRkIQxkm1Oe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390549386-4702-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, rob@landley.net, perex@perex.cz, moinejf@free.fr, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--1AtvaQRkIQxkm1Oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 03:43:00PM +0800, Xiubo Li wrote:
> If the CPU/CODEC DAI set_sysclk() is not support, the -ENOTSUPP will returnd.
> Here do the check like set_fmt().

Applied, thanks.

--1AtvaQRkIQxkm1Oe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5riKAAoJELSic+t+oim9fooQAIFXCnKqJzESU8MhE/V2hl3D
DMW4L/WvuPt4w00b3ILfBvLpENqftBMaAjRPu9SGoC6fDXoWtrbwkD0vrjyz8eHF
e2ufZt0zTWRsMPI5LH68U+9THlF/U97yf64uIqTCHMSkS472yjKE5anSAKZMhgSn
/puHorpeW3hRgzumZ6sFazcSU3p9DxDF5W3Gx6IWJy2YeiSjgxzcVBPHDvA9s/PB
Ox0qoYCCoR3HvuGwT5ba8xvKxrx4Pb04o7n7BQsKGIVs2rXyy1+F4zCvGf8TQv1/
0YhlVaMDWp9t/Igjr7+sV1JTsJCNNMiXsNfAZniGmvs855am+9iGloXZJiFyCWP4
tsFa2IcyX3EIzHdlBnw/t8nEduKlzx3aJNBAhXTmy2/VWgNZVIG9jJvxyQUG6+TK
por1+YwYjbIzfMMy6QLUmkwWXuyDzNWe8CtcoLtTh82JWVgReka3dvndVFyeCAo7
VvVb2uQWpy9+2osaElkQ/N2eJpQ/K0K/+li8Fi68dtsSHvcV/LGt/AORE4VRlaB5
ZQO4N7SjmyMl4nrZDvUCVPxy/GqpFcU3HbKR7+yxn3SwMbpQsV7WgXs2F3g4Gn6s
0sABFRgpNXYPiW/Ltcg1r3ddYk0UMmOStHMHVH6Ztl5+C21+IIRFgQH28Bs5gDxJ
INZT5PKKj0T1bzliAzRx
=HGbO
-----END PGP SIGNATURE-----

--1AtvaQRkIQxkm1Oe--
