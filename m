From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: tlv320aic3x: add missing
	registers and bits
Date: Sun, 1 Jul 2012 19:31:31 +0100
Message-ID: <20120701183131.GG28922@opensource.wolfsonmicro.com>
References: <4FEAA303.5020806@aksignal.cz>
	<20120627120130.GJ308@opensource.wolfsonmicro.com>
	<4FEB0429.9080209@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7767787878470636053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E43724391
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Jul 2012 20:31:42 +0200 (CEST)
In-Reply-To: <4FEB0429.9080209@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7767787878470636053==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rvXnmSEQm80JaX+R"
Content-Disposition: inline


--rvXnmSEQm80JaX+R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 03:01:29PM +0200, Prchal Ji=C5=99=C3=AD wrote:
> Adds missing register default values to cache.
> Adds register and bit shift definitions in header file.
> Changes are for TLV320AIC310x based on data sheet.

This doesn't apply against current ASoC, please regenerate it against my
current tree.

> v2: keep formatting of cache
> v3: fix wrong diff format (sorry for that, I start learning git)

Don't put noise like this in the changelog, if you want to include it
put it after the --- like SubmittingPatches says.

--rvXnmSEQm80JaX+R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8Jd8AAoJEBus8iNuMP3duJAP/iah56LBuErhzlsHGYfT5JmG
0/MRDxSiV1HHQuSNgis513xoOHq/1eE4spS0xYd7bxh84T+8lBLAx+jGAO1l3UkO
IZfH3lG0WOKkysMh9a97cRyTbE2nTGUS+47dfz3NCBH1x2p0hL7ibktEcVhp4boH
a7kTkdMXlCaMLBr/NbOCGbp0YS2PUn/pSNYRz/+Qb4P0nt3yviXMEcNACkr3ZSNu
h86Q3qz4TUHhUfCSRLkm6mJaIK2bZaslE2WojFIN1IbGTBGd8MyXynXeLF28fdqH
4ZFl/tQ78cnoE7Lwy1GiiqHwcFs/Q9f6n7GJlBlxQwq5USmbQq2zywK7DTGWjWjy
UuZoh5Oy/FBkIsIT5N0k7BJpzCPb//4DJqp+pcNmBBBljcsmMqk0X9LMns4s3Llv
X7L4l1NJPZzdIIR5TEe9ud5tIJ1caXoV0iqVAC92OytKweJwzAPGfTjCK5k0Gy1f
B/a7Cj7aVMOliB1khsIAQIP1DzQ34GYMfy6mSZKcs9xLVz1SrFofkN5z6vl/hv0A
8ukxBEnNTKVYTr86RPz8Ov4J+G8NVNNc1POuIXa9x6eve+KGwKkMXCSWHKm5El+P
VZoCYRwoA38WpJpk2GNbnkFgAgL8GZzRoDt0F2qh6D7BrbFlGVP2yg3+TKcZKc7w
Fh7bx0KOzyZWM8oL1F/9
=BC+E
-----END PGP SIGNATURE-----

--rvXnmSEQm80JaX+R--

--===============7767787878470636053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7767787878470636053==--
