From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Clock generators in ASoC setups
Date: Wed, 25 Jul 2012 11:52:58 +0100
Message-ID: <20120725105258.GH3099@opensource.wolfsonmicro.com>
References: <500FABD0.4040001@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2108246711282945379=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ACC3B2652F6
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 12:52:57 +0200 (CEST)
In-Reply-To: <500FABD0.4040001@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2108246711282945379==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 25, 2012 at 10:18:24AM +0200, Daniel Mack wrote:

> some board I'm working on feature chips (connected via I2C) that are in
> charge of generating clocks for both the CPU DAI and the codecs.
> Previously, I configured them manually in platform specific code, but I
> wonder if there's a better, more generic way to get the job done,
> especially with regards to DT driven boards?

The problem here is that we don't have a usable clock API to work with.

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD9ADAAoJEBus8iNuMP3d0IsP/j/UYizvDzCNf7X3MrOWXLv2
CcLOr5sciwIaR2Il2BhyfQmLP+fgZJgAqKrHJABu6Y3cCQgdwrQQO4vUtcu+ea9t
vLAddGYrHqmatmKRuYS2BMgt+bPde5XaY9/jOoMhrxKNV9N3X0RaCBDlDk5C2pM1
L8bjWUFB5s2pAybeA4D2tBB0xQmGoariskm1XWsHhpo/aLjg0X79Pmm6iszeqvqJ
JF/pEGRyjiSgj4/4bwRlcf0RYS4eAX/n3RearG26gWPah9okk6E3pOeAaNzWEhoz
+H5DZp2hpM5OAOvLsSqbgaI+IqGWuAgdX5iCaahfpmp9kIFLEUHGnYG1W4n0zVE+
WZ0YdkEV54WxfPzrTsYYpFNXjGD34F8yYDx98lReOZ+7x/OMLO+OuPU3NGXDo8Bf
LFFjbF7uxqFbIk+zpnA4lKO2kpcU+s6vzMy2ytIuq8dNfYdvuhy+62ViPspnm5k0
3aFCQXM143i8w6Zi1FKRcbpVVdAUZUFFoEEbtNcNc1UV9CE6m73vVZtjyYTBMxjL
B+QiM/8iNj41L++rzbkohZUd9ylge56pb+fxg66jfnZkAcsxh5Sg/+TTvh0y4nlt
Y2QLOmPt+SAG4m1dx7+hb4jfw7X3L35A4pE2e3P45dTlJgql0T8T86AuHDo2OfEx
owHNq8at5P3dP8Xd7Cke
=E5gz
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

--===============2108246711282945379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2108246711282945379==--
