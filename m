From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: atmel_ssc_dai: enable fslen extension
 feature
Date: Sat, 21 Jun 2014 11:37:56 +0100
Message-ID: <20140621103756.GA5099@sirena.org.uk>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
 <1402481682-9811-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FX1XXxwkuRo+XMsw"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402481682-9811-3-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--FX1XXxwkuRo+XMsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2014 at 06:14:40PM +0800, Bo Shen wrote:
> When SSC work as master, it will generate the frame sync signal.
> On old SoCs, it only supports frame sync length less or equal to
> 16bits, on newer SoCs, it supports frame sync length extension,
> which can support frame size larger than 16 bits.
> So, add this to make it supports playback 24/32 bits audio clips.

Applied, thanks.

--FX1XXxwkuRo+XMsw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpWCAAAoJELSic+t+oim9CmEP/iAR+yTB3stIbkoH5+DH8+6e
xx2gRfd2VOuQiywZTPJtsjaGnRsKLaDDaey7hJoo8KKzzayDVm6EsYSKWJZ1heMM
SGPZRON+BQJuTkdsWb/sqctmGzUWOEkW0p2Y/oAR1Q2YA70IthaA/fQxwhHegho+
8eQc83KRgamJJ4ejHfcKzsk0Kk1cJu9T7qgmjWABursQUXyq+0WZvRZuhDOxJOCU
Ts5iPhJwOjN4CRXLSn5K4MeZA+jXL/gfS7OyEszP8LezWR5DFNS//jPfI08VXldC
EwMfZGBtvDQxPwNNgroKjQFNKZIJhj8iZAj9WXbB8jtdV2IoPgaYqp0NNOEjZS6P
U6SU7wwIHhfAVTYsZFTeRcRf4K6FxkikVz52jk28phYYFMILq0WZQ0zMgQdsybPr
26k1vbylahaocaq1xZoxOKIaFt9ilEoZcMpiIQy9Rrq/8wZUPcA7B7VG8JLCHSyP
ApbQ7WaxQpW9PIpQAspqnz3qQGwDBAjXwjdrjTds1c5VtBIm735cYLCkqsmp+Twc
KnpwmVxbCX0Z+rsP5ocEBku6Lb+ibsKEoI6UDp4JG6yt0Wcw+LkE7+QIzkYd4mAX
1/77OOTjwof4kEiWTEFFxAOY2y2VFQG3v0CQZt+s6eXzbIOW9HcuIhzc5IqHYI54
QJTLCDRQCqGkATM+gkR8
=oqsX
-----END PGP SIGNATURE-----

--FX1XXxwkuRo+XMsw--
