From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 01/14] ASoC: qcom: Remove redundant error check.
Date: Mon, 4 May 2015 13:24:13 +0100
Message-ID: <20150504122413.GQ15510@sirena.org.uk>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1430414195-10913-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="glwmnIOgU1tcuP7N"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430414195-10913-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--glwmnIOgU1tcuP7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 06:16:35PM +0100, Srinivas Kandagatla wrote:
> This patch remove redundant check after request_resource as ioremap would
> do the check anyway.

Applied, thanks.

--glwmnIOgU1tcuP7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR2TsAAoJECTWi3JdVIfQTGsH/R9JkfV2fLpnWNGzsrVzPXPb
MxVKrqvBIvfIj+QWiukL8Dur4K6yJ1Tn4ryN63F8yOOFa1HlWWcWmdfCW6xngYsj
c26mUhIHfNsZrwXLK9NQTNu70QSPNwHXTZ+OAPpirszXNv5qrbEO4Jli1dsjDVWv
lQX7Poeohs5DKnMx1m664oM+0+iBValtgXbB0Ubyn2VVQy8dpXSpLPYX1aSfGJ9m
EWL97b1/+qC4yitRKHxkYXFo1tAcXnniKZlGUf77MnJ2gCQnXcjruK00270n6EgL
sQLgIqbEUnt4MMF+dtSDaEmU9DPkDizoczmmLIbD3ZlMtVgoiORhi7mE1TgBI7Q=
=4NCx
-----END PGP SIGNATURE-----

--glwmnIOgU1tcuP7N--
