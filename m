From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add support for
 clock divider setup
Date: Wed, 30 May 2018 10:10:11 +0100
Message-ID: <20180530091011.GA6920@sirena.org.uk>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-4-daniel@zonque.org>
 <20180529113509.GE23509@sirena.org.uk>
 <d6b9da97-8c71-ccfb-07e4-353620396a31@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8338851641267343715=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D4DA266F88
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 11:10:14 +0200 (CEST)
In-Reply-To: <d6b9da97-8c71-ccfb-07e4-353620396a31@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============8338851641267343715==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 10:29:10PM +0200, Daniel Mack wrote:
> On Tuesday, May 29, 2018 01:35 PM, Mark Brown wrote:

> > Why do we have anything that actually needs this?  The devices with a
> > set_clkdiv() operation are pretty legacy at this point and most of them
> > should just be figuring out the dividers for themselves anyway.

> The PXA platform CPU DAI still has it, and grepping also reveals some
> Freescale and Samsung platforms.

PXA is definitely very legacy, as are some of the Samsung and Freescale
ones - PXA in particular hasn't had much love in years.

> If that's considered legacy, we shouldn't add bindings for it of course. I
> can look into the PXA driver and see if it can auto-detect the dividers
> itself. It won't be straight forward though as the clocking setup also
> depends on configurations such as TDM slots, external vs. internal clocks
> etc. Meh.

It's usually relatively straightforward - something along the lines of
work out what your BCLK needs to be and everything else flows from that.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOanAACgkQJNaLcl1U
h9CLHwf/fig0uV4FFAwxKHLQNO96dUW8xKE4q9Btgs1AGbTdUMZNxt7oC2cowEjR
KuwFslG/NxFdv1RVUvuU/6GBILC7YqnZZAeTDVsti29I8xVX7BapUc65IPhZ+ZEO
fM8Q/FUQZBxlLRp9svAw7LAc4HWxqtqtRXjNR8y3ZhPMvKGDhO8A2qSBVfY5kaDm
wmUpQn6GWobqVqiU3TPol7Y5d9aXdkTshpH9tZH3DbD10ZrpZrEsFD5BBy3o1WiE
0AnrmlImuaFsMWqBjsekjbSTTnCODH5he9RW55NZkHNnBd8ZgNGFW4lbtRrkxetT
wwvVtkpAj+F+qx6p+qUeeF+Hb/jFkQ==
=owBC
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

--===============8338851641267343715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8338851641267343715==--
