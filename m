From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: ASoC: axi-spdif: Use
 devm_ioremap_resource() instead of devm_request_and_ioremap()
Date: Mon, 16 Dec 2013 20:46:40 +0000
Message-ID: <20131216204640.GX3185@sirena.org.uk>
References: <1387195644-28513-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3904263153479509708=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FA4F2619F7
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 21:46:46 +0100 (CET)
In-Reply-To: <1387195644-28513-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Fengguang Wu <fengguang.wu@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3904263153479509708==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjLo8P/CG6vpADRe"
Content-Disposition: inline


--PjLo8P/CG6vpADRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2013 at 01:07:23PM +0100, Lars-Peter Clausen wrote:
> From: Fengguang Wu <fengguang.wu@intel.com>
>=20
> devm_request_and_ioremap() has been deprecated in favour of
> devm_ioremap_resource(). Fixes the following coccinelle warning:

Applied both, thanks.

--PjLo8P/CG6vpADRe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSr2atAAoJELSic+t+oim9/ioP/2pVInw8QLX4DQUM0s5bod1X
pcO0g2jO4q3I5KIsH+nYb+GTNLkQbzzyQeXF7l/5iYOY2Oixld2swB+AtlAW1Rvo
9JcP0KrCxcV59oTPiFjWezvDRsf8CTShp05/sntJGY0OQlIHL2Sexyo2Jw5m9Uvh
7UEGKvsnmuiHT1Vve0+2FYw0pntoFJzdyzCbB6L+ODsJUT1CiSl3OgY8K27l8pQr
MFez2I5qebb3X16PgvYr6DMAvOc/thTrMgTz9vqrr80qLO84TEA0tqBvRmfhEnWE
dFfqAZvmSAhTGmr4HcKnX1Qa4gzmdYljepcgxB33+JDrnBE1gxACxJw7SoDUzAtS
ORV8tGztC/HSbjY4rbwvSwRYvthpPIulsVwH3ycHLBE++eODPj03Aku695VJPByH
GTUENszI8yPhqKIWAXw/dtBXcBf+n/ZY3ui7uz7oGQa6yLKhuJa7QDhZAKbSa4Xi
XopcosuqEnomiSZd7dathQXguTbF84uFGGYJ3AAUHbNybWKnQify8TlEeqiREflY
HjaNCI2nhrz+XBgA1do4NjBCPcQfPVFujkRDJgo1StRxl0OniK7f0TRfQIw+b86v
FwywgBOmXMx35Xy7Ex3L2t7YaGT3nj3SK5uOIC/T3m4UrEBA+liIh/I7867c77NE
Bq9A+74WWLgRPRWpTYVV
=hZGg
-----END PGP SIGNATURE-----

--PjLo8P/CG6vpADRe--

--===============3904263153479509708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3904263153479509708==--
