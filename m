From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: Add support for HifiBerry DAC
Date: Fri, 13 May 2016 14:21:13 +0100
Message-ID: <20160513132113.GP22038@sirena.org.uk>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
 <1463130853-25096-3-git-send-email-kernel@martin.sperl.org>
 <20160513105409.GB22038@sirena.org.uk>
 <C139252A-23AC-4C37-A5E5-E0D7AF1DCC89@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C139252A-23AC-4C37-A5E5-E0D7AF1DCC89-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 02:20:57PM +0200, Martin Sperl wrote:
> > On 13.05.2016, at 12:54, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > You could almost use simple-card here but the BCLK ratio requirement is
> > probably a bit much, I'm not immediately seeing a nice way to specify
> > the ratio there since it depends on the sample width.

> Actually it is just: <sample-width> * <number of channels>
> where number of channels is fixed to 2 for bcm2835-i2s.

> So maybe that already happens automatically in the framework?

No, it's not handled.  Lots of devices don't care or have different
requirements (eg, 256fs).  The tricky bit with specifying it is that the
ratio depends on the sample width here but it might depend on something
else with another device, or the number of channels might vary.  That
should be doable with DT but it feels like more trouble than it's
reasonable to ask you to take here.

> Something like this could get added to the core?
> Is there interest in getting something like this?

> Could look like this:
> bclk-ratios =3D=20
>   /* for 96kHz at 16bit/channel use bclk-ratio 40 */
>   <96000 16 40>,=20
>   /* for 48kHz at 32bit/channel use bclk-ratio 80 */
>   <48000 16 80>,
>   /* for any (other) sample frequency at 16 bit use bclk-ratio 32 */
>   <0 16 32>,
>   /* for any (other) sample frequency at 32 bit use bclk-ratio 64 */
>   <0 32 64>;

> but there could also be other approaches as well,
> how this could get described in the device tree.

You may well end up with something like that, yeah.

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNdTEAAoJECTWi3JdVIfQE/sH/3jsZxxvx8WOkOFvT8Vz+g+M
o2hmUku704qdOQFfU3kDoGbYnBzqY5MZoeHWvz7s9jb4DTev0EjxG8+z0fwVMf2y
XmlOH3RngXcZKRf7u050MLhaV3xJrJF9D0ImRBjhfmUjxdde47Ue4inpG5VJub77
RU9A0QszN/g1wch0ZFeFvzgC7+TulfDcIKzZVtpN8mud+okNX+V2Pted8xzK/UMr
waUxmUmf95AXW9amyy/sMCD/N3uPQzMzXYI2Sjq4E/Y86zDMrz/hOlkT0Rkn/f29
BBZEaWJ7uyQ7AUXdZ7jiuZav2M1bd7eIBEcf12yPE+Yp6j+iOLyL7QUKZO61hEQ=
=tr3C
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
