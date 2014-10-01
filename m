From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Do not force codecs selection
 by SND_SOC_FSL_ASOC_CARD
Date: Wed, 1 Oct 2014 17:07:33 +0100
Message-ID: <20141001160733.GE4273@sirena.org.uk>
References: <1412106735-18892-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0049519508311512177=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62FBE260518
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 18:07:40 +0200 (CEST)
In-Reply-To: <1412106735-18892-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--===============0049519508311512177==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rPFbv4B2w2tcwGo5"
Content-Disposition: inline


--rPFbv4B2w2tcwGo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 04:52:15PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> The wm8962 driver uses the input subsystem, but it is selected by
> SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
> resulting in this link error:

Applied, thanks.  The more important thing here is that this is supposed
to be a generic driver with no dependency on any particular CODEC.

--rPFbv4B2w2tcwGo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULCbEAAoJECTWi3JdVIfQwMUH/1HyqBoOnzK+c89gNLPvwR49
95o24KBH3X0WsD/0rpch2Y5A12ZVyhvaaYnNPsIqAIsX+xMZyngBPtxEDPCb7ZOD
gfVDlUVeAwTvPJkXT6U7W1EsAf4eX05p4Hp8rZfnVBWJ29UcFZKLIiinGk5tGyqC
W5ObCKvKsgs2uij0Bt78nF6faLIa1+mh+HbFEyc127l0Rk2BgtRvNnbN34kTPYlP
kvedp2JXf8NNnikL+IpMuH3qgUy1rZ6Xy+2EdXoYRCXp4i0DUVbr2JpG8OWrJ1eW
4TGLDm8AC+PqWw9KTkkslg0Pk+Sv7pi1cVJsrGRuRvCIsWcDFjySpd3uJUYvGZI=
=NPRo
-----END PGP SIGNATURE-----

--rPFbv4B2w2tcwGo5--

--===============0049519508311512177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0049519508311512177==--
