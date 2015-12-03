From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/16] ASoC: Intel: Skylake: Update DMIC
 DAIs and capabilities
Date: Thu, 3 Dec 2015 00:59:48 +0000
Message-ID: <20151203005948.GB5727@sirena.org.uk>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
 <1448703121-5831-2-git-send-email-vinod.koul@intel.com>
 <20151201213251.GX1929@sirena.org.uk>
 <20151202045359.GC1854@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3667977877391878317=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55B472665B4
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 01:59:52 +0100 (CET)
In-Reply-To: <20151202045359.GC1854@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3667977877391878317==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2015 at 10:23:59AM +0530, Vinod Koul wrote:
> On Tue, Dec 01, 2015 at 09:32:51PM +0000, Mark Brown wrote:
> > On Sat, Nov 28, 2015 at 03:01:46PM +0530, Vinod Koul wrote:

> > >  #define HDA_MONO 1
> > >  #define HDA_STEREO 2
> > > +#define HDA_QUAD 4

> > Are these defines really helping clarify things?

> hmm, that is a good point :) Since we already had 1, 2 4 seems a logical
> choice. I dont mind either way

I think I'd prefer to just use the numbers, it's not like HDA uses a
different definition of stereo to anything else.

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWX5QDAAoJECTWi3JdVIfQodgH/2nhv3y39eiWDMlG1jXRGi+W
NPfJ8ayzbLe2TTQ2M0FfuNIwo0b6v5V1IAE5WrwxLjrb2q1UInB1lGxKPPfpYuUc
lAQDYyZWsY7vbtfvp+ZG7Bdb8llWrO4JZ9JzMDGDWAXWcBx2/nvWP/RwqG0SUUu1
MWvEU+Q6ORAt+DcJZ7fxCfKqElmuXy+X5WA5VJzI+iNXu++oJEW/JPb0/1VGCbbD
9+OXMHy+w5pWGSh1s4EuAaHPQUqn2gtI1E20O1por2OqJ1jqKKFIxk2GeYGmREJC
/6vrJ/KZlkwAFY07cmHh+u0rqhikFXcUx26GQXaWaOayU9Q2kJkmrHRdAmHEyv0=
=zGTa
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--

--===============3667977877391878317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3667977877391878317==--
