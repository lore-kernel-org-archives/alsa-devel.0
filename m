From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel-pcm-dma: increase buffer_bytes_max
Date: Wed, 1 Apr 2015 21:33:42 +0100
Message-ID: <20150401203342.GH6023@sirena.org.uk>
References: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Bo Shen <voice.shen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 09:40:37PM +0200, Alexandre Belloni wrote:
> atmel-pcm-dma is not limited to a buffer size of 64kB like atmel-pcm-pdc.
> Increase buffer_bytes_max to 512kB to allow for higher bit rates (i.e. 32bps at
> 192kHz) to work correctly. By default, keep the prealloc at 64kB.

Applied, but please look into Lars' suggestion - we should be able to
just figure everything out from the DMA controller.

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFYlAAoJECTWi3JdVIfQ+8cH/0byFLSIR25J6M3sC4SS2pMk
yFnT1RvGCrMypOIoezdsp8Egp0sJ06LasDF3o4lrh0/B1DEo2TZr7ngbODfHhXjI
PNXHWKW2maEFEPb4boR45ivU35nvlSveJNDjT2lOFj//PIMJ3p65GkeVkTGL+Dd0
IM5xr/em3/rt5py2Jx7ILOD4f/BHa+7wZEILrqcFiDxMrrhmuI8n6mnN5wxyGAxa
hYQoli1m+QgCJaKNWW0UIevRyHrHYFsOf92ruObsCX7rHbb0VVwW1fhugBHzoNqD
Z+LRLjuICqy4ifKWSoP/Cpc6v7/2khE0NMgbd9xmB/8NI+sBDdVtO81M4vW7T4I=
=k4wT
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--
