From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/2] ASoC: bcm2835: Add S16_LE support via packed DMA transfers
Date: Wed, 27 Apr 2016 11:54:04 -0700
Message-ID: <878tzyublf.fsf@eliezer.anholt.net>
References: <1461763613-28714-1-git-send-email-hias@horus.com> <1461763613-28714-2-git-send-email-hias@horus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461763613-28714-2-git-send-email-hias@horus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Reichl <hias@horus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Martin Sperl <kernel@martin.sperl.org>, Luis de Bethencourt <luis@debethencourt.com>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain

Matthias Reichl <hias@horus.com> writes:

> The bcm2835-i2s driver already has support for the S16_LE format but
> that format hasn't been made available because dmaengine_pcm didn't
> support packed data transfers.

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXIQrMAAoJELXWKTbR/J7ozMkP/3Puj2xYb0FDVqPrt95uTThl
h+zixSPJjgc/qVh4gm2wf+61jEusPx6pESmlxjJemdgtw/zdBUky7tR5FkNyaOwR
rpdjtbrw8oS+4rlNhlA1BszaVXnAMfV5kuKHXjCgUTHJ2khuVg3of1gCyi8/JQAU
HRfmpBcfsBWpSJe6fS6cC8f7w3VmK7LMSKmfLdGw9JjUZsvIo5rqsFOOpq9FQ3SD
CfSRkD0wFIA6z3oMqalCXh4FWjuyOUHp52F37mO9tIEF23D8eg63weuP8ffmtYy5
OfN9Mf1z4FMDzY8YIN1Tx7qUq82RuflPRry+PxFVCoUk0kiYXzQJt/a1FHuOP6qT
LVWXegKH6Fhr3vDsNvNimRMynb7AQvwrvoYSXyF8GwD4qlzaJaLmOVFvTinyS0r9
6xTwWOCOJb923yxl8x4mylISJ4sD3C68n6vf2UZoNGNV9VtS21+/Fn8q89YMnMs8
jtbNhoqmPnETV8Ne3PUwwqc0rp8PCwHpMs2xJ5GTknMjxZ5S1OwuNixV6G8kEqBa
xL9K3mHhxOwq4wOlngbQ6CIo9czglJuT+9gb1lusWFbbe3wIuJLaT89IiKGXN6xl
c2epp6Gs/eLvYDQ3Th43WcFLhskkI61jaJywPVJMtyTS2BD4AYvQEBypGP/jbl5x
5VW9Cl/a2Au9h/yX6aTd
=zVJO
-----END PGP SIGNATURE-----
--=-=-=--
