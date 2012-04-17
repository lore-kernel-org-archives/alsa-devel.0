From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: da7210: Minor update for PLL and SRM
Date: Tue, 17 Apr 2012 16:20:06 +0100
Message-ID: <20120417152006.GM6652@opensource.wolfsonmicro.com>
References: <1334674858.13279.9.camel@matrix>
	<20120417145618.GL6652@opensource.wolfsonmicro.com>
	<1334676602.13279.13.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4022414276053368024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A5B31041D0
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 17:20:11 +0200 (CEST)
In-Reply-To: <1334676602.13279.13.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============4022414276053368024==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Content-Disposition: inline


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2012 at 09:00:02PM +0530, Ashish Chavan wrote:

> To do that we will have to use spaces instead of tab for indentation. I
> am not sure if that is fine. You mean something like below, right?

> 		if ((fref == da7210_pll_div[cnt].fref) &&
> 		    (da7210->master ==  da7210_pll_div[cnt].mode) &&
> 		    (fout == da7210_pll_div[cnt].fout)) {

Yes, that's totally fine.  8 character tabs and spaces below that.

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjYoXAAoJEBus8iNuMP3dKrwQAJj9n2b4Y3HEPqVfCwezZEhk
VUwqg87v770JLxMrMFCJ4KUPsKXLxvRl0iawMNli2j+/jAtv3TgXGn9s/T6joTuq
3g0pVlsOgJjCh8tx24vWhfhSsBm5qD44LEq81fQ3hCwV+dyl4zH/U7QIWUWfFs7P
MZsDhJwhnELndedJWz56RSz/luRs6arZe8EC0s2ANj2kXZsogMPodW17zwKzBVfJ
sYTO8NYrgyXKXllCs7m9Xchyxi5dh29E8q64anEHK4Ud4RYoYu+UCn6J6myLNXuC
IzszYkBZK+QIdzz5Jij8VYT5qPVzH5iBH8ZQIi5AKonLl17cKLGH5cWl5Ufjtx8B
QkXL9vI4O3JoDQva/lRrmRL8PVkz38wR1JP2N6PwRjb7HBbpUF/6JCIsqZPG8aqJ
6CoD5xJ4PA5C1X9N7bMGSxXDte5HR5xCqwzoOzphsQwi3BmZ1dSw650XlXhDaWtX
7HIivP5H2MGt0P43CpG91SCkRhQ1ACF78167qwAvM0BAkZn7CAi1qYJPhEq4ui6q
WbDz86uvrdCkO+C11fdlatSLvH2371vywaBonKtfP4F4uP6QJPOlsyZup9JRrfRs
djAFxet5Ls0NJc1rK7j+Qbwqm3A8NKnYf7/PMcF6l8ucA+msAHKdBxQvRZfGNJo3
Px4N4V2WzpK2wk+hibQP
=GUMY
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--

--===============4022414276053368024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4022414276053368024==--
