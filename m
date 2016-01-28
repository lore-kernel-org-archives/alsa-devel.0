From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V2 2/3] ARM: bcm2835: I2S: use new register-range and clock framework
Date: Thu, 28 Jan 2016 14:16:37 -0800
Message-ID: <87powlfiyi.fsf@eliezer.anholt.net>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org> <1452602149-5875-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452602149-5875-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Since the move to the new clock framework with commit 94cb7f76caa0
> ("ARM: bcm2835: Switch to using the new clock driver support.")
> the bcm2835-i2s driver was no longer working.
>
> This patch fixes the address ranges:
> * remove the PCM clock register range that is owned by the clockmanager
> * fix the length, which did not include the last register of this device
>
> It also adds the required pcm-clock.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqpNFAAoJELXWKTbR/J7o2TsQAImrCMmUg0HPm4RX3RXvhRfI
BLNjzdpgVM4ZyXX7HtIvB31KV7OmBtMjga0csjB6ybrIqdeql+IhuoV5tCrr+L8c
STzCx7f9xlLIV4O2xhF6LKwapugaXLFkMsSYZ821YZakhOMyJj0hI1/aqcNFSowy
UHkRkJo7cFzsBnrJutQFc3MrBOfjvmncl2CfUZVMlFKvs0x2o4UuOO4XpXcU2Z2t
gBsfy9BIGLem0/uJV0j2BSE7CFG1UUkHqAt6LuzpcYu2up/BQIy+mGRpEo98OsaB
kAU4PigDHUAyLT/4EBZ6u1KxtmPCmxP/2XfPUhx+uyOFyxXsAdeF0SQCvg6YZVYv
UrffYPYBmLq1RfV2oVqE6oE1UAwURs5ix8KDAR+nYqzM9HIVlUcr1lRDfP3Oom95
mb1GbLQn+ByxXL7r+8OE23GmMEK8rvu2Carxgx8jr6OSRQrzlM4uvd9TQ5OSkmzh
bF5/keO0MQiPtoRlYK3c1vFgbwkJYRSTD47BOYZrkhjXOb0X9SuOCSV2cNfRUk2W
trPGfuPdURWeWHeLkzwkZ4sLJuIU167L4yMj+6rCWDwgVBcxALMCGX0OU1bmhd/F
uId1BUMPdnP5IAUG21VJrfROAdiNTggIFjWASE5rt8ZiEgJ2lwPk9GWPB0RPDbCJ
br+sP5acS8uzBgGTOTYt
=PQXw
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
