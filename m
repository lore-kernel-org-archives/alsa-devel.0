From: noreply@alsa-project.org
Subject: [ALSA - lib 0000116]: alsalib raises assertion
Date: Wed, 9 Jun 2004 20:04:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <d4c84f4bb208eb975667c94b853799ee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0116
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Benjamin Otte
Assigned To:                perex
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - lib
Bug ID:                     116
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             03-04-2004 15:30 CET
Last Modified:              06-09-2004 20:04 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    alsalib raises assertion
Description:=20
I'm reproducing this from
http://bugzilla.gnome.org/show_bug.cgi?id=3D134007
I'm not able to reproduce this myself as I don't have a broken soundcard.
You might want to contact the reporter of the Gnome bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 perex - 03-05-2004 12:43 CET=20
----------------------------------------------------------------------
It seems like a complicated bug to me. Can you determine the used
hardware?
Perhaps, the user should communicate with us using this bug-tracking
system.

I need to know the hardware and configuration which is passed to
snd_pcm_hw_params() function (see snd_pcm_dump() and other functions whic=
h
can
print the actual configuration).

Also, you may use the snd-dummy driver to emulate any kind of hardware to
catch this sort of bugs (see alsa-kernel/drivers/dummy.c).

Also, 1.0.3 code contains some fixes regarding the sample rate
conversions,
so this bug might be already fixed.

----------------------------------------------------------------------
 tiwai - 03-05-2004 19:44 CET=20
----------------------------------------------------------------------
does it happen with 1.0.3?

----------------------------------------------------------------------
 perex - 03-23-2004 15:52 CET=20
----------------------------------------------------------------------
No direct contact with original reporter.

----------------------------------------------------------------------
 joshuadf - 04-16-2004 04:24 CEST=20
----------------------------------------------------------------------
Reminder sent to perex

I can reproduce this Bug 000116 with Fedora Core 2test2, alsa-lib-1.0.3a-=
1
RPM. I was referred here by Colin Walters:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D119958

This is using the builtin sound on an ASUS A7N266-VM/AA,
nvidia nforce chipset, standard snd_intel8x0 driver. (I'm not using the
funky nforce surround-sound features.)

I'm using gstreamer-0.8.0-4.=20

