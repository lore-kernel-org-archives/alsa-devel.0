From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Thu, 18 Sep 2014 10:28:52 -0700
Message-ID: <20140918172852.GY7960@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140916193053.GD7960@sirena.org.uk>
 <20140917105552.GA13006@vinod.koul@linux.intel.com>
 <20140917193706.GU7960@sirena.org.uk>
 <20140918061237.GA24663@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4554296943452502462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C7A02654C5
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 19:29:42 +0200 (CEST)
In-Reply-To: <20140918061237.GA24663@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4554296943452502462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sSUaqNktoHc9XcFh"
Content-Disposition: inline


--sSUaqNktoHc9XcFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2014 at 11:42:37AM +0530, Vinod Koul wrote:
> On Wed, Sep 17, 2014 at 12:37:06PM -0700, Mark Brown wrote:

> > This doesn't really answer my concern - what happens if we're already
> > active and making a change?

> Since this is specfic to BE (SSP) port, the DSP FW doesnt allow us to reconfigure
> the slots when it is active. These will take effect next time the BE
> restarts.

> Yes not ideal but thats something we have to live with!

That's fine but in that case I would expect to see an error returned to
userspace rather than just silently ignoring what it's doing until the
next time we start a stream, or at the very least some sort of warning
generated.  Silently ignoring things isn't great especially with no
comments in the code, it ends up looking like a bug.

--sSUaqNktoHc9XcFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGxZTAAoJECTWi3JdVIfQEncH/RCLchQ32AGndPllRIatHiYe
MZn4b6hg0CcuFs8s5k34iaRnHRMuZAGpbBe6rx85Ivk/9HC/tEnvZl6P2W/hrgUn
TXdeGgdkQts468zWQu6mvpjHAoZiHrRK5ep7sDqC4Qfz3ddNCXg+DdGs/04jmZp9
cySZMj/5drMPEWV2PYiLolxPKRlVUz+xIAmREhLPMwuLU5qDbYPojydH9hIOGCuI
pw65MmsF5dFeWqpLmCSov9eZ0WkRYyxpbDicDf6hAo9mp6Gy3nVekhQtgMUmFRDX
Qdc1zTMdbz6S7uksGnxVWAHodxN7c9sLTk0cdccaJW8QCj+M56+5UPeqIMJll30=
=aEZ4
-----END PGP SIGNATURE-----

--sSUaqNktoHc9XcFh--

--===============4554296943452502462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4554296943452502462==--
