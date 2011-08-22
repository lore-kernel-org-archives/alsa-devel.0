From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: Gadget: Add Audio Class 2.0 Driver
Date: Mon, 22 Aug 2011 16:46:28 +0300
Message-ID: <20110822134627.GP30398@legolas.emea.dhcp.ti.com>
References: <1313752934-20081-1-git-send-email-jassisinghbrar@gmail.com>
 <20110822113002.GD30398@legolas.emea.dhcp.ti.com>
 <CAJe_Zhdb7d23_x=1GWV2EnEjdn69XBKEz+hCeCuBx4v9XAmykg@mail.gmail.com>
 <20110822124406.GI30398@legolas.emea.dhcp.ti.com>
 <CABb+yY3QxvHf38-qfD5ig77nJK=0eVLiSPVpbTh_DCfHNGRyGQ@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kOdvwer/5gjFgNo6"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABb+yY3QxvHf38-qfD5ig77nJK=0eVLiSPVpbTh_DCfHNGRyGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--kOdvwer/5gjFgNo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2011 at 06:30:36PM +0530, Jassi Brar wrote:
> > I understand your point, but then we will have two gadget drivers (and
> > two function drivers) for the same thing (USB Audio), it's the same
> > thing with the storage gadgets and we have decided on dropping one of
> > them recently, so I'm not keen on accepting another gadget driver which
> > will essentially do the same thing.
> No dear, not the same thing.
> As I said, they differ by features as well as USB-Spec... only the
> 'audio' thing is common.

and that's what I meant by same thing. How different is UAC_1 from
UAC_2.

> > If audio2.c can achieve audio.c's functionality, then you can start by
> > re-factoring audio.c so that it come closer to what audio2.c is today.
> audio.c and audio2.c have almost nothing in common. Please have a look
> at the code.
> Making audio.c closer to audio2.c would mean :-
>   * Changing all of the descriptors of audio.c {uac_1 -> uac_2}
>   * Removing all alsa related code and adding virtual alsa sound card.
>  At the end, audio.c would have been changed completely and Linux-usb-gad=
get
> lost the UAC_1 compliance.

it shouldn't loose compliance. If it does it was probably not done
right.

> > WRT UAC_1/UAC_2 compliance, you can use a Kconfig entry, or two separate
> > USB configurations (one with UAC_1 and another UAC_2). So there are ways
> > to make this all work while still keeping backwards compatibility.
> IIUC, you mean adding UAC_2 compliance and virtual sound-card i/f to
> audio.c, while
> preserving the it's original functionality ?

yes.

> But that would mean having two drivers in one file, because they are
> so different.

then make only a differnt function driver, f_uac2.c, which gets added as
another interface (or configuration) to audio.c.

> Otherwise, please have a look at audio.c and audio2.c and suggest what
> exactly you mean.

audio.c doesn't do anything audio related. It's just adding the
configuration to composite layer. The real specification is implemented
in f_audio.c (should probably be called f_uac1.c, though).

Then only thing different between audio.c and audio2.c is bDeviceClass,
bDeviceSubClass and bDeviceProtocol, but that can be easily handled with
Kconfig choice and/or module parameter.

--=20
balbi

--kOdvwer/5gjFgNo6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOUl2zAAoJEAv8Txj19kN1VHsH/i5rg+J8Ue3fBpFzqMUl/XP4
Rp/wAwqsSVS1jtxJzSuZAgQqCfYUcQUNHlgtB76XRDZdaH27DuxrmDUOkP5rm/xi
6k0TioyI478eEBP66TtulkUCEiUM3Di22MthXzSmbsC0Qkmxw69yGtKZzI06c7sC
6oeY8mKYuSaVEFvPyNX8pGNBnbALvR+MRTcfg8OBApYWZUMqyxu2zqm9rhD0eAYK
bQnqs2LYf4BgV3nlUNyjGk7tfnOtF2tnG66tlCtaJedpPp0iwOB40SnP1to78soe
WqT9ZY0v+UJElaiAkpFwMVfnMLVL3zQwiYvWh5hZvF8pDAyyducGkI6CUqKzEMA=
=YYyB
-----END PGP SIGNATURE-----

--kOdvwer/5gjFgNo6--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
