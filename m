From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH - usb 1/1] Terratec Aureon 7.1 USB ID added
 for C-Media cm6206 quirks
Date: Thu, 28 Apr 2011 18:12:03 +0200
Message-ID: <1304007123.3911.4.camel@mattotaupa>
References: <1304000320-25970-1-git-send-email-wbreyha@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0721473951732576987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 8252D1037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 18:12:06 +0200 (CEST)
In-Reply-To: <1304000320-25970-1-git-send-email-wbreyha@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: wbreyha@gmx.net
List-Id: alsa-devel@alsa-project.org


--===============0721473951732576987==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-c3998nUMUXtMmMI0V7qH"


--=-c3998nUMUXtMmMI0V7qH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Wolfgang,


Am Donnerstag, den 28.04.2011, 16:18 +0200 schrieb wbreyha@gmx.net:
> From: Wolfgang Breyha <wbreyha@gmx.net>

the commit summary can also be in present tense.

> Hi!
>=20
> This patch adds support for the
> Terratec Aureon 7.1 USB
> which uses a C-Media cm6206 and needs all the quirks already found in the=
 past.

Maybe add a not if everything is working with this patch or if there are
still unsupported things.

> Greetings,
> Wolfgang Breyha

The salutations are not so good for a proper commit message.

> Signed-off-by: Wolfgang Breyha <wbreyha@gmx.net>
>=20
> diff --git a/sound/usb/format.c b/sound/usb/format.c
> index 5b792d2..f079b5e 100644
> --- a/sound/usb/format.c
> +++ b/sound/usb/format.c
> @@ -176,9 +176,11 @@ static int parse_audio_format_rates_v1(struct snd_us=
b_audio *chip, struct audiof
>  			if (!rate)
>  				continue;
>  			/* C-Media CM6501 mislabels its 96 kHz altsetting */
> +			/* Terratec Aureon 7.1 USB C-Media 6206, too */
>  			if (rate =3D=3D 48000 && nr_rates =3D=3D 1 &&
>  			    (chip->usb_id =3D=3D USB_ID(0x0d8c, 0x0201) ||
> -			     chip->usb_id =3D=3D USB_ID(0x0d8c, 0x0102)) &&
> +			     chip->usb_id =3D=3D USB_ID(0x0d8c, 0x0102) ||
> +			     chip->usb_id =3D=3D USB_ID(0x0ccd, 0x00b1)) &&

Should the IDs be sorted? Maybe put the comments what device this is
right before the ID?

>  			    fp->altsetting =3D=3D 5 && fp->maxpacksize =3D=3D 392)
>  				rate =3D 96000;
>  			/* Creative VF0470 Live Cam reports 16 kHz instead of 8kHz */
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 355759b..916b6a4 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -533,6 +533,7 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
> =20
>  	case USB_ID(0x0d8c, 0x0102):
>  		/* C-Media CM6206 / CM106-Like Sound Device */
> +	case USB_ID(0x0ccd, 0x00b1): /* Terratec Aureon 7.1 USB */

Should this be sorted too?

>  		return snd_usb_cm6206_boot_quirk(dev);
> =20
>  	case USB_ID(0x133e, 0x0815):


Thanks,

Paul

--=-c3998nUMUXtMmMI0V7qH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk25kc0ACgkQPX1aK2wOHVif1wCgjVtzkwLPOMIxJwV6KAM7KcRt
fQIAn1Lyc7UeY1JfK3K55W5DzLZteZfx
=Iye+
-----END PGP SIGNATURE-----

--=-c3998nUMUXtMmMI0V7qH--


--===============0721473951732576987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0721473951732576987==--
