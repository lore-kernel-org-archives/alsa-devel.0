From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: VIA823x testing
Date: Wed, 29 Jan 2003 00:19:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301290019.55309.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301281425.38097.tais.hansen@osd.dk> <s5hznplkzyh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznplkzyh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 28 January 2003 17:21, Takashi Iwai wrote:
> > > please check the mixer configuration.
> > > there must be any sounds, even though pops/clicks and error message=
s
> > > might come.
> > No sound at all. I've tried turning everything up to full volume,
> > unmuting everything, tried all three onboard minijacks. Not a peep.
> hmm, then it seems something goes wrong completely.
> at least, i see the "invalid CURR_PTR" error at each call.
> it's weird.  did you see this in the log of ogg123?

Yes. Lots of those. I also noticed something else. Seems like there's som=
e=20
kind of overflow in the logging or something. I found a few lines that ha=
s=20
been truncated like these:

Jan 28 17:30:44 proficio kernel: ALSA ../alsa-kernel/pci/via82xx.c:733:=20
invURR_COUNT reg

Jan 28 17:30:46 proficio kernel: ALSA ../alsa-kernel/pcURR_COUNT reg

Jan 28 17:30:46 proficio kernel: ALSA ../alsa-kernel/p3: invalid CURR_COU=
NT=20
reg

I'm guessing that too much output comes too fast, filling some buffer and=
=20
truncating the rest. It's probably syslogd which truncates, but I thought=
 I'd=20
mention it anyway.


> > - From what I can see when playing with ogg123, it's speeding through=
 the
> > ogg-file. It took 4.8s to play 10s ogg-file.
> interesting.
> the new patch will put the timestamp at each interrupt, so you can
> measure the period time between interrupts.
> this shoud be (period-size-in-frames * 4 / sample-rate)

I edited the patch. You inited a timeval tval, but referred to tv->sec an=
d=20
tv->usec. I'm guessing it should have been tval.tv_sec and tval.tv_usec.

> please compare the measured values.

I'm not sure what you mean with 'period-size-in-frames', so I just wrote =
up=20
the numbers here.

8 'period elapsed' from ogg123 test (44100 Hz, 2 ch):

1043795039.736837 idx 0 ptr 0x0
+0.008531 idx+1 ptr+0x1000
1043795039.745368 idx 1 ptr 0x1000
+0.001152 idx+1 ptr+0x1000
1043795039.746520 idx 2 ptr 0x2000
+0.012034 idx+1 ptr+0x1000
1043795039.758554 idx 3 ptr 0x3000
+0.012041 idx+1 ptr+0x1000
1043795039.770595 idx 4 ptr 0x4000
+0.004189 idx+1 ptr+0x1000
1043795039.774784 idx 5 ptr 0x5000
+0.000696 idx+1 ptr+0x1000
1043795039.775480 idx 6 ptr 0x6000
+0.012130 idx+1 ptr+0x1000
1043795039.787610 idx 7 ptr 0x7000

5 'period elapsed' from aplay test (44100 Hz, 2 ch, Signed 16 bit Little=20
Endian) period_size 4410:

1043794327.002204 idx 0 ptr 0x0
+0.012029 idx+5 ptr+0x44e8
1043794327.014233 idx 5 ptr 0x44e8
+0.012031 idx+5 ptr+0x44e8
1043794327.026264 idx 10 ptr 0x89d0
+0.012029 idx+5 ptr+0x44e8
1043794327.038293 idx 15 ptr 0xceb8
+0.012032 idx+6 ptr+0x44e8
1043794327.050325 idx 21 ptr 0x113a0

I'm not sure what to make of this. Sorry.

- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPjcQGIIvLOJqwYc4AQIWzhAAgk2e6Bpelgc539+zXr3tQhOH6DSPlcQ7
c2J1ta1PkKuqY9OH1uvYqxcIbR2wqQ5wdB6y6zaLsD0pdODQr0adtuY4FX+FiiyB
iMpI23E0T8JY21gw09dmn0hrvfFH/0xsW+rFBtIur+1uHYg/eKLdKs6rHo6vng5h
0NgAbiN2Xd9Mx9yZBVTj81VwZm/d7GRFu52xgafhgtRACcLM4bDve4ErouvhleY4
YClGXcZyBhprYMXxKr0Rv/3lSM+iP2bDis/B1lVotVABQRrino5NbM4CCBr7Hrrt
Zl/Ay1tphQ9sBuqrSumvMJ7IA9FMnt/BjAxuN+7VIQjDSGguYde1oWuinYPXTo//
4BoKRu46/5WOuJzi13aJXAI3pa2V+DVEVPOvmHoodTc8UV2mOWlAsVaUjw7I+ipy
e0R2JvDfL4O2F8XDVUsxjwxwkKlm+70CyM4PtNw1kBrkgDONQ6G9HQkIOe/ie4oh
dQR2btvxv273gsrRdz0JSfYDvd8r3uWjPffNsSzxlQk9q9yORgd2KytBkUZvj5bS
WHPC8R9KAjiAnju9cv+yX9n507VsyEAX594ISLK179bADdzrpZActJRIkvNvYSBh
8CXU4ZkQRPFOrGk5AF0MhGuiWHazOOshX7clxTTl9Tlf1iOEODz3nosJbpEre9aJ
pKqcrOVNBSs=3D
=3D6lBB
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
