From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Tue, 13 Jul 2010 20:31:54 -0500
Message-ID: <1279071115.29042.0.camel@localhost.localdomain>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1861725150260298922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 6363D243FD
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 03:31:57 +0200 (CEST)
In-Reply-To: <AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
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


--===============1861725150260298922==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tlBjcY5fkxedddbc9ZpL"


--=-tlBjcY5fkxedddbc9ZpL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-07-14 at 09:20 +0800, Raymond Yau wrote:
> 2010/7/14 Chris <cpollock@embarqmail.com>
>=20
> > On Wed, 2010-07-14 at 07:26 +0800, Raymond Yau wrote:
> > > 2010/7/14 Chris <cpollock@embarqmail.com>
> > >
> > > > I want to submit a bug report on the below. This issue was noted in
> > > > Mandriva 2010 and is still present in 2010.1
> > > >
> > > > pulseaudio[24553]: alsa-util.c: snd_pcm_delay() returned a value th=
at
> > is
> > > > exceptionally large: -161920 bytes (-917 ms).
> > > > localhost pulseaudio[24553]: alsa-util.c: Most likely this is a bug=
 in
> > > > the ALSA driver 'snd_ens1371'. Please report this issue to the ALSA
> > > > developers.
> > > >
> > >
> > > This kind of bug report without a full pulseaudio log is almost usele=
ss
> > > without a test case which can reproduce the bug,
> > >
> > >
> > > > localhost pulseaudio[24553]: alsa-util.c: snd_pcm_dump():
> > > > localhost pulseaudio[24553]: alsa-util.c: Hardware PCM card 0 'Enso=
niq
> > > > AudioPCI' device 0 subdevice 0
> > > > localhost pulseaudio[24553]: alsa-util.c: Its setup is:
> > > > localhost pulseaudio[24553]: alsa-util.c:   stream       : PLAYBACK
> > > > localhost pulseaudio[24553]: alsa-util.c:   access       :
> > > > MMAP_INTERLEAVED
> > > > localhost pulseaudio[24553]: alsa-util.c:   format       : S16_LE
> > > > localhost pulseaudio[24553]: alsa-util.c:   subformat    : STD
> > > > localhost pulseaudio[24553]: alsa-util.c:   channels     : 2
> > > > localhost pulseaudio[24553]: alsa-util.c:   rate         : 44100
> > > > localhost pulseaudio[24553]: alsa-util.c:   exact rate   : 44101
> > > > (1445100000/32768)
> > > >
> > >
> > > The ens1371 cannot support exactly 44100
> >
> > Then Raymond, tell me, how do I stop this from happening? It just
> > happens, I'm not playing any audio when it does. For instance
> >
> > Jul 13 17:29:39 localhost pulseaudio[24553]: ratelimit.c: 466 events
> > suppressed
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:44 localhost pulseaudio[24553]: ratelimit.c: 497 events
> > suppressed
> >
> > So, is this a pulseaudio issue or an Alsa issue?
> >
> >
> You need to provide a full pulseaudio log and a test case which can
> reproduce your problem
>=20
> open a new terminal
>=20
> pulseaudio -k ; pulseaudio -vvvvv
Where should I post this Raymond?


--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-tlBjcY5fkxedddbc9ZpL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkw9E4AACgkQ43Kn2pjmcFzdKACeMpV0q/jdfwHJK34TLhnowPvV
K8wAnA7WaQZ0uG0mBsaYz791bts4g4IO
=DhP/
-----END PGP SIGNATURE-----

--=-tlBjcY5fkxedddbc9ZpL--


--===============1861725150260298922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1861725150260298922==--
