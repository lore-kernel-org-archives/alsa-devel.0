From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs: mxs-saif: Register the irq with
 the device name
Date: Mon, 10 Nov 2014 19:58:39 +0000
Message-ID: <20141110195839.GP3815@sirena.org.uk>
References: <1415648970-14383-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7800996712528159083=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 234EA265B79
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 20:59:55 +0100 (CET)
In-Reply-To: <1415648970-14383-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7800996712528159083==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FHix762cz8AMoI2U"
Content-Disposition: inline


--FHix762cz8AMoI2U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 05:49:30PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Instead of registering the irq name with the driver name, it's better to =
pass
> the device name so that we have a more explicit indication as to what saif
> instance the irq is related:

Applied, thanks.

--FHix762cz8AMoI2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYRjvAAoJECTWi3JdVIfQkwwH/i+pxO4iy6TDorbsha0A/Wkw
erKVYkeAcMz5U8MF7hSEIOzNc6FFe5DEvjr7en7sfjClXsZmH7vOvu21+taPeAbj
HCFFA4PzaMiHC+cRRngYL+mNiIxU8z3pW7n7RFx/QY+HVT/Om1fJwHjhRomycTuX
Q/tZAGl0tkPXGfY9wTKItJLRVMbBzSo+cfk6keKYTPjYJ/Y23eGosTK/bSFOYkcT
zZwRMwCPF2CajVLrfWa5/1FPzvQxJEsPw9ZDtnTHQRFt5Y7QcZcbOXy9U83AFNo3
LwbNFG1CH6MQXOs75rus73XiPFprw9JcWVTynBefdB8bCZCSGpjDoB23Sc61r2k=
=78iT
-----END PGP SIGNATURE-----

--FHix762cz8AMoI2U--

--===============7800996712528159083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7800996712528159083==--
