From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: compress: Correct handling of
	compressed ops
Date: Fri, 26 Jan 2018 11:48:42 +0000
Message-ID: <20180126114842.GB32674@sirena.org.uk>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <87wp06lotn.wl%kuninori.morimoto.gx@renesas.com>
 <20180125094745.rxboofyab5ey5nux@localhost.localdomain>
 <87mv114fz4.wl%kuninori.morimoto.gx@renesas.com>
 <20180126100351.bygmlfndmwiqfsvp@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0456342252882232219=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C425266C0E
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 12:49:04 +0100 (CET)
In-Reply-To: <20180126100351.bygmlfndmwiqfsvp@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, dan.carpenter@oracle.com, lgirdwood@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0456342252882232219==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 26, 2018 at 10:03:51AM +0000, Charles Keepax wrote:
> On Fri, Jan 26, 2018 at 12:33:53AM +0000, Kuninori Morimoto wrote:

> > Thus, if we can replace all CPU/Codec/Platform into component, every device
> > can have every feature, with no categorize !
> > In other words, we don't know how many device have it.

> Yeah I think there is quite a lot more work to get to that point
> though, we need to understand how we will present this to
> user-space.

I think some of this will sort itself out for the immediate future
through implementation choices in that we've not yet seen a system where
it'd make sense to combine multiple DAIs with compressed ops and don't
seem likely to right now.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlprFZkACgkQJNaLcl1U
h9ABTQf/RVOFA/5BQHhR+aZ2ZIRlaZeNd19l2cAzK4hAHyJhjYqTTgV1XO5n9Wru
kMm2F2ZHLTc0Xt2UL6tteQT9Z1ZHtlpUxF2ui87yhetqNqDHoSy4TfnATl+RNy6c
MkmFtrnK97S0e7EDHmMsLA++OzU5AhthBPkkZaj9zYNkXjrC9/DqAcCuEridHpml
KWpbxvkabXJ6fsLM2VxYf8gPr3sZwimuNqwlnqIuugM1+PYvVyqEpMhtQL7Uxzj0
6iMbHgIMkBTAfK+PfHzE7Q30zJI3Y7dIJOF+DXoi0XQO841JXHc9kZO3h/TRCd+D
tSQ1VF49cuwok/+rMjljKY8btvlbmA==
=I4ar
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--

--===============0456342252882232219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0456342252882232219==--
