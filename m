From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix SOC_DOUBLE_R_SX_TLV volume mixer
	arguments
Date: Sat, 21 Jun 2014 11:24:44 +0100
Message-ID: <20140621102444.GP5099@sirena.org.uk>
References: <1403294418-6743-1-git-send-email-ryan.harvey@cirrus.com>
 <alpine.DEB.2.02.1406201503070.25941@heelrod>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5859654173014619201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DEE5265141
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 12:25:04 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1406201503070.25941@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com, Ryan Harvey <ryan.harvey@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============5859654173014619201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+zcGsx7vUN9P7pfi"
Content-Disposition: inline


--+zcGsx7vUN9P7pfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2014 at 03:03:58PM -0500, Brian Austin wrote:
> On Fri, 20 Jun 2014, Ryan Harvey wrote:
>=20
> >Remove unnecessary bit shifts. Correct min value to match datasheet. #St=
eps equals number of steps between min and max.
> >
> >This patch depends on 8f0367b53d887726b1f4b0b39e0f09b7cca2f79f
> >ASoC: cs42l56: Fix stereo channel register assignment for Headphone and
> >LineOut volume mixers.
> >
> >Signed-off-by: Ryan Harvey <ryan.harvey@cirrus.com>
> >---
> Acked-by: Brian Austin <brian.austin@cirrus.com>

I don't seem to have any of these patches from Ryan - don't know what's
going on there, the message looks like it should be going to me, but
without the patches I can't apply them (and they typos in the list
address means I couldn't pick up the list copy).

--+zcGsx7vUN9P7pfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpV1pAAoJELSic+t+oim9cXAP/1IOnLPBCCHyMwGHikpSX0e+
bl/80NtJAIs4FydxcGX9I1fMv1KashJ3xX18qxka7+OrtGO2mXNPiHS3m/FMRynk
gkmtjuURNtCQCZtXQ/MD93tvyRbGmC0qOtoVleF1CO+BV7Gheg//8cGhjdSwQ8Y8
4w4to5VvCJwY1vjTY9n/InwqNMhYkvXoVO1Mv0attI8SudH7R0vvKV7ywNdLa9td
KI3Sde/oqWcY2pJBU7np50mHVDBoTpBjZ6Dkt599krV7pKPQseehs10dE4OF30tl
KYQHtOO09PXSRreh+5HH9Y2xHHfWerCNegm6y8A7W9QWPG2MXitgzvvBWMIai7Mq
HJ6dcBc5oqhMXM9AkkbmgqZHUm9/9Jd9FdeoPmMOa7IevDQycArW+JtfIK+bv//Y
QdBla1LY6K3RTGZ6l8XY8Y50iE2g+WNBcixPmxa1nEJKhpp9bppQg4Qe+6tMBC0f
Ia80NPhzkY3QXgA0I/lHA81rf8WrQP36hFcSO0X6S+1qQuycNp7K0OOobr4up+wV
Hrl7uTx0X4/0KeSnRXVBDProC7p17tMFfzn86JpTPHQY4kmILEJAkJjIZo9/41HY
1az2fjxN8dcmNwSQGA2dHwwx3Fv05+0cwKezuSNY12xs8rLn2xmZ6xq6XUTkvQlR
kZkZox9efGyDfqJhVCg4
=MAfk
-----END PGP SIGNATURE-----

--+zcGsx7vUN9P7pfi--

--===============5859654173014619201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5859654173014619201==--
