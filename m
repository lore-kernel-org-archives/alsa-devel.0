From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mc13783: add mixer controls
Date: Wed, 9 Oct 2013 16:13:36 +0100
Message-ID: <20131009151336.GO21581@sirena.org.uk>
References: <1381330904-26389-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4539616843360800513=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FEAE2654E1
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 17:13:45 +0200 (CEST)
In-Reply-To: <1381330904-26389-1-git-send-email-s.trumtrar@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4539616843360800513==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R4k3HSW7UfPFhwix"
Content-Disposition: inline


--R4k3HSW7UfPFhwix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 05:01:44PM +0200, Steffen Trumtrar wrote:

> +static const char * const mc13783_alsp[] = {"Off", "Codec", "Right"};
> +
> +static const char * const mc13783_ahs[] = {"Codec", "Mixer"};

What are these - these look like they might be DAPM rather than regular
controls?

> +	SOC_SINGLE("Headset Amp Right Switch", MC13783_AUDIO_RX0, 9, 1, 0),
> +	SOC_SINGLE("Headset Amp Left Switch", MC13783_AUDIO_RX0, 10, 1, 0),

I would expect these to be stereo controls rather than two mono
controls?

> +	SOC_ENUM("Line out Amp Switch", mc13783_enum_arxout),

Switches shouldn't be enums.

> +	SOC_SINGLE("Codec Capture Mix Switch", MC13783_AUDIO_RX0, 21, 1, 0),

CODEC and Codec seem to be getting mixed in the file.

--R4k3HSW7UfPFhwix
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVXKdAAoJELSic+t+oim9SO8P/1oEZuEumQA6GVRjs5Q+uRrJ
+wz7oOe1m15eDX6K6LAVJmzaOVacnm3JW+EoXmLXKELD4OnONeENPP5H1Gq0uJDh
+i8MpbB8FE+7QbfO7CTWA8Q0b2AQEeKKKuBUo44M6dBDOi/gdOFNDjqb0yS0adIo
yHVYFR+QAw+ipQV0YDDAZbJVNLQCTQuzNW0O9mmZO9EH5G2PcM/tChWbNjeqAJE/
M7tTX0V3sBhBzOoT20TCjcCGzt7ADMMtIXKO9JNA8BeHILGbuFJsyPivPWZWjamC
9atfhEB8WDQso2CC4DibAF/bFd6+ZSfdiWyEz8aTiAk7ijITrNN7lq2j+IBEOzzj
EYFMl33H6ZAkbhuI9j/01FxExdmRv9N7aqQz5ZXQOry2nQ2T/v9VbUxWs0Q3lgzJ
NMzzGiAExnSYAtb+V8QQSJLklDy9zx8Kl5ED/dNqQ2xMOsRRdFppRhv94pQzVAzb
2uFH8lB0YytAbxzOsDKdwfr5i6S1330+zny9pNaaHLgzhGYgg8CYMTrjdSb5e2A4
/PHUE5WIUOwLv2WY1SgdneOy0yifNxvNzUruQLwIMlcbMYFlkn/3GjwjZRGpkryY
AI44PPGWvup7lJz0Lj3G/dcnh4S0MqJbbbPUhpgj1tZ1pRgAWoFPSXGcW318dYE1
6k3fuWlgh2kjCEPrf6sH
=jga6
-----END PGP SIGNATURE-----

--R4k3HSW7UfPFhwix--

--===============4539616843360800513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4539616843360800513==--
