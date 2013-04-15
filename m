From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for
	imx-pcm-fiq
Date: Mon, 15 Apr 2013 17:15:45 +0100
Message-ID: <20130415161544.GH15837@opensource.wolfsonmicro.com>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
 <516AB111.3000007@tabi.org> <20130414141015.GC27394@pengutronix.de>
 <516AC305.2000800@tabi.org> <20130414152016.GE27394@pengutronix.de>
 <516ACA7D.60807@tabi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3521264752745421134=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AEF1226517C
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 18:15:46 +0200 (CEST)
In-Reply-To: <516ACA7D.60807@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3521264752745421134==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2013 at 10:25:49AM -0500, Timur Tabi wrote:

> Ah, so this is a work-around for a bug, where the codec is
> incompatible with the SoC?  Mark, are you familiar with this issue?
> Is there a way to reconfigure the codec so that it works better with
> the SoC?  It seems ridiculous to add all this code just because an
> incompatible codec was chosen for some board.

It's a limitation in the SoC - it sort of tries to bodge AC'97 in but
doesn't do a great job of it and can't handle the idea that there's
multiple streams of data on the bus.  This isn't something that can be
configured in the CODEC.

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbCeqAAoJELSic+t+oim9bYYQAI+NTEDwKUPRZI2tpi87aRKA
OxykfiWKM9jFMmgESGD8bEbD2fIAaTC9/yKzmmizbYVmbmuFUyFuH7WmHkfar+Qs
/b53iAELJutkMfUXaA1QOE6/0Ju3jjSJCDwASA8MgvaNTpvVJ/B8K3QuC3ECK35l
ew2dg/vmHkpTJ/91DnS7pfjA0JNJ7uEx2DbI4UMxwI3CoDgxdCXkA6HY5N/Goora
BOHA+yGkOFEcLJmImF4HX/mmgy/mtuJKSVhgcjgBcGB5csv5Sfr19P4U5oveRF5w
wNaUcbPH+duLMqLcZAajsAgeP6JwLYnO0t1MfhkEWwFxS8lyZ8a1HqpXWWV4VXru
pAoNq/RqRwdq/F8qC+zZOvjtJGo0w5SV8f6OF1/mcpHRn044RmTXNXnr3VGRo0U3
9pqjQJswDZjHScYH0TYgFnM3KYwo0BC4WSYjlrhF33+lisOxFNRGWWOQYQDGoRH5
q+Cs6Ve+7RxztR2k8kF38yJ+X6AQsiFEBWuHFGg8YhToRo+jB6kv0p1xMO/ZQ8Ce
FaJ+vTi0KQ3Y1PR6V93CADsajw8xdloXudIoXe0OvBIIQM59WoXF2PLAn3klofE2
7tBYaHe4dR3yEXWKOQZGE2Tlgne1wH7bq8Gw4QAwyI/m6M4TQXdG2X2b7Jqtjh+P
2cQkP6nLzOoBaJA47L/K
=HQRy
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--

--===============3521264752745421134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3521264752745421134==--
