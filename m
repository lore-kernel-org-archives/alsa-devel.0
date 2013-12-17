From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
	sgtl5000_enable_regulators()
Date: Tue, 17 Dec 2013 13:48:49 +0000
Message-ID: <20131217134849.GD3185@sirena.org.uk>
References: <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
 <20131217021610.GA7172@S2101-09.ap.freescale.net>
 <20131217113705.GP3185@sirena.org.uk>
 <20131217123946.GN6691@S2101-09.ap.freescale.net>
 <20131217124657.GW3185@sirena.org.uk>
 <20131217131612.GO6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7182656885206589392=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B5F65261178
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 14:48:53 +0100 (CET)
In-Reply-To: <20131217131612.GO6691@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============7182656885206589392==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M3+ROfcjp/6iDHff"
Content-Disposition: inline


--M3+ROfcjp/6iDHff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2013 at 09:16:15PM +0800, Shawn Guo wrote:
> On Tue, Dec 17, 2013 at 12:46:57PM +0000, Mark Brown wrote:

> > It tells the core that it now knows about all regulator mappings so it
> > knows if it's not got a mapping none will ever appear.

> Okay, it sounds like what we need.  But I searched all the occurrences
> of have_full_constraints() in core.c, and haven't found how it
> influences the regulator_map_list searching.  I'm looking at function
> regulator_dev_lookup().  Can you point me the correct place of the code?

For platform data it can't influence the map searching since we rely on
the driver registering outbound supplies, all it does is change if we
defer or error.  Though the erroring code seems to have gone AWOL at
some point and it'd never have been robust for modular drivers anyway.

--M3+ROfcjp/6iDHff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsFY+AAoJELSic+t+oim9W1wQAJpJQrvp/UufaMjbEYs0LMBb
RnXl4lU0I2i1uQCgif3BoohBYOtZ4+GDYskCHVWA/N+ToHuvTHwXI/JGWpYVLi35
3v9OQ31EGNA4uszJJOkX5stlAIsrCc3w9udmOnjmN5VK4e9O09mVYix+dOofKI6k
JdjYbV2OCqwvadUyKmQ94JNF/eQBcZM4ge3y9ugGpUfcbplITcVBKD4NFe2Dwxaf
dJUn0PbnwDbELwYzdxL/V8QhCmeQe2YYmNMw8moZl2HkD/pL9Z8TFVuZ5bEyjxz1
8Z6ccj0l2bIbqnMzKr/Q/p3FBvW/O67UTcnWJD3Avy9dMGk3fC2iP4S73bfOyOpx
EsE7NWBsyMcDT5B69qmwOSQ0ruFnDRYtztkKKcEBCfjinxUZqELclfU1xVUla6Le
1yB1SpHa6GX+c1zS6Z/AS+QA5Olh/okgFfEu1f/nICEaL0YRaFtJKTvfHVZ080ZX
q9cOPspFlZomKHn0UL5w2rppJtoxIMRxnaQLobBwbsUhmVzZVpWJCkA4KYBOlrf1
Fz0WdkoNSmyaaIbNUio6dptjiewNHnT3uzD9L3Kr/Fbmm2+ZxR/z/ChAl4s0TtGT
lLDE1hvCnsIZ9MGd/r694fqmf8ETtrkZIqhi9apY5JgUT6coinL+Bej7JNCcJ3Li
VT0Akh94KdVvUhAbDWW0
=orpL
-----END PGP SIGNATURE-----

--M3+ROfcjp/6iDHff--

--===============7182656885206589392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7182656885206589392==--
