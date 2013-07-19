From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Provide a .hw_free function
Date: Fri, 19 Jul 2013 13:45:36 +0100
Message-ID: <20130719124536.GI9858@sirena.org.uk>
References: <1374236288-28854-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6786212302192824479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D795265697
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 14:45:43 +0200 (CEST)
In-Reply-To: <1374236288-28854-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============6786212302192824479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2013 at 09:18:08AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>

> Currently after playing any audio file, we get the following error messag=
e:

> $ aplay clarinet.wav=20
> Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,=
 Stereo
> $ wm8962 0-001a: Unsupported sysclk ratio 544

> This error message appears about 5 seconds after the audio playback has=
=20
> finished.

> In order to avoid such error message, let's add a .hw_free function which=
 will
> zero out wm8962->lrclk and wm8962->bclk, which according to the code belo=
w:

> 	if (!wm8962->bclk || !wm8962->lrclk) {
> 		dev_dbg(codec->dev, "No audio clocks configured\n");
> 		return;
> 	}

> ,will cause the wm8962_configure_bclk() function not to search a valid sy=
sclk=20
> ratio after playback has finished.

This means that if we start a bypass path the driver won't remember the
last sample rate setting so there's zero chance that we'll come up with
something useful by default.  The issue here is triggered by the machine
switching from the FLL to direct MCLK usage where the MCLK isn't
generating a useful ratio.

I suspect we should just kill the configure_bclk() in set_sysclk(), that
one isn't safe as we can't reconfigure a live SYSCLK and it's probably
the one that generates your warnings.

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6TTtAAoJELSic+t+oim9+1cP/i+rtDznDOOM0q5t47f+zCOt
UiJZszPyG+iixV8YLH4wGLT1MgiB9QOPhfLO/X1TQzUXYKCKaaaxOPMdCegcjV0B
WZE49HKQCW2ZwMjX/d8Yg9XamP2Y4iiM+IQ6YnNoQmdiz2y378vhCrcnKgMxXTuS
yESvBe7B9jUTHXRxL10Rx+FEopfiz1Yr6Z/daEu3ob2Q+r/R5gIsQ10oVEzIG0Ok
rAk9R+qfHLONfT2/aUT/d0yrEIIXotxN0GYt4gO9n+bRKLlmcmT5/0PQ2z/641oP
pkmUPdvfQ9gu+1dw8vBmxg/DwHqyVQSpZL149CbrpcJ0SqqaKFTo8OI+E5hjosCt
RVbbBZPw0vMRZSogrvnzKvPF+bVJuEsTfeiOMbn6+1Gytu/UP2k29I+B2PAw8D3M
cGxwUBB86JPlE54PAVvcPEQN6z8pTvPIM9KzgsRJCDumIgUyuqau7XK+th2gS0RJ
7potRHaYr0Ldx+wqreL+Z2O8seFo8Xkee3sbq3n0BCfo/AToF8QXpYkFbKMeA8EI
5RgbDcS8ZzCsFtruPlBJ4WlsH8xeMUZ3hM45MqxLotNtryxPntaENYKnz7nM+yk6
EGTasLFN07LR/N12sR7C+DRNwYWXKOKADR83usbEFD8KlVL0KpWJrI8uYNHw9tFe
pkhkY9LOFBymzY7BBh9H
=nDXs
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--

--===============6786212302192824479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6786212302192824479==--
