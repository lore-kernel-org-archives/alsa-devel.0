From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l52: Fix mask for REVID
Date: Mon, 7 Apr 2014 10:48:59 +0100
Message-ID: <20140407094859.GZ14763@sirena.org.uk>
References: <1396713875.9878.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0162287251578541224=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 010122608ED
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 11:49:15 +0200 (CEST)
In-Reply-To: <1396713875.9878.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============0162287251578541224==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Y8a5CJOPM/zJV44"
Content-Disposition: inline


--8Y8a5CJOPM/zJV44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 06, 2014 at 12:04:35AM +0800, Axel Lin wrote:
> BIT[0:2] of register 01h is REVID, so the mask for REVID should be 0x7.
> Also updates the code to use CS42L52_CHIP_REV_MASK.

Applied, thanks.

--8Y8a5CJOPM/zJV44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTQnSIAAoJELSic+t+oim9g+cP/29g6NkPEUgnDQnOE5o3KkXC
SkjoHPNzf5FBy1cLI93VlBW3atPXeCfxxW7FKgWHa7Pde97wjrE0Xvn1iPLc6+zn
Eby1zgULO4Q3N0KN+V7morVDgc7m+Yicdz+sQP94hUY91k2DuDm/mxJvgcr0oz9M
GY+DGGwfylmleYzBBYnEegNxltvJVV856YMjgTYSfgIDRNBpT9dtuf1p6zOkAfl8
W/UGqAybiGbsntN8q4/yqzY3SKER40CEqZE1TFKOjgwI7u5JWVinIvQQjMYR118W
RXbf6nfcrf+ZVzuIHgMQw9Id6JLAwLD0J5vuldi5/WCgElsiPLhYIKepjdb9+01S
mF53P2egTANHSi2uiebOtnC+CSRGm0LXQ30xqft9a0gUwcryDoOj8aqfxGE6X/A0
9fTXBE/GQ+7dXHligClqWS+/Ri+2A7aEa2/7PBIrlg5FG9vwuPe/ug0iugRF9pTy
SzxgAsv3rcpdN4dCpiLkVu1R1nc3/wVMoC7eVP9cfLAvhCFKKep0+S/+HpcYhIKt
1XJadqL6nNkO4nubjlm6XnfvMJ8V0Eqr8HlyRcU6Gw3hyLIxHwzcnUVPDsgja+21
xIedDtLEVwmh8AWRqjjwe2oCTaa0t9qRIIZva0gqoJn4cbyNRoK1WDA8Hdwn9Ugy
3V1pyWnkBz08rMmz5sPv
=OEh7
-----END PGP SIGNATURE-----

--8Y8a5CJOPM/zJV44--

--===============0162287251578541224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0162287251578541224==--
