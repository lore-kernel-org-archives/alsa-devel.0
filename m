From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: max98373: Changed SPDX header in
 C++ comments style
Date: Wed, 10 Jan 2018 10:29:40 +0000
Message-ID: <20180110102940.GA13207@sirena.org.uk>
References: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
 <20180110101506.GC9003@sirena.org.uk>
 <s5htvvuxbcr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0529144815653140084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B075266C5E
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 11:29:45 +0100 (CET)
In-Reply-To: <s5htvvuxbcr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, Ryan Lee <ryans.lee@maximintegrated.com>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0529144815653140084==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2018 at 11:21:56AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Tue, Jan 09, 2018 at 09:01:58PM -0800, Ryan Lee wrote:

> > > @@ -1,4 +1,4 @@
> > > -/* SPDX-License-Identifier: GPL-2.0 */
> > > +// SPDX-License-Identifier: GPL-2.0
> > >  /* Copyright (c) 2017, Maxim Integrated */

> > Please change the entire header to C++, mixing C and C++ on adjacent
> > lines looks ugly.

> I'm not sure whether it's a good direction to go, either.

> I rather wonder why SPDX line *must* be in C++ comment style...

Apparently it's to remove any ambiguity for the tooling or something,
plus Linus decided he likes C++ comments.

I don't understand why this isn't done as a macro like MODULE_LICENSE()
and so on but the decision was rushed through and not really publicised
:9

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpV6xQACgkQJNaLcl1U
h9AIdgf/V1gk1TN/F7sTyXwgGnmLs9zDFSf/6BDrHtT65FM0mL/21keC/oWDjny1
WC4BG4+kV83DSjV0yjakCoS4jbmYK4Ck6m7FmK9tSuP4WdjPdiEF5JJZE4zftp9L
lOg4pXtPWE+lbUCdMbpgVpARQbkN2+HYNRppkqk2NEaN/uvUEBg79jkXrwwRtf9R
EqXRjlYuCcjCsLnbLDmm6OOMxzB71ty9RF1ezPeuar4C0ULKnS6KgGpv0vQBau8r
tde2XWQ64F2XvpHfRNJtFOeyBMEANiBkxwViru9D6AUfQg3q8MdEFNLmAoUrgjyU
UeWAbHNqLnagb7EsoDhdi+6SLwtnBA==
=la6V
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

--===============0529144815653140084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0529144815653140084==--
