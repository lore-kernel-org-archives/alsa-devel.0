From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: ak5702: add support for ak5702
 -- 4ch ADC
Date: Mon, 29 Oct 2012 16:04:51 +0000
Message-ID: <20121029160450.GB4511@opensource.wolfsonmicro.com>
References: <CAFsPKCXpZ43SBXyPTJnXR9mUgXyLK0T=JBiQrkBWGzSJOuLptA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7037568730471536546=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C4190265D26
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 17:04:52 +0100 (CET)
In-Reply-To: <CAFsPKCXpZ43SBXyPTJnXR9mUgXyLK0T=JBiQrkBWGzSJOuLptA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paolo Doz <paolo.doz@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7037568730471536546==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2012 at 09:43:57AM +0100, Paolo Doz wrote:
> This codec driver adds support for Asahi Kasei AK5702.
>=20
> Signed-off-by: Paolo Doz <paolo.doz@gmail.com>

Lars-Peter already went through most of this so I'll not follow up in
detail.  One overall comment which Lars-Peter didn't make but which it's
worth bearing in mind was that your driver looks like it was written
several years ago, it'd probably help a lot if you were to look at more
modern drivers and make sure what you're doing resembles them
stylistically.

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjqkcAAoJELSic+t+oim9SssP+wd/uNMF8ODKv64XKsXQI5Jt
/SU0VSuLA8cTDqIIhVHT0PZFMQ0p1n1+6zDCZu/7kF0fCTwhcXOTi7la1yJanfN6
WrWqfDwelNpaT45S5VZZYamEKh+TnQ+04f0dcg8EUfdCHFuZobR98kwSNT5tJxYp
LwblC3/LWtYWiaIjZdNaAdaPkXjpHJZro5Ho1/IFLX0r2wlJ2zqb3TXljRfdpaO1
TUY1SP+IfIGoFPHOdZx5ZzgG7EP+dlUrV2fySSyTTqsHlRAUTbBddcDIaoI9KqTj
bcBgCqwcsvgq07LwT+N0u4Jvn9sLH4KZsK8MtT6dSXgXZhKGr8UK5FfHc0MQnUxb
97o6a2XcQBKMLs3s7eZOrOqcq2J1TplWXc4khKYVDfQPUwL858LFbzJwWaU07r4+
USHPV7BaIUy85uUuR3cmx7R22XxKp/BPJIRqrVaVfPSDt3yydzpmq1TLQHCVFWkz
G9yfwVDpnfGZQjAOGtApXRgeY9+mpC82g7fGO70D39bcZazSQEXv5miDyNmpbH43
2Yp6/HG1t6u6Wefr97JAw53iRjoxb9jJTomikc7nUuyyuvX6N/oRgdP4GaMRz7hy
mhRQhyYio79KXA+PpDoKV2hKdKuhxqCjWS+LjGsKmoE0SowySIesyaJJuqRXpP3O
kNTCj425jbeG47tQBodo
=x2ND
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

--===============7037568730471536546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7037568730471536546==--
