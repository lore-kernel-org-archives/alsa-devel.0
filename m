From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
Date: Fri, 16 Mar 2012 19:21:12 +0000
Message-ID: <20120316192110.GH3158@opensource.wolfsonmicro.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
	<CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
	<20120316111814.GA7860@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3476400400236566638=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A93432434F
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:21:18 +0100 (CET)
In-Reply-To: <20120316111814.GA7860@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Trent Piepho <tpiepho@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============3476400400236566638==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 07:18:18PM +0800, Shawn Guo wrote:

> Maybe having "fsl,imx-audio-xxx" for machine drivers backed by SSI,
> and "fsl,imx-esai-audio-xxx" for the ones backed by ESAI?

Alternatively if the SSI and ESAI devices are compatible enough at the
ASoC API level (or can be identified by the driver just by looking at
the DAI that's referenced without too much pain) the CPU DAI could just
be linked to either type of DAI (probably with a more generic name for
the property).

But either way works fine, and obviously you're going to end up with
more complex systems which use a completely custom binding anyway.

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY5KMAAoJEBus8iNuMP3d6OUP/2l5zrgRDR3uar2GhYX0sOSd
TLnspJVg4ypxeyAERPsInzprnuXuuJLUguIn5zIqTZx2UvbGwF1nZ9+wZ9uZibUs
vwSJuwWMs/j6lq6DKV9U2ON8+X7dPLTP5FKNkimOI050WY5oqSH39J3xfOXjJof5
6a1/R4I+1oJ9vrExTHo/nkZ/XeQ5aua0hpT9lBUmRQoHXOfzbjnDUHYFVDDjc8Ah
DF1VOFnrddBsv1jeeMIL44rwjKiRoJ2fzA9LO+1mKzQ8habQLQsvd3lj8bjHcZzU
4lpzG1zPyMsLXf31vw6hbBqmFpD8rdsv/2Gk3zQ32lNHw8eMCICch2FGwrjPj7RS
B/hTFCtiGO+Sq76qDyr5FXtxmExuvUgPI0j8q03LZYFsBgLl6b6R0Yf3lamg3USC
1mhKx5du3DSoT+Tp/b49umKulfQvbor2owdZcsXcHcQjOiq95iDtij9XwwH/7n8o
Xz8GvPiERiv4UtzCiSpZ+uFpbP21G2S5+H+Pm2vepGuByG4L5e1S80zOZ5SA15Nc
hcOe+STmdlEn/5IvyBP07Q8wOa0RVNe5qrE5YcZrKDWiwO4z8MCQ6UOmfiH4+7aL
P8ySZoYaTq3nFLI9rEXQ4zf6ny7zw+II8xAUZ6LPiPGVMxupCK9xEDpzEr3KL3vK
nb8WDOBrLDN5DKtBzFr5
=l3vg
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--

--===============3476400400236566638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3476400400236566638==--
