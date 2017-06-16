From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: dapm: Add new widget type
 snd_soc_dapm_dsp_component
Date: Fri, 16 Jun 2017 12:09:53 +0100
Message-ID: <20170616110953.waxwojvnrgrnlc26@sirena.org.uk>
References: <1497555964-4862-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2712732482271241096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85E052669F3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 13:10:05 +0200 (CEST)
In-Reply-To: <1497555964-4862-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2712732482271241096==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rsckat6tmrl7simf"
Content-Disposition: inline


--rsckat6tmrl7simf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 15, 2017 at 08:46:04PM +0100, Liam Girdwood wrote:
> Add a new widget type to represent internal DSP components and allow DSP
> drivers and firmware to define topologies using this widget type.

Hrm, this is replacing the previous ones with buffer, effect, and the
SRCs?  I actually thought most of the types could be useful there - I
can see from a sequencing point of view we might want to start buffers
first, and the SRC and encoder/decoder widgets are going to be useful
when we're tracking more than just simple routing with DAPM.  The only
bit I was really concerned about was the overlap between pipeline and
effect.

--rsckat6tmrl7simf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllDvIAACgkQJNaLcl1U
h9B/Hwf9H/ZZ9GtrWj9Al/KdyNp6Kw+/qRIxQ64lPggf1pUtKeKtWRTWaH32cPoP
gg5QM33RUgcjrt03zMSX9/rawXz3WbFVAYIOgQ56b9q065Y09pgz8LMHuiqSMDSB
A90GF21Uw5b9hmYBMLq4SJwPP+sC1gKZIkZQNNNHuML1e5JoB5Va9HiFXYgTFzWX
6egKeFKOO1RP9hnyQ9RA1N0swZmE1DQQBcb+TjFXt58hcIrSwgEMzZlzYOynOow/
/Ugk9mBREKDb4EchwoY7vJit86y/7zo2EM1yh0/WSBSdP/AEu8GJlNQWyOyGswKm
7Ev3/XN7kYNKvQgeCzwJeXEhtrUFJw==
=4kOc
-----END PGP SIGNATURE-----

--rsckat6tmrl7simf--

--===============2712732482271241096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2712732482271241096==--
