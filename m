From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Mon, 20 Jun 2016 14:26:40 +0100
Message-ID: <20160620132640.GT26099@sirena.org.uk>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
 <5763DC72.1060200@metafoo.de> <20160617121548.GI16910@localhost>
 <20160617123156.GO26099@sirena.org.uk>
 <20160620114429.GP16910@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0854657191045606841=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7F9C266631
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 15:26:48 +0200 (CEST)
In-Reply-To: <20160620114429.GP16910@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============0854657191045606841==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K0M4iRgkWWXhiQ9N"
Content-Disposition: inline


--K0M4iRgkWWXhiQ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2016 at 05:14:29PM +0530, Vinod Koul wrote:
> On Fri, Jun 17, 2016 at 01:31:56PM +0100, Mark Brown wrote:
> > On Fri, Jun 17, 2016 at 05:45:48PM +0530, Vinod Koul wrote:
> > > On Fri, Jun 17, 2016 at 01:18:10PM +0200, Lars-Peter Clausen wrote:

> > > > Why and why is this something that other cards do not need to do?

> Other systems do not have a DSP sitting and need to redownload code which
> takes time and results in card being resumed even when the platform is not
> ready.

So what you're actually trying to do here is serialize the resume - this
isn't just a thing with DSPs, it's also a thing with I2C, regulators and
so on.  A quick glance suggests that disabling async suspend might help
here.

--K0M4iRgkWWXhiQ9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXZ+8OAAoJECTWi3JdVIfQM74H/iTklCqEi7fGMSr38IEZDZH/
WzM/EXkg0+JUDyhmyBsRWTOKstv9bJdKWC2eBRmmqJ59YctyflkKkpFukluJlAQQ
UqM0ty/OdWBQqCQ1IH1kBzTpTN7MHPLvzCvzjFLq4w0TlZ0aXX2xM+SKqfggk3mK
DKEtNs9SEA6/aFRJfxu0QHIRVpFoJohUHpJGBgII4ec5DpBMRI3kj5XbrOO0LCFL
e+i9HKQka2C5lOQ7sHmEY5frb3csg5nCHTCaH+Q+eh9OmmFO8Rb6F8GMgRLAjE3a
QbJgMLUYdWWC90oElHZqyLvqiuAj9vPZIuiuBQc+c3Jjs9rslCm/PRT6vvJdqac=
=tmrR
-----END PGP SIGNATURE-----

--K0M4iRgkWWXhiQ9N--

--===============0854657191045606841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0854657191045606841==--
