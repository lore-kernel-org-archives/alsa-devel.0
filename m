From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Wed, 17 Sep 2014 12:37:06 -0700
Message-ID: <20140917193706.GU7960@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140916193053.GD7960@sirena.org.uk>
 <20140917105552.GA13006@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3827349456881006136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E8D2265122
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 21:37:25 +0200 (CEST)
In-Reply-To: <20140917105552.GA13006@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3827349456881006136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zJNEIfy6us2B785O"
Content-Disposition: inline


--zJNEIfy6us2B785O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2014 at 04:25:57PM +0530, Subhransu S. Prusty wrote:
> On Tue, Sep 16, 2014 at 12:30:53PM -0700, Mark Brown wrote:

> > This is returning with the lock still held AFAICT.  I'm a bit surprised
> > that we don't need to interact with the hardware if we've disabled
> > everything, shouldn't this have some effect on the hardware?

> > Also the coding style thing with the comments again.

> Will fix the locking and comment.

> Regarding interaction with the driver, the slot map is cached and sent in
> sst_set_be_modules event. This is sent only when that particular BE is
> active, otherwise driver will happily cache these values.
> This is the reason why we don't see trigger to DSP when usermode fiddles
> around.

> In our model only when a particular FE/BE/Mixer/Pipe is active we forward
> the settings and parameters, rest we keep the values  in driver and forward
> when DAPM enables them.

> I think we can add this explanation here at top of this file to help.

This doesn't really answer my concern - what happens if we're already
active and making a change?

> Power ops in SST takes care of the PM handling.
> Following comment is already added in the code which explains.
> "Send the command only if this call is the first enable or last disable"

> Let us know if it is not clear enough.

No, that comment is orthogonal to the interaction with the DSP which is
what is confusing.

--zJNEIfy6us2B785O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGeLdAAoJECTWi3JdVIfQ0V8H/juBredzhviLXJeW3ZPHYYGh
Ju2dQveCt2ushbwPJbr7fnf7E278HaATTalxJPThpihpTq8agpfI+kjNX6vZ492u
+zyBZyOxIGXtKemPAR6Z5ogwjc+58tqyFoCmwoPr3QctmdiHhrHxt20jWyJE9i2E
1UKQ5ihJejTQssXYtfOcenSnrxrH4bJL84KLaxYypWqL6tzJoCQ8qZUPq7Ny17z3
lLs1ao01fFztdNHRbHGnwmcBhpaCB6TjQ5vTtX5IzS0CS5NidQ1D7pmZTPB/Bi/L
6yp6u0eBhz4WFQGNpsoNUSASR5plgRNN8aUPY5z42bVY33P8r5+F95fry6ECyFk=
=S8to
-----END PGP SIGNATURE-----

--zJNEIfy6us2B785O--

--===============3827349456881006136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3827349456881006136==--
