From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: intel: Don't print FW version
	repeatedly
Date: Mon, 27 Mar 2017 15:52:57 +0100
Message-ID: <20170327145257.gryns6a6m5xzbnkp@sirena.org.uk>
References: <20170327121700.21502-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0631190255111316001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C343F26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 16:53:14 +0200 (CEST)
In-Reply-To: <20170327121700.21502-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0631190255111316001==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uv5ejiva2ucj47do"
Content-Disposition: inline


--uv5ejiva2ucj47do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2017 at 02:17:00PM +0200, Takashi Iwai wrote:
> Intel SST driver spews an info message "FW Versoin xxxx" at each time
> the device gets initialized.  Since it's triggered at each PM (or even
> runtime PM), it appears too frequently, which is rather annoying.

I already applied your earlier version...

--uv5ejiva2ucj47do
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljZJ0gACgkQJNaLcl1U
h9DEsQf9EnZl8TWWOSrZJoDJuWY5ttmmN+cxB/202HMXc2NwAE7sCxG4Pie5KITs
V2vyWPpv2WA03a5nltk/PVvUDGJler0vfQaM+rWg7cJpZIEVJti2nL9FeX9YpuJc
XALDBAurWs4qmKvR1F1XnI2OQnQBPxCCk9UOOczmKI59Sq5OWEQ2QUBauHBeup/b
PTYKVeSz4VqUGassqN95+BEgcYP/OWb7jLMSI3ha7VDBtH8mpZTYF1Bh99lI6FjO
dXmqYG/C8/Rs6IaQCIzsW7GKBCxlBY6Q5NSR0BBEsZ2PP5oYw89BPOSP2huGpaTO
+XGtXKjrc386sZ1T82yTP0rRagDFJg==
=osSl
-----END PGP SIGNATURE-----

--uv5ejiva2ucj47do--

--===============0631190255111316001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0631190255111316001==--
