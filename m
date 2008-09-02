From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Using GDB for ALSA How to?
Date: Tue, 2 Sep 2008 09:08:36 +0200
Message-ID: <20080902070836.GO15719@lug-owl.de>
References: <48BC4E6A.1070508@popdial.com> <20080901202407.GL15719@lug-owl.de>
	<48BC5198.1050906@popdial.com> <20080901211326.GM15719@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0425042103463950758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 21C1E2462D
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 09:08:37 +0200 (CEST)
In-Reply-To: <20080901211326.GM15719@lug-owl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Estrada <MrUmunhum@popdial.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0425042103463950758==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qse+WBH4guesipZ+"
Content-Disposition: inline


--qse+WBH4guesipZ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-09-01 23:13:26 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wr=
ote:
> On Mon, 2008-09-01 13:33:28 -0700, William Estrada <MrUmunhum@popdial.com=
> wrote:
> > Jan-Benedict Glaw wrote:
> > > On Mon, 2008-09-01 13:19:54 -0700, William Estrada <MrUmunhum@popdial=
=2Ecom> wrote:
> > > >   I am trying to use GDB with my ALSA program. I wish to display (p=
rint)=20
> > > > a handle for
> > > > an snd_pcm_t pointer. I am getting the following error:
> > > >    =20
> > > > > (gdb) p Device
> > > > > $9 =3D (snd_pcm_t *) 0x92be458
> > > > > (gdb) p *Device
> > > > > $10 =3D <incomplete type>
> > > >
> > > >   How do I display the snd_pcm_t structure?

So... Looking at it, snd_pcm_t is willfully specified as a hidden
struct, the real definition is only used where *really* needed, that
is: inside libasound2. It's in pcm_local.h, to not allow an arbitrary
user to easily fiddle with the lib's internal state.

As you want to peek into it, I guess you're facing a problem
somewhere. It would probably help if you describe your actual problem.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:               The real problem with C++ for kernel modules is:
the second  :                                 the language just sucks.
                                                   -- Linus Torvalds

--qse+WBH4guesipZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIvOZzHb1edYOZ4bsRAgODAJ9yoS7p9YcWtpTdza9aJvopPllWrACfTIQT
0cEm4YITp48sM7opWz/G+o0=
=DfPJ
-----END PGP SIGNATURE-----

--qse+WBH4guesipZ+--

--===============0425042103463950758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0425042103463950758==--
