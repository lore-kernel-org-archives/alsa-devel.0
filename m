From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: Gadget: Add Audio Class 2.0 Driver
Date: Mon, 22 Aug 2011 17:28:06 +0300
Message-ID: <20110822142805.GT30398@legolas.emea.dhcp.ti.com>
References: <1313752934-20081-1-git-send-email-jassisinghbrar@gmail.com>
 <20110822113002.GD30398@legolas.emea.dhcp.ti.com>
 <CAJe_Zhdb7d23_x=1GWV2EnEjdn69XBKEz+hCeCuBx4v9XAmykg@mail.gmail.com>
 <20110822124406.GI30398@legolas.emea.dhcp.ti.com>
 <CABb+yY3QxvHf38-qfD5ig77nJK=0eVLiSPVpbTh_DCfHNGRyGQ@mail.gmail.com>
 <20110822134627.GP30398@legolas.emea.dhcp.ti.com>
 <CABb+yY2m2MfkFwf+XTdKzsCCeSFz_J2LoGxJricamhNtTcSAcg@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e4Ac2VUIqaLF2Uxx"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABb+yY2m2MfkFwf+XTdKzsCCeSFz_J2LoGxJricamhNtTcSAcg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--e4Ac2VUIqaLF2Uxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2011 at 07:30:35PM +0530, Jassi Brar wrote:
> On Mon, Aug 22, 2011 at 7:16 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> >
> >> But that would mean having two drivers in one file, because they are
> >> so different.
> >
> > then make only a differnt function driver, f_uac2.c, which gets added as
> > another interface (or configuration) to audio.c.
> Yup, by audio.c I meant {audio.c + f_audio.c} and audio2.c {audio2.c +
> f_audio2.c}
>=20
>=20
> >> Otherwise, please have a look at audio.c and audio2.c and suggest what
> >> exactly you mean.
> >
> > audio.c doesn't do anything audio related. It's just adding the
> > configuration to composite layer. The real specification is implemented
> > in f_audio.c (should probably be called f_uac1.c, though).
> Agreed. Reusing audio.c is quite reasonable.
> So, I'll :-
> * Merge audio2.c into audio.c
> * Rename f_audio.c -> f_uac1.c
> * Add new f_audio2.c as f_uac2.c
> * Add Kconfig switch to compile UAC_1 (audio.c + f_uac1.c)  or  UAC_2
> (audio.c + f_uac2.c)
>=20
> I'll wait for other comments and revise the patch after a few days.

ok, sounds reasonable.

--=20
balbi

--e4Ac2VUIqaLF2Uxx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOUmd1AAoJEAv8Txj19kN1Zd0H/10d0Xcpx/2hHTdHcS3DqmPh
pK+LoBFVsQmg+Xn+UNZ8aqKnfJ6GBDBLiAmLzLOgaLbzFsOca6xrOz+rqKHZZs6E
q50a0PfZOVZLTHP9+1fiAiiblEjCmDmVeJitXwuIO3/43d98W2BXQzTzkcIzok6Z
0xRCYmad+OORR5VbeG5Ritei2VGe9qXUh2CfehHZe8zpdRRORcUDE2s1YfLMGGIL
1crbD/P5yCms39v9zJ2i3WLPv//NzcXJZnGwsQ3Bp/FoN+1HQRygPkjv0gM50kD8
2WwkxT53B3+SOlJZOubqytvsUViLSX9Sqyj1ZAXwnxcNqD2AEe0vibRos0YZErE=
=FIOP
-----END PGP SIGNATURE-----

--e4Ac2VUIqaLF2Uxx--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
