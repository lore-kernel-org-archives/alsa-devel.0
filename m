From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
 after reset
Date: Fri, 10 May 2013 21:58:16 +0100
Message-ID: <20130510205816.GV3200@sirena.org.uk>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
 <518C4A8E.6020501@boundarydevices.com>
 <CAOMZO5AoWqhSdH5WVu=TFgejis=8mWNGYyHneRc5idwCd8RZWA@mail.gmail.com>
 <518D4660.9070202@boundarydevices.com>
 <518D4781.30507@boundarydevices.com>
 <CAOMZO5Dj83WqD2tQBQDBz9FzvLQGyuv-4yvb4gwL=rRq6DxPuw@mail.gmail.com>
 <CAOMZO5BQv-AwzXfYC0y+OvKNMHtkFOosPUGAWNBQizd9A+zk8w@mail.gmail.com>
 <20130510205616.GU3200@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0747068945392438640=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D44D261692
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 22:58:28 +0200 (CEST)
In-Reply-To: <20130510205616.GU3200@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org


--===============0747068945392438640==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bOC9TN0n4iVUZoxs"
Content-Disposition: inline


--bOC9TN0n4iVUZoxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2013 at 09:56:16PM +0100, Mark Brown wrote:
> On Fri, May 10, 2013 at 04:39:32PM -0300, Fabio Estevam wrote:

> > Ops, actually I did not. Will fix it.

> I'll wait for a new version.

Ah, actually that really only affects the already applied patch so...

--bOC9TN0n4iVUZoxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjV9lAAoJELSic+t+oim9uLwP/0kaQfcIugSAC+5O+jnBUJ1u
7bW22B+ycqxpCqympNAAfzEGITYjgaurRdCUuaPjcng/ZE2Vz8oMaG56Bwi7Y1q/
WVUvDODP+c6udPOTi9iRwhxKJirexeD+GC3XXDSyyMftx16LkyNWtMw8j2imD634
oByEXPnm+m2I3FKkaKZmSQGHOm/8ersJ0kdrG05JiU/wj3TPhhIlz21HC1+kbLw4
SiykjdqShsEVX3hzs743diT5ycCaJ8WEdw6CgW62037TtBl2ViaveU24XBCFySJP
pCDXcLSKyL6njvIeqvgKsVj9tW21x4UikU9myfX/u7w+JsdWTkP5FaNMUISoo9xU
OIZ9s/xYPEqv3kwsiIOqUyC6ufWchfbkK4JXTFEQoUu5QYMghVjyakH8ABLQfacE
3g4+gq3nwWquRpeLHv4eGCeRZfMOM3T3WEsaQp5GTbIExxTmWqkOMvL3yFFhXzRQ
EDZUP68phWESE7+rgExZhb+LGqmeDpG2mvFrpfFX8oMjGnx7mWasU55VqfqBU9ac
rcCWlNvFlFOy7FcqTy/SwmN/KWgSzAdac9eZ6YbSLdTqlZQDPnMbr/Y3odwLWu6g
noK8gSMSvXtNaOZqi1O6Ywj51MhOtfklkd9Pcx5nm4R3NODtxeBjDJNsvnE9wJSh
HBE0OKiB2XSdNwl5/7fa
=w60c
-----END PGP SIGNATURE-----

--bOC9TN0n4iVUZoxs--

--===============0747068945392438640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0747068945392438640==--
