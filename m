From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add
 asoc_simple_card_parse_daifmt()
Date: Fri, 12 Sep 2014 15:02:51 +0100
Message-ID: <20140912140251.GA7960@sirena.org.uk>
References: <871trkytuv.wl%kuninori.morimoto.gx@gmail.com>
 <87wq9cxf6n.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8823631989844538050=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F9E0261B25
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 17:39:42 +0200 (CEST)
In-Reply-To: <87wq9cxf6n.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============8823631989844538050==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHmMVWdCgqSO3x88"
Content-Disposition: inline


--wHmMVWdCgqSO3x88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2014 at 09:38:59PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current daifmt setting method in simple-card driver is
> placed to many places, and using un-readable/confusable method.
> This patch adds new asoc_simple_card_parse_daifmt()
> and tidyup code.

This doesn't apply against current code, please check and resend.

--wHmMVWdCgqSO3x88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEv0KAAoJECTWi3JdVIfQeLsH/j3VyxYLIGyL34mdfQc37BhQ
y74rpQKQeOYQ4eue487f1kESUSeMqTVEvjKjN7CJy9rDLBrx1dVxmqmOWpL2wytX
1W1MrU2+YsEyMj+9CYyKtLW1Uz2L9+tCGPYCi6HR27sAfPdBsXaC67N6sw+uavyI
ZsjP2ZYDYpIyCMsYYv6aGRWoGzXMSl9AuiU1dcU/ao2vpWoo/xleUyT7USCIK0Dm
jSsQV4mzJPOc1xm+4Khhs5zumnNZdifoz07XlSP3V+QA+Jh5Mhpax56BrWCuCoWD
M3G74a2k91+Lco7if32QxdpNuC72VGjvG34bCWs6zJy01R5Q4m5O1NpEKS4O8Pc=
=3p/F
-----END PGP SIGNATURE-----

--wHmMVWdCgqSO3x88--

--===============8823631989844538050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8823631989844538050==--
