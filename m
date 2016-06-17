From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Fri, 17 Jun 2016 13:31:56 +0100
Message-ID: <20160617123156.GO26099@sirena.org.uk>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
 <5763DC72.1060200@metafoo.de> <20160617121548.GI16910@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8535041423312275796=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C055265AE4
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 14:32:50 +0200 (CEST)
In-Reply-To: <20160617121548.GI16910@localhost>
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


--===============8535041423312275796==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+Rs1qz93vBJxC1z"
Content-Disposition: inline


--R+Rs1qz93vBJxC1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 05:45:48PM +0530, Vinod Koul wrote:
> On Fri, Jun 17, 2016 at 01:18:10PM +0200, Lars-Peter Clausen wrote:

> > Why and why is this something that other cards do not need to do?

> When card suspends, the DAPM suspend closes the widgets, which translates to
> we sending IPC to DSP for tearing down the pipelines.

> So we need the platform to be suspended last and resume first. This way the
> snd_soc_suspend will tear down pipelines and snd_soc_resume restore those
> back.

That doesn't answer the question - this applies to any control
mechanism.

--R+Rs1qz93vBJxC1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY+27AAoJECTWi3JdVIfQYDcH/3YCKQZlGxq7oDZDR+JGHqNz
wmp9B4ATHEphMDGI+QOxEPFq3pfic4A7+rUNGcfN96cHNTpYDqnchVxEYszZJQ5r
RXNwreRmkZKgeOCs2QGyKXNu0be+XAZi0INhBf4qIH/JmTZIle6HOzHDdQP4wZ4j
ZrdNhDDesi2MCfmm3rUXbuHr7m6Wlp0zbe5t3o/d3KIKIASAPjQCnv70MmiWlX7f
pRZgfJwK8n2vhrIKfUR1iATaK8P+75sQXIM1PnjVI3zoQXNgCj5lMSXofZHZtgJ7
boe3494d6tQQEff2rcCaJMvN8KudPmoTKBc4K4Z1SMrA3F7A9H+Wh4qU5ilYZcE=
=8SiX
-----END PGP SIGNATURE-----

--R+Rs1qz93vBJxC1z--

--===============8535041423312275796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8535041423312275796==--
