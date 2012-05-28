From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/15] ASoC: mxs-saif: Use
 clk_prepare_enable/clk_disable_unprepare
Date: Mon, 28 May 2012 16:24:39 +0100
Message-ID: <20120528152439.GO4032@opensource.wolfsonmicro.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
	<1337987696-31728-15-git-send-email-festevam@gmail.com>
	<20120528145117.GI4032@opensource.wolfsonmicro.com>
	<CAOMZO5BbCLyxwnsupgVaRr9DYNT+E=Th2UoBEOGzXxh1d-9D5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3296417990701827178=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E94A243EA
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 17:24:41 +0200 (CEST)
In-Reply-To: <CAOMZO5BbCLyxwnsupgVaRr9DYNT+E=Th2UoBEOGzXxh1d-9D5w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@freescale.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============3296417990701827178==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Content-Disposition: inline


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2012 at 12:21:01PM -0300, Fabio Estevam wrote:

> With this patch applied I have just realized the following (only
> during the first 'aplay', subsequent 'aplay's do not show it):

[Attempting to do stuff we shouldn't in hard IRQ context]

Is this not just a case of calling clk_prepare_and_enable() from atomic
context - the whole reason the two are split is that only _enable() can
be called in atomic context?

I'll discard this commit for now.

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw5ixAAoJEBus8iNuMP3d1noP/10I76xGCulQS01hzvB3UiO2
2QGvTHhY0e01Pd0hYOCeAWh3jwfFWdGzCja9uHe7anNYIXv/vCpVZCbVy7gSvQgh
GOAzK7c5lULNmfPbdXzsoraGyTy3WtpSh1DUF4UhNVLbyejvSRLKZEI+1QW06B73
q/e2Ue4PunIX6JISgzbVRW7rcMwlEtIgHrZBMlhs2kujqyj2Vkse21bAHe5pGWXq
Uw91PhfVQzAcX5I37i8RH5h0vQ3yeyD3qaLYH0He7GQz0L2nBFGjtTRM/aweqj1Z
TCXxLDZxrvJv6aSSqJEER7B8QVgYSNFOojrs1WHO+vcdVKpXpJ/aNJO5elwz3oLG
LdH6XJwifqRSZzlse12FzoCfGerDf3BnUF76JdYM188CrfJpj8J3OhG5tWUYhRke
StB8/EEcuKNpjRRxKrvAW1eggAbtJklxeweBtawTly4ttABroi4HKh0pm2KolhCM
qV6y6BveraHCAoKSWSmy8Ro+88Fr7yh2kIzuSJ0RZDMJCA73OXRAtcVJF31j2UHK
Y7Wn0tXK9pj3ncRYrOv50zYzQAwKUPKOfSdkcIViZpsrl+47j9nmBWHxSjO77yyD
YLVUislFGttOGhxGbBx31ExxUX7YbvXb5icDxlSl/jXGtBPIfVVW/2p0eM26JEpX
XNfXn0L/y7BHM6zcK2g1
=Ib2R
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--

--===============3296417990701827178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3296417990701827178==--
