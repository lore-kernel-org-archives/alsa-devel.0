From: John Rigg <j@sound-man.co.uk>
Subject: Re: Some problems with two 1010LTs (pcm_multi & jackd)
Date: Thu, 26 Jan 2006 18:48:43 +0000
Message-ID: <20060126184843.GA3747@localhost.localdomain>
References: <43D8D6E9.80902@findus.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C40C518E
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 19:37:39 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <43D8D6E9.80902@findus.dhs.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Petter =?iso-8859-1?Q?Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 26, 2006 at 03:04:25PM +0100, Petter Sundl=F6f wrote:
> Hello.
>=20
> I've added a second 1010LT in my studio box. The two LTs are card1 and=20
> card2.
> Following the steps from=20
> http://www.sound-man.co.uk/linuxaudio/ice1712multi.html I created the=20
> .asoundrc (and modified it to hw:1 and 2 where appropriate. I have=20
> attached this file.
> I then proceeded to patch jack 0.100.7 (release tarball) with the=20
> MMAP_COMPLEX patch. This was installed to the /usr/ prefix.
>=20
> I then downloaded alsa-lib-1.0.10 (release) and applied pcm_multi-patch=
.=20
> I installed this over the existing alsa-lib, into prefix /usr/lib.
>=20
> After this I tried to run jackd -d alsa -r44100 -p512 -C multi_capture=20
> -P multi_playback
>=20
> I then get this stdout message:
>=20
> jackd 0.100.7
> Copyright 2001-2005 Paul Davis and others.
> jackd comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
>=20
> JACK compiled with System V SHM support.
> loading driver ..
> creating alsa driver ...=20
> multi_playback|multi_capture|1024|2|48000|0|0|nomon|swmeter|-|32bit
> configuring for 48000Hz, period =3D 1024 frames, buffer =3D 2 periods
> nperiods =3D 2 for capture
> nperiods =3D 2 for playback

It's starting with the wrong sample rate and number of frames, but using
the right devices. That's strange.
You say you installed alsa-lib over an existing one. Are you sure you rep=
laced
it?

> I then start Ardour and open a session. I place the playhead somewhere=20
> and try to start playback. Nothing happens. After a few seconds, Ardour=
=20
> is disconnected from JACK, and I receive this in jackd's stdout:
>=20
> ALSA: poll time out, polled for 17416024 usecs

This is the error message I kept getting before I patched pcm_multi.c.

It might be worth removing alsa-lib and jack completely and
recompiling/reinstalling.

> DRIVER NT: could not run driver cycle
> jack main caught signal 12
> no message buffer overruns
>=20
> Clues?
>=20
> Info: Kernel 2.6.14-0.10.rrt.rhfc4.ccrma #1 PREEMPT
> Cards are not connected via S/PDIF or World clock -- don't have any suc=
h=20
> cables, and besides, I read it isn't working _yet_ with LT cards.

You won't be able to record for long like this. It will run for a while,
as the clocks are pretty accurate, but they will drift and you'll get
xruns and/or jackd will die.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
