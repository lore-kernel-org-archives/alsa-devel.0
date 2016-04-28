From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: allow changing the
 playback/capture rates for symmetric links
Date: Thu, 28 Apr 2016 18:13:45 +0100
Message-ID: <20160428171345.GQ3217@sirena.org.uk>
References: <1461746959-11443-1-git-send-email-peda@axentia.se>
 <20160427161504.GZ3217@sirena.org.uk>
 <122ca84a-230e-654e-425f-3adb0ca00ec7@axentia.se>
 <20160428103822.GJ3217@sirena.org.uk>
 <s5h8tzyuhad.wl-tiwai@suse.de>
 <20160428111001.GK3217@sirena.org.uk>
 <s5h1t5qug7a.wl-tiwai@suse.de>
 <20160428114150.GM3217@sirena.org.uk>
 <s5hy47yszzm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2251614585995787050=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3E71265019
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 19:13:58 +0200 (CEST)
In-Reply-To: <s5hy47yszzm.wl-tiwai@suse.de>
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2251614585995787050==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TLryreJvNc5+tOdm"
Content-Disposition: inline


--TLryreJvNc5+tOdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 28, 2016 at 02:02:21PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Thu, Apr 28, 2016 at 01:26:49PM +0200, Takashi Iwai wrote:

> > > BTW, this reminds me of another question: don't we have a dummy ASoC
> > > driver like snd-dummy?  It would be convenient for a casual API
> > > testing.

> > No, someone would need to write a series of dummy drivers that exercised
> > the various API features (almost all of which are kernel internal) and
> > then instantiated them but nobody stepped up and did that yet.

> Well, we don't support all API features there.  Developer can modify
> the existing code and test it quickly if needed at any time once when

Yeah.  Though the main use case would be making sure changes hadn't
broken any of the more obscure DAPM features (at least, that's the main
place where we seem to have issues) so...

> the base code is present.  So, yeah, we need a volunteer!

No problem then :)

--TLryreJvNc5+tOdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIkTHAAoJECTWi3JdVIfQbFMH/3slQiM1DhZKqXvnHuWjCKF7
zNLdo6VJkC6VZQdPSXvzrzuo3FDQdtbG3iOkp1xFPPbgEe6NXHJ4AAjhPItCODrn
WPyhX+aPVCs2dvqHviLIyIEkN4awNQ5kdnrm1PfFCVmkBGq4f3F1/W21H/MtSmw2
k44ZOtO4J/BRxHbPwzd8uu++2wZAM8H1Lz1k1QddK+OQ7SrKj7WFtlaS18pYo6TC
698QqScozmUCO1kLdUrOyFlgmcbvoRvtAzG9xYjGnjsW9jX4TPIoJs+Ndt8t0fhK
0cZ9XtIeoEJBwHFKJsp9iWJyhDXS93Zw7hXgCuW11tUUwl2rs7SIMcluqQKxJ/Y=
=39/m
-----END PGP SIGNATURE-----

--TLryreJvNc5+tOdm--

--===============2251614585995787050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2251614585995787050==--
