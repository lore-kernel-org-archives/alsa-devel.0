From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Wed, 8 Jun 2005 13:13:46 +0200
Message-ID: <200506081313.48981.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <200506072002.49600.alien999999999@users.sourceforge.net> <s5hacm1kv7f.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1179908.vTlDKg8ZuM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacm1kv7f.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Igor Kovalenko <garrison@mail.ru>, openvortex-dev@nongnu.org, Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart1179908.vTlDKg8ZuM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op woensdag 8 juni 2005 12:18, schreef Takashi Iwai:
> At Tue, 7 Jun 2005 20:02:47 +0200,
>
> Alien wrote:
> > this is a patch against some CVS version of a few weeks ago not more th=
an
> > 3 weeks i think...
>
> The patch looks almost fine to me.
>
> Just subtle things:
> > @@ -202,6 +205,10 @@
> >  		goto alloc_out;
> >  	}
> >
> > +	snd_card_set_dev(card, &pci->dev);
> > +
> > +	snd_card_set_dev(card, &pci->dev);
> > +
> >  	*rchip =3D chip;
>
> Too much :)
>
> > Index: alsa-kernel/pci/au88x0/au88x0_eqdata.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_eqdata.c,v
> > retrieving revision 1.1
> > diff -u -r1.1 au88x0_eqdata.c
> > --- alsa-kernel/pci/au88x0/au88x0_eqdata.c	9 Mar 2004 11:52:13 -0000	1.1
> > +++ alsa-kernel/pci/au88x0/au88x0_eqdata.c	7 Jun 2005 17:56:37 -0000
> > @@ -104,7 +104,11 @@
> >  };
> >
> >  /*_rodataba0:*/
> > -static long eq_levels[32] =3D {
> > +static u16 eq_levels[64] =3D {
> > +	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> > +	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> > +	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> > +	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> >  	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> >  	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> >  	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>
> You don't need to define values if the static array is initialize to
> zero.  In this case,
>
> 	static u16 eq_levels[64];
>
> would be better.
>
>
> Takashi

you sure that this will initialize to 0 ? i seem to remember that C doesn't=
=20
init arrays to 0... unless there's a memset somewhere, of course, i never=20
wrote kernel stuff...

--nextPart1179908.vTlDKg8ZuM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD4DBQBCptLsuBWKXETrtdcRAirpAKDkpaT0vN10szxDKEp7bUUFpXfYAACVHSG2
oVu1XaBewlCPT4eJUWMTdw==
=dAoX
-----END PGP SIGNATURE-----

--nextPart1179908.vTlDKg8ZuM--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
