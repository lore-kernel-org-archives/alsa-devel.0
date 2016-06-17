From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Fri, 17 Jun 2016 13:35:23 +0100
Message-ID: <20160617123523.GP26099@sirena.org.uk>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
 <20160617111407.GE26099@sirena.org.uk>
 <20160617121359.GH16910@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5397374504924683706=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AEB9D265B94
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 14:35:28 +0200 (CEST)
In-Reply-To: <20160617121359.GH16910@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5397374504924683706==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QKpLca3blcvhMJ0W"
Content-Disposition: inline


--QKpLca3blcvhMJ0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 05:44:00PM +0530, Vinod Koul wrote:
> On Fri, Jun 17, 2016 at 12:14:07PM +0100, Mark Brown wrote:

> > Just use snd_soc_resume() directly.

> Nope, that leads to warnings.

> .complete is the only callback that expects void return whereas
> snd_soc_resume like other returns int.

This is possibly an indication that you're abusing things then - this is
a very unusual interface to use as well...  the patch just looks very
fishy as is, and as we were talking about in the other thread Lars
started it seems like this is bodging around something rather than
solving the right problem.

--QKpLca3blcvhMJ0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY+6KAAoJECTWi3JdVIfQSQ0H/1Oxd8RHEPpSagqowYBscij2
kj87k7mZ9Kk3DBR8NEEL4Sntz5ft8kBZQVHVvMHbTAtDeG0OYUZaZuJ/Ob4qu8OH
XF2XFrHJVHOkCETJIrsQw/IUKtSQEIw6fejINbqxRB1TEW2wM2LQJPWZjIbGNTpY
fOtuqE+JxBkGFHAJO1rY99qgmuhSfAFYQ2HbvfKdGZXin1fotxnZU+2tfYKq0Iby
w+8s9HSXCBsDcAr/3VZBBg8syhZVT7EEpa98VgzgcZFu0zDnq9W3pKv05sSyeAGg
Djn0UJ31yHSZJinOkdMe+HhN6M6RmWnZx33v7mM9N8GGCRhy8Mu/LfsOE0gFNGU=
=nEde
-----END PGP SIGNATURE-----

--QKpLca3blcvhMJ0W--

--===============5397374504924683706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5397374504924683706==--
