From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: sn95031: Replace direct
 snd_soc_codec dapm field access
Date: Fri, 15 May 2015 16:49:10 +0100
Message-ID: <20150515154910.GA4637@sirena.org.uk>
References: <1431685980-6600-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1492533951205138994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D77ED2664DC
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 17:49:30 +0200 (CEST)
In-Reply-To: <1431685980-6600-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1492533951205138994==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2015 at 12:32:53PM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct is eventually going to be
> removed, in preparation for this replace all manual access to
> codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Applied all, thanks.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVhV1AAoJECTWi3JdVIfQ0u0H+gID7vtrDCpxoFP/vanBV4RZ
8IW0pRE4AfT+98EhslG47FSNBWRhy9OAS6CqnXFM0C+/z3rMrMGdqA4SY83fXyow
Me8EBO5is+2a5gRkDQWunYSTtQjFx9Pml2vNnPM9/1Zt0sPdXWtVXxZ0Bve/Oarz
owhTQmSkneV62av+p42RMg/i8dVcI6psIiatWCW0bfZ5mDpME5F4XVgoJ6RrTrgF
HlFl59cMvF9MpgjIGzJIusDAHvRSOOIW0/gN+hokErtaB4Qxe6gsarNmxvTC8P04
EqDvbbp7QEsg83UD+BlZOsKnSJO6bQBbi15OM3FwxT/f9bLi61XASPkU5cF9diY=
=OcEQ
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============1492533951205138994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1492533951205138994==--
