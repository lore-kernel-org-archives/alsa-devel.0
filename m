From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codec: fix the sparse check warnings.
Date: Thu, 3 Apr 2014 11:56:16 +0100
Message-ID: <20140403105616.GT14763@sirena.org.uk>
References: <1396482839-27609-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5341797663634203118=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52272265662
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 12:56:44 +0200 (CEST)
In-Reply-To: <1396482839-27609-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5341797663634203118==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kG2acDqmwoBDcCHP"
Content-Disposition: inline


--kG2acDqmwoBDcCHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2014 at 07:53:59AM +0800, Xiubo Li wrote:
> Some thing Likes:
>=20
> reproduce: make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
> sparse warnings: (new ones prefixed by >>)

Applied, thanks.

--kG2acDqmwoBDcCHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPT5NAAoJELSic+t+oim9bXkP/2SUaXhmAGJwcehUVUv9xRFx
X80weuGJjXaTG1N4GH+opbaX0z5u4PziNBzTttPTlQEsd7nSsanvhoeUzXbB9E/p
tsBb+Cr5T/Ka/REs1TaB56oXDEjB14P0pVWAOPQ/3OzPQFpN2PqcjwVwpB9+S9qC
aDDI31Py2pSo+zNG9yOAk3rucSBHwLyl0H1/M14V0PsKJRFopbjlkVkLh6rmZiFE
ZyWVEaYdnACsl6bt6p6gZnLinM7wIFrSpiw8nuJijVb4vM5mzrcMgJP+5pTrp8/r
Rf+hJokR7mtCDLUaOKWJi/QFK8tc7vSfMbtoy84LrjAtVXDTOSZpJYEpVZCJ0xsJ
oYjghlUiNnVZ2NSe0zl21YUeN6U0VAOssu1Mfa5gaON0+wP5L6K8NjSN8szbj4O9
2gUhRflBycCgLgEu0vxO/IYn9ebmd8nfLjDwBVva4R/aPBplrATMvkOugf2xYSYD
5IO+6rrwAukhodOlV5A+qXG0+fE05e03N2kRAfURoKFTvvY69I5GBpRywJANdB9I
OwPvrTaeIvk5/+TV+gKdbpNSzJO0kAiIxpgEJANJGyxXqrKcEulOSEjg3baWFxrO
hV2lHhuh1EW2aKpnMBNHzSZUkzxcq03Jr/pPrv2BJ3ZShlSl3qjX9wT1g8Yz7PyW
W0QeOyNGB4dAN8otIPm2
=MfOf
-----END PGP SIGNATURE-----

--kG2acDqmwoBDcCHP--

--===============5341797663634203118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5341797663634203118==--
