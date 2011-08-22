From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: Gadget: Add Audio Class 2.0 Driver
Date: Mon, 22 Aug 2011 17:29:18 +0300
Message-ID: <20110822142917.GU30398@legolas.emea.dhcp.ti.com>
References: <1313752934-20081-1-git-send-email-jassisinghbrar@gmail.com>
 <20110822113002.GD30398@legolas.emea.dhcp.ti.com>
 <CAJe_Zhdb7d23_x=1GWV2EnEjdn69XBKEz+hCeCuBx4v9XAmykg@mail.gmail.com>
 <20110822124406.GI30398@legolas.emea.dhcp.ti.com>
 <CABb+yY3QxvHf38-qfD5ig77nJK=0eVLiSPVpbTh_DCfHNGRyGQ@mail.gmail.com>
 <20110822134627.GP30398@legolas.emea.dhcp.ti.com>
 <CABb+yY2m2MfkFwf+XTdKzsCCeSFz_J2LoGxJricamhNtTcSAcg@mail.gmail.com>
 <20110822142805.GT30398@legolas.emea.dhcp.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tn/+KOyBVBGpvvUM"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110822142805.GT30398-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--tn/+KOyBVBGpvvUM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2011 at 05:28:05PM +0300, Felipe Balbi wrote:
> > >> Otherwise, please have a look at audio.c and audio2.c and suggest wh=
at
> > >> exactly you mean.
> > >
> > > audio.c doesn't do anything audio related. It's just adding the
> > > configuration to composite layer. The real specification is implement=
ed
> > > in f_audio.c (should probably be called f_uac1.c, though).
> > Agreed. Reusing audio.c is quite reasonable.
> > So, I'll :-
> > * Merge audio2.c into audio.c
> > * Rename f_audio.c -> f_uac1.c

just another tip/request:

when generating your patches add -M -C switches to git format-patch.
This will let git detect the renaming.

--=20
balbi

--tn/+KOyBVBGpvvUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOUme9AAoJEAv8Txj19kN1mf8H/jXfU/6M6tl7+3nFRnN+6k0H
0Gh7nnFl9VgUbo/dYetrND24ZcgefW7XID8me2lj07SNLVyHSawZ18znCFpGpDJJ
Bw7ZblmXJMsz0wuGivbKPXGwOCSjtN/oyWu0kgfDIdsznicr8bCs8E0z/EEjOvp/
BsSwZhfGUVr/BcydIM2WFt6BgGIFqgUwRQ+h0By6iHPcmVnKcK1s/UgZjU2Sjmfm
S7/za1Z3/RHNgj7tVsNbNSp41M/ERJLu5Bo6vnbB9JwCQM721l7t47vAG4epgqi3
g811+Mj6N1fJNkUQilvR3sHevSFEy+5I4QB3AJPelSqvORnBVkXPgNcJ2GfRwj8=
=QEBK
-----END PGP SIGNATURE-----

--tn/+KOyBVBGpvvUM--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
