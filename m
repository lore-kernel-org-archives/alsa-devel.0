From: "Richard Lemon" <richard@clinicdesign.com.au>
Subject: RE: nforce2 (snd_intel8x0) channels scrolling
Date: Tue, 11 Nov 2003 09:44:30 +1030
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <ACB58D7EB1318947B319C01D1A5C38634B6B3E@neo.spud.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi All,

This is one of the problems I have been seeing with the intel8x0 driver =
as well. The problem occurs when you call snd_pcm_start a second time =
after an xrun, or after you have shut down a program with ctl-c and =
started it again in the same console. I used the=20

If you close the console and open a new one the problem seems to go =
away!? I used the example code pcm.c from the alsa-lib test directory.

It occurs with both [nforce2 ALC650] combo and [Intel 82901EB-ICH5 =
Analog devices id 75].

I also have a problem when the drivers have been running for a long time =
(around 5 hours). Without an xrun the snd_pcm_delay() function starts =
returning impossible numbers. Checking drift against either rdtsc or =
gettimeofday() alsa starts giving me a 0.1 second per second drift.

I haven't got a machine I can set up for this style of kernel debugging =
unfortunately, so I am trying to code around these problems.

richard.


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Tuesday, 11 November 2003 4:37 AM
To: Vladimir I. Umnov
Cc: James Courtier-Dutton; alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] nforce2 (snd_intel8x0) channels scrolling


At Sun, 9 Nov 2003 20:37:15 +0300,
Vladimir I. Umnov wrote:
>=20
> On Sun, 09 Nov 2003 15:25:25 +0000
> James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
>=20
> > Vladimir I. Umnov wrote:
> > > Hw: a7n8x deluxe 2.0 (nforce2-c1 + MCP-T)
> > > Sw: 2.6.0-test8, alsa-lib from cvs
> > > lspci:
> > > 00:05.0 Multimedia audio controller: nVidia Corporation: Unknown
> > > device 006b (rev a2)        Subsystem: Asustek Computer, Inc.:
> > > Unknown device 0c11        Flags: bus master, 66Mhz, fast devsel,
> > > latency 0, IRQ 5
> > >         Memory at d7000000 (32-bit, non-prefetchable) =
[size=3D512K]
> > >         Capabilities: [44] Power Management version 2
> > >=20
> > > 00:06.0 Multimedia audio controller: nVidia Corporation: Unknown
> > > device 006a (rev a1)        Subsystem: Asustek Computer, Inc.:
> > > Unknown device 8095        Flags: bus master, 66Mhz, fast devsel,
> > > latency 0, IRQ 11
> > >         I/O ports at e400 [size=3D256]
> > >         I/O ports at d000 [size=3D128]
> > >         Memory at d7087000 (32-bit, non-prefetchable) [size=3D4K]
> > >         Capabilities: [44] Power Management version 2
> > >=20
> > > Mplayer and xine used for testing in 6channels mode.
> > > Channels mapping stays wrong after:
> > > 1) snd_pcm_drop() called (seeking and quit);
> > > 2) after long time of playing in 6channels mode, even without =
x-run.
> > >=20
> > > p.s. My sblive works very well now, but my friends doesn't have
> > > sblive and they want working 6channels audio under linux on =
nforce2.
> > >=20
> > > p.p.s. I may help with testing or finding a bug, but I need help. =
I
> > > new to alsa-driver and can't understand how it works, and can't =
find
> > > how snd_pcm_drop() implemented in i810 module.
> > >=20
> > >=20
> > Here is a simple speaker test program.
> > I nicely tests different speaker layout modes.
> >=20
> > Read the readme.txt file that is with it on how to use it.
> > If you still get the problem with this simple program, it is =
certainly
> > a bug in alsa.
> After channels scrolled (after a few seek in mplayer, then quit),
> ./speaker_test-Dsurround51-c 6 works wrong (Center->Front Left,
> LFE->Front Right, ...).
> But after I use "front" device and then repeat test with 6 channels
> setup, channel mapping is ok.
> If i press ctrl+c with 6channels test and then repeat it
> (snd_pcm_drop()) scrool is apear, and after i run 3 times, channels
> mapping is ok.
>=20
> With sblive all works perfectly!!! This is alsa-driver bug.

try to change the mapping of surround51 device in
/usr/share/alsa/cards/NFORCE.conf.


Takashi


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
