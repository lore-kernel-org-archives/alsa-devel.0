From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing
Date: Fri, 25 May 2018 11:26:09 +0100
Message-ID: <20180525102609.GK4828@sirena.org.uk>
References: <20180517133009.26079-1-m.felsch@pengutronix.de>
 <CAL_JsqKhkVOYf+XEA3MYpK4JYfMrZTbHZtoXgaH=wCBRoU6cfQ@mail.gmail.com>
 <1526640409.3948.5.camel@pengutronix.de>
 <20180523165352.GA6187@rob-hp-laptop>
 <20180525094724.3f4edofopk52i3v6@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7677205709529174942=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C2E93267634
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 12:26:13 +0200 (CEST)
In-Reply-To: <20180525094724.3f4edofopk52i3v6@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============7677205709529174942==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T5F8Mpu1Sg8jtYtl"
Content-Disposition: inline


--T5F8Mpu1Sg8jtYtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2018 at 11:47:24AM +0200, Marco Felsch wrote:

> I found the: "ti,charge-period (sound/ti,tas5086.txt)" binding which
> represents nearly the same but it is not common. One opportunity would be to
> introduce a common "charge-period-us" binding and change the ti binding the
> common binding later.

Are you sure what you have is a charge period and not some stabalization
time or something?

--T5F8Mpu1Sg8jtYtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsH5MAACgkQJNaLcl1U
h9D0nAf/TkfjY5yL0LIna/QZ2emlLPo80P6AOd37c3vruPNzXhAsEVZFQKZ8a/mT
EVAAkRp9r1r8XWdejBGkH0XlQPcDw0/GePEFBaJDI253UVt6RznayyRtbxZ5Wa4q
j0RyKP5Ti10Z0sko8JPrsCsP0Proc062Xih7naRrAxQVfFgdFH4nZPIfVf4kO/jW
BT1/IVJ236jEoPSHDuRQULzGzHyLyCo1tWHcItsVgu+tnixURQlrMaAutStkHdNF
SqXXO11EaHz+ybFyWg5BBQ4qLlTu6Rgi1LaVzcdWjZH7EtCkZuhjEzeugLW5iRr1
YRntSvZehgGp5IE/w0HonLKxuVjLkA==
=I6Sp
-----END PGP SIGNATURE-----

--T5F8Mpu1Sg8jtYtl--

--===============7677205709529174942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7677205709529174942==--
