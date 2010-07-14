From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Wed, 14 Jul 2010 17:15:58 -0500
Message-ID: <1279145758.29042.11.camel@localhost.localdomain>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5124531724082372909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 7721810387D
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 00:16:01 +0200 (CEST)
In-Reply-To: <AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org


--===============5124531724082372909==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-oMDovj8addmTfke09UeK"


--=-oMDovj8addmTfke09UeK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-07-14 at 20:23 +0800, Raymond Yau wrote:
> 2010/7/14 Chris <cpollock@embarqmail.com>
>=20
> > On Wed, 2010-07-14 at 10:09 +0800, Raymond Yau wrote:
> > >
> > >
> >
> > >
> > >         > You need to provide a full pulseaudio log and a test case
> > >         which can
> > >         > reproduce your problem
> > >         >
> > >         > open a new terminal
> > >         >
> > >         > pulseaudio -k ; pulseaudio -vvvvv
> > >
> > >         Where should I post this Raymond?
> > >
> > >
> > >
> > > AFAIK , this mailing list has a limit of the message size
> > >
> > >
> > > BTW ,
> > >
> > > did the program abort when you run alsa-time-test  and pipe the outpu=
t
> > > to "tail -n 500"
> > >
> > >
> > >
> > > http://thread.gmane.org/gmane.linux.alsa.devel/60371/focus=3D60520
> > >
> > > Beware that the program generate a log of output
> >
> > Raymond, I've ran bzip2 on the output of pulseaudio -k ; pulseaudio
> > -vvvvv and it went from 129k to 9k. Should I fwd to you or post on the
> > list?
> >
> > --
> >
>=20
>   appl_ptr is also behind the hw_ptr in 0.9.21-0.1mdv2010.0
>=20
> https://qa.mandriva.com/show_bug.cgi?id=3D56473#c15
>=20
> Apr 12 15:21:43 localhost pulseaudio[13701]: alsa-util.c: appl_ptr :
>=20
> 28465776
> Apr 12 15:21:43 localhost pulseaudio[13701]: alsa-util.c:   hw_ptr       =
:
> 28555040
>=20
> and also appl_ptr is also behind the hw_ptr for snd_via82xx
>=20
> https://qa.mandriva.com/show_bug.cgi?id=3D56473#c0
>=20
>=20
> Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   appl_ptr     :
> 767919576
> Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   hw_ptr       :
> 767990616

I posted both of those bug reports. Honestly, I just want it to work
without all the error output to syslog and thrashing of my HD for
minutes at a time. As I said, I've got the output of pulseaudio -vvvvv
if anyone would like to look at it and tell me what I need to do to fix
the problem.=20

Chris



--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-oMDovj8addmTfke09UeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkw+Nx4ACgkQ43Kn2pjmcFw5/gCeIqGBk/VXo6Ejo7AptQ/+6aAf
U6sAnjZ200nAlI4cda/kPM4i/TYXq5hK
=8aNZ
-----END PGP SIGNATURE-----

--=-oMDovj8addmTfke09UeK--


--===============5124531724082372909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5124531724082372909==--
