From: Joachim Schiele <js@dune2.de>
Subject: Q <-> using alsa for midi through
Date: Thu, 27 Nov 2003 21:08:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311272108.09109.js@dune2.de>
Reply-To: js@dune2.de
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

dear list members,

=3D<problem>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

i want to user the Q as masterkeyboard and muse as sequencer to record the=
=20
notes, but how? i can't get the Q working with the alsa midi through!

how can i change my setup that working with the Waldorf Q as masterkeyboard
and the PC (midi through=3D=3D1) as Master, so i can play the Q and record =
it!=20

first my setup:
| Waldorf Q | -out----in-> PC -out----in-> | Waldorf Q|
with either muse (midi trough set!) or this command: (dd if=3D/dev/snd/midi=
C0D0=20
bs=3D1 of=3D/dev/snd/midiC0D0)
also note that "local off" is set on the Q so it can't trigger itselfe
locally, only over the midi wire trough the pc!

when i play the Q, strange things happen:
=2D -not every note is triggered (many don't get through)
=2D -faster playing (5-10 fingers on keys on Q) get diffrent midi error like
sending cc or program changes like pitch up, change of midi port numbers,
suddenly other sounds appear.
=2D -also strange sounds like sqeezing or very high never ending tones appe=
ar.

i know that this is not a BUG of the Waldorf Q because it is working with t=
he
MC 50 (hardware sequencer from roland) well!

=3D<other stuff>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
if i set up the emu10k1 midiIN/OUT <-> muse (midi seq),
i can send midi-out perfectly form my pc <-> waldorf Q / MC 307 when i'm
playing with the virtual muse midi-keyboard!

what i can do (what's working):
=2D -can send sysex(dump) from waldorf Q successfully to PC (no faults)
=2D -can receive every sysex i sent from my PC <-> Q
=2D -can sent notes from muse to either the Q or MC 307 with success (virtu=
al
keyboard of muse)!

special: with midi trough=3D1
=2D -using this command:
(dd if=3D/dev/snd/midiC0D0 bs=3D1 of=3D/dev/snd/midiC0D0)
it is working with the following setup:
| MC 307 | out----in> PC out----in> | MC 307 |
and it's even working with hi midi bandwith usage of the MC 307!

=3D<setup of alsa>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

version of alsa i'm useing:
=2D -1pre1 the latest source!
kernel:
=2D -2.4.22
soundcard:
=2D -emu10k1 with 2-3m large midicable


# aconnect -l -i
client 0: 'System' [type=3Dkernel]
    0 'Timer           '
    1 'Announce        '
        Connecting To: 63:0
client 64: 'Rawmidi 0 - EMU10K1 MPU-401 (UART)' [type=3Dkernel]
    0 'EMU10K1 MPU-401 (UART)'
joachim@debian:~$ aconnect -l -i -o
client 0: 'System' [type=3Dkernel]
    0 'Timer           '
    1 'Announce        '
        Connecting To: 63:0
client 64: 'Rawmidi 0 - EMU10K1 MPU-401 (UART)' [type=3Dkernel]
    0 'EMU10K1 MPU-401 (UART)'
client 65: 'Emu10k1 WaveTable' [type=3Dkernel]
    0 'Emu10k1 Port 0  '
    1 'Emu10k1 Port 1  '
    2 'Emu10k1 Port 2  '
    3 'Emu10k1 Port 3  '

# lsmod
snd-seq-oss            28928   0 (autoclean) (unused)
iptable_filter          1772   0 (autoclean) (unused)
ip_tables              14976   1 [iptable_filter]
sd_mod                 11084   0 (autoclean)
snd-pcm-oss            38244   0
snd-seq-midi            4000   0 (unused)
snd-mixer-oss          13360   1 [snd-pcm-oss]
snd-emu10k1-synth       4764   0 (unused)
snd-emu10k1            73348   1 [snd-emu10k1-synth]
snd-pcm                59780   0 [snd-pcm-oss snd-emu10k1]
snd-hwdep               5248   0 [snd-emu10k1]
snd-page-alloc          6228   0 [snd-emu10k1 snd-pcm]
snd-ac97-codec         46484   0 [snd-emu10k1]
snd-emux-synth         27676   0 [snd-emu10k1-synth]
snd-util-mem            1280   0 [snd-emu10k1 snd-emux-synth]
snd-seq-midi-emul       4960   0 [snd-emux-synth]
snd-seq-virmidi         3272   0 [snd-emux-synth]
snd-seq-midi-event      3328   0 [snd-seq-oss snd-seq-midi snd-seq-virmidi]
snd-seq                36400   2 [snd-seq-oss snd-seq-midi
snd-emux-synthsnd-seq-midi-emul snd-seq-virmidi snd-seq-midi-event]
snd-timer              14436   0 [snd-pcm snd-seq]
snd-rawmidi            13600   0 [snd-seq-midi snd-emu10k1 snd-seq-virmidi]
snd-seq-device          4256   0 [snd-seq-oss snd-seq-midi snd-emu10k1-synth
snd-emu10k1 snd-emux-synth snd-seq snd-rawmidi]
snd                    32484   0 [snd-seq-oss snd-pcm-oss snd-seq-midi
snd-mixer-oss snd-emu10k1 snd-pcm snd-hwdep snd-ac97-codec snd-emux-synth
snd-util-mem snd-seq-virmidi snd-seq-midi-event snd-seq snd-timer snd-rawmi=
di
snd-seq-device]

joachim@debian:~$ cat /proc/asound/devices
  1:       : sequencer
  0: [0- 0]: ctl
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 19: [0- 3]: digital audio playback
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  9: [0- 1]: raw midi
 10: [0- 2]: raw midi
 33:       : timer

joachim@debian:~$ cat /proc/asound/cards
0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.4) at 0xc000, irq 9

joachim@debian:~$ cat /proc/asound/seq/drivers
snd-emu10k1-synth,loaded,1
snd-seq-midi,loaded,1
snd-seq-oss,loaded,requested,1
joachim@debian:~$ cat /proc/asound/seq/oss
OSS sequencer emulation version 0.1.8
ALSA client number 63
ALSA receiver port 0

Number of applications: 0

Number of synth devices: 1

synth 0: [Emu10k1]
  type 0x1 : subtype 0x20 : voices 64
  capabilities : ioctl enabled / load_patch enabled

Number of MIDI devices: 5

midi 0: [EMU10K1 MPU-401 (UART)] ALSA port 64:0
  capability read/write / opened none

midi 1: [Emu10k1 Port 0] ALSA port 65:0
  capability write / opened none

midi 2: [Emu10k1 Port 1] ALSA port 65:1
  capability write / opened none

midi 3: [Emu10k1 Port 2] ALSA port 65:2
  capability write / opened none

midi 4: [Emu10k1 Port 3] ALSA port 65:3
  capability write / opened none

tnx in advice!

if something is missing, i will mail it on request!

sorry for my bad english!
=2D --=20
gruss,
joachim schiele
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xlmoyzk1c1T5Os4RAvmYAJ9jp34vSgUfT7UXoO8cauWncG2JcgCeM0fQ
gZbZOfO/bkxSnGJQnZR4Aes=3D
=3Dfx4+
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
