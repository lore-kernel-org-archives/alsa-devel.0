From: noreply@alsa-project.org
Subject: [ALSA - driver 0000014]: No sound from external speakers (laptop)
Date: Tue, 15 Jun 2004 15:00:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <74b1a8ff861acf560ebf2ee627fc158e@bugtrack.alsa-project.org>
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
0014
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                user74
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     14
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Sid updated
Kernel Version:             2.4.24-ck1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             01-29-2004 20:15 CET
Last Modified:              06-15-2004 15:00 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    No sound from external speakers (laptop)
Description:=20
On my laptop (acer272xv) I can't use external output with my Creative 2.1=
,
because I can't hear anything.
I've tryied with other external speaker and with other releases of
alsa-driver, but there's no difference.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 tiwai - 01-30-2004 12:44 CET=20
----------------------------------------------------------------------
to be sure: do you mean "external speaker" as the output from the
headphone jack on your laptop?

anyway, give the contents of /proc/asound/card0/codec#0/* files and
/etc/asound.state.

----------------------------------------------------------------------
 sparkyva - 01-30-2004 17:56 CET=20
----------------------------------------------------------------------
I'm running with an Intel8x0 on my Dell Inspiron 8500 and getting the
similar results as what jorge is seeing. I get no sound through the built
in speakers, however, when I plug a set of headphones into the headphone
jack, I get sound. The built in speaker works, I've tested it through
Windows. Also, recording doesn't work with either the internal mic or one
plugged into the mic jack. I am using kernel 2.6.1 (but have tried
everything back to 2.6.0)
(I have also tried several different combinations in the alsamixer
application without success) Upon compiling the drivers and libs I got no
complaints.
BTW I am using ALSA 1.0.2
cat /proc/asound/card0/ac97#0
0-0/0: SigmaTel STAC9750/51

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 20-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : post 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic2
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D1 AMAP DSA=3D0 SPDIF VRA
Extended status  : SPCV SPDIF=3Dres SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 44100Hz
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D44.1=
kHz


cat /etc/asound.state
state.I82801DBICH4 {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Master Playback Switch'
                value true
        }
        control.2 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 0
                value.1 0
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Headphone Playback Switch'
                value true
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Headphone Playback Volume'
                value.0 2
                value.1 2
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Master Mono Playback Switch'
                value true
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 2
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'PC Speaker Playback Switch'
                value true
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 15'
                iface MIXER
                name 'PC Speaker Playback Volume'
                value 0
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Phone Playback Switch'
                value true
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Phone Playback Volume'
                value 0
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Mic Playback Switch'
                value true
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value 31
        }
        control.13 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Mic Boost (+20dB)'
                value true
        }
        control.14 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Line Playback Switch'
                value true
        }
        control.15 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 0
                value.1 0
        }
        control.16 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'CD Playback Switch'
                value true
        }
        control.17 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'CD Playback Volume'
                value.0 0
                value.1 0
        }
        control.18 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Video Playback Switch'
                value true
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Video Playback Volume'
                value.0 0
                value.1 0
        }
        control.20 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Aux Playback Switch'
                value true
        }
        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 0
                value.1 0
        }
        control.22 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'PCM Playback Switch'
                value true
        }
        control.23 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 7
                value.1 7
        }
        control.24 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Mic
                comment.item.1 CD
                comment.item.2 Video
                comment.item.3 Aux
                comment.item.4 Line
                comment.item.5 Mix
                comment.item.6 'Mix Mono'
                comment.item.7 Phone
                iface MIXER
                name 'Capture Source'
                value.0 Mic
                value.1 Mic
        }
        control.25 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Capture Switch'
                value false
        }
        control.26 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.27 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 'pre 3D'
                comment.item.1 'post 3D'
                iface MIXER
                name 'PCM Out Path & Mute'
                value 'post 3D'
        }
        control.28 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name '3D Control - Switch'
                value true
        }
        control.29 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Mix
                comment.item.1 Mic
                iface MIXER
                name 'Mono Output Select'
                value Mix
        }
        control.30 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Mic1
                comment.item.1 Mic2
                iface MIXER
                name 'Mic Select'
                value Mic2
        }
        control.31 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Center'
                value 8
        }
        control.32 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Depth'
                value 8
        }
        control.33 {
                comment.access read
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000f0000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
        }
        control.34 {
                comment.access read
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
cf00000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000
        }
        control.35 {
                comment.access 'read write'
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Default'
                value
'008200020000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
        }
        control.36 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'IEC958 Playback Switch'
                value true
        }
        control.37 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 3'
                iface MIXER
                name 'IEC958 Playback AC97-SPSA'
                value 0
        }
        control.38 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'External Amplifier Power Down'
                value true
        }
}

