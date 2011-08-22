From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: Gadget: Add Audio Class 2.0 Driver
Date: Mon, 22 Aug 2011 15:44:07 +0300
Message-ID: <20110822124406.GI30398@legolas.emea.dhcp.ti.com>
References: <1313752934-20081-1-git-send-email-jassisinghbrar@gmail.com>
 <20110822113002.GD30398@legolas.emea.dhcp.ti.com>
 <CAJe_Zhdb7d23_x=1GWV2EnEjdn69XBKEz+hCeCuBx4v9XAmykg@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJe_Zhdb7d23_x=1GWV2EnEjdn69XBKEz+hCeCuBx4v9XAmykg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2011 at 06:07:46PM +0530, Jassi Brar wrote:

[big snip]

> Hi Felipe,

Hi

> Functionality wise, audio.c hardcodes the data-path to the physical
> audio-codec onboard
> whereas audio2.c provides user-space with a virtual sound-card to fool ar=
ound
> with audio-data the way the user wants. The functionality that has
> lion's share of code.
> Also, although the functionality of audio.c can be achieved by audio2.c (=
but not
> vice-versa) we'll break user-space by changing the behavior of audio.c
> to audio2.c
>=20
> Besides fundamental differences in functionality, they differ by
> Usb-Audio-Class
> compliance as well.  audio.c is UAC_1 compliant, whereas audio2.c is UAC_2
> complaint.
> One can not replace the other. For ex, MS-Windows doesn't support
> UAC_2 by default
> yet, Linux does reasonably well. And by definition having
> Linux-USB-Gadget support
> UAC_2 also, is only better. So by having both we cover more ground than by
> having just one.

I understand your point, but then we will have two gadget drivers (and
two function drivers) for the same thing (USB Audio), it's the same
thing with the storage gadgets and we have decided on dropping one of
them recently, so I'm not keen on accepting another gadget driver which
will essentially do the same thing.

If audio2.c can achieve audio.c's functionality, then you can start by
re-factoring audio.c so that it come closer to what audio2.c is today.

WRT UAC_1/UAC_2 compliance, you can use a Kconfig entry, or two separate
USB configurations (one with UAC_1 and another UAC_2). So there are ways
to make this all work while still keeping backwards compatibility.

--=20
balbi

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOUk8WAAoJEAv8Txj19kN1IWAH/iPWsgKWpQZqWJUkvURNVMu5
ZCParEPkLdTBN4e9W/HD1Zeo6qf08db0OldLw5kQsR7zhLN9xEmc+arC5eRRnZvA
O67dHC1p0h4maV/6C3Q3VXzX3JZGct+ugpRDZb/W3+9ZAXDZTvzCx/i9FD0rt2XC
UmF8PUvl6DIYaIG7tqhYjsyZPHir0FjmLzi4NLXiNusq2beB2LGOP5LEIS8QXT/B
HPiJhoQwXXzTDW9vpKiam0jIC3CX1llQKHB9kUC4P4Suu7TR7lkRAHZQ79qvMJw/
dar1Oju1R1rkwqTFuJzW1TOBvfC0oyrtZjVDmmAhtN5PGWm202Qaa2CksG7mfhE=
=dejj
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
