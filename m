From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] ASoC: codecs: wm8904: add dt ids table
Date: Mon, 26 Jan 2015 16:42:29 +0000
Message-ID: <20150126164229.GB21293@sirena.org.uk>
References: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
 <20150115115425.GX3043@sirena.org.uk>
 <54B866B9.8000900@atmel.com>
 <54C65C36.9050106@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ViWwB84N1zFtNiVD"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54C65C36.9050106-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sound-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Morozov <linux-lCH5ugpmZSMox3rIn2DAYQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ViWwB84N1zFtNiVD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 04:24:38PM +0100, Nicolas Ferre wrote:
> Le 16/01/2015 02:17, Bo Shen a =E9crit :

> >> Does this end up in the i2c_driver_id driver data or do we need some
> >> extra code when devtype is assigned to check for an of_node and look at
> >> the DT data instead?  That certainly used to be the case...

> > At the beginning I think as the same as you, and also add the code to=
=20
> > get the data as I do in <drivers/misc/atmel-ssc.c>. However, as I=20
> > remember, I2C seems only use the compatible string after the comma, tha=
t=20
> > means only for "wlf,wm8904", it uses "wm8904" to match. So, I remove al=
l=20
> > the code I added, and just keep these, and it can get the device type=
=20
> > correctly.

> > So, when I submit the patch and keep the code as simple as possible.

> I don't understand what's keeping this patch from being applied. Voice,
> do you mind re-sending?

I need to convince myself that the above actually works and is doing the
right thing; the above explanation sounds like if it works it might be
relying on a bug.

--ViWwB84N1zFtNiVD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxm50AAoJECTWi3JdVIfQRJkH/26//wf/lSxYQGI3s2tcHMY3
xLGkekFc+GuSLkudf84JTvMwmGuRsh7wGW5OfV40Oq1OB4Fxoj2H9N5ySWv8K/1+
HYlc1gd2AqYKGM/o60VpBIOIQadPaxIVFYVmf0XcBxfjktuAi2lGO/c66D3QskA8
EmHHT4ZbReTWV3TfMB3inIey6mSFgEkszfcOzvU05vwpy5VH7xrpi7JG5gSTXNxG
9Aet8v38l5At0M2Tflb/SqrAKAZtSpxwqTz7IATe4l9W4r3KjOAUH1bRfj7ngFQh
unMs+/PJx9sjGXHYw9/Ma8FJyXbJPkQada3aB1WdgRGsXbtxNeZX1PuZ/7M2Jpg=
=qC8j
-----END PGP SIGNATURE-----

--ViWwB84N1zFtNiVD--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
