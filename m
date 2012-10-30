From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Store codec capabilites in alsa
Date: Tue, 30 Oct 2012 15:13:03 +0000
Message-ID: <20121030151303.GS4511@opensource.wolfsonmicro.com>
References: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
 <508A69DB.7030009@ti.com> <508DD824.3040600@codeaurora.org>
 <20121029170732.GF4511@opensource.wolfsonmicro.com>
 <508F4830.4010600@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5535847959765695485=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E0AD2602DC
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 16:22:07 +0100 (CET)
In-Reply-To: <508F4830.4010600@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5535847959765695485==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WKQ7zUpzoH2KEHMN"
Content-Disposition: inline


--WKQ7zUpzoH2KEHMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2012 at 08:23:28PM -0700, Patrick Lai wrote:
> On 10/29/2012 10:07 AM, Mark Brown wrote:

> >Unless you tell us something about what's being advertised it's very
> >hard to comment;

> CODEC has filters for noise cancellation purpose. CPU will need to
> know given CODEC has noise cancellation support. Also, CPU needs to
> know the CODEC registers to program the filters and which digital
> audio interface would have noise reference.

Why is this all not just normal configuration done from the application
layer?  Especially the noise reference configuration just looks like
totally normal routing configuration.

--WKQ7zUpzoH2KEHMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQj+5uAAoJELSic+t+oim9sSIP/idWm0oIH9rqf5vhb3PLgNOM
E3H2Aof4XWTjgNiSnbOLEF0a50qJdAS8Y/shy9SeHUpr+JaicHNUFFNvO1qNCmZs
wA/hv7buVb17rpD9ZOLGzL4HMRKdBjvICrCZrvuuga4F+skEfuTYpuJ8xUBeSUey
f+RsM6RAg9biJmrKsIxv22n/+oqUcV5ggeYyZ+Kx9uino5bCBmUFvHtPK9svdkF/
7Oi17zOxZaqPkNbDqWHGw8tgS29hUgQBwq+r3KkOWAUgRXAEOxQBZb9pZPcMCcFZ
K39OPmbrybFFTitsWI1wNctk/dAE2HnsrR56c6jADRO7ijdjM79p0jrtLAgJgW//
1gysbV+CzSFvSkuZBGtQlIyeesgkp0llOI3Gi2fLlllzx3J8gYvC2V8BVa9jATQN
5Ed1Sx67Iwb1Hqj/UCC9rBPTrh/4ESDc52BDHEA18OG6p4G3pLp43zbTa1mHee2U
/QasX2BSHhQiuu9hbLJQHZdSf5X+vXaATgCMWwUFxe/d0U339+7w3F6CT08+V3wV
kG/aprgXcIKtZ5vfNucq/l32OEaeatlnMScZWf/U6vgYBQKX0Nw/JLW0VqwI138e
E1zTWVXVD1YAq4ilV0ZReSO732oSTfiaeOIUgJ7odvvJ7celBRvGK3cfThV2XYPs
ozkbfBT8OI2+GKOsf/NX
=WyDn
-----END PGP SIGNATURE-----

--WKQ7zUpzoH2KEHMN--

--===============5535847959765695485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5535847959765695485==--
