From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Tue, 6 Mar 2012 12:33:22 +0000
Message-ID: <20120306123322.GP19635@opensource.wolfsonmicro.com>
References: <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
	<20120306104015.GF17370@n2100.arm.linux.org.uk>
	<20120306120646.GH19635@opensource.wolfsonmicro.com>
	<20120306122516.GH17370@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7700956042373582685=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B10581044D6
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 13:33:25 +0100 (CET)
In-Reply-To: <20120306122516.GH17370@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============7700956042373582685==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XFI+TFG+M3u0jUjZ"
Content-Disposition: inline


--XFI+TFG+M3u0jUjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 12:25:16PM +0000, Russell King - ARM Linux wrote:

> Please also note that in ALSA documentation, an 'atomic' callback means
> little with respect to race conditions.  All it means is that the callback
> is called from a context where sleeping in the callback is not permitted.
> The documentation does not say what is protected by the ALSA spinlocks and
> mutexes, so without reviewing the ALSA code, driver writters have little
> idea whether they need their own locks or not.

Well, who reads the documentation to get this stuff anyway?  As you
observe it's far from complete about what's what locked when and how so
you need to go to the code to see what's actually going on, especially
whenever you need to call back into the ALSA APIs.  Though of course I'm
pretty sure there's a bunch of uniprocessor assumptions through the body
of driver code anyway...

--XFI+TFG+M3u0jUjZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVgQHAAoJEBus8iNuMP3ddBcQAJxG7byjVOQ+2ZAgg7kX4KWC
w1adC5g/AjAbhJ+D0G1nAkPSckPJnnQ4lpGgem6/ghBj7egbgNk5LZ8RyrxwZ8OD
HraAb/tp8gknUjALW3zbY4naK5GHGRFUh4FdvoVHkgQ1squBuohrBQUN/tf5KIwA
yQJWzbFfewPeZYjU2Gk7LbmOYpG1tLncaqFPT9YDz1hLF+X5io0dXsoPBp1+TncY
GVFN2lUKnrjGZNgVf02u+xQXoZBu7QYH9g9MFsd3ZLOem/g1E61AQkD4sdg3ItB6
YeIbSp/oSpHXqnR8OQpaF9PaamM/KL95OeGbvihKCmpncrDPHsvf4+0yprKxl1Cq
E4S9sKYKu8t3i7O3PANojBzo/Et7CiMpl9DjPDQDGQO11vgI0Nlk8hxvUHi4dJgm
WpAgxENUsCO8J0v9YySuKY4C/nKMFn7D8afBCE/SzBgwL9nTH3t8KBvSYfEh5asP
J1zgyXidBAhDUkKQFCs71UdVtzBQj2/AKug0Dt99syJjPfrWo3Ko+WiCUYjIqQjN
yXXxQaosVvdyxGKiS6wKqkxC3U1y2xHd+r8iM5/u4Xc6kCxq0ss5uVF4RREQXUkG
lW3OX1AFoa43PvamSXTWOm8B2eoEJOyCdq+oY8XsGvXYH1iSXYGJ6jRBF46F79DM
aOnlwV1oEcOjyGM7aaCe
=tsXS
-----END PGP SIGNATURE-----

--XFI+TFG+M3u0jUjZ--

--===============7700956042373582685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7700956042373582685==--
