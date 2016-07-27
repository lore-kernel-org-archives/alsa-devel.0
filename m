From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Wed, 27 Jul 2016 19:04:56 +0100
Message-ID: <20160727180456.GQ11806@sirena.org.uk>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <20160727032111.GY9681@localhost>
 <s5hh9bb7he6.wl-tiwai@suse.de>
 <20160727172125.GF9681@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FrxVhwK/bNRjN48l"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160727172125.GF9681@localhost>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--FrxVhwK/bNRjN48l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 27, 2016 at 10:51:26PM +0530, Vinod Koul wrote:
> On Wed, Jul 27, 2016 at 07:57:05AM +0200, Takashi Iwai wrote:

> > For unloading the module, yes, it should have been prevented by
> > managing the module refcount.  However, unbinding can't be stopped by
> > that.  It's a known problem.

> Oh yes, unload is an issue. Are these any solutions to prevent this?

> In core, should we de-register the card if one of the components exits. The
> .remove should be called for the driver, thus triggering unregister?

That's the theory but it's full of holes at the minute.  Someone needs
to sit down and fix all the holes in there.

--FrxVhwK/bNRjN48l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmPfHAAoJECTWi3JdVIfQBocH/1e+ezUdl0YGlZgwiECeh9f9
qhqeei8CDpUQVgVvJkxLMaatey+SUJl07HS+YqG403bwlzwx9CA0sr05wfMX1V/T
0IN5IFXdq9fjvR35EJEvafQ9p36HiI5oUJDQ7wq78YA6VxbD9UePiC8FuzF3Z/Ck
DaEacUYvU4cvOpoUC39FEi3fCjQSUGqa7U7Wgv1LckyYXbAS8w1k2P0oUn0cMU5f
F6yUlLdS93umNzVPi0tbL9RUYxS6/UZRIf5McFHA1l45gC3y2Zi/frKlD1KyRPro
4QNYtMvS7mDSiZOV3YM8wCYmYruDKsNO6Wt0dfKvcwy4hGkl/hl1BjaAsQzFu78=
=uAXQ
-----END PGP SIGNATURE-----

--FrxVhwK/bNRjN48l--
