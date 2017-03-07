From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dwc: remove 'out of memory' message
Date: Tue, 7 Mar 2017 13:56:17 +0100
Message-ID: <20170307125617.rwxhqji4gfsjpoxc@sirena.org.uk>
References: <20170225110323.7506-1-michelcatalin@gmail.com>
 <9da9efc3-cd9b-70a5-a764-e8be32e67d13@sakamocchi.jp>
 <s5hshmyz6k2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9170195107719600405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 13AAC266AC4
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:56:37 +0100 (CET)
In-Reply-To: <s5hshmyz6k2.wl-tiwai@suse.de>
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
Cc: Jose.Abreu@synopsys.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, s.nawrocki@samsung.com, colin.king@canonical.com, Mihai Burduselu <michelcatalin@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org


--===============9170195107719600405==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cajxcc4w3mphzmtk"
Content-Disposition: inline


--cajxcc4w3mphzmtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2017 at 04:19:41PM +0100, Takashi Iwai wrote:

> However, the problem of this (and lots of other) patch is that it
> doesn't give proper information.  Instead, in a single line, it merely
> declares checkpatch.pl as a bible.  Very helpful, eh?

> So, please reconsider the changelog when you submit this kind of
> patches.

Yeah, it's a *huge* set of patches with poor changelogs and very minor
benefits which is more work to digest than it seems useful to.

--cajxcc4w3mphzmtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli+rfAACgkQJNaLcl1U
h9Dg+Af8DbM0uqJIK3G8JfXhJw2kHkEXv+5z9aqsQZKxmjr8jrGp/cxs2d5rckSa
RsXk4/R67CUGXke1bF5NynuiENGcGwwRxIYp1zg5y3nFANKu2wvagkbD/zBGH3Ui
NcmrSPX2AEms/w3QTNMXAbl3YguVSXviWnceJ2pYqyOStOcuUxbebKF/TwALnfJB
Gi3b0GCwJRZdAtADvfD7jIW8DMzrfqB/iMCLhuc5zISEcN+Z+vbVNKGiL0yTnCOI
wWe1p2HBffvU/KZxRHCAavqavpUEKCJsHOecOP/Ko6c+5EodLJw3cp+bsZDh7GRN
OkJD49qEIoRHQMIuIcdZR6RRI0HAfg==
=BTHO
-----END PGP SIGNATURE-----

--cajxcc4w3mphzmtk--

--===============9170195107719600405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9170195107719600405==--