----------------------------------------------------------------------
 sparkyva - 01-30-2004 20:41 CET=20
----------------------------------------------------------------------
I got recording working. However the only thing I did (that I know of) is
recompiled my kernel and recompiled the alsa drivers, and in the kernel
settings added PC Speaker support into the kernel (not as a module)

----------------------------------------------------------------------
 jorge2 - 01-30-2004 22:01 CET=20
----------------------------------------------------------------------
Hi.
Yes, my Creative 2.1 is plugged in the headphone jack (green), near
microphone jack (pink).
Using Windows Xp HE there's no problem with output.
Here're details you need:

------- /proc/asound/card0/codec97#0/ac97#0-0 -----


0-0/0: Realtek ALC202 rev 0

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic2
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D1 AMAP DSA=3D0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3D6/9 VRA
PCM front DAC    : 22050Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kH=
z


------- /proc/asound/card0/codec97#0/ac97#0-0+regs -----

0:00 =3D 5980
0:02 =3D 0b0b
0:04 =3D 0000
0:06 =3D 000b
0:08 =3D 0000
0:0a =3D 801e
0:0c =3D 8019
0:0e =3D 801d
0:10 =3D 0505
0:12 =3D 0f0f
0:14 =3D 9c1c
0:16 =3D 9f1f
0:18 =3D 0606
0:1a =3D 0606
0:1c =3D 8000
0:1e =3D 0000
0:20 =3D 0100
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 000f
0:28 =3D 0607
0:2a =3D 05e1
0:2c =3D 5622
0:2e =3D 5622
0:30 =3D 5622
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 8080
	0:38 =3D 8080
0:3a =3D 2824
0:3c =3D 0000
0:3e =3D 0000
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0000
0:4e =3D 0000
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0000
0:5c =3D 0000
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 0000
0:64 =3D 0808
0:66 =3D 0808
0:68 =3D 0000
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0003
0:70 =3D 0211
0:72 =3D 6aa9
0:74 =3D 0063
0:76 =3D 0000
0:78 =3D 0003
0:7a =3D 57c4
0:7c =3D 414c
0:7e =3D 4740

------- /proc/asound/card0/codec97#0/mc97#1-1 -----

1-1/0: Silicon Laboratory Si3036/8 rev 7

Extended modem ID: codec=3D1 LIN1
Modem status     : GPIO ADC1 DAC1 PRB(res) PRE(ADC2) PRF(DAC2) PRG(HADC)
PRH(HDAC)
Line1 rate       : 12000Hz

------- /proc/asound/card0/codec97#0/mc97#1-1+regs -----

0:00 =3D 0000
0:02 =3D 0000
0:04 =3D 0000
0:06 =3D 0000
0:08 =3D 0000
0:0a =3D 0000
0:0c =3D 0000
0:0e =3D 0000
0:10 =3D 0000
0:12 =3D 0000
0:14 =3D 0000
0:16 =3D 0000
0:18 =3D 0000
0:1a =3D 0000
0:1c =3D 0000
0:1e =3D 0000
0:20 =3D 0000
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 0000
0:28 =3D 0000
0:2a =3D 0000
0:2c =3D 0000
0:2e =3D 0000
0:30 =3D 0000
0:32 =3D 0000
0:34 =3D 0000
0:36 =3D 0000
0:38 =3D 0000
0:3a =3D 0000
0:3c =3D 4001
0:3e =3D f20d
0:40 =3D 2ee0
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 8080
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 003e
0:4e =3D fffe
0:50 =3D 003f
0:52 =3D 0000
0:54 =3D 0020
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0133
0:5c =3D f010
0:5e =3D 0040
0:60 =3D 0000
0:62 =3D 7000
0:64 =3D 0002
0:66 =3D 0a08
0:68 =3D 0008
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0000
0:70 =3D 0000
0:72 =3D 0000
0:74 =3D 0000
0:76 =3D 0000
0:78 =3D 0000
0:7a =3D 0000
0:7c =3D 5349
0:7e =3D 4c27

