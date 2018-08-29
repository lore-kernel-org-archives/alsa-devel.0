From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC
 (with a WM8731)
Date: Wed, 29 Aug 2018 16:26:56 +0100
Message-ID: <20180829152656.GF27808@sirena.org.uk>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
 <20180829145355.GD27808@sirena.org.uk>
 <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8164729808571046570=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F1E362676BF
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 17:26:57 +0200 (CEST)
In-Reply-To: <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, florian.meier@koalo.de, cristian.birsan@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8164729808571046570==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 29, 2018 at 06:20:59PM +0300, Codrin Ciubotariu wrote:
> On 29.08.2018 17:53, Mark Brown wrote:

> > That also has the nice bonus that with that I think you'd be able to use
> > the graph card rather than a custom driver?

> The main reason for adding a custom driver and not using graph/simple card
> is the snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
> XTAL_RATE, SND_SOC_CLOCK_IN) call. This enables the oscillator found in the
> wm8731 codec. Since WM8731_SYSCLK_XTAL is not 0, we can't use
> system-clock-frequency DT property to set it.

Right, that'd be more substantial surgery on the driver to change the DT
binding so that it's got a clock provider in it; it'd be nice to do but
it's a bit much to make it a blocker so the machine driver is OK.

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluGuz8ACgkQJNaLcl1U
h9ABhgf+P2btioRY9N06d9KjSWUiRSkEYQPemnjN526ijueP5FG94UR8X5u2zmxE
6IyhiNVhkYYm3lythZpKBabkm0nU3ZR1wUhMa+RUCs2ZAaUKSRs+TK+LhqIDpAPw
eV+I7/kJ/1OD83+Z0NJNeAxxECW/QwkH90tBSwYC5mUmMiofOMAJWLAQHWaPBsBA
nR3oYqiEySwVj3EYJ/dqWhy9v9Ld/fYykqy/+RbrRiradU3UuS7MapUnPUySi9nE
jjV6n+rAXnZXwNX6zcawFISVzXeBrhbpdTLVmelIIxZa71ESj7sL30GXIZCXhHLt
D7Ux1EEd4mGBJwfIjzcKhIy1PVHriw==
=MfUu
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--

--===============8164729808571046570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8164729808571046570==--
