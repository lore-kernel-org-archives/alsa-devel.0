From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: use device dependency clock
Date: Wed, 5 Feb 2014 17:26:40 +0000
Message-ID: <20140205172640.GF32298@sirena.org.uk>
References: <87wqhg6228.wl%kuninori.morimoto.gx@gmail.com>
 <20140204182749.GR22609@sirena.org.uk>
 <87siryv15f.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6510744920101503630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 343C4265007
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:26:49 +0100 (CET)
In-Reply-To: <87siryv15f.wl%kuninori.morimoto.gx@gmail.com>
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


--===============6510744920101503630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 04:44:34PM -0800, Kuninori Morimoto wrote:

> Here "new style" means "external sound clock has relationship with sound driver",
> "old style" means "external sound clock is independent clock"

> This patch adds new clock-relationship rule to rsnd <-> platform.
> (sound clock should has relationship to sound drvier)

> The external sound clocks (= clk_a/b/c/i) are "independent" clock
> in current linus/master.
> Then, all clk_get(dev, xxx) will be same clock (= module clock)
> (It was not strange if clk_get(dev, xxx) returns NULL though, but...)

> # Above code can works well both common/legacy clock implementations.
> # And, it can't select both common/legacy clock in same time.

> I will exchange git log comment (= about "new/old" clock),
> is it OK ?

OK, I'm hoping that this situation is not expected to last more than a
kernel release or so until all the platforms are converted - can we have
a comment explaining the issue giving an ETA in the code as well as in
the changelog please?

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8nRNAAoJELSic+t+oim9yqAQAJVp7hdjGGGpmm/Gav6esOw8
e6ndsccl66xWE9rocmiEoq5jzZ9Cs2UPrtNSWW9GEddGnadcDayAlNvqS3CnN1nX
MtT3QINUyR4NwWkZmX7DlzW6Qq1kXHXx6qwxOVfe5RiKFuvETAJl1/8ghmwSgKbc
5/P4crRA3FZ5shvZT6ePG2iXfuC/qcoqAbdPpkisIyhYBphdwQYZ9o2K7GAcKNCh
+VjjanRJjYVKOw8vadxYEGZK5T4XhIlTYr3zkY8/MXhXRFYCYfBq/mlt6MT1cvcz
m1+rJ1krS9oJuiTal7U3n2YCHHkP0lvZ+vXYCLfggCo9IsnNuf1fspJDvr8EVFS3
07GOg4WVFKSJpJULduYYvu7iE0zFPVEab1MxP1aXzDV4Xx36xokv90uWfw7/SBb2
EW2HGsQOp78Xtj8HK2MrhV4V4UBj5A6LPhc92cDfW4tC06GeeSVE3FTn7UA+Z0M/
ZfL/O6Gwy0j39T7Xls5lABuPrrqlExF3/mso9Dsa/yA/6AePlSLtJyO9mPRX7cgl
TOL8XkGzGyXaZKz77Vpygl2ymKB8ijv1OiqNLuNGZN2g5J9iyhCOWTFFunW+VRHJ
6760//g5MaQFS1hVsYvqkIPWcsImH82SpU4lX6ReFyaQLBedyP0gKjIkgrwwfspi
WtCtSLPsUe+CEvMzF8LU
=MjFH
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--

--===============6510744920101503630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6510744920101503630==--