------- /etc/asound.state -----

state.SI7012 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 20
		value.1 20
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 20
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 6
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 2
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value true
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 26
		value.1 26
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 16
		value.1 16
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 3
		value.1 3
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 25
		value.1 25
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 'Mix Mono'
		value.1 'Mix Mono'
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value false
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic2
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 0
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 0
	}
	control.30 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value
'0fff000f0000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
	}
	control.31 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value
cf00000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000
	}
	control.32 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value
'008200020000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
	}
	control.33 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.34 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 2
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier Power Down'
		value false
	}
}

----------------------------------------------------------------------
 jorge2 - 02-02-2004 19:37 CET=20
----------------------------------------------------------------------
Hi to all.
Today I've tryied 2.6.2-rc2-mm2 with pcspkr enabled and statically
compiled in, but there's no difference against 2.4.24-ck1, even using
simple headphones.
Regards.

----------------------------------------------------------------------
 tiwai - 02-04-2004 20:00 CET=20
----------------------------------------------------------------------
the mixer configuration looks ok.  might be related with some minor
chip-specific register of this codec, though.

how about the internal speaker built in the laptop?
when the green jack is not plugged, does it output any tone?

note that the pcspeaker of kernel config has nothing to do with
the ac97 output.  it enables the normal "beep" tone only.

----------------------------------------------------------------------
 tiwai - 02-04-2004 20:01 CET=20
----------------------------------------------------------------------
in the case of sparkyva:

"Master" volume is zero.  raise it first.

----------------------------------------------------------------------
 jorge2 - 02-04-2004 20:52 CET=20
----------------------------------------------------------------------
When green jack is unplugged there's no problem, sounds are correctly
played.
I've seen that if I plug creative jack (or other speakers) to green outpu=
t
but I don't insert it completely, sound were produced in both speakers
(integrated and external ) with noise.
I've tryied this strange situation even with headphones, and it happens
again.
Regards.
					Jorge

----------------------------------------------------------------------
 matsgora - 02-05-2004 13:52 CET=20
----------------------------------------------------------------------
i got the same problem as jorge. I have an Acer 273x

Got sound on the laptop speakers but no sound when i try using the
headphones jack.=20

On http://www.martinjones.net/acerlinux/ official Linux-Laptop howto for
Acer273xc there is also reported the same bug.

[Quote]
 The bad new is that I have just spent ages trying to get the ALSA driver=
s
working but without any luck. The even worse news is that I have spent
weeks trying to hack the sources to get the headphones to work. You can
have sound from the speakers, but not the headphones
[/Quote]

----------------------------------------------------------------------
 dale - 02-05-2004 14:05 CET=20
----------------------------------------------------------------------
Hi,