$ gst-launch filesrc location=3Dmusic.mp3 ! mad ! alsasink
RUNNING pipeline ...
gst-launch-0.8: pcm_plug.c:882: snd_pcm_plug_hw_params: Assertion `err >=3D
0' failed.
Aborted
$

----------------------------------------------------------------------
 Benjamin Otte - 04-19-2004 13:06 CEST=20
----------------------------------------------------------------------
I guess this should be reopened when someone can still reproduce it :)

----------------------------------------------------------------------
 perex - 04-19-2004 15:27 CEST=20
----------------------------------------------------------------------
Ok, apply plug-hw-param.patch . It removes asserts, but does not solve
bug.
If it's error (the passed hardware parameters should be accepted), please=
,
send me
output from 'snd_pcm_dump()' for the failing parameters to reproduce bug
here. Thanks.

----------------------------------------------------------------------
 noaq - 04-19-2004 21:29 CEST=20
----------------------------------------------------------------------
I also see this problem. This is my hardware, according to /sbin/lspci
-vvv

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: Asustek Computer, Inc. A7V8X Motherboard (Realtek
ALC650 codec)

I'm not entirely sure about how to determine what version of the alsa
driver that is included in the redhat development kernel that I run, but
the alsa-utils package is version 1.0.3 and I suppose that the in-kernel
code is very close to the canonical kernel.org kernel. When trying the
command=20

"gst-launch-0.8 filesrc location=3D"/usr/share/sounds/startup3.wav" !
wavparse ! alsasink"

i get a back-trace very similiar to the one above.

----------------------------------------------------------------------
 sxpert - 04-20-2004 00:30 CEST=20
----------------------------------------------------------------------
I have this bug using the following config
alsa from gentoo 2.6.5-gentoo-r1 kernel
alsalib from gentoo 1.0.3b-r2
using snd-usb-audio driver (Creative Sound Blaster MP3+ usb)

----------------------------------------------------------------------
 noaq - 04-25-2004 12:03 CEST=20
----------------------------------------------------------------------
I'm not entirely sure about what you mean, but I have recompiled alsa-lib
with the patch above and modified the alsa gstreamer plugin to print the
return value from
 snd_pcm_hw_params. It is -22.

I have also added the following after the failing call:

        snd_output_t *debug_out;
        snd_output_stdio_open(&debug_out, "/tmp/alsa-debug.out", "a");
        snd_pcm_dump(this->handle, debug_out);

and the resulting contents of /tmp/alsa-debug.out is this:

Plug PCM: Hardware PCM card 0 'VIA 8235' device 0 subdevice 0

Is there anything else that I can do to help?

----------------------------------------------------------------------
 perex - 04-25-2004 12:09 CEST=20
----------------------------------------------------------------------
Thanks. We are close. Please, use snd_pcm_hw_params_dump(hw_params, out)
call before snd_pcm_hw_params() call in gstreamer code. I need to know
the asking configuration.

----------------------------------------------------------------------
 noaq - 04-25-2004 12:15 CEST=20
----------------------------------------------------------------------
snd_pcm_hw_params_dump() outputs the following:

ACCESS:  MMAP_INTERLEAVED
FORMAT:  S8 U8 S16_LE S16_BE U16_LE U16_BE S24_LE S24_BE U24_LE U24_BE
S32_LE S32_BE U32_LE U32_BE FLOAT_LE FLOAT_BE FLOAT64_LE FLOAT64_BE MU_LA=
W
A_LAW IMA_ADPCM S24_3LE S24_3BE U24_3LE U24_3BE S20_3LE S20_3BE U20_3LE
U20_3BE S18_3LE S18_3BE U18_3LE U18_3BE
SUBFORMAT:  STD
SAMPLE_BITS: [4 64]
FRAME_BITS: [4 640000]
CHANNELS: [1 10000]
RATE: (11999 49349398)
PERIOD_TIME: (166 682667)
PERIOD_SIZE: 8192
PERIOD_BYTES: [4096 655360000]
PERIODS: 2
BUFFER_TIME: (331 1365448)
BUFFER_SIZE: 16384
BUFFER_BYTES: [8192 1310720000]
TICK_TIME: 1000

----------------------------------------------------------------------
 Benjamin Otte - 06-09-2004 20:04 CEST=20
----------------------------------------------------------------------
Attached is a .c file to reproduce the bug.
Compile with "gcc -ggdb3 `pkg-config --libs --cflags alsa` test.c -o test=
"
and run with "./test <device>" where "./test plughw:0" fails while "./tes=
t
hw:0" succeeds when you use an nForce2 or similar.

The problem is related to how the plug device has a dependency between
rate conversions and buffer sizes and the fact that the autodetection of
correct matches is pretty weak, because rate conversions don't check for
valid buffer sizes.

I'll attached some outputs of hw params while refining that show the issu=
e
pretty well:
=3D=3D> bt:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0000=20
snd_pcm_plug_hw_refine_schange (pcm=3D0x80d47e0, params=3D0xbfffe9d8,
sparams=3D0xbfffe630) at pcm_plug.c:653
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0001=20
0x405452d1 in snd_pcm_plug_hw_params (pcm=3D0x80d47e0,
params=3D0xbfffe9d8) at pcm_plug.c:882
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0002=20
0x4052e0d0 in sndrv_pcm_hw_params (pcm=3D0x80d47e0, params=3D0xbfffe9d8)
at pcm_params.c:2260
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0003=20
0x4051f80d in snd_pcm_hw_params (pcm=3D0x80d47e0, params=3D0xbfffe9d8) at
pcm.c:784
=3D=3D> params:
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: [4000 4000]
PERIOD_TIME: (166 2048000]
PERIOD_SIZE: 8192
PERIOD_BYTES: 8192
PERIODS: 2
BUFFER_TIME: (331 4096000]
BUFFER_SIZE: 16384
BUFFER_BYTES: 16384
TICK_TIME: 1000
U24_3LE U24_3BE S20_3LE S20_3BE U20_3LE U20_3BE S18_3LE S18_3BE U18_3LE
U18_3BE
SUBFORMAT:  STD
SAMPLE_BITS: [4 64]
FRAME_BITS: [4 640000]
CHANNELS: [1 10000]
RATE: [4000 4294967295)
PERIOD_TIME: (62 2048000]
PERIOD_SIZE: (0 4294967295)
PERIOD_BYTES: (0 4294967295)
PERIODS: (0 4294967295]
BUFFER_TIME: [1 4294967295]
BUFFER_SIZE: [1 4294967294]
BUFFER_BYTES: [1 4294967295]
TICK_TIME: 1000

=3D=3D> bt:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0000=20
snd_pcm_plug_hw_refine_schange (pcm=3D0x80dc9d0, params=3D0xbfffe9c8,
sparams=3D0xbfffe620) at pcm_plug.c:736
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0001=20
0x405452d1 in snd_pcm_plug_hw_params (pcm=3D0x80dc9d0,
params=3D0xbfffe9c8) at pcm_plug.c:882
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0002=20
0x4052e0d0 in sndrv_pcm_hw_params (pcm=3D0x80dc9d0, params=3D0xbfffe9c8)
at pcm_params.c:2260
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0003=20
0x4051f80d in snd_pcm_hw_params (pcm=3D0x80dc9d0, params=3D0xbfffe9c8) at
pcm.c:784
=3D=3D> params:
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: [4000 4000]
PERIOD_TIME: (166 2048000]
PERIOD_SIZE: 8192
PERIOD_BYTES: 8192
PERIODS: 2
BUFFER_TIME: (331 4096000]
BUFFER_SIZE: 16384
BUFFER_BYTES: 16384
TICK_TIME: 1000
U24_3LE U24_3BE S20_3LE S20_3BE U20_3LE U20_3BE S18_3LE S18_3BE U18_3LE
U18_3BE
SUBFORMAT:  STD
SAMPLE_BITS: [4 64]
FRAME_BITS: [4 640000]
CHANNELS: [1 10000]
RATE: [4000 4294967295)
PERIOD_TIME: (62 2048000]
PERIOD_SIZE: (0 4294967295)
PERIOD_BYTES: (0 4294967295)
PERIODS: (0 4294967295]
BUFFER_TIME: [1 4294967295]
BUFFER_SIZE: [1 4294967294]
BUFFER_BYTES: [1 4294967295]
TICK_TIME: 1000
=3D=3D> sparams:
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 8000
PERIOD_TIME: [1000 2048000]
PERIOD_SIZE: [8 16384]
PERIOD_BYTES: [32 65536]
PERIODS: [1 1024]
BUFFER_TIME: [1000 2048000]
BUFFER_SIZE: [8 16384]
BUFFER_BYTES: [32 65536]
TICK_TIME: 1000
3BE U20_3LE U20_3BE S18_3LE S18_3BE U18_3LE U18_3BE
SUBFORMAT:  STD
SAMPLE_BITS: [4 64]
FRAME_BITS: [4 640000]
CHANNELS: [1 10000]
RATE: [4000 4294967295)
PERIOD_TIME: (62 2048000]
PERIOD_SIZE: (0 4294967295)
PERIOD_BYTES: (0 4294967295)
PERIODS: (0 4294967295]
BUFFER_TIME: [1 4294967295]
BUFFER_SIZE: [1 4294967294]
BUFFER_BYTES: [1 4294967295]
TICK_TIME: 1000

Note how rate is 4000 vs 8000 while buffer size is 16384 vs 16384 but it
then requests 32768 for the rate conversion which fails.
The code should have picked a rate of 8000 so no rate conversion is
necessary.

GStreamer works around this now, so it's not an issue for us anymore.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
03-04-04 15:30 Benjamin Otte  New Bug                                    =
 =20
03-05-04 11:01 perex          Assigned To               =3D> perex       =
   =20
03-05-04 11:01 perex          Status                   new =3D> assigned =
   =20
03-05-04 12:43 perex          Bugnote Added: 0000498                     =
 =20
03-05-04 12:43 perex          Category                 hw specific config=
uration
=3D> pcm - digital audio
03-05-04 19:44 tiwai          Bugnote Added: 0000512                     =
 =20
03-23-04 15:52 perex          Bugnote Added: 0000660                     =
 =20
03-23-04 15:52 perex          Resolution               open =3D> suspende=
d  =20
03-23-04 15:52 perex          Status                   assigned =3D> reso=
lved
04-16-04 04:11 joshuadf       Bug Monitored: joshuadf                    =
 =20
04-16-04 04:24 joshuadf       Bugnote Added: 0000826                     =
 =20
04-19-04 13:06 Benjamin Otte  Bugnote Added: 0000854                     =
 =20
04-19-04 13:06 Benjamin Otte  Resolution               suspended =3D> reo=
pened
04-19-04 13:06 Benjamin Otte  Status                   resolved =3D> feed=
back
04-19-04 15:09 perex          Status                   feedback =3D> assi=
gned
04-19-04 15:26 perex          File Added: plug-hw-param.patch            =
      =20

04-19-04 15:27 perex          Bugnote Added: 0000856                     =
 =20
04-19-04 21:29 noaq           Bugnote Added: 0000864                     =
 =20
04-20-04 00:30 sxpert         Bugnote Added: 0000868                     =
 =20
04-23-04 00:11 benw           Bug Monitored: benw                        =
 =20
04-25-04 12:03 noaq           Bugnote Added: 0000938                     =
 =20
04-25-04 12:09 perex          Bugnote Added: 0000939                     =
 =20
04-25-04 12:15 noaq           Bugnote Added: 0000940                     =
 =20
06-09-04 20:04 Benjamin Otte  Bugnote Added: 0001297                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
