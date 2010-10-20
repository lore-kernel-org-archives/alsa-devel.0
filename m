From: "Juliano F. Ravasi" <ml@juliano.info>
Subject: hda-intel (ALC889) - sound loops/repeats continuously,
 and general brokenness
Date: Wed, 20 Oct 2010 17:40:48 -0200
Message-ID: <4CBF45C0.5060903@juliano.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 Hello ALSA devs,

(Cc'ing alsa-devel since looks like it can be a driver problem/bug, but
still unsure. Need some expert advice.)

I'm experiencing a lot of problems reproducing audio with an HD Audio
"card" integrated on an Intel DX58SO mainboard. It happens only on this
card, everything is Ok with another (USB) card.

The most visible problem is that `aplay` plays only a small fragment of
audio (less than one second), then hangs and the card keeps reproducing
that fragment continuously in a loop, until killed with Ctrl-C. `aplay
-N` progresses, but each fragment repeats 3 times.

Doing an strace on `aplay`, it hangs here while repeating the audio
fragment:

...
semop(294912, {{0, 0, 0}, {0, 1, SEM_UNDO}}, 2) =3D 0
semop(294912, {{0, -1, SEM_UNDO|IPC_NOWAIT}}, 1) =3D 0
ioctl(4, 0x4122, 0x3)                   =3D 0
ioctl(4, 0x4122, 0)                     =3D 0
ioctl(4, 0x4122, 0xe4)                  =3D 0
poll([{fd=3D3, events=3DPOLLIN|POLLERR|POLLNVAL}], 1, -1) =3D 1 ([{fd=3D3,
revents=3DPOLLIN}])
ioctl(4, 0x4122, 0x3)                   =3D 0
ioctl(4, 0x4122, 0xe4)                  =3D 0
ioctl(4, 0x4122, 0x1)                   =3D 0
read(3,
"\6\0\0\0\1\210\377\377\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\210\377\3=
77"...,
128) =3D 64
read(3, 0x7fff890f6810, 128)            =3D -1 EAGAIN (Resource
temporarily unavailable)
poll([{fd=3D3, events=3DPOLLIN|POLLERR|POLLNVAL}], 1, -1^C <unfinished ...>

Descriptor 3 is /dev/snd/timer ... Perhaps time stops progressing for
the driver? `aplay -N` continues a little here because this poll() call
timeouts after 1000ms, but this still repeats each fragment 3 times.

Other audio software (mplayer, amarok) can play audio almost normally,
except when you pause. When paused, the same behavior happens: the last
fragment of sound before pausing keeps repeating continuously until
unpaused.

When the song finishes, the application (tested with mplayer) also
hangs, the last fragment keeps repeating while the process is blocked here:

ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig -icanon -echo
...}) =3D 0
ioctl(0, SNDCTL_TMR_START or TCSETS, {B38400 opost isig icanon echo
...}) =3D 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo
...}) =3D 0
ioctl(6, 0x4144^C <unfinished ...>

Descriptor 6 is /dev/snd/pcmC0D0p , and 0x4144 is SNDRV_PCM_IOCTL_DRAIN
ioctl in sound/asound.h. Sometimes mplayer timeouts and reports:

[AO_ALSA] alsa-lib: pcm_hw.c:616:(snd_pcm_hw_drain)
SNDRV_PCM_IOCTL_DRAIN failed (-5): Input/output error

I'm at a loss here. I have already read the sound/alsa/HD-Audio.txt and
tried many of the tweaks described there, but with no luck.

Any help is greatly appreciated.


System information:
http://www.alsa-project.org/db/?f=3D4ab249b0f301ff20260d7388432e624aa65092d6


Best regards,
Juliano.

-- =

Juliano F. Ravasi =B7=B7 http://juliano.info/
5105 46CC B2B7 F0CD 5F47 E740 72CA 54F4 DF37 9E96


---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