I would like to add that i also have an Acer 273XC and have the same
headphone problem.  I have tried for months to get it working, to no avai=
l
:(

hope this helps!,

Dale

----------------------------------------------------------------------
 rocco - 02-26-2004 13:07 CET=20
----------------------------------------------------------------------
sparkyva,

in the inspiron you'll have to mute the external thingy in alsamixer, the
rightmost toggle. It's toggled with the m, mute button.

 Item: External Amplifier Power Down [Off]=20

And the internal speakers will work.

----------------------------------------------------------------------
 matsgora - 02-26-2004 18:16 CET=20
----------------------------------------------------------------------
i tried your suggestion rocco, and it still doesn't work on the acer273x

----------------------------------------------------------------------
 tiwai - 02-26-2004 18:20 CET=20
----------------------------------------------------------------------
please make sure that all of you have the same ac97 codec chips.
the chip might be different from model to model.

----------------------------------------------------------------------
 dale - 03-01-2004 10:31 CET=20
----------------------------------------------------------------------
I agree with matsgora, muting External Amplifier Power Down did not fix t=
he
problem for me either.

----------------------------------------------------------------------
 tiwai - 03-05-2004 19:49 CET=20
----------------------------------------------------------------------
guys, PLEASE, do not mix the problems with different laptops!

if you have Dell Inspiron, create another bug report.
i'd like to see the problem on Acer laptops.

Acer laptop owners: please confirm that your ac97 chip is
identical with the one sparkyva reported.

----------------------------------------------------------------------
 jorge2 - 03-05-2004 20:37 CET=20
----------------------------------------------------------------------
I think my laptop chipset is different from sparkyva: see my bugnote of
30-01-04 for details.
The description doesn't show any capabilities, i.e. headphone out....

Today, I've tryied linux-2.6.4-rc1-mm2 kernel with alsa 1.03 and there's
no difference with old drivers and kernels (no sound from external
speakers).

----------------------------------------------------------------------
 matsgora - 03-06-2004 18:20 CET=20
----------------------------------------------------------------------
My acer laptop does not have the same ac97 chip as sparkyva. The specs ar=
e
the same as jorge2.

lspci | grep Multimedia
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)


cat /proc/asound/card0/ac97#0
0-0/0: Realtek ALC202 rev 0
=20
Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement
=20
Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D1 AMAP DSA=3D0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3D3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=3D0x22 Generation=3D1
Rate=3D44.1kHz

cat /proc/asound/card0/ac97#0regs
0:00 =3D 5980
0:02 =3D 9f1f
0:04 =3D 0000
0:06 =3D 801f
0:08 =3D 0000
0:0a =3D 801e
0:0c =3D 801f
0:0e =3D 801f
0:10 =3D 9f1f
0:12 =3D 9f1f
0:14 =3D 9f1f
0:16 =3D 9f1f
0:18 =3D 9f1f
0:1a =3D 0000
0:1c =3D 0000
0:1e =3D 0000
0:20 =3D 0000
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 000f
0:28 =3D 0607
0:2a =3D 05c5
0:2c =3D ac44
0:2e =3D ac44
0:30 =3D ac44
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 8080
0:38 =3D 8080
0:3a =3D 0a20
0:3c =3D 0000
0:3e =3D 0000
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0000
0:4e =3D 0000
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0000
0:5c =3D 0000
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 0000
0:64 =3D 0808
0:66 =3D 0808
0:68 =3D 0000
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0003
0:70 =3D 0211
0:72 =3D 6aa9
0:74 =3D 0063
0:76 =3D 0000
0:78 =3D 0003
0:7a =3D 57c4
0:7c =3D 414c
0:7e =3D 4740

cat ac97#1-1
1-1/0: Silicon Laboratory Si3036/8 rev 7
=20
Extended modem ID: codec=3D1 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 0Hz

 cat ac97#1-1regs
0:00 =3D 0000
0:02 =3D 0000
0:04 =3D 0000
0:06 =3D 0000
0:08 =3D 0000
0:0a =3D 0000
0:0c =3D 0000
0:0e =3D 0000
0:10 =3D 0000
0:12 =3D 0000
0:14 =3D 0000
0:16 =3D 0000
0:18 =3D 0000
0:1a =3D 0000
0:1c =3D 0000
0:1e =3D 0000
0:20 =3D 0000
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 0000
0:28 =3D 0000
0:2a =3D 0000
0:2c =3D 0000
0:2e =3D 0000
0:30 =3D 0000
0:32 =3D 0000
0:34 =3D 0000
0:36 =3D 0000
0:38 =3D 0000
0:3a =3D 0000
0:3c =3D 4001
0:3e =3D ff00
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 8080
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 003f
0:4e =3D ffff
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0003
0:5c =3D f010
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 7000
0:64 =3D 0000
0:66 =3D 0008
0:68 =3D 0008
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0000
0:70 =3D 0000
0:72 =3D 0000
0:74 =3D 0000
0:76 =3D 0000
0:78 =3D 0000
0:7a =3D 0000
0:7c =3D 5349
0:7e =3D 4c27

