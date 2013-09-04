From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel: disable error interrupt
Date: Wed, 4 Sep 2013 10:48:08 +0100
Message-ID: <20130904094808.GP3084@sirena.org.uk>
References: <1378279666-19873-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2497000308375036730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D9B2654D8
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 11:48:13 +0200 (CEST)
In-Reply-To: <1378279666-19873-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2497000308375036730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rmjRBBEgaenXGypG"
Content-Disposition: inline


--rmjRBBEgaenXGypG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2013 at 03:27:46PM +0800, Bo Shen wrote:
> As once the error interrupt is triggered, it can not be cleared.
> So, disable it.
>=20
> No side effect found while testing on sama5d3xek and at91sam9x5ek
> boards.

Applied, thanks.

--rmjRBBEgaenXGypG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJwHVAAoJELSic+t+oim9nBwQAINUyEgewnZwoGKXw99n6bQ9
S7+HKMLmX4suC7q3L4YNWkwx9pCbYBHSbKLrf7CmteljCWtoS2FGnvmVlFqvmqJ2
B6y7jLIaFLsCJFXfWNok8hSZWFSo74ec8YVfZ4T8h7Z7fp5cOz8l71tFBlX80DMF
QVJiGkZz7wJYjdOoe+XSdpHbks2+m9FWCCUsrCjDIU/z7qORSFl4UdDaFY0Vo+4q
kjhqbZ05XXzb5CxT306XORryWiox3NUDwOkmJ8PR+smZI1GU4qWndVfSziI4/lxy
5R8C95IFbZwAWH2+ZwXUICtFaX5LtoGIOK0ZbvnYDu8cPGSu7H/J8RRLA7AqXmsq
n+oZ6/9fVQxE2X4GTOlvQi9gD+BQCq3wCew2wzVmLx7s6qKtXl8Pdlv/w5elc/7E
don35/Wji4rfpfNFklIcfWm02WNci0cvWxf3R/XqGPGHm3W0YLN3PEGHydr7WHvz
Bv5FaAXjqnt2pFQGcr1eVvLAHt4MgI6qJKQj1G9jv3HUGUO47dzzsgSx7I50xOmE
FwdAfIap1NK0DkI44B6G4IFzxwqK7HukmWNnu/ETQbLVgM37cU+ybXsYuWCxHWe2
IlqlAummFNBG+Czw7d5c9iyYYfbIfLGoAyUgqZNiEWVOqP0gXNONBExcLFLZtH8X
w8AGZnnhnXSjITb6v+1W
=2Pqv
-----END PGP SIGNATURE-----

--rmjRBBEgaenXGypG--

--===============2497000308375036730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2497000308375036730==--
