From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: [Openvortex-dev] Re: [ALSA - driver 0001047]: module hangs at seemingly random times
Date: Sun, 31 Jul 2005 14:38:54 +0200
Message-ID: <200507311438.59443.alien999999999@users.sourceforge.net>
References: <50ce26d334ea87a34d7e9e58d1d69a87@bugtrack.alsa-project.org> <42EC84DE.4050306@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1160399.SkouB7HbUq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42EC84DE.4050306@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: openvortex-dev@nongnu.org
Cc: Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart1160399.SkouB7HbUq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm not too sure, but i _can_ tell you that lastly i had two weird errors=20
about something adb, when snd-au8810 didn't play any sound anymore, i was=20
able to kill all apps who use sound and modprobe -r snd-au8810, and modprob=
e=20
again, and without reboot i was able to get sound working again.

I must say that i haven't been on this PC much and haven't had much time to=
=20
test these things, allthough i'm planning too, (but i think i'll update CVS=
=20
first with these 2 patches who got lost accidentally before i test this. I=
=20
hope i'll get some time this week(end).

thanks for all the help and info concerning snd-au8810 (in 64bit)

AL13N

Op zondag 31 juli 2005 09:59, schreef Raymond:
> If there are 16 instances of aplay playing mono stream.
>
> What error will be returned by snd_pcm_open() for the 17th instance of
> aplay ?
>
>
>
> alsa-kernel/pci/au88x0/au8810.h
>
> #define NR_ADB   0x10
>
> alsa-kernel/pci/au88x0/au8830.h
>
> #define NR_ADB   0x20
>
>
> alsa-kernel/pci/au88x0/au88x0.c
>
> 	if ((err =3D snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {
> 		snd_card_free(card);
> 		return err;
> 	}
>
> bugtrack@alsa-project.org wrote:
> > A NOTE has been added to this issue.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1047>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Reported By:                alien999999999
> > Assigned To:                mjander
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Project:                    ALSA - driver
> > Issue ID:                   1047
> > Category:                   PCI - au88x0
> > Reproducibility:            sometimes
> > Severity:                   block
> > Priority:                   normal
> > Status:                     assigned
> > Distribution:               Mandrake
> > Kernel Version:             2.6.7
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Date Submitted:             04-12-2005 20:43 CEST
> > Last Modified:              04-12-2005 20:51 CEST
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Summary:                    module hangs at seemingly random times
> > Description:
> > sometimes i start playing a song, and it starts playing a few second or
> > so and hangs, then i kill the application and modprobe -r all sound
> > modules and modprobe them again to make it work again.
> >
> > BUT: sometimes not only that happens, but also when i try to kill the
> > apps it will not kill. when that happens, all kill, killall, top, ps aux
> > commands hang at the command line and cannot be killed by CTRL-C or
> > otherwise, i have been able to see that when i stopped my display
> > managener I did an lsmod and it gave something like this:
> >
> > snd-pcm-oss            59752  11
> > snd-mixer-oss          20480  1 snd-pcm-oss
> > snd-au8810             43760  220
> > snd-ac97-codec         83408  1 snd-au8810
> > snd-pcm               108172  112 snd-pcm-oss,snd-au8810,snd-ac97-codec
> > snd-page-alloc         10384  1 snd-pcm
> > gameport                3840  1 snd-au8810
> > snd-mpu401-uart        11904  1 snd-au8810
> >
> >
> > as you can see the snd-au8810 module seem to have an impossible number =
of
> > "dependencies" (i think has to do with the number of unclosed sound-apps
> > trying to be played; this could be since gaim is programmed to execute =
an
> > 'aplay %s')
> >
> > i've had this major crash below only 3 times; and the logs didn't detect
> > anything specific at the time. the only thing the logs mentioned at that
> > time was an ntpd sync going on; so the only thing i can think of is that
> > at a certain moment when a sync is going on, some kind of lock is holdi=
ng
> > cause this to happen... the only thing that i can do to fix this is
> > reset...
> >
> > it is interesting to note that i also have an snd-emu10k1 as second car=
d,
> > which never gave problems like this, and i am always able to "modprobe =
=2Dr
> > snd-emu10k1" ...
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > ----------------------------------------------------------------------
> >  alien999999999 - 04-12-05 20:48
> > ----------------------------------------------------------------------
> > i forgot to note that i have the mdk 10.1 x86_64 distro and my version
> > has a few 64bit fixes to get past kernel hangs and kernel oopses
> >
> > ----------------------------------------------------------------------
> >  alien999999999 - 04-12-05 20:51
> > ----------------------------------------------------------------------
> > i have attached the changed files (since i don't have a CVS version of
> > alsa to diff against)
> >
> > these files are located in the alsa-driver-1.0.8/alsa-kernel/pci/au88x0/
> > path
> >
> > Issue History
> > Date Modified  Username       Field                    Change
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 04-12-05 20:43 alien999999999 New Issue
> > 04-12-05 20:43 alien999999999 Distribution              =3D> Mandrake
> > 04-12-05 20:43 alien999999999 Kernel Version            =3D> 2.6.7
> > 04-12-05 20:48 alien999999999 Note Added: 0004461
> > 04-12-05 20:49 alien999999999 File Added: au88x0.c
> > 04-12-05 20:49 alien999999999 File Added: au88x0.h
> > 04-12-05 20:50 alien999999999 File Added: au88x0_core.c
> > 04-12-05 20:50 alien999999999 File Added: au88x0_mixer.c
> > 04-12-05 20:51 alien999999999 Note Added: 0004462
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> _______________________________________________
> Openvortex-dev mailing list
> Openvortex-dev@nongnu.org
> http://lists.nongnu.org/mailman/listinfo/openvortex-dev

--nextPart1160399.SkouB7HbUq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC7MZjuBWKXETrtdcRAt2YAKDgVSwwgvNSa+Q5LiE/7JUqYSxtQQCff4Z4
86DxSSifIWsK4+eRy+oDkZI=
=jEEC
-----END PGP SIGNATURE-----

--nextPart1160399.SkouB7HbUq--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