----------------------------------------------------------------------
 dale - 03-07-2004 16:30 CET=20
----------------------------------------------------------------------
Yes my chip is also the same as jorge2 and matsgora.

----------------------------------------------------------------------
 tiwai - 03-09-2004 15:15 CET=20
----------------------------------------------------------------------
ok, sparkyva's laptop is from Dell.  sorry for confusion.

so, the all acer laptops have ALC202 codec, right?

----------------------------------------------------------------------
 matsgora - 03-09-2004 18:12 CET=20
----------------------------------------------------------------------
Jepp. that seems to be the case tiwai. The acer laptops uses the ALC202
codec

----------------------------------------------------------------------
 jorge2 - 06-08-2004 20:25 CEST=20
----------------------------------------------------------------------
Hi to all...
What about our ALC202 chipset and speaker-out plug?
Any patches to test?

----------------------------------------------------------------------
 mcbridematt - 06-15-2004 15:00 CEST=20
----------------------------------------------------------------------
I have a Acer Travelmate 274i here (same hardware, faster CPU).  If I plu=
g
in headphones, there is NO SOUND in the headphones at all.

'External Amplifier' is enabled in alsamixer - no effect
tried every ac97_quirk option - no effect.

Been a problem for a long time - see
http://mcbridematt.dhs.org/index.php?p=3D67&page=3D2

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
01-29-04 20:15 user74         New Bug                                    =
 =20
01-29-04 20:15 user74         File Added: details.txt                    =
 =20
01-30-04 12:44 tiwai          Bugnote Added: 0000049                     =
 =20
01-30-04 17:56 sparkyva       Bugnote Added: 0000063                     =
 =20
01-30-04 17:56 sparkyva       Bug Monitored: sparkyva                    =
 =20
01-30-04 20:41 sparkyva       Bugnote Added: 0000070                     =
 =20
01-30-04 22:01 jorge2         Bugnote Added: 0000071                     =
 =20
02-02-04 19:37 jorge2         Bugnote Added: 0000119                     =
 =20
02-04-04 20:00 tiwai          Bugnote Added: 0000165                     =
 =20
02-04-04 20:01 tiwai          Bugnote Added: 0000166                     =
 =20
02-04-04 20:52 jorge2         Bugnote Added: 0000169                     =
 =20
02-04-04 20:52 jorge2         Bugnote Added: 0000170                     =
 =20
02-04-04 20:53 jorge2         Bugnote Deleted: 0000169                   =
 =20
02-05-04 13:52 matsgora       Bugnote Added: 0000181                     =
 =20
02-05-04 14:05 dale           Bugnote Added: 0000182                     =
 =20
02-26-04 13:07 rocco          Bugnote Added: 0000347                     =
 =20
02-26-04 18:16 matsgora       Bugnote Added: 0000358                     =
 =20
02-26-04 18:20 tiwai          Bugnote Added: 0000359                     =
 =20
03-01-04 10:31 dale           Bugnote Added: 0000401                     =
 =20
03-05-04 19:49 tiwai          Bugnote Added: 0000513                     =
 =20
03-05-04 20:37 jorge2         Bugnote Added: 0000515                     =
 =20
03-06-04 18:20 matsgora       Bugnote Added: 0000520                     =
 =20
03-07-04 16:30 dale           Bugnote Added: 0000524                     =
 =20
03-09-04 15:15 tiwai          Bugnote Added: 0000547                     =
 =20
03-09-04 18:12 matsgora       Bugnote Added: 0000551                     =
 =20
06-08-04 20:25 jorge2         Bugnote Added: 0001296                     =
 =20
06-15-04 15:00 mcbridematt    Bugnote Added: 0001308                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
