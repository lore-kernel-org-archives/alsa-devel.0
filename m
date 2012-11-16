From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
Date: Fri, 16 Nov 2012 15:41:15 +0900
Message-ID: <20121116064113.GQ4387@opensource.wolfsonmicro.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
 <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
 <20121116061250.GP4387@opensource.wolfsonmicro.com>
 <50A5DE4E.80206@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XG0jWBK27HhJN4nS"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50A5DE4E.80206@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--XG0jWBK27HhJN4nS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 16, 2012 at 02:33:50PM +0800, Bo Shen wrote:
> On 11/16/2012 14:12, Mark Brown wrote:

> >No, this isn't what was meant - the idea is to send only the addition of
> >pinctrl data as one patch, based off the ASoC branch instead of -next.

> What is the pinctrl data? (This patch can be applied on

The data you're adding in the device tree!

> sound/topic/atmel branch without any conflicts)

That's not helpful to anyone doing bisection if there's nothing defining
the pin states, it means that the system won't be able to start the
driver as the API call will fail.

> The other one add pinctrl nodes, must based on -next, or else I
> don't know where should I add the pinctrl nodes.

What makes you say this?

--XG0jWBK27HhJN4nS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpd/+AAoJELSic+t+oim9RIkP/1LYaeqQ/YCRJLbvg9KDIb+O
AodflGN2SYcYdSo+8wDzUj1p4sMeHCGByMuNd5k432tFJXcEnRbIPDVHyHvkid6f
ewazRMztFen2sii9RLUjAflqZoatAWg4T4fb5+gq1fZZ1thTr2xEzUPdNCLDzgzx
tilrjyTspyUmDGngEQuOHOMgkOJloNYmC+OAAaPFk4WgYsermPh4v5JfTg2Aq9kM
AcVTkqRLE4HOy7fBuAbIe38vTL8/2S85j7uqFmffx5QZrO9BBn8ywJrfJDajpLwd
uoZx9XnPbWaJfpFoiAVMfPmGhVyCEpyh0JGHl2Wey56TcuJShPXLIjtZfgwR2Tun
ykAQiXW6R5GhUeuuOOQJQUwhA9vDfFW7Vokt8BfsIDZsGDOWPFeYmrH9FHBCS0/g
edXcfpRGRtONi846saI/RyvjSiawimNVcYDcdIZFmfp4QKIlIHZ0YobSgkiB1QNW
/UD4vJmrnWeYLRAeLzZDtFwoa7AYi/4zVWKrkcDNIQK3gnprV8JOSq4dfwBC4CAD
A4s56Qw7XmK5trBAwI2uMRTF9igj1vlJpj2CvKbUHqDauPYa9PNRvKNeqhSWF7NZ
Hu1v+voUZrrqmalG+sX+t4rO1g9ErVq6qLyuiE3VlW26nSoe7a5/tsVVX0qSe1yX
CJv8DOutxOtXYVUlzzRi
=eftW
-----END PGP SIGNATURE-----

--XG0jWBK27HhJN4nS--
