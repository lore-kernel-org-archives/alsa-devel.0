From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] sound: usb: mixer: increase control transfer timeout
Date: Mon, 29 Aug 2011 15:23:21 +0300
Message-ID: <20110829122320.GX13925@legolas.emea.dhcp.ti.com>
References: <1314616226-15942-1-git-send-email-balbi@ti.com>
 <4E5B7EE7.6070103@ladisch.de>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ar0NSVY9gjTGNA2"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E5B7EE7.6070103-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--1ar0NSVY9gjTGNA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 29, 2011 at 01:58:31PM +0200, Clemens Ladisch wrote:
> Felipe Balbi wrote:
> > 100ms might not be enough for slower devices. Increasing
> > timeout to 1000ms doesn't seem like overkill.
> >=20
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -296,7 +296,7 @@ static int get_ctl_value_v1(struct usb_mixer_elem_i=
nfo *cval, int request, int v
> >  		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), reques=
t,
> >  				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
> >  				    validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
> > -				    buf, val_len, 100) >=3D val_len) {
> > +				    buf, val_len, 1000) >=3D val_len) {
>=20
> If the timeout for reading values needs to be increased, writing (in
> snd_usb_mixer_set_ctl_value) probably needs some attention too.

Ok, I'll increase all 100ms delays to 1000. Is that ok ?

--=20
balbi

--1ar0NSVY9gjTGNA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOW4S4AAoJEAv8Txj19kN1KskIAJ9kmecPs9hb4koinHmNoB+X
adKJQU+1ZEGRICWRvbG7L/+TEv4RZJODDBH4nbwIgs+e4C9iK7SH/kkSmnV72Kun
C55PdktrDeJFKk7XaBPPGw++M+kzfrFcuW0fA+dcsKcLooBMEwKn9ngahbaX/bDS
W4oVTnf/rPGIQRMK3RyCIM6z3dS12mWUPoxYjeGfPaiuXVcf45qR2Rt3DQHd2rOh
ffepFWiUrKzm4el0hScPC+/5VWaHee46CXHPyGhrpKmXMrYPam/FQiCkaZj9qfrd
zOQc4rjuAf+QIp4wE2MN416hg5gWS/qvBxAGhU0aFmdRjca/yQxAgSLoReQbnok=
=5AmT
-----END PGP SIGNATURE-----

--1ar0NSVY9gjTGNA2--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
