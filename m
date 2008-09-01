From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Using GDB for ALSA How to?
Date: Mon, 1 Sep 2008 23:13:26 +0200
Message-ID: <20080901211326.GM15719@lug-owl.de>
References: <48BC4E6A.1070508@popdial.com> <20080901202407.GL15719@lug-owl.de>
	<48BC5198.1050906@popdial.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1439705253174592782=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A4AA24553
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 23:13:27 +0200 (CEST)
In-Reply-To: <48BC5198.1050906@popdial.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Estrada <MrUmunhum@popdial.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1439705253174592782==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kc9HNjpzOXVc7FFU"
Content-Disposition: inline


--Kc9HNjpzOXVc7FFU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-09-01 13:33:28 -0700, William Estrada <MrUmunhum@popdial.com> =
wrote:
> Jan-Benedict Glaw wrote:
> > On Mon, 2008-09-01 13:19:54 -0700, William Estrada <MrUmunhum@popdial.c=
om> wrote:
> > >   I am trying to use GDB with my ALSA program. I wish to display (pri=
nt)=20
> > > a handle for
> > > an snd_pcm_t pointer. I am getting the following error:
> > >    =20
> > > > (gdb) p Device
> > > > $9 =3D (snd_pcm_t *) 0x92be458
> > > > (gdb) p *Device
> > > > $10 =3D <incomplete type>
> > >
> > >   How do I display the snd_pcm_t structure?
> >
> > My guess is that this pointer is simply uninitialized. Did you check
> > that it was properly prepared?
>
> Yes, the device is opened. Is that what you mean??

Partially.  But I misread your log, too.  Seems that gdb failed to
figure out how snd_pcm_t is actually defined. You'd try casting it to
struct _snd_pcm *  if the type information got lost somewhere. (You'd
check the later by examining the `readelf -wi' output for your binary
or library you're hacking on.)

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of: They that give up essential liberty to obtain temporary safet=
y,
the second  : deserve neither liberty nor safety.  (Ben Franklin)

--Kc9HNjpzOXVc7FFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIvFr2Hb1edYOZ4bsRAva+AJ43tDlD1vnRQcMxt+3fQ75beRRh6QCaA7r3
0kjmwZsbGwfrFQc08VFpTjY=
=TYgd
-----END PGP SIGNATURE-----

--Kc9HNjpzOXVc7FFU--

--===============1439705253174592782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1439705253174592782==--
