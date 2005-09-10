From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Sat, 10 Sep 2005 09:03:47 +0200
Message-ID: <200509100903.50069.alien999999999@users.sourceforge.net>
References: <4317CC51.3040709@netvigator.com> <44272.62.59.249.250.1126163238.squirrel@62.59.249.250> <43222B74.1020602@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1424448.hVRNcnIbCp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43222B74.1020602@netvigator.com>
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
Cc: alsa-devel@lists.sourceforge.net, Erik <assie2@zonnet.nl>
List-Id: alsa-devel@alsa-project.org

--nextPart1424448.hVRNcnIbCp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op zaterdag 10 september 2005 02:40, schreef Raymond:
> When watching movie using xine (downmixing 5.1 to Surround40) with my
> au8830 on 32bits machines, the 4 channels are correct at first movie
> only. The Human voice (center) come out from rear speakers aftewards.
>
> 1) speaker-test -c 4 -D hw:0,0
> 2) using xine to play 5.1 channel-test audio samples with FFTScope enable=
d.

isn't it possible that xine swaps the channels? this kind of test should be=
=20
conducted with the same tools...

> the above tests indicate that the front and rear channels are swapped
> after the first play.
>
> Please let me know if you also have this problem on your MX300.
>
> The hardware equalizer of au8830 sound much better than the software
> equalizer of XMMS.
>
> There are follow up about how to fix 32/64bits issues related to the
> equalizer and features not presented in au8820.
>
> http://sourceforge.net/mailarchive/message.php?msg_id=3D11997399
>
> alien seem have no interest to test the hardware equalizer
> because of the hang oops.

I finally recompiled the kernel, cause i had a power failure...

the latest thing is in place and so far i haven't had any weird hangs or=20
crashes (yet),... right now, it's time to play alot of things and see what=
=20
happens...

I'm not really interested in a hardware equalizer, just like that, it's got=
=20
nothing to do with the hang problems (which are NOT kernel oopses, btw) (or=
=20
not anymore, at least)

we'll see if we get that adb failure again, i've let it print=20
in /var/log/messages, so, we'll see if its solved or not...

do you want me to test out the hardware equalizer? i'm not using 4.0 btw...

> Alien wrote:
> >>i'm busy with home improving but when i have time i will try the patch
> >>again on 2.6.12 kernel. I have not checked if it is the same alsa
> >>version as 2.6.11 but i think it is.
> >>
> >>b.t.w. the volume bar problem is in XMMS (didn't try other programs
> >>because i haven't a lot of time) (just online for mail checking etc.
> >>that's it)
> >>but i think alien can tell you about the volume bar problems.
> >
> > which volume bar problems are you talking about?
> > 1. the ones where if you get 49% it's loud and on 51% quite silently?
>
> This problem on STAC9704 have been fixed.
>
> > 2. or irregular sound volume when you are about halfway (without changi=
ng
> > volume yourself).
> >
> > actually after experimenting I think it might be something hardware
> > related (ie with the volume control of my speaker system, not the
> > au8810)...
> >
> >>pc information:
> >>
> >>mandriva 2005 le
> >>kernel 2.6.11
> >>amd 64 bit 3500+
> >>diamond monster sound mx300 au8830 card
> >>
> >>
> >>Erik

--nextPart1424448.hVRNcnIbCp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDIoVWuBWKXETrtdcRAscwAKDfMtv17X4DFTeL0v2vzVSTU7WdWACgyMgG
5ACaE0S1nPimx8xIhKysXb8=
=cXMe
-----END PGP SIGNATURE-----

--nextPart1424448.hVRNcnIbCp--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
