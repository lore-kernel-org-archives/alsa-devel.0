From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] sound: usb: mixer: increase control transfer timeout
Date: Mon, 29 Aug 2011 14:19:32 +0300
Message-ID: <20110829111931.GU13925@legolas.emea.dhcp.ti.com>
References: <1314616226-15942-1-git-send-email-balbi@ti.com>
 <20110829111607.GB21556@linutronix.de>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sBvc846/5FzkyDmz"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110829111607.GB21556-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--sBvc846/5FzkyDmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 29, 2011 at 01:16:07PM +0200, Sebastian Andrzej Siewior wrote:
> * Felipe Balbi | 2011-08-29 14:10:26 [+0300]:
>=20
> >Not sure this information is valid on a commit log, but I
> >have a FPGA-platform which I use to test my USB controller
> >and when that's running on FS, this message fails because
> >control message times out before controller has the opportunity
> >to complete all three phases of the SETUP transaction.
>=20
> Does it still happen if you remove all the debug output from your udc
> driver?

I can try it out, but what's the point ? If we don't increase the
timeout, then whenever we want to debug some other problem, we will have
to keep a local patch on that file ?

--=20
balbi

--sBvc846/5FzkyDmz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOW3XDAAoJEAv8Txj19kN1G6wH/RBB5V93bS68st7mY8fW2WUl
QwVOl/ztpPCRGrVuNKw7e+dW3jL9R1BI0LlmjRDzc51dtTCZixs6//PqciwF1V+I
fMj7olopOdIlU7DNwrA9lgFb2E0239XQBVVPw+spJX09XK8D/h7BLpKmDCZRNJOw
yXnY9jF9tphy43UH/NLC1BkN3ql5L+JeN729jnOJ7Ymp2aqob/Rh0a0bg/cpfj/4
4EMthpYP0AD9vfGJy4Pcl9VYibbsn1vSL/SbyfLbgHATHRIHiW2w/5vUwgrOqiAq
i07Ng9YQ364pF5U7Gp1SlCODacZx2AWARHpOBB11mOhGtbs9KKk0rRuR8/QiyeE=
=7At/
-----END PGP SIGNATURE-----

--sBvc846/5FzkyDmz--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
