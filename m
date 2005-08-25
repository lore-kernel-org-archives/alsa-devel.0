From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Thu, 25 Aug 2005 19:43:07 +0200
Message-ID: <200508251943.10332.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <200508232340.46629.alien999999999@users.sourceforge.net> <430DFC0D.1010502@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15644962.EsvFQAy3WQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <430DFC0D.1010502@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: Manuel Jander <manuel.jander@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart15644962.EsvFQAy3WQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op donderdag 25 augustus 2005 19:12, schreef Raymond:
> Alien wrote:
> > anyway, i really need to do the latest tests, i have way too many adb
> > failures lately.
>
> What do you means when you say "adb failures" ? ( any message in system
> log )

found one:
Aug 22 21:55:45 queen kernel: Vortex: vortex_fifo_setadbctrl fail

after that, i have to restart alsa

but this is only partly the problem, it's only lately that i see that error=
=20
when there are problems, before i never saw anything in logs and it still h=
ad=20
the same problem

there is one thing though, i haven't gotten the error where snd-au8810 has =
210=20
dependencies anymore.

if i now have an error with sound, i only have to kill all appl using alsa,=
=20
and restart alsa (when that dep error was there, i had to reboot to have=20
sound + ps aux crashed the console and lotsa other things, applications usi=
ng=20
alsa had weird statusses etc...)

> > it mostly happens, when watching a movie and gaim starts a little sound.
> >
> > i've determined that it's not likely to be the max available sounds, but
> > more likely to be the weird scheduling of sounds at the same time
> >
> > i urge you people to chat more using some program that starts little
> > sounds so, you have lots of short start and stops at the same time, may=
be
> > use gaim for ICQ and IRCing, that always gives me plenty of sounds...
> >
> > PS: i forgot the latest patch i had to try out.
>
> Don't forget the latest patch "Fixed missing spin_unlock" on CVS .

i'll definately try that one sometime later tonight, it seems it might fit =
the=20
problem

> > I'll do one patch to try out, and hope it doesn't require me to reboot
> > this machine...
> >
> > i'm using alsa CVS from some weeks ago, i think
>
> Although I can play multiple mono sound streams on device 2 on my au8830.
>
> I don't know why the connection routine of device 2 is disabled only on
> au8810 driver.
>
> If you have any application using device 2 to playback (e.g. 3D demo in
> vortexcontrol), wierd things may happen on au8810 since some of the
> route and mixer of device 2 playback stream has not been assigned.

that's odd ...

--nextPart15644962.EsvFQAy3WQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDDgMuuBWKXETrtdcRAnBkAJ9+sdsHCIHUeimwH4uz/U61vB5mxACfX3sp
kreTElQlhUNG17yPAmPsjRo=
=Rnsi
-----END PGP SIGNATURE-----

--nextPart15644962.EsvFQAy3WQ--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
