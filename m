From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: pcm5102a: Add support for
 PCM5102A codec
Date: Mon, 23 May 2016 18:08:53 +0100
Message-ID: <20160523170853.GB8206@sirena.org.uk>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
 <1463130853-25096-2-git-send-email-kernel@martin.sperl.org>
 <34ab107e-10dc-fbd3-28d1-203c6411851c@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sZvnRN25x3w09J/6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <34ab107e-10dc-fbd3-28d1-203c6411851c-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Emmanuel =?iso-8859-1?Q?Fust=E9?= <emmanuel.fuste-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--sZvnRN25x3w09J/6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 22, 2016 at 11:29:55PM +0200, Emmanuel Fust=E9 wrote:

> There is nothing PCM5102A specific here, and it is pretty generic.
> Wouldn't it be better to write instead a simple-i2s-codec for all the
> classics I2S "hifi" DACs which will get the I2S/DAI parameters from DT ?
> PCM510x, PCM5122 in HW mode, ES9023, a bunch of ES90xx implementations
> etc... will use exactly the same code with only format and rate variation.
> And for the rate, it is implementation dependent, even in the case of
> pcm5102a.

If we do that then we have no idea what the hardware actually is and
we're creating more effort on the DT side, the DT has to specify all=20
the parameters for the device rather than just the name.  Given how
trivial the code is it's not clear that this is a win.

--sZvnRN25x3w09J/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQzklAAoJECTWi3JdVIfQxMEH+wS1CStB373Wki1cNk97/m3h
q7AYt0brHcvv0BltlDRGLLPPT3mA/YV6LR/Kir7oF83pqHCqhW5HYTwk4ECFV6go
3vzOssXnabhhfV9EOyFeMjDdiYramnyTLz/tbeKeEMpH4cQmQmKc101S91xiuDF2
AyoWZBeZICRHkVAS6VEdw6bn6NnyuzcGkXmjNs4eeqfiOKgDfuFQEVvAqwChPmId
o5LiBaR+AhzyVuhTYU8NowcFkgsKeMaoofgIv/HlBHJim2H9NDTcebuEz72+qORV
JozO6VjGr3LFj49xMPWYlnWlL5W6XA4OCybp9r1e6/cTJASfPPc558LsROS5gOg=
=hCkY
-----END PGP SIGNATURE-----

--sZvnRN25x3w09J/6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
