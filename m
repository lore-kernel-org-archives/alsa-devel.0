From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: via82xx: unreliable audio, strange mixer behavior
Date: Fri, 21 Nov 2008 07:08:23 -0500
Message-ID: <20081121120823.GD3899@storm.local.network>
References: <20081120170409.GG17813@storm.local.network>
	<s5hk5ax8f3l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4819963427384554753=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.webfaction.com (mail3.webfaction.com [70.85.44.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 34D5A24474
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 13:08:31 +0100 (CET)
In-Reply-To: <s5hk5ax8f3l.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4819963427384554753==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline


--47eKBCiAZYFK5l32
Content-Type: multipart/mixed; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 21, 2008 at 12:59:10PM +0100, Takashi Iwai wrote:
> At Thu, 20 Nov 2008 12:04:09 -0500,
> Forest Bond wrote:
>>=20
>> Hi,
>>=20
>> I'm using snd-via82xx on an Ubuntu 8.04 system.  alsa-info.sh output is =
here:
>>=20
>> http://www.alsa-project.org/db/?f=3D1c3d5570e7b57d4d2f79b964a323dd7b4efd=
7e78
>>=20
>> Here are the symptoms:
>>=20
>> Audio goes away after a semi-random interval.  Sometimes it returns after
>> `modprobe -r snd-via82xx' followed by `modprobe snd-via82xx', but someti=
mes it
>> seems to take a full reboot.
>>=20
>> This looks similar to:
>>=20
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D3D3194
>>=20
>> Some folks think that this kind of issue is triggered by audio volume be=
ing
>> above a certain level.  I'm not entirely sure if this is true, but I thi=
nk it
>> is.  One time, I apparently triggered the issue by unplugging and replug=
ging the
>> audio cable from the mainboard during playback.
>>=20
>> Audio can be heard even when the PCM volume level is 0 (as told by alsam=
ixer).
>> The volume does get louder when I turn up that mixer control, but it nev=
er goes
>> away entirely when I turn the volume to zero.  Mute works as expected.
>=20
> The volume 0 doesn't always mean the mute on several hardwares.
> So this can be irrelevant if it happens always.
>=20
> I vaguely remember about the low-power mode of some codec chips.
> Which codec chip does your system have?  Please run alsa-info.sh with
> --no-upload option, and attach the output file.

The output would be the same as what was already uploaded, right?  I've att=
ached
that output here for your convenience.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-info.sh.output"
Content-Transfer-Encoding: quoted-printable


!!################################
!!ALSA Information Script v 0.4.52
!!################################

!!Script ran on: Wed Nov 19 19:00:52 UTC 2008


!!Linux Distribution
!!------------------

Ubuntu 8.04.1 \n \l DISTRIB_ID=3DUbuntu DISTRIB_DESCRIPTION=3D"Ubuntu 8.04.=
1"


!!Kernel Information
!!------------------

Kernel release:    2.6.24-21-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.16
Library version:   =20
Utilities version:  1.0.15


!!Loaded ALSA modules
!!-------------------

snd_via82xx


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [V8237          ]: VIA8237 - VIA 8237
                      VIA 8237 with VIA1617A at 0xf000, irq 19


!!PCI Soundcards installed in the system
!!--------------------------------------

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8=
237 AC97 Audio Controller (rev 60)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:11.5 0401: 1106:3059 (rev 60)
	Subsystem: 16f3:4170


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-usb-audio: index=3D-2
snd-usb-usx2y: index=3D-2
snd-usb-caiaq: index=3D-2
snd-cmipci: mpu_port=3D0x330 fm_port=3D0x388


!!Loaded sound module options
!!--------------------------

!!Module: snd_via82xx
ac97_clock : 48000
ac97_quirk : <NULL>
dxs_support : 5
enable : N
id : <NULL>
index : -1
joystick : N
mpu_port : 0


!!AC97 Codec information
!!---------------------------
--startcollapse--

0-0/0: VIA Technologies VIA1617A

PCI Subsys Vendor: 0x16f3
PCI Subsys Device: 0x4170

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : IC Ensemble/KS Waves

Current setup
Mic gain         :  0dB [ 0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=3D0 rev=3D2 LDAC SDAC CDAC DSA=3D0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3D3/4 VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=3D0x22 Generation=3D1 Ra=
te=3D48kHz

0:00 =3D 6d50
0:02 =3D 0808
0:04 =3D 9f1f
0:06 =3D 801f
0:08 =3D 0000
0:0a =3D 801e
0:0c =3D 801f
0:0e =3D 801f
0:10 =3D 9f1f
0:12 =3D 9f1f
0:14 =3D 0000
0:16 =3D 9f1f
0:18 =3D 0808
0:1a =3D 0000
0:1c =3D 0000
0:1e =3D 0000
0:20 =3D 0000
0:22 =3D 0000
0:24 =3D 0001
0:26 =3D 800f
0:28 =3D 09c7
0:2a =3D 05c1
0:2c =3D bb80
0:2e =3D bb80
0:30 =3D bb80
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 9f9f
0:38 =3D 9f9f
0:3a =3D 2a20
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
0:5a =3D 0200
0:5c =3D 0000
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D ffff
0:64 =3D ffff
0:66 =3D 0000
0:68 =3D 0000
0:6a =3D 0000
0:6c =3D 3760
0:6e =3D 0000
0:70 =3D 0000
0:72 =3D 0000
0:74 =3D 0004
0:76 =3D 0000
0:78 =3D 0070
0:7a =3D 0370
0:7c =3D 5649
0:7e =3D 4170
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Nov 19 17:57 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 24 Nov 19 17:57 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Nov 19 18:48 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 25 Nov 19 17:57 /dev/snd/pcmC0D1c
crw-rw---- 1 root audio 116, 17 Nov 19 17:57 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  1 Nov 19 17:57 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Nov 19 17:57 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: V8237 [VIA 8237], device 0: VIA 8237 [VIA 8237]
  Subdevices: 3/4
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
card 0: V8237 [VIA 8237], device 1: VIA 8237 [VIA 8237]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: V8237 [VIA 8237], device 0: VIA 8237 [VIA 8237]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: V8237 [VIA 8237], device 1: VIA 8237 [VIA 8237]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [V8237]

Card hw:0 'V8237'/'VIA 8237 with VIA1617A at 0xf000, irq 19'
  Mixer name	: 'VIA Technologies VIA1617A'
  Components	: 'AC97a:56494170'
  Controls      : 53
  Simple ctrls  : 38
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [-12.00dB] [on]
  Front Right: Playback 23 [74%] [-12.00dB] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-46.50dB] [off]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-46.50dB] [off]
  Front Right: Playback 0 [0%] [-46.50dB] [off]
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [on]
  Front Right: Playback 23 [74%] [0.00dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-46.50dB] [off]
  Front Right: Playback 0 [0%] [-46.50dB] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-46.50dB] [off]
