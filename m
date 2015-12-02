From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Wed, 2 Dec 2015 10:32:41 +0000
Message-ID: <20151202103241.GC1929@sirena.org.uk>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
 <20151130162548.GZ1929@sirena.org.uk>
 <20151201025654.GJ3901@localhost>
 <20151201122747.GG1929@sirena.org.uk>
 <20151202052330.GE1854@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3122994870342921459=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A82C261566
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 11:32:47 +0100 (CET)
In-Reply-To: <20151202052330.GE1854@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3122994870342921459==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0eAbFZQk1SsvtJhS"
Content-Disposition: inline


--0eAbFZQk1SsvtJhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2015 at 10:53:30AM +0530, Vinod Koul wrote:

> But if we do wrt from CPU the situation is different

>      CPU Tx (Pb)  -----------> Codec Tx (Pb)
>      CPU Rx (Cap) <----------- Codec Rx (Cap)

> Since this follows normal playback kind of scenario, we need to link pb-pb
> and cap-cap

But neither of these is a CODEC so why would the CODEC flag be set in
the DAI?  Unless your "Codec" here is genuinely the CODEC rather than
the CPU DAI connected to the CODEC in which case surely this is just a
normal DAI link?

--0eAbFZQk1SsvtJhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXsjIAAoJECTWi3JdVIfQViIH+QGHWOsPBzZhQmMo99strizo
0sQMQKA4WydRe7d1mP+7gU7L4E72/hnKRCOrsGAAwMC4ePm5FkIQmeSKWm52NFeJ
8YF2S5l8sPtndq5BwkusJm+3e2seje+5vn6KZ++QljBUkWrv+ENwm0m5g8Vghrsw
VHyc4iV3lgkeH2bfYuDTv6pJFhlVztZ/gwOnaL1PRbahq4hgjkWJWYeHa6BkieS8
NC1s59STP3Mk/KjtuHM8WH0iTB5OqR2ZIuY0T2wd5DblCyVTf1KJFe/9i6PGEuRJ
0w5vec18eHmoyCBOahaRpNoevh0c3SlfzasZ7tVMArAKQIbVdSEk/2rLWPz6Qrc=
=2XPM
-----END PGP SIGNATURE-----

--0eAbFZQk1SsvtJhS--

--===============3122994870342921459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3122994870342921459==--
