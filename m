From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Wed, 16 Sep 2015 21:34:53 +0100
Message-ID: <20150916203453.GZ12027@sirena.org.uk>
References: <cover.1442298607.git.han.lu@intel.com>
 <20150916163758.GJ12027@sirena.org.uk>
 <1442422620.10528.133.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1447471413003175847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B0F9A2616EF
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:35:02 +0200 (CEST)
In-Reply-To: <1442422620.10528.133.camel@loki>
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
Cc: han.lu@intel.com, alsa-devel@alsa-project.org, tiwai@suse.com, bernard.gautier@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1447471413003175847==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IekLpJqQZjUH9JS1"
Content-Disposition: inline


--IekLpJqQZjUH9JS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2015 at 05:57:00PM +0100, Liam Girdwood wrote:

> I didn't think of bounds testing the controls :) Especially useful for
> DSPs where we could overflow or crash FW if certain combinations of
> enumerated controls are used.

I'll try to get onto it again in my copious free time.  :/

> We were looking at testing the gains too, to make sure that a 6dB
> control gain really does mean a 6dB gain in signal. It's in the TODO
> list. Most of the code is already there to do this, but we were looking
> to upstream first and then incrementally add features. I think Han plans
> to upstream the tinyalsa support after the initial code is upstream
> though.

Yeah, definitely not something needed for initial release.

--IekLpJqQZjUH9JS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+dJsAAoJECTWi3JdVIfQLl0H/j1KWUJL+pMq/0aFCXO70p8b
CF9ca84QuLQLqptfYKwYaM+mlEy2D7YcFLxDRf2IjI8upf8AmatpSaVThlhxfwLA
Mkjklpz4ygrFsGDUoiN17pzJoyGFFmakK1xvUxkUTjaXH833//CUX5/k2O1jsDkf
gC9L7ydaUDn7pDOV1e7jTsUDXSiygxO7jM6gWG+iE5SVeoeh1hc23RxWCIQtKWe0
iV5GCM9hHWlR7gvQmCQI5beaK4SXtLuwS9kiGwS+Mo1rtTiBiYY1rBowh9kZtWzQ
kL2A9DFN9uMc6aPHJy3Gog75YG4hGJNOdibsdz4NmJ0q7EsKIqJufCSwb7Zh58A=
=tTh/
-----END PGP SIGNATURE-----

--IekLpJqQZjUH9JS1--

--===============1447471413003175847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1447471413003175847==--
