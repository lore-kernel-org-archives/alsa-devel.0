From: Hod McWuff <hod@wuff.dhs.org>
Subject: Re: Playback studders
Date: 20 Mar 2002 16:57:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1016661474.1448.10.camel@samoyed.wuff.dhs.org>
References: <E16neoC-0000o5-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-TR2Uz7m0O5po7kxOSFUR"
In-Reply-To: <E16neoC-0000o5-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-TR2Uz7m0O5po7kxOSFUR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


I've got a few different ones: emu10k1 on a 1G P3, ymfpci on a P4, that
Maestro on a couple of Dell laptops, and a gaggle of crappier P3's with
ens1371's and i810_audio's.=20

They all work fine now, but I had a bitchin' time getting them that way.
Hadn't noticed the hdparm thing, but I had that set up right from the
getgo anyway.

I've found with sched(O1), rmap (possibly irrelevant), preempt,
lockbreak, and the IDE patch, I can whale the tar out of it. Random app
loads, 5-6 OpenGL screen saver windows, kernel build + kernel rpm
rebuild + XFree rebuild, keep going... I have yet to cause a single skip
on either the P3 or P4 with that combination.

This does argue that the long-held kernel locks are the problem.
Scheduling efficiency would seem to make up for that somewhat.

On Wed, 2002-03-20 at 07:03, alsa-devel-request@lists.sourceforge.net
wrote:

