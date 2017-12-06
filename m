From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 18/19] ASoC: tlv320aic31xx: Add
 headphone/headset detection
Date: Wed, 6 Dec 2017 17:32:15 +0000
Message-ID: <20171206173215.bitae546h2ibedhz@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-19-afd@ti.com>
 <20171201134127.2msgmjrfj47ypl3w@sirena.org.uk>
 <b2d9ffa9-3923-cb86-f0ad-cf4f37e56334@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8157462863710203667=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BEDD52679C7
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:32:20 +0100 (CET)
In-Reply-To: <b2d9ffa9-3923-cb86-f0ad-cf4f37e56334@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============8157462863710203667==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b6yf5vzli6rkx7lx"
Content-Disposition: inline


--b6yf5vzli6rkx7lx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 11:25:15AM -0600, Andrew F. Davis wrote:
> On 12/01/2017 07:41 AM, Mark Brown wrote:

> > This only does half the job, there's no way for anything to specify a
> > jack here.

> Other CODECs drivers expose some kind of platform/machine specific
> function(s) to send the jack definition to the CODEC, we seem to be

Your driver doesn't do that.

> missing a generic way to report jack information up to the machine layer
> driver.

snd_soc_codec_set_jack()

--b6yf5vzli6rkx7lx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooKZ4ACgkQJNaLcl1U
h9BLwAf/eF7bKC1y0lMn/peaYCmdm6njXP6Ee3dYYx9ilWTbVQNT454m0tWlFSk0
dDOIs04LTlnQRuYAUWHwafJ2XQ5ZRz057LX7VnCBHC+kUj9UbuX4hoLJ8CP7mE/M
M2+QgylmQlKsPDmOkTuh3txJIJlUkHIbsM95iWvJzMiN0Bsp5rgzSmTHQmW2S1NI
6dBgdYGzvYLBGA229GNL3FsfDPPxRjUrkuIPnLyQp8WDUPeLhhr/JROUNA+hYcAT
2AkhqJBED6xCIlYFtO2TIhQlwOHIpY0OQs+YphvyPJqgqnNRPdY8iem2VRxISnta
PaQHQy1CwNjCYcE0yPerGrPS5FKY8w==
=CZfY
-----END PGP SIGNATURE-----

--b6yf5vzli6rkx7lx--

--===============8157462863710203667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8157462863710203667==--
