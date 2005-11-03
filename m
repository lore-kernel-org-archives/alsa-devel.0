From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: asym plugin in asoundrc causes "poll time out" errors in jackd
Date: Thu, 3 Nov 2005 18:12:29 +0200
Message-ID: <20051103161229.GB10146@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi list!

I've already sent this mail to jackd mailing list, but didn't got any
helpful replies.. so I'm trying if somebody knows more about asym stuff
here.

I'm trying to run jackd with multi + asym plugins in ~/.asoundrc, but I g=
et
"ALSA: poll time out, polled for 17407547 usecs" messages all the time fr=
om
jackd..

.asounrdc available here:
http://nrg.joroinen.fi/asoundrc-asym.txt

Ok.. you might ask why I need multi + asym plugins? Well.. the whole poin=
t
is to combine two ice1712 cards (M-Audio Delta 1010LT's) for use in studi=
o
multichannel recording. Therefore "multi" plugin is needed to combine the
channels and to create one virtual "jackmulti" device which jackd can use=
.

One virtual combined device is needed because jackd supports only one
card/device.

In these tests I haven't (yet) combined the cards, so this problem happen=
s
with one/single ice1712 card!

Now, these ice1712 cards have 12 channels in, and 10 channels out.
Asymmetric channel count. Jackd won't start with this kind of asymmetric
"jackmulti" device. Therefore I use "asym" plugin to create "duplex" devi=
ce,
which has symmetric channel count in and out.

Jackd starts fine with this multi+asym "jackmulti" device.

The problem is this:

$ jackd -d alsa -d jackmulti -r 44100 -p 512
jackd 0.100.0
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate =3D 44100
creating alsa driver ...
jackmulti|jackmulti|512|2|44100|0|0|nomon|swmeter|-|32bit
configuring for 44100Hz, period =3D 512 frames, buffer =3D 2 periods
nperiods =3D 2 for capture
nperiods =3D 2 for playback
ALSA: poll time out, polled for 17407870 usecs
ALSA: poll time out, polled for 17407477 usecs
....


Those "poll time out" messages are printed all the time, even if I don't
start any jack clients!

If I start jackd with -P or -C parameter, it will work OK and I don't get
those poll time outs! (And audio can be played normally etc).

I'm running Debian unstable, with 2.6.14-1-686-smp kernel. The same probl=
em
was with 2.6.12-1-686-smp kernel.

I have patched/recompiled debian jackd packege with MMAP_COMPLEX
support/patch.

Any comments/ideas very welcome.. I'm willing to debug and work on this.=20

-- Pasi K=E4rkk=E4inen
      =20
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
