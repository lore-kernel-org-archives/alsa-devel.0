From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs42l56: Fix stereo channel
 register assignment for Headphone and LineOut volume mixers
Date: Thu, 17 Jul 2014 19:58:39 +0100
Message-ID: <20140717185839.GF17528@sirena.org.uk>
References: <1405621015-29017-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7319520636631039172=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07B2326557A
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 20:58:56 +0200 (CEST)
In-Reply-To: <1405621015-29017-1-git-send-email-brian.austin@cirrus.com>
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
Cc: alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com, ryan.harvey@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============7319520636631039172==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l+LxDeyHMCBjwres"
Content-Disposition: inline


--l+LxDeyHMCBjwres
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 01:16:54PM -0500, Brian Austin wrote:
> Stereo Headphone and LineOut volume mixers are now attached to HPA+HPB, LOA+LOB.

Applied, thanks.  Please word wrap your commit messages.

--l+LxDeyHMCBjwres
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyBzcAAoJELSic+t+oim96RYP/jAxOOtzrZqLXo+0YKpumnyn
wkazIuNVr5MfKOYmBWfE93nAxtlQUWUc7ztEdGL9wPyKDHSG4gl9vSbLgkzUQ36J
LWU9bvWPR78wcKjP4GfqCGNjK4UW/xwfrbTfT8I/lisYIRz5widqsI/oSP23bdbe
aH65iqa4/5/y5o5isbfT/Dkw4+Ec2JfefflXgZtsU68M68s8wUrMNOzHdMvevkMn
RBKbaNaE8U7rfoL1gxdI3LLN2WkHy2HKfjqMjktRBkSYZpWmC59wQBV6kNJXALBZ
BWcq6pJhJSHiJfqFtw7x5kQz+I7xFztklvem3fGLyWg9BxDEIb3NHlFLonlhUsxe
GI6zP7wg8ZlPIkmICVdw7klszhcfGWStcjZV6XDrLd+WaNyYUcfXL7mIRkdohtMS
JdtXT5w26LTvoSWpqfEooubwNG6EK/TldoLZ9oBuGrSL+sVuUZWNUDpoXxJ73Ox7
NL2juOP8WqJmPHuAg7JPGKLBzjaXTNt2Z6Fg1MqDMUdh2Kt+Kq99/sGsdV27nw9a
wCdGWBwIYHNCsZWPespiQwExcb00uTqrfQ+e8YKADmWfxmuXF9AhvUSNX2XvOuH7
Rwf7qgRQshP8LFpFDt1Hng7CJaZKx2mpRJH4EcwiGwPW89hhiPQegv5truBeqA5S
QNG79PpvRcaV7bDgH4p9
=nDPd
-----END PGP SIGNATURE-----

--l+LxDeyHMCBjwres--

--===============7319520636631039172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7319520636631039172==--