Simple mixer control 'Center/LFE Exchange',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-46.50dB] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [off]
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mic Boost ( 20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 0 [0%] [-45.00dB] [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities: enum
  Items: 'Mix' 'Mic'
  Item0: 'Mix'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [on]
  Front Right: Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Alternate Level to Surround Out',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Downmix LFE and Center to Front',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Downmix Surround to Front',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Input Source Select',0
  Capabilities: enum
  Items: 'Input1' 'Input2'
  Item0: 'Input1'
Simple mixer control 'Input Source Select',1
  Capabilities: enum
  Items: 'Input1' 'Input2'
  Item0: 'Input1'
Simple mixer control 'Smart 5.1 Select',0
  Capabilities: enum
  Items: 'LineIn Mic1' 'LineIn Mic1 Mic3' 'Surr LFE/C Mic3' 'LineIn LFE/C M=
ic3' 'LineIn Mic2' 'LineIn Mic2 Mic1' 'Surr LFE Mic1' 'Surr LFE Mic1 Mic2'
  Item0: 'LineIn Mic1'
Simple mixer control 'VIA DXS',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [-48.00dB]
  Front Right: Playback 31 [100%] [-48.00dB]
Simple mixer control 'VIA DXS',1
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [-48.00dB]
  Front Right: Playback 31 [100%] [-48.00dB]
Simple mixer control 'VIA DXS',2
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [-48.00dB]
  Front Right: Playback 31 [100%] [-48.00dB]
Simple mixer control 'VIA DXS',3
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [-48.00dB]
  Front Right: Playback 31 [100%] [-48.00dB]


!!Alsactl output
!!-------------

--startcollapse--
state.V8237 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center/LFE Exchange'
		value false
	}
	control.2 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'LineIn Mic1'
		comment.item.1 'LineIn Mic1 Mic3'
		comment.item.2 'Surr LFE/C Mic3'
		comment.item.3 'LineIn LFE/C Mic3'
		comment.item.4 'LineIn Mic2'
		comment.item.5 'LineIn Mic2 Mic1'
		comment.item.6 'Surr LFE Mic1'
		comment.item.7 'Surr LFE Mic1 Mic2'
		iface MIXER
		name 'Smart 5.1 Select'
		value 'LineIn Mic1'
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 23
		value.1 23
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Center Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'LFE Playback Volume'
		value 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 false
		value.1 false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Surround Playback Volume'
		value.0 0
		value.1 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Headphone Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Mono Playback Switch'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 0
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost ( 20dB)'
		value false
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.27 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 23
		value.1 23
	}
	control.30 {
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
		value.0 Mic
		value.1 Mic
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.32 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.33 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.34 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.35 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.36 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 0
	}
	control.37 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 0
	}
	control.38 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000f0000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
	}
	control.39 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value cf00000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000
	}
	control.40 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '008200020000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
	}
	control.41 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.42 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 0
	}
	control.43 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Alternate Level to Surround Out'
		value false
	}
	control.44 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Downmix LFE and Center to Front'
		value false
	}
	control.45 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Downmix Surround to Front'
		value false
	}
	control.46 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value false
	}
	control.47 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Input1
		comment.item.1 Input2
		iface MIXER
		name 'Input Source Select'
		value Input1
	}
	control.48 {
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
	control.49 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.50 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		value.0 31
		value.1 31
	}
	control.51 {
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
	control.52 {
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
	control.53 {
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
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_via82xx
gameport
snd_ac97_codec
ac97_bus
snd_mpu401_uart
snd_rawmidi
via
drm
video
output
sbs
sbshc
container
ipv6
joydev
pl2303
usbserial
evdev
af_packet
serio_raw
psmouse
hci_usb
bluetooth
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_page_alloc
snd_seq
snd_timer
snd_seq_device
snd
soundcore
i2c_viapro
i2c_core
button
shpchp
pci_hotplug
via_agp
agpgart
usbtouchscreen
usbhid
hid
ext3
jbd
mbcache
sg
sd_mod
pata_via
via_rhine
mii
ehci_hcd
uhci_hcd
pata_acpi
ata_generic
usbcore
libata
scsi_mod
fan
fbcon
tileblit
font
bitblit
softcursor



--pQhZXvAqiZgbeUkD--

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJJqS3RO4fQQdv5AwRApNcAJsEiGK4NCSS+9fg76ztCelFunL/RQCeLU5d
6FEJqC4XVF2DMHvGCdRgnZQ=
=7bpr
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--

--===============4819963427384554753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4819963427384554753==--
