From: Martin Steigerwald <martin@lichtvoll.de>
Subject: [REGRESSION] 4.1-rc4: Sound muted after boot
Date: Wed, 20 May 2015 16:31:55 +0200
Message-ID: <1902192.Ae1uPbIBnJ@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello!

On ThinkPad T520 (Intel Sandybridge) with 4.14-rc4 + two BTRFS patches =
and=20
one Intel P-State debug patch I have no sound output on internal Intel =
HD=20
audio codec.

According to ThinkPad T520 LED with striked-through speaker the loud sp=
eaker=20
is in disabled state. Also KDE=B4s Phonon says a soundcard is missing. =
In=20
alsa-mixer I see nothing as MM for muted. If I press the key next to th=
e LED=20
I get a notification on the desktop that loud speaker has been enabled =
/=20
disabled, but the LED still is on for it being disabled.

I do not hear anything in Amarok or with aplay. alsa-mixer sound volume=
s are=20
100 for master and PCM. I also tried with disabling "Auto-Mute Mod", bu=
t=20
still no sound.
=20
When I reboot and in BIOS or GRUB press the key then the LED toggles st=
ate.

When I reboot into Linux 4.0.1 sound is working fine and loud speaker=20
disabled LED is toggled off, so I bet this is a regression 4.1-rc4 comp=
ared=20
to 4.0.1.


The following is from non-working 4.1-rc4 kernel:

merkaba:~> lspci -s 00:1b.0 -nnv
00:1b.0 Audio device [0403]: Intel Corporation 6 Series/C200 Series Chi=
pset=20
=46amily High Definition Audio Controller [8086:1c20] (rev 04)
        Subsystem: Lenovo Device [17aa:21cf]
        Flags: bus master, fast devsel, latency 0, IRQ 29
        Memory at f2520000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Capabilities: [70] Express Root Complex Integrated Endpoint, MS=
I 00
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Root Complex Link
        Kernel driver in use: snd_hda_intel

merkaba:~> cat /proc/asound/cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf2520000 irq 29
merkaba:~> cat /proc/asound/version=20
Advanced Linux Sound Architecture Driver Version k4.1.0-rc4-tp520-btrfs=
trim-
pstatetrace+.
merkaba:~> cat /proc/asound/devices=20
  2: [ 0]   : control
  3: [ 0- 0]: digital audio playback
  4: [ 0- 0]: digital audio capture
  5: [ 0- 3]: digital audio playback
  6: [ 0- 7]: digital audio playback
  7: [ 0- 8]: digital audio playback
  8: [ 0- 0]: hardware dependent
  9: [ 0- 1]: hardware dependent
 10: [ 0- 3]: hardware dependent
 33:        : timer
merkaba:~>=20


merkaba:~> aplay -L=20
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
phonon
    HDA Intel PCH mit Mixer
default:CARD=3DPCH
    HDA Intel PCH, CX20590 Analog
    Default Audio Device
sysdefault:CARD=3DPCH
    HDA Intel PCH, CX20590 Analog
    Default Audio Device
front:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    Front speakers
surround21:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    2.1 Surround output to Front and Subwoofer speakers
surround40:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speaker=
s
hdmi:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, HDMI 0
    HDMI Audio Output
hdmi:CARD=3DPCH,DEV=3D1
    HDA Intel PCH, HDMI 1
    HDMI Audio Output
hdmi:CARD=3DPCH,DEV=3D2
    HDA Intel PCH, HDMI 2
    HDMI Audio Output
dmix:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    Direct sample mixing device
dmix:CARD=3DPCH,DEV=3D3
    HDA Intel PCH, HDMI 0
    Direct sample mixing device
dmix:CARD=3DPCH,DEV=3D7
    HDA Intel PCH, HDMI 1
    Direct sample mixing device
dmix:CARD=3DPCH,DEV=3D8
    HDA Intel PCH, HDMI 2
    Direct sample mixing device
dsnoop:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    Direct sample snooping device
dsnoop:CARD=3DPCH,DEV=3D3
    HDA Intel PCH, HDMI 0
    Direct sample snooping device
dsnoop:CARD=3DPCH,DEV=3D7
    HDA Intel PCH, HDMI 1
    Direct sample snooping device
dsnoop:CARD=3DPCH,DEV=3D8
    HDA Intel PCH, HDMI 2
    Direct sample snooping device
hw:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    Direct hardware device without any conversions
hw:CARD=3DPCH,DEV=3D3
    HDA Intel PCH, HDMI 0
    Direct hardware device without any conversions
hw:CARD=3DPCH,DEV=3D7
    HDA Intel PCH, HDMI 1
    Direct hardware device without any conversions
hw:CARD=3DPCH,DEV=3D8
    HDA Intel PCH, HDMI 2
    Direct hardware device without any conversions
plughw:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, CX20590 Analog
    Hardware device with all software conversions
plughw:CARD=3DPCH,DEV=3D3
    HDA Intel PCH, HDMI 0
    Hardware device with all software conversions
plughw:CARD=3DPCH,DEV=3D7
    HDA Intel PCH, HDMI 1
    Hardware device with all software conversions
plughw:CARD=3DPCH,DEV=3D8
    HDA Intel PCH, HDMI 2
    Hardware device with all software conversions


Ciao,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