>=20
> Message: 2
> Date: Tue, 19 Mar 2002 12:48:08 -0800
> From: Christian Lambert <clambert@sgi.com>
> To: alsa-user@alsa-project.org
> cc: alsa-devel@alsa-project.org
> Subject: [Alsa-devel] Re: Playback stutters
>=20
>=20
> I am also having this problem with both my ensoniq es1371 and my
> audiophile 2496 with kernel 2.4.18 and alsa 0.9beta12.  It seems
> to be way worse in mplayer and also when playing tribes2 where it
> just constanly shutters.    I have an es1371 at work where I installed
> the same version of alsa but there it's working fine with the game,
> the difference is that I'm running kernel 2.4.8 so I'm wondering if
> something broke in kernel 2.4.18 that causes this?
>=20
> I would really like to be able to get this running stable at home.
> My machine config at work and home is almost identical in both
> hardware and software except for the kernel version.
>=20
> Each soundcard have their own IRQ so I'm pretty sure the hardware
> I have at home is ok.  With OSS/free and OSS/commercial the sound is fine
> so it's something between alsa and kernel 2.4.18.
>=20
> When I was listening to music in xmms, if I move windows around or
> just click buttons in netcape for example it seems to shutters everytime
> I do that.
>=20
> Anybody else seeing this?
>=20
> > Hey,
> >
> > audio playback stutters on my system. All playback programms I have tes=
ted
> > have this problem (with and without artsd). I use alsa driver 0.9.0beta=
12.
> > The soundcard is a no-name ALS4000 soundcard. My system: Linux 2.4.18,
> > Debian testing, Dual Athlon, Tyan S2460. I have read that often IRQ
> > problems cause those kind of problems, but I already tried to disable a=
s
> > much as possible hardware to free up interrups. I also changed the orde=
r of
> > the PCI cards and I tried it with and without MP Interrupts.
> > The playback stutters if e.g. I drag around windows or a programm start=
s
> > (even if the load is very low). It doesn't stutter if I do heavy
> > calcualtion (like running kfract multiple times) and the load is above =
4.
> > What else should I try to narrow down the problem?
> >
> > regards,
> > Roland Schulz
>=20
>=20
>=20
>=20
> Message: 7
> Date: Wed, 20 Mar 2002 15:05:03 +1100
> From: Zenaan Harkness <zen@getsystems.com>
> To: alsa-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Subject: [Alsa-devel] Re: Playback stutters
>=20
> I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
> 3i), my test is:
>=20
> copy a cd image file from one partition to another, while trying to play
> an mp3 using mpg123.
>=20
> The mp3 skips all over the place.
>=20
> I haven't applied any alsa patches yet - just been trying to set up this
> laptop since I got it at work a week ago. At first I thought it was the
> loop driver - I'd been loopback mounting my cd image, but that's not the
> case.
>=20
> I've tried:
>  - low latency patch against 2.4.18
>  - preempt + lockbreak patches against 2.4.18
>  - preempt patch against 2.4.19-pre3-ac3 (lockbreak doesn't apply)
>=20
> all have same problem. Since I've only recently tried setting up this
> laptop, I don't know whether or not an earlier kernel works or not. Does
> anyone know the earliest kernel that works for them without skipping, whe=
n
> copying a large file, etc?
>=20
> thanks
> zen
>=20
>=20
> ---
> I am also having this problem with both my ensoniq es1371 and my
> audiophile 2496 with kernel 2.4.18 and alsa 0.9beta12.  It seems
> to be way worse in mplayer and also when playing tribes2 where it
> just constanly shutters.    I have an es1371 at work where I installed
> the same version of alsa but there it's working fine with the game,
> the difference is that I'm running kernel 2.4.8 so I'm wondering if
> something broke in kernel 2.4.18 that causes this?
>=20
> I would really like to be able to get this running stable at home.
> My machine config at work and home is almost identical in both
> hardware and software except for the kernel version.
>=20
> Each soundcard have their own IRQ so I'm pretty sure the hardware
> I have at home is ok.  With OSS/free and OSS/commercial the sound is fine
> so it's something between alsa and kernel 2.4.18.
>=20
> When I was listening to music in xmms, if I move windows around or
> just click buttons in netcape for example it seems to shutters everytime
> I do that.
>=20
> Anybody else seeing this?
>=20
> > Hey,
> >
> > audio playback stutters on my system. All playback programms I have tes=
ted
> > have this problem (with and without artsd). I use alsa driver 0.9.0beta=
12.
> > The soundcard is a no-name ALS4000 soundcard. My system: Linux 2.4.18,
> > Debian testing, Dual Athlon, Tyan S2460. I have read that often IRQ
> > problems cause those kind of problems, but I already tried to disable a=
s
> > much as possible hardware to free up interrups. I also changed the orde=
r of
> > the PCI cards and I tried it with and without MP Interrupts.
> > The playback stutters if e.g. I drag around windows or a programm start=
s
> > (even if the load is very low). It doesn't stutter if I do heavy
> > calcualtion (like running kfract multiple times) and the load is above =
4.
> > What else should I try to narrow down the problem?
> >
> > regards,
> > Roland Schulz
>=20
>=20
>=20
>=20
> --__--__--
>=20
> Message: 8
> Date: Wed, 20 Mar 2002 15:08:18 +1100
> From: Zenaan Harkness <zen@getsystems.com>
> To: alsa-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Subject: [Alsa-devel] Re: Playback stutters
>=20
> Please CC me:
>=20
> zen@getsystems.com
>=20
> ta
> zen
>=20
>=20
> On Wed, Mar 20, 2002 at 03:05:03PM +1100, Zenaan Harkness wrote:
> > I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
> > 3i), my test is:
>=20
>=20
> --__--__--
>=20
> Message: 9
> To: Zenaan Harkness <zen@getsystems.com>
> cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
> Subject: Re: [Alsa-devel] Re: Playback stutters=20
> Date: Tue, 19 Mar 2002 23:15:12 -0500
> From: Paul Davis <pbd@Op.Net>
>=20
> >I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
> >3i), my test is:
> >
> >copy a cd image file from one partition to another, while trying to play
> >an mp3 using mpg123.
> >
> >The mp3 skips all over the place.
>=20
> since you almost certainly have IDE drivers, have you configured them
> correctly using hdparm? these are source of considerable scheduling
> latency, in ways that AFAIK are not improved by any of the "latency
> reducing" patches available. don't ask me how to configure them - i
> only use SCSI drives - but a quick google search should reveal
> relevant advice.
>=20
> --p
>=20
>=20
> --__--__--
>=20
> Message: 10
> Date: Wed, 20 Mar 2002 16:32:15 +1100
> From: Zenaan Harkness <zen@getsystems.com>
> To: Paul Davis <pbd@Op.Net>
> Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
> Subject: Re: [Alsa-devel] Re: Playback stutters
>=20
> On Tue, Mar 19, 2002 at 11:15:12PM -0500, Paul Davis wrote:
> > >I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
> > >3i), my test is:
> > >
> > >copy a cd image file from one partition to another, while trying to pl=
ay
> > >an mp3 using mpg123.
> > >
> > >The mp3 skips all over the place.
> >=20
> > since you almost certainly have IDE drivers, have you configured them
> > correctly using hdparm? these are source of considerable scheduling
> > latency, in ways that AFAIK are not improved by any of the "latency
> > reducing" patches available. don't ask me how to configure them - i
> > only use SCSI drives - but a quick google search should reveal
> > relevant advice.
>=20
> thanks
>=20
> hdparm improves the situation, but I still get some (minimal) skips now:
>=20
> zen8100a:~# hdparm /dev/hda
>=20
> /dev/hda:
>  multcount    =3D 16 (on)
>  I/O support  =3D  1 (32-bit)
>  unmaskirq    =3D  1 (on)
>  using_dma    =3D  1 (on)
>  keepsettings =3D  0 (off)
>  nowerr       =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D  8 (on)
>  geometry     =3D 7296/255/63, sectors =3D 117210240, start =3D 0
>  busstate     =3D  1 (on)
>=20
>=20
> My current 'test':
>  - playing an mp3
>  - running make clean && make bzImage
>  - copying a cd image between two partitions
>  - loading up the odd application (eg. mozilla)
>=20
> With hdparm settings I've tried:
>  - 2.4.18 + preempt + lockbreak
>  - 2.4.18 + lowlatency
>  - 2.4.19-pre3-ac3 + preempt
>=20
> These seem to all give the same minimal skips with above activities.
>=20
> No skips with only the kernel compile (not doing the large copy).
>=20
> ta
> zen
>=20
>=20
> --__--__--
>=20
> Message: 11
> Date: Wed, 20 Mar 2002 16:48:38 +1100
> From: Zenaan Harkness <zen@getsystems.com>
> To: Paul Davis <pbd@Op.Net>
> Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
> Subject: Re: [Alsa-devel] Re: Playback stutters - Correction
>=20
> On Wed, Mar 20, 2002 at 04:32:15PM +1100, Zenaan Harkness wrote:
> > On Tue, Mar 19, 2002 at 11:15:12PM -0500, Paul Davis wrote:
> > > >I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maest=
ro
> > > >3i), my test is:
> > > >
> > > >copy a cd image file from one partition to another, while trying to =
play
> > > >an mp3 using mpg123.
> > > >
> > > >The mp3 skips all over the place.
> > >=20
> > > since you almost certainly have IDE drivers, have you configured them
> > > correctly using hdparm? these are source of considerable scheduling
> > > latency, in ways that AFAIK are not improved by any of the "latency
> > > reducing" patches available. don't ask me how to configure them - i
> > > only use SCSI drives - but a quick google search should reveal
> > > relevant advice.
> >=20
> > thanks
> >=20
> > hdparm improves the situation, but I still get some (minimal) skips now=
:
> >=20
> > zen8100a:~# hdparm /dev/hda
> >=20
> > /dev/hda:
> >  multcount    =3D 16 (on)
> >  I/O support  =3D  1 (32-bit)
> >  unmaskirq    =3D  1 (on)
> >  using_dma    =3D  1 (on)
> >  keepsettings =3D  0 (off)
> >  nowerr       =3D  0 (off)
> >  readonly     =3D  0 (off)
> >  readahead    =3D  8 (on)
> >  geometry     =3D 7296/255/63, sectors =3D 117210240, start =3D 0
> >  busstate     =3D  1 (on)
> >=20
> >=20
> > My current 'test':
> >  - playing an mp3
> >  - running make clean && make bzImage
> >  - copying a cd image between two partitions
> >  - loading up the odd application (eg. mozilla)
> >=20
> > With hdparm settings I've tried:
> >  - 2.4.18 + preempt + lockbreak
> >  - 2.4.18 + lowlatency
> >  - 2.4.19-pre3-ac3 + preempt
> >=20
> > These seem to all give the same minimal skips with above activities.
> >=20
> > No skips with only the kernel compile (not doing the large copy).
>=20
> CORRECTION:
> Just retested with full hdparm (added -u setting) settings on
> 2.4.19-pre3-ac+preempt, and no skipping with above activities. This
> seems pretty good.
>=20
> I could generate skips when switching from X to text console. Could not
> generate skip when cycling virtual desktops within X (at high key repeat
> rate). Again this seems pretty good.
>=20
> thanks
> zen
>=20
>=20


--=-TR2Uz7m0O5po7kxOSFUR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8mQXhCcSqvpnxLx8RAnz9AJsF59fJ0Znamv9/3vO+ZrCetQJzHQCgg1I8
DyojhG3w8oGWAhFsbKdnpPw=
=bsHp
-----END PGP SIGNATURE-----

--=-TR2Uz7m0O5po7kxOSFUR--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
