From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch
	fall-through
Date: Fri, 3 Aug 2018 17:45:04 +0100
Message-ID: <20180803164504.GF6591@sirena.org.uk>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0500644538880292087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 344732677B5
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 18:45:07 +0200 (CEST)
In-Reply-To: <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, valdis.kletnieks@vt.edu, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0500644538880292087==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2018 at 11:41:39AM -0500, Gustavo A. R. Silva wrote:
> On 08/03/2018 11:26 AM, valdis.kletnieks@vt.edu wrote:
> > On Wed, 01 Aug 2018 14:56:16 -0500, "Gustavo A. R. Silva" said:

> > Wait, what? This looks like the sort of bug -Wimplicit-fallthrough is supposed
> > to catch.  Unless for 'case WM8994_SYSCLK_OPCLK:' we actually do want to do a
> > whole bunch of snd_soc_component_update_bits() calls and then return -EINVAL
> > whether or not that case succeeded?

> Yeah, it seems like a bug. Can someone confirm this?

> Notice that this code has been there since 2010.

Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
noticed.

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltkho8ACgkQJNaLcl1U
h9DkAAf9E//pNerxjDyXizhdfm6UO/DYGAcnytURqh48UBox/K+4WEvzHMDGGylL
Si5WIP5K49waMc5sK9AjPbSn6X89mkagChE5O5EPohCccVLMkilWTAE90rBLVhr9
606FTIIOUATb6zFk6f83PQ8LmzZ3H1CHzy/H2qPtc7RUgnQEFnNlK8z/9OTTsiKU
pvz3cC3Ga2r+bq31njxXF5l4niW5higDBF2qb0fLHqEA/qlCdee5pLJ/IgQd8zmO
xcm3W7UGXJA6aAo9Jl/9h8C6jA6nX85tiv16Mjm+P1GMeVUnNwegAbA2I355OjDm
Lg9ztCy1+TUANlNJC3PyDMtOQSF2Fg==
=KHID
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--

--===============0500644538880292087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0500644538880292087==--
