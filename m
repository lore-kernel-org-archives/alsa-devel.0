From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Drop invalid DMI fields when setting
 card long name from DMI info
Date: Wed, 28 Jun 2017 18:45:39 +0100
Message-ID: <20170628174539.w6l6syfn33d3prua@sirena.org.uk>
References: <20170628070139.18340-1-mengdong.lin@linux.intel.com>
 <s5hpodoi44t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3283563455257467739=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68B44266838
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 19:45:59 +0200 (CEST)
In-Reply-To: <s5hpodoi44t.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3283563455257467739==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hzythlvbfd6rpzer"
Content-Disposition: inline


--hzythlvbfd6rpzer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2017 at 04:22:10PM +0200, Takashi Iwai wrote:
> mengdong.lin@linux.intel.com wrote:

> > +static const char * const dmi_blacklist[] = {
> > +	"To be filled by OEM",
> > +	"TBD by OEM",
> > +	"Default String",

> We found also a case with "Default string" (note the case-sensitive).

I'll apply Mengdong's current patch, that can be added incrementally.

--hzythlvbfd6rpzer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT60IACgkQJNaLcl1U
h9DNIAgAgjVki3C65m9jvFrEPuUUT73HaoMTA2GRQFXA2mur2udivD+lUbS39uAJ
rrP539MTw5uqiv7x+5BAbOF3ZcXoomCD6g987yeSXSutx9IUzVRhsJaWQYCGIkzI
z0zNcy3fCWgo1ew3gPKNvT+5BJtDyDKo7s0njJkqSxTypwG8S3BuHoa/4Pb+/Lc+
dI2hmabgQrt2UpBjY6rxSLq70Mi/8524cwFUMOu51+7QROVwc7O1n5R7NgaaSgqZ
DO00Cmbwh72HVN8lK/ZKwRAvp4Qq9XYqGPsr64X0K8siJbKw/Pz3bo5dq1LWt6l5
YZoN1ZliJ1noh1AvReATU9tyfWvMig==
=YTr9
-----END PGP SIGNATURE-----

--hzythlvbfd6rpzer--

--===============3283563455257467739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3283563455257467739==--
