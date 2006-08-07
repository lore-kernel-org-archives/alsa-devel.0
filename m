From: Christoph Lameter <christoph@lameter.com>
Subject: Re: P4M800PRO Mobo with VIA8237 (ALC655) no sound
Date: Mon, 7 Aug 2006 09:49:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608070930080.3308@graphe.net>
References: <Pine.LNX.4.64.0608041624260.9917@graphe.net>
	<s5hwt9kralg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hwt9kralg.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Aug 2006, Takashi Iwai wrote:

> VIA8237 has "VIA DXS" playback volumes.  They should be 100% (and are
> so as default).

They are all on.

> Otherwise, it's a problem of ac97 mixer setting for ALC655.
> Please attach the generated file by "alsactl -f somefile store", and 
> the contents of /proc/asound/card0/codec97#0/* files for further
> checking.

state.V8237 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 16
		value.1 16
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Center Playback Volume'
		value 31
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'LFE Playback Volume'
		value 30
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Surround Playback Volume'
		value.0 31
		value.1 31
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Mono Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 31
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 11
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 31
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 31
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB) Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 31
		value.1 31
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 31
		value.1 31
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 31
		value.1 31
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 31
		value.1 31
	}
	control.26 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
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
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 15
		value.1 15
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.30 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select Capture Switch'
		value Mic1
	}
	control.31 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.32 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.33 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 0
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Duplicate Front'
		value false
	}
	control.37 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Shared
		comment.item.1 Independent
		iface MIXER
		name 'Surround Jack Mode'
		value Shared
	}
	control.38 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 '2ch'
		comment.item.1 '4ch'
		comment.item.2 '6ch'
		iface MIXER
		name 'Channel Mode'
		value '2ch'
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
	}
	control.40 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 PCM
		comment.item.1 'Analog In'
		comment.item.2 'IEC958 In'
		iface MIXER
		name 'IEC958 Playback Source'
		value PCM
	}
	control.41 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value false
	}
	control.42 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Input1
		comment.item.1 Input2
		iface MIXER
		name 'Input Source Select'
		value Input1
	}
	control.43 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Input1
		comment.item.1 Input2
		iface MIXER
		name 'Input Source Select'
		index 1
		value Input1
	}
	control.44 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.45 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		value.0 31
		value.1 31
	}
	control.46 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		index 1
		value.0 31
		value.1 31
	}
	control.47 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		index 2
		value.0 31
		value.1 31
	}
	control.48 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		index 3
		value.0 31
		value.1 31
	}
}
state.CMI8738MC6 {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 25
		value.1 25
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 25
		value.1 25
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Capture Switch'
		value.0 false
		value.1 false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Synth Playback Volume'
		value.0 25
		value.1 25
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Synth Playback Switch'
		value true
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 4
		iface MIXER
		name 'Synth Capture Route'
		value.0 false
		value.1 false
		value.2 false
		value.3 false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 25
		value.1 25
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'CD Playback Switch'
		value.0 true
		value.1 true
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 4
		iface MIXER
		name 'CD Capture Route'
		value.0 false
		value.1 false
		value.2 false
		value.3 false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 4
		iface MIXER
		name 'Line Capture Route'
		value.0 false
		value.1 false
		value.2 false
		value.3 false
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Capture Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 2
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Aux Playback Switch'
		value.0 false
		value.1 false
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Aux Capture Switch'
		value.0 false
		value.1 false
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost Playback Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 7'
		iface MIXER
		name 'Mic Capture Volume'
		value 0
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 7'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Speaker Playback Switch'
		value true
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost Capture Switch'
		value false
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Four Channel Mode'
		value true
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Line-In
		comment.item.1 'Rear Output'
		comment.item.2 'Bass Output'
		iface MIXER
		name 'Line-In Mode'
		value Line-In
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 In Valid'
		value false
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Copyright'
		value false
	}
	control.33 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 5V'
		value true
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Loop'
		value false
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 In Monitor'
		value false
	}
	control.36 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.37 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback Con Mask'
		value ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.38 {
		comment.access 'read write inactive'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback PCM Stream'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 In Select'
		value false
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 In Phase Inverse'
		value false
	}
	control.41 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic-In
		comment.item.1 'Center/LFE Output'
		iface MIXER
		name 'Mic-In Mode'
		value 'Center/LFE Output'
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name Modem
		value false
	}
}

0-0/0: Realtek ALC655 rev 0

PCI Subsys Vendor: 0x4005
PCI Subsys Device: 0x4760

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
0:00 = 0000
0:02 = 0f0f
0:04 = 0000
0:06 = 8000
0:08 = 0000
0:0a = 8008
0:0c = 8000
0:0e = 8000
0:10 = 8000
0:12 = 8000
0:14 = 0000
0:16 = 0000
0:18 = 0000
0:1a = 0606
0:1c = 0f0f
0:1e = 0000
0:20 = 0400
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 09c4
0:2a = 05c4
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 0100
0:38 = 0000
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
0:68 = 0aea
0:6a = 8000
0:6c = 0000
0:6e = 0025
0:70 = 81e0
0:72 = 22e8
0:74 = 8000
0:76 = 0000
0:78 = 0007
0:7a = a092
0:7c = 414c
0:7e = 4760

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
