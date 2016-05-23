From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: pcm5102a: Add support for
 PCM5102A codec
Date: Mon, 23 May 2016 23:29:05 +0100
Message-ID: <20160523222905.GG8206@sirena.org.uk>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
 <1463130853-25096-2-git-send-email-kernel@martin.sperl.org>
 <34ab107e-10dc-fbd3-28d1-203c6411851c@laposte.net>
 <20160523170853.GB8206@sirena.org.uk>
 <312f8476-a437-04d9-3d16-38d7c7c233ad@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IRIOLc8eTv1AOxGv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <312f8476-a437-04d9-3d16-38d7c7c233ad-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Emmanuel =?iso-8859-1?Q?Fust=E9?= <emmanuel.fuste-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--IRIOLc8eTv1AOxGv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2016 at 10:37:18PM +0200, Emmanuel Fust=E9 wrote:

> All the parameters are only rate and format.

Off the top of my head clocking constraints are another thing we could
know...

> And even rate is implementation dependent. Knowing the name of the hardwa=
re
> give nothing. You still have to look at the schematic or look at the board
> to know valid rates.

Fortunately we have mechanisms for constraining things between multiple
devices, it's not like this is a property unique to registerless CODECs.

> Yes this push more effort on the DT side, but I think this is better to
> describe in DT the actual "I2S only" hardware capabilities of the
> implementation of the device guided by wiring or design choice.
> Doing code cut&paste and two static assignment adjustment to create a "ne=
w"
> driver is completely overkill and nonflexible.

If someone was so motivated they could also make one big driver with a
table of per device constraints in it, it doesn't *have* to be separate
files.

> /* pcm5102a in HW mode with external SCK (4wire mode)
>  * at 128fs, 192fs or 256fs
>  */
> 	pcm5102a-4w: pcm5102a {
> 		compatible =3D "simple-i2s-codec";
> 		rate =3D <SNDRV_PCM_RATE_8000_192000>;
> 		format =3D < SNDRV_PCM_FMTBIT_S16_LE
> 			|SNDRV_PCM_FMTBIT_S24_LE
> 			|SNDRV_PCM_FMTBIT_S32_LE>;
> 	};

Those defines look awfully Linux specific...

> /* pcm5102a in HW mode with PLL on BCK (3wire mode)
>  * 16to384khz but only with bck rate of 64fs
>  */
> 	pcm5102a-4w: pcm5102a {
> 		compatible =3D "simple-i2s-codec";
> 		rate =3D <SNDRV_PCM_RATE_8000_192000
> 			^ SNDRV_PCM_RATE_8000>;
> 		format =3D <SNDRV_PCM_FMTBIT_S32_LE>;
> 	};

=2E..and another way of doing the multiple options would be to have the
binding be per device and use the clock binding to describe where the
master clock comes from which then allows us to start and stop that
clock on demand and possibly (as our clock API integration improves)
constrain based on that.  It may be that in future or perhaps even just
for other users of the same board the set of constraints is different
(perhaps they choose some other clock rate for something in the system
due to other constraints which lets the master clock vary more for
example). =20

It's also just more work for the second person to come across the
device, at best they have to go and type in the same data over again.

A brief look at the datasheet suggests that there's also a few GPIO
controls we might have wired up where we can expose them and of course
regulators we may want to control in some systems.

--IRIOLc8eTv1AOxGv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQ4QvAAoJECTWi3JdVIfQ3XIH/0nd6+u7w7RAeUeoUOEnOdDR
Ah0GmpGSnqPpHr4Wf10hfV4Xs8POua+kVZLxuUZDfEqnCSkQ7pcmLoNtGdj71pUb
T1DOKVBPT8nEMf02JJeKhrPQxCC3+Bwtzh8ueu2xrlFUzH/LUFNnJjtlqTFsM/Cr
c31i0tbsjgAyB6wc2DGNifE3qJTPyzV7HdntjPqMBJB6MUW6YD0oxJiQx/6eci4x
3VW/dapWEE/LCNxkR+jxIe36KD+JgQUCCO03DKuR2lmNbZ92F8rmuXKL/0kc6UV3
yEz2ZkAqb3lTAbm7UcqUO6q7hWjg/qz2F1XGUKUXklS7NHhrB0kFZpRfw8lxT2Y=
=F/Fq
-----END PGP SIGNATURE-----

--IRIOLc8eTv1AOxGv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
