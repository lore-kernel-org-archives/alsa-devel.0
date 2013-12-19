From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode
 support for SSI on i.MX series
Date: Thu, 19 Dec 2013 10:48:04 +0000
Message-ID: <20131219104804.GT31886@sirena.org.uk>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8091669770579791213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 85CBB26530B
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 11:48:08 +0100 (CET)
In-Reply-To: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, timur@tabi.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============8091669770579791213==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QCC2I/2CckNfI+Tr"
Content-Disposition: inline


--QCC2I/2CckNfI+Tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 06:44:45PM +0800, Nicolin Chen wrote:
> From: Nicolin Chen <b42378@freescale.com>
>=20
> This patch adds three main functions for DAI master mode: set_dai_fmt(),
> set_dai_sysclk() and set_dai_tdm_slot(), and one essential baud clock
> accordingly. After appending this patch, the fsl_ssi driver on i.MX series
> has the ability to derive LRCLK and BCLK from baud clock source so as to
> support some audio Codecs which can only be used in slave mode.

Applied, thanks.

--QCC2I/2CckNfI+Tr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSss7hAAoJELSic+t+oim9EeYP/RDpWeDZFHzVsCBe66KpRKlH
I8HCnRChRZz6dI10EheWrIEiYXWWZ9UkRsXXx6DphN+K5OniRU2ozogDZdewvaBj
Y1eZk8Ho09gufRz7mWQNA+JLA6PfZ5nUWLQpIYYnv9kVDyQJ3EhGCK/izg+jVc+y
uKVg6Lvz6DTPsWuHqNl6/Dc75y87XuAVjYiYH56X/louGm4Y//4BfFbUNqO8UxVT
kJeUaOV2um/wiDfnuOjB3ojSiNq1AJXNWk9tl8/Jh0khXCIAj/6Zv7qeIZh9jaQI
fZf1MVVSqWKnkAJKQhxVWLzy/GH7Abi+SHeSWMXcO9jhKdqqjt+kSis2QEFlayzV
xuEyhLdtY3RWcyoZta4c+dySZY8IH0ahRDsbdByEcSLH1adP0vSu0/Th+Ynq7gAW
YtK2VRoQI1z02CGP3JAWmW8hCDTOECUwMs/6TtmrcYMnrrajY8eF0kHv0ju7A3Ze
1w0EfFOV67lTJEpWe/ruWfcbTFq+n3flvYO6TlgZA4tuS9PsYrPKJiN2YMui7+NH
vfHjH0x8PcrT1P+UWKL+g621lhalxKvUTR/dyONRFG6seNGkHVrtKr61T27jSMXo
Vmhvo4nxc1bubV0bsE7C3GRWdffa8dPPdgWBRsciJCqDEmK2R1vv0Xr4Ctt5xlVx
6G520tJq91ENcWquOG/t
=+6lW
-----END PGP SIGNATURE-----

--QCC2I/2CckNfI+Tr--

--===============8091669770579791213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8091669770579791213==--
