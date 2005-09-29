From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000014]: No sound from headphone jack on Acer27* laptops
Date: Thu, 29 Sep 2005 12:30:09 +0200
Message-ID: <20bfa722b829dfec69861039dfa4f10d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 44B20191
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 12:30:10 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14> 
======================================================================
Reported By:                -VoltagE-
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   14
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     confirmed
Distribution:               Debian Sid updated
Kernel Version:             2.4.24-ck1
======================================================================
Date Submitted:             01-29-2004 20:15 CET
Last Modified:              09-29-2005 12:30 CEST
======================================================================
Summary:                    No sound from headphone jack on Acer27* laptops
Description: 
On my laptop (acer272xv) I can't use external output with my Creative 2.1,
because I can't hear anything.
I've tryied with other external speaker and with other releases of
alsa-driver, but there's no difference.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000664 ac97_quirk with SIS 7012 [ALC202] don't...
======================================================================

----------------------------------------------------------------------
 tiwai - 01-30-04 12:44 
----------------------------------------------------------------------
to be sure: do you mean "external speaker" as the output from the
headphone jack on your laptop?

anyway, give the contents of /proc/asound/card0/codec#0/* files and
/etc/asound.state.

----------------------------------------------------------------------
 sparkyva - 01-30-04 17:56 
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
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=res SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 44100Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz


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
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.34 {
                comment.access read
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
        }
        control.35 {
                comment.access 'read write'
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Default'
                value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
 sparkyva - 01-30-04 20:41 
----------------------------------------------------------------------
I got recording working. However the only thing I did (that I know of) is
recompiled my kernel and recompiled the alsa drivers, and in the kernel
settings added PC Speaker support into the kernel (not as a module)

----------------------------------------------------------------------
 jorge2 - 01-30-04 22:01 
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
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=6/9 VRA
PCM front DAC    : 22050Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz


------- /proc/asound/card0/codec97#0/ac97#0-0+regs -----

0:00 = 5980
0:02 = 0b0b
0:04 = 0000
0:06 = 000b
0:08 = 0000
0:0a = 801e
0:0c = 8019
0:0e = 801d
0:10 = 0505
0:12 = 0f0f
0:14 = 9c1c
0:16 = 9f1f
0:18 = 0606
0:1a = 0606
0:1c = 8000
0:1e = 0000
0:20 = 0100
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0607
0:2a = 05e1
0:2c = 5622
0:2e = 5622
0:30 = 5622
0:32 = bb80
0:34 = 0000
0:36 = 8080
	0:38 = 8080
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0003
0:70 = 0211
0:72 = 6aa9
0:74 = 0063
0:76 = 0000
0:78 = 0003
0:7a = 57c4
0:7c = 414c
0:7e = 4740

------- /proc/asound/card0/codec97#0/mc97#1-1 -----

1-1/0: Silicon Laboratory Si3036/8 rev 7

Extended modem ID: codec=1 LIN1
Modem status     : GPIO ADC1 DAC1 PRB(res) PRE(ADC2) PRF(DAC2) PRG(HADC)
PRH(HDAC)
Line1 rate       : 12000Hz

------- /proc/asound/card0/codec97#0/mc97#1-1+regs -----

0:00 = 0000
0:02 = 0000
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 0000
0:0e = 0000
0:10 = 0000
0:12 = 0000
0:14 = 0000
0:16 = 0000
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 0000
0:28 = 0000
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 4001
0:3e = f20d
0:40 = 2ee0
0:42 = 0000
0:44 = 0000
0:46 = 8080
0:48 = 0000
0:4a = 0000
0:4c = 003e
0:4e = fffe
0:50 = 003f
0:52 = 0000
0:54 = 0020
0:56 = 0000
0:58 = 0000
0:5a = 0133
0:5c = f010
0:5e = 0040
0:60 = 0000
0:62 = 7000
0:64 = 0002
0:66 = 0a08
0:68 = 0008
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 5349
0:7e = 4c27

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
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.31 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.32 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
 jorge2 - 02-02-04 19:37 
----------------------------------------------------------------------
Hi to all.
Today I've tryied 2.6.2-rc2-mm2 with pcspkr enabled and statically
compiled in, but there's no difference against 2.4.24-ck1, even using
simple headphones.
Regards.

----------------------------------------------------------------------
 tiwai - 02-04-04 20:00 
----------------------------------------------------------------------
the mixer configuration looks ok.  might be related with some minor
chip-specific register of this codec, though.

how about the internal speaker built in the laptop?
when the green jack is not plugged, does it output any tone?

note that the pcspeaker of kernel config has nothing to do with
the ac97 output.  it enables the normal "beep" tone only.

----------------------------------------------------------------------
 tiwai - 02-04-04 20:01 
----------------------------------------------------------------------
in the case of sparkyva:

"Master" volume is zero.  raise it first.

----------------------------------------------------------------------
 jorge2 - 02-04-04 20:52 
----------------------------------------------------------------------
When green jack is unplugged there's no problem, sounds are correctly
played.
I've seen that if I plug creative jack (or other speakers) to green output
but I don't insert it completely, sound were produced in both speakers
(integrated and external ) with noise.
I've tryied this strange situation even with headphones, and it happens
again.
Regards.
					Jorge

----------------------------------------------------------------------
 matsgora - 02-05-04 13:52 
----------------------------------------------------------------------
i got the same problem as jorge. I have an Acer 273x

Got sound on the laptop speakers but no sound when i try using the
headphones jack. 

On http://www.martinjones.net/acerlinux/ official Linux-Laptop howto for
Acer273xc there is also reported the same bug.

[Quote]
 The bad new is that I have just spent ages trying to get the ALSA drivers
working but without any luck. The even worse news is that I have spent
weeks trying to hack the sources to get the headphones to work. You can
have sound from the speakers, but not the headphones
[/Quote]

----------------------------------------------------------------------
 dale - 02-05-04 14:05 
----------------------------------------------------------------------
Hi,

I would like to add that i also have an Acer 273XC and have the same
headphone problem.  I have tried for months to get it working, to no avail
:(

hope this helps!,

Dale

----------------------------------------------------------------------
 rocco - 02-26-04 13:07 
----------------------------------------------------------------------
sparkyva,

in the inspiron you'll have to mute the external thingy in alsamixer, the
rightmost toggle. It's toggled with the m, mute button.

 Item: External Amplifier Power Down [Off] 

And the internal speakers will work.

----------------------------------------------------------------------
 matsgora - 02-26-04 18:16 
----------------------------------------------------------------------
i tried your suggestion rocco, and it still doesn't work on the acer273x

----------------------------------------------------------------------
 tiwai - 02-26-04 18:20 
----------------------------------------------------------------------
please make sure that all of you have the same ac97 codec chips.
the chip might be different from model to model.

----------------------------------------------------------------------
 dale - 03-01-04 10:31 
----------------------------------------------------------------------
I agree with matsgora, muting External Amplifier Power Down did not fix the
problem for me either.

----------------------------------------------------------------------
 tiwai - 03-05-04 19:49 
----------------------------------------------------------------------
guys, PLEASE, do not mix the problems with different laptops!

if you have Dell Inspiron, create another bug report.
i'd like to see the problem on Acer laptops.

Acer laptop owners: please confirm that your ac97 chip is
identical with the one sparkyva reported.

----------------------------------------------------------------------
 jorge2 - 03-05-04 20:37 
----------------------------------------------------------------------
I think my laptop chipset is different from sparkyva: see my bugnote of
30-01-04 for details.
The description doesn't show any capabilities, i.e. headphone out....

Today, I've tryied linux-2.6.4-rc1-mm2 kernel with alsa 1.03 and there's
no difference with old drivers and kernels (no sound from external
speakers).

----------------------------------------------------------------------
 matsgora - 03-06-04 18:20 
----------------------------------------------------------------------
My acer laptop does not have the same ac97 chip as sparkyva. The specs are
the same as jorge2.

lspci | grep Multimedia
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)


cat /proc/asound/card0/ac97#0
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
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x22 Generation=1
Rate=44.1kHz

cat /proc/asound/card0/ac97#0regs
0:00 = 5980
0:02 = 9f1f
0:04 = 0000
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 9f1f
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0607
0:2a = 05c5
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = 0000
0:36 = 8080
0:38 = 8080
0:3a = 0a20
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0003
0:70 = 0211
0:72 = 6aa9
0:74 = 0063
0:76 = 0000
0:78 = 0003
0:7a = 57c4
0:7c = 414c
0:7e = 4740

cat ac97#1-1
1-1/0: Silicon Laboratory Si3036/8 rev 7
 
Extended modem ID: codec=1 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 0Hz

 cat ac97#1-1regs
0:00 = 0000
0:02 = 0000
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 0000
0:0e = 0000
0:10 = 0000
0:12 = 0000
0:14 = 0000
0:16 = 0000
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 0000
0:28 = 0000
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 4001
0:3e = ff00
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 8080
0:48 = 0000
0:4a = 0000
0:4c = 003f
0:4e = ffff
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0003
0:5c = f010
0:5e = 0000
0:60 = 0000
0:62 = 7000
0:64 = 0000
0:66 = 0008
0:68 = 0008
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 5349
0:7e = 4c27

----------------------------------------------------------------------
 dale - 03-07-04 16:30 
----------------------------------------------------------------------
Yes my chip is also the same as jorge2 and matsgora.

----------------------------------------------------------------------
 tiwai - 03-09-04 15:15 
----------------------------------------------------------------------
ok, sparkyva's laptop is from Dell.  sorry for confusion.

so, the all acer laptops have ALC202 codec, right?

----------------------------------------------------------------------
 matsgora - 03-09-04 18:12 
----------------------------------------------------------------------
Jepp. that seems to be the case tiwai. The acer laptops uses the ALC202
codec

----------------------------------------------------------------------
 jorge2 - 06-08-04 20:25 
----------------------------------------------------------------------
Hi to all...
What about our ALC202 chipset and speaker-out plug?
Any patches to test?

----------------------------------------------------------------------
 mcbridematt - 06-15-04 15:00 
----------------------------------------------------------------------
I have a Acer Travelmate 274i here (same hardware, faster CPU).  If I plug
in headphones, there is NO SOUND in the headphones at all.

'External Amplifier' is enabled in alsamixer - no effect
tried every ac97_quirk option - no effect.

Been a problem for a long time - see
http://mcbridematt.dhs.org/index.php?p=67&page=2

----------------------------------------------------------------------
 dale - 02-02-05 14:25 
----------------------------------------------------------------------
Hi, i have some spare time on my hands and would really like to get some
work started on this problem.  
If there are any patches i would like to test them, or any help on how i
could try and fix the problem myself would be appreciated.  
I dont want to have to try and hack the source myself, but it has been a
year since it was first reported and i really want to get sound out of the
headphones, the laptop speakers are not great.

----------------------------------------------------------------------
 tiwai - 02-04-05 13:18 
----------------------------------------------------------------------
Does the attached patch (for CVS / 1.0.8) have any influence?

----------------------------------------------------------------------
 jorge2 - 02-04-05 18:03 
----------------------------------------------------------------------
I've tried your patch on top of 2.6.11-rc2-mm2-vivid1 patchset but there're
no good news: sound didn't work with external speakers.
Here is the output for files in /proc:
************************
[/proc/asound/card0/codec97#0/ac97#0-0]
0-0/0: Realtek ALC202 rev 0

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : Mic
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz
************************

[/proc/asound/card0/codec97#0/ac97#0-0+regs]

************************

0:00 = 5980
0:02 = 0707
0:04 = 0000
0:06 = 001f
0:08 = 0000
0:0a = 001e
0:0c = 0015
0:0e = 000e
0:10 = 1111
0:12 = 1212
0:14 = 0a0a
0:16 = 0707
0:18 = 0808
0:1a = 0505
0:1c = 0505
0:1e = 0000
0:20 = 2200
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0607
0:2a = 05c5
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = 0000
0:36 = 8080
0:38 = 8080
0:3a = 0824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0003
0:70 = 0211
0:72 = 6aa9
0:74 = 0063
0:76 = 0000
0:78 = 0003
0:7a = 57c4
0:7c = 414c
0:7e = 4740

Thanks a lot.

----------------------------------------------------------------------
 dale - 02-21-05 09:16 
----------------------------------------------------------------------
Hi tiwai,

Have tried the patch with 2.6.10-gentoo-r6 and unfortunately there is
still no output through the headphones.

thanks,

Dale

----------------------------------------------------------------------
 wenton - 06-20-05 06:48 
----------------------------------------------------------------------
Greetings! Not sure if this hurts or helps.  I have been able to get this 
working in my laptop, but not sure about this behavior: everything appears
to 
be sound card 1 instead of 0; e.g. alsamiser -c 1 and everything works if
I use
things  like/dev/dsp1 and /dev/mixer1 and so on.  Trying to use alsamixer

without "-c 1" tells me, "no mixer elems found"  Trying to use /dev/dsp0 
et. al. seems to act like I am using a null device... device is connected
but 
has nothing physical connected to it.  I do not have another soundcard.  

However, there is a modem built into this chip (82801DB) that does not
seem to
be configured correctly; could this be causing the problem? How else can I
fix
this? I have changed the symbolic links (/dev/dsp->/dev/dsp1, 
dev/mixer->/dev/mixer1,etc.) but this seems more of a band-aid than a fix.

----------------------------------------------------------------------
 dale - 06-22-05 19:50 
----------------------------------------------------------------------
Hi wenton, do you have any more information on your configuration?
I only have /dev/dsp, not /dev/dsp0 /dev/dsp1 etc.  I am using UDEV if it
helps.

So are you saying you have actually managed to get the headphone port to
work with this configuration?

Many Thanks,

Dale

----------------------------------------------------------------------
 wenton - 06-24-05 08:54 
----------------------------------------------------------------------
Hi Dale,

Well, first off, if I understand correctly, (someone else please
verify/correct me), UDEV only manages hotplug devices, but I did find an
excerpt from 'man udev' that might be useful:

   # sound card with PCI bus id 00:0b.0 to be called dsp
   BUS="pci", ID="00:0b.0", NAME="dsp"

but I have to admit, I don't know enough about udev to know how to use
that information.  There were a few other things in that man page that
suggested that various device files are managed by udev, so that might be
why your /dev/dsp[0-3] could be missing.  (I don't want to polute things
by posting it into here.)

As for my own configuration, on a Compaq M2010, I am using Slackware 10.0
which comes with ALSA1.0.5a.  I simply allowed alsaconf to detect and
configure everything on it's own.  When I do 'ls -l /proc/asound' I find:

   I82801DBICH4 -> card1
   Modem -> card0
   (and other stuff)

So at least I can verify what I thought earlier, about ALSA detecting the
modem as card0 and the audio ports as card1.  Also, looking at
/proc/asound/cards tells me about the same thing.

Another thought, and again I'm looking for someone to verify/correct me, I
believe the /dev/dsp? files are OSS-related, and if you have OSS
compatibility turned off, that might explain why those files aren't on
your system.

My laptop only has a mic input and lineout/headphone out, but it does seem
to be working just fine.  I think ALSA only wants to set mixer settings
specifically for /dev/dsp0 (somewhere in rc.alsa?) so I have to manually
set my mixer settings every reboot, so I added that to my rc.local, but at
least it does work.

----------------------------------------------------------------------
 dale - 06-28-05 10:50 
----------------------------------------------------------------------
Hi Wenton,

In your last note you say you are using a Compaq M2010, but this problem
is
specific to the acer travelmate 27x.

----------------------------------------------------------------------
 graf_eichbaum - 07-07-05 18:05 
----------------------------------------------------------------------
Hi all,

I have an Acer Travelmate 273XC with the same Headphone problem when using
Linux. Recently I re-installed my Windows XP and installed the Windows
Driver for the SIS 7012 chipset. Suddenly I had the same problem as under
Linux (no sound from external speakers, just internal speakers). I than
took a look at the old audio driver, that is being offered by Acer. I then
discovered, that this is a Realtek driver. So I used the current Realtek
Windows Audio Driver which works just fine (even with headphones plugged
in). So it seems, that the Acer notebooks do not have SIS Sound Chips
built-in, but Realtek chips. No clue, if this information might help.

----------------------------------------------------------------------
 jorge2 - 07-17-05 13:18 
----------------------------------------------------------------------
Ehm.. I think there's a little mistake :D 
I've opened this issue many month ago with another username (jorge), but
few days after account creation, I wasn't able to login with it (I don't
know why), so I've created another one (jorge2).
Anyway, no good news for this issue yet... :(
Regards.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-04 20:15 user74         New Issue                                    
01-29-04 20:15 user74         File Added: details.txt                      
01-30-04 12:44 tiwai          Note Added: 0000049                          
01-30-04 17:56 sparkyva       Note Added: 0000063                          
01-30-04 17:56 sparkyva       Issue Monitored: sparkyva                    
01-30-04 20:41 sparkyva       Note Added: 0000070                          
01-30-04 22:01 jorge2         Note Added: 0000071                          
02-02-04 19:37 jorge2         Note Added: 0000119                          
02-04-04 20:00 tiwai          Note Added: 0000165                          
02-04-04 20:01 tiwai          Note Added: 0000166                          
02-04-04 20:52 jorge2         Note Added: 0000169                          
02-04-04 20:52 jorge2         Note Added: 0000170                          
02-04-04 20:53 jorge2         Note Deleted: 0000169                        
02-05-04 13:52 matsgora       Note Added: 0000181                          
02-05-04 14:05 dale           Note Added: 0000182                          
02-26-04 13:07 rocco          Note Added: 0000347                          
02-26-04 18:16 matsgora       Note Added: 0000358                          
02-26-04 18:20 tiwai          Note Added: 0000359                          
03-01-04 10:31 dale           Note Added: 0000401                          
03-05-04 19:49 tiwai          Note Added: 0000513                          
03-05-04 20:37 jorge2         Note Added: 0000515                          
03-06-04 18:20 matsgora       Note Added: 0000520                          
03-07-04 16:30 dale           Note Added: 0000524                          
03-09-04 15:15 tiwai          Note Added: 0000547                          
03-09-04 18:12 matsgora       Note Added: 0000551                          
06-08-04 20:25 jorge2         Note Added: 0001296                          
06-15-04 15:00 mcbridematt    Note Added: 0001308                          
11-22-04 18:48 tiwai          Relationship added       has duplicate 0000664
02-02-05 14:25 dale           Note Added: 0003488                          
02-04-05 13:18 tiwai          Note Added: 0003504                          
02-04-05 13:19 tiwai          File Added: ac97-alc-fix.diff                    
02-04-05 18:03 jorge2         Note Added: 0003512                          
02-05-05 13:27 jorge2         Issue Monitored: jorge2                      
02-21-05 09:16 dale           Note Added: 0003678                          
02-23-05 09:54 dale           Issue Monitored: dale                        
06-14-05 21:20 graf_eichbaum  Issue Monitored: graf_eichbaum                    
06-20-05 06:48 wenton         Note Added: 0005093                          
06-22-05 19:50 dale           Note Added: 0005145                          
06-24-05 08:54 wenton         Note Added: 0005204                          
06-28-05 10:50 dale           Note Added: 0005294                          
07-07-05 18:05 graf_eichbaum  Note Added: 0005400                          
07-16-05 16:55 jdthood        Reporter                 user74 => -VoltagE- 
07-16-05 16:55 jdthood        Status                   new => confirmed    
07-16-05 16:55 jdthood        version                  1.0.2 => 1.0.8      
07-16-05 16:55 jdthood        Summary                  No sound from external
speakers (laptop) => Sound from internal speakers but not from headphones --
Acer272xv
07-16-05 16:55 jdthood        Description Updated                          
07-16-05 19:27 dale           Issue End Monitor: dale                      
07-16-05 19:28 dale           Issue Monitored: dale                        
07-17-05 13:18 jorge2         Note Added: 0005507                          
08-02-05 21:17 ignition       Issue Monitored: ignition                    
09-29-05 12:30 jdthood        Summary                  Sound from internal
speakers but not from headphones -- Acer272xv => No sound from headphone jack on
Acer27* laptops
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
