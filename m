From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Thu, 24 Aug 2017 14:49:24 +0100
Message-ID: <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0113643558390417894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 64BAD266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 15:49:31 +0200 (CEST)
In-Reply-To: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0113643558390417894==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vsaeo73eazkfqtfe"
Content-Disposition: inline


--vsaeo73eazkfqtfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2017 at 04:41:10PM +0300, Andy Shevchenko wrote:

> There is no platform code that uses i2c module table.
> Remove it altogether and adjust ->probe() to be ->probe_new().

What is the value in doing this?  Removing the ability to instantiate
via board files is just inconveniencing people doing that, it's not a
goal in itself.

--vsaeo73eazkfqtfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlme2WQACgkQJNaLcl1U
h9Ba4gf+KtCYFO3YmVkrcPhBuVIzTIEmjpEJlqLxYMhFznd2gHrHqIinFHa9yVyR
I7K6jGDc0hmbpbizkcDhLMQcs5B59ndyU0nCz3J2Taly6nNUSlcPOD+TfFWNaRl+
eqtvG8FrdsuQThfriSZKYUiyEKmSAHI9eIRZSU1A+4xPEtVJ4vHmprNorAJ3w+3N
7mjeBlzefonLedbksU5rQAuXX9hnU8uGgrcedoEMac9cSVs1+9JtWFGncWp4M0Io
q64obrMiZUQhDKkqqaEiBPBPuze2bHT7l3YWeleVD1Z5JKOi4kQPBfyIOncIZ025
a232a2xPbk+X/3d6paH27zOF6a/0Uw==
=8AC0
-----END PGP SIGNATURE-----

--vsaeo73eazkfqtfe--

--===============0113643558390417894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0113643558390417894==--
