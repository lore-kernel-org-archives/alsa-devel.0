From: "a.renault@kaptalia.com" <a.renault@kaptalia.com>
Subject: Re: [alsa] Crackling after 6.45 hours
Date: Mon, 26 Jan 2015 15:41:53 +0100
Message-ID: <39512580.o0cGg5VYGZ@linux-le0l.site>
References: <3427562.sVz54J9OhN@linux-le0l.site> <54C62E62.3060904@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1576294.ymWlTpRRuz"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 39FFD2605D7
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 15:41:57 +0100 (CET)
In-Reply-To: <54C62E62.3060904@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--nextPart1576294.ymWlTpRRuz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le lundi 26 janvier 2015 13:09:06 Lars-Peter Clausen a =E9crit :
> On 01/23/2015 03:34 PM, a.renault@kaptalia.com wrote:
> > Hi everyone,
> >=20
> > I currently facing the following issue :
> >=20
> > My sound crackling after 6.45 hours of music without reinitializati=
on.
> >=20
> > I am using sdl-mixer, sdl and alsa.
> >=20
> > I deployed a bug on libsdl at the address :
> > https://bugzilla.libsdl.org/show_bug.cgi?id=3D2794
> > And after some works we discover that the snd_pcm_writei answer
> > "-1073741824".
> >=20
> > The error code "-1073741824" is not one of -EINTR, -EPIPE, -ESTRPIP=
E,
> > -EAGAIN. So "snd_pcm_recover" does not handle anything.
> >=20
> > If you are brave enought please take a look at the link,
> >=20
> > Any idea would be greatly appreciated.
>=20
> Hi,
>=20
> What's your hardware. Can you run the alsa-info.sh[1] script and send=
 the
> output to the mailing list?
Hi,=20

First of all, I had to comment the lspci part of the script because I a=
m using=20
busybox on my imx6. (Did not found a way to add it :S)

Then I have got this card : http://www.msc-technologies.eu/products/boa=
rds/qseven/msc-q7-imx6.html
with a Wolfson WM9711.

I hope the log file will be enough,
Best regards,
>=20
> Thanks,
> - Lars
>=20
> [1] http://www.alsa-project.org/main/index.php/Help_To_Debug
--=20
Adrien
--nextPart1576294.ymWlTpRRuz
Content-Disposition: attachment; filename="alsa-info.txt.imx6"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="alsa-info.txt.imx6"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Fri Jan 23 16:57:29 UTC 2015


!!Linux Distribution
!!------------------




!!DMI Information
!!---------------

Manufacturer:      
Product Name:      
Product Version:   
Firmware Version:  


!!Kernel Information
!!------------------

Kernel release:    3.0.35.Q7_IMX6-13.12.01
Operating System:  GNU/Linux
Architecture:      armv7l
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.24
Library version:    
Utilities version:  1.0.27.2


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [q7imx6ac97audio]: q7-imx6-ac97-au - q7-imx6-ac97-audio
                      q7-imx6-ac97-audio


!!Loaded sound module options
!!---------------------------


!!AC97 Codec information
!!----------------------
--startcollapse--

0-0/0: Wolfson WM9711,WM9712,WM9715

PCI Subsys Vendor: 0x0000
PCI Subsys Device: 0x0000

Flags: f410
Capabilities     : -bass & treble- -headphone out- -loudness-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : Wolfson Microelectronics 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=7/8 VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

0:00 = 6174
0:02 = 0e0e
0:04 = 0000
0:06 = 000e
0:08 = 0f0f
0:0a = 0800
0:0c = 801f
0:0e = 6808
0:10 = bf1f
0:12 = 0000
0:14 = 0800
0:16 = 0008
0:18 = 2808
0:1a = 3000
0:1c = 8f0f
0:1e = 0400
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0405
0:2a = 0411
0:2c = ac44
0:2e = bb80
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
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
0:4c = f83e
0:4e = ffff
0:50 = 0000
0:52 = 0000
0:54 = 0808
0:56 = f83e
0:58 = 000c
0:5a = 0040
0:5c = 0000
0:5e = 0400
0:60 = 0808
0:62 = 0808
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0080
0:76 = 0006
0:78 = 0001
0:7a = 0000
0:7c = 574d
0:7e = 4c12
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----    1 root     audio     116,   0 Jan  1  1970 /dev/snd/controlC0
crw-rw----    1 root     audio     116,  24 Jan  1  1970 /dev/snd/pcmC0D0c
crw-rw----    1 root     audio     116,  16 Jan  1  1970 /dev/snd/pcmC0D0p
crw-rw----    1 root     audio     116,  33 Jan  1  1970 /dev/snd/timer

/dev/snd/by-path:
drwxr-xr-x    2 root     root            60 Jan  1  1970 .
drwxr-xr-x    3 root     root           140 Jan  1  1970 ..
lrwxrwxrwx    1 root     root            12 Jan  1  1970 platform-soc-audio -> ../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

defaults.pcm.rate_converter "linear"

pcm.dmix_48000{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 48000
}
}

pcm.dmix_44100{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 44100
}
}

pcm.dmix_32000{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 32000
}
}

pcm.dmix_24000{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 24000
}
}

pcm.dmix_22050{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 22050
}
}

pcm.dmix_16000{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 16000
}
}

pcm.dmix_12000{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 12000
}
}

pcm.dmix_11025{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 11025
}
}

pcm.dmix_8000{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 8000
}
}

pcm.!dsnoop_48000{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 48000
}
}

pcm.!dsnoop_44100{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 44100
}
}

pcm.!dsnoop_32000{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 32000
}
}

pcm.!dsnoop_24000{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 24000
}
}

pcm.!dsnoop_22050{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 22050
}
}

pcm.!dsnoop_16000{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 16000
}
}

pcm.!dsnoop_12000{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 12000
}
}

pcm.!dsnoop_11025{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 11025
}
}

pcm.!dsnoop_8000{
type dsnoop
ipc_key 5778293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 10000
buffer_time 512000
format S16_LE
rate 8000
}
}

pcm.asymed{
type asym
playback.pcm "dmix_44100"
capture.pcm "dsnoop_44100"
}

pcm.dsp0{
type plug
slave.pcm "asymed"
}

pcm.!default{
type plug
route_policy "average"
slave.pcm "asymed"
}

ctl.mixer0{
type hw
card 0
}


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: q7imx6ac97audio [q7-imx6-ac97-audio], device 0: AC97 HiFi ac97-hifi-0 []
  Subdevices: 0/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: q7imx6ac97audio [q7-imx6-ac97-audio], device 0: AC97 HiFi ac97-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [q7imx6ac97audio]:]

Card hw:0 'q7imx6ac97audio'/'q7-imx6-ac97-audio'
  Mixer name	: 'Wolfson WM9711,WM9712,WM9715'
  Components	: 'AC97a:574d4c12'
  Controls      : 93
  Simple ctrls  : 75
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-21.00dB] [on]
  Front Right: Playback 17 [55%] [-21.00dB] [on]
Simple mixer control 'Master Left Inv',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-21.00dB] [on]
  Front Right: Playback 17 [55%] [-21.00dB] [on]
Simple mixer control 'Master ZC',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Headphone ZC',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Tone Cut-off',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'Bass Control',0
  Capabilities: enum
  Items: 'Linear Control' 'Adaptive Boost'
  Item0: 'Linear Control'
Simple mixer control 'Bass Cut-off',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 0 [0%]
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
Simple mixer control 'PCM Out Path & Mute',0
  Capabilities: enum
  Items: 'pre 3D' 'post 3D'
  Item0: 'pre 3D'
Simple mixer control 'PCM Playback to Headphone',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PCM Playback to Master',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PCM Playback to Phone',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Side Tone',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%] Playback [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Line to Headphone',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Line to Master',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Line to Phone',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic 1',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 23 [74%]
Simple mixer control 'Mic 1 to Phone',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic 2',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 23 [74%]
Simple mixer control 'Mic 2 to Phone',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic 20dB Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Mic Select Source',0
  Capabilities: enum
  Items: 'Mic 1' 'Differential' 'Mic 2' 'Stereo'
  Item0: 'Mic 1'
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Phone to Headphone',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Phone to Master',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 1 [33%]
Simple mixer control 'Beep to Headphone',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%] Playback [on]
Simple mixer control 'Beep to Phone',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%] Playback [on]
Simple mixer control 'Beep to Side Tone',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%] Playback [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [on]
  Front Right: Playback 23 [74%] [0.00dB] [on]
Simple mixer control 'Aux to Headphone',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%] Playback [on]
Simple mixer control 'Aux to Phone',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%] Playback [on]
Simple mixer control 'Aux to Side Tone',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%] Playback [on]
Simple mixer control 'Mono Output Select',0
  Capabilities: enum
  Items: 'Mix' 'Mic'
  Item0: 'Mix'
Simple mixer control 'Mono ZC',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Playback Attenuate (-6dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 48 [76%]
  Front Right: Capture 48 [76%]
Simple mixer control 'Capture 20dB Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture Select',0
  Capabilities: enum
  Items: 'Mic 1' 'NC' 'NC' 'Master Mix' 'Line' 'Headphone Mix' 'Phone Mix' 'Phone'
  Item0: 'Mic 1'
  Item1: 'Mic 1'
Simple mixer control 'Capture Volume Steps',0
  Capabilities: enum
  Items: '+1.5dB Steps' '+0.75dB Steps'
  Item0: '+1.5dB Steps'
  Item1: '+1.5dB Steps'
Simple mixer control 'Capture ZC',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture to Phone 20dB Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture to Phone Mux',0
  Capabilities: enum
  Items: 'Stereo' 'Left' 'Right' 'Mute'
  Item0: 'Mute'
Simple mixer control '3D Lower Cut-off',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control '3D Upper Cut-off',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'ADC',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ALC Attack Time',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 8 [53%]
Simple mixer control 'ALC Decay Time',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'ALC Function',0
  Capabilities: enum
  Items: 'None' 'Left' 'Right' 'Stereo'
  Item0: 'None'
Simple mixer control 'ALC Headphone',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%]
Simple mixer control 'ALC Headphone Mux',0
  Capabilities: enum
  Items: 'Stereo' 'Right' 'Left' 'None'
  Item0: 'Left'
Simple mixer control 'ALC Hold Time',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 8 [53%]
Simple mixer control 'ALC Max',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 6 [86%]
Simple mixer control 'ALC NG',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ALC NG Threshold',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 23 [74%]
Simple mixer control 'ALC NG Type',0
  Capabilities: enum
  Items: 'Constant Gain' 'Mute'
  Item0: 'Constant Gain'
Simple mixer control 'ALC Target',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'ALC ZC',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ALC ZC Timeout',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Loudness (bass boost)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Out3',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 23 [74%] Playback [on]
Simple mixer control 'Out3 LR Mux',0
  Capabilities: enum
  Items: 'Master Mix' 'Headphone Mix'
  Item0: 'Master Mix'
Simple mixer control 'Out3 Mux',0
  Capabilities: enum
  Items: 'Left' 'VREF' 'Left + Right' 'Mono'
  Item0: 'Left'
Simple mixer control 'Out3 ZC',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!--------------

--startcollapse--
state.q7imx6ac97audio {
	control.1 {
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.2 {
		iface MIXER
		name 'Master Playback Volume'
		value.0 17
		value.1 17
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 -2100
			dbvalue.1 -2100
		}
	}
	control.3 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.4 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 31
		value.1 31
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
		iface MIXER
		name 'Master Mono Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.6 {
		iface MIXER
		name 'Master Mono Playback Volume'
		value 17
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 -2100
		}
	}
	control.7 {
		iface MIXER
		name 'Tone Control - Bass'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
		}
	}
	control.8 {
		iface MIXER
		name 'Tone Control - Treble'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
		}
	}
	control.9 {
		iface MIXER
		name 'Phone Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'Phone Playback Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
		}
	}
	control.11 {
		iface MIXER
		name 'Line Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.12 {
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.13 {
		iface MIXER
		name 'Aux Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.14 {
		iface MIXER
		name 'Aux Playback Volume'
		value.0 23
		value.1 23
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.15 {
		iface MIXER
		name 'PCM Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.16 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 23
		value.1 23
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.17 {
		iface MIXER
		name 'PCM Out Path & Mute'
		value 'pre 3D'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'pre 3D'
			item.1 'post 3D'
		}
	}
	control.18 {
		iface MIXER
		name '3D Control - Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'Loudness (bass boost)'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.20 {
		iface MIXER
		name 'Mono Output Select'
		value Mix
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mix
			item.1 Mic
		}
	}
	control.21 {
		iface MIXER
		name 'Mic Select'
		value Mic1
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic1
			item.1 Mic2
		}
	}
	control.22 {
		iface MIXER
		name '3D Control - Center'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
		}
	}
	control.23 {
		iface MIXER
		name '3D Control - Depth'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 1
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 3'
		}
	}
	control.29 {
		iface MIXER
		name 'ALC Target Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
		}
	}
	control.30 {
		iface MIXER
		name 'ALC Hold Time'
		value 8
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
		}
	}
	control.31 {
		iface MIXER
		name 'ALC Decay Time'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
		}
	}
	control.32 {
		iface MIXER
		name 'ALC Attack Time'
		value 8
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
		}
	}
	control.33 {
		iface MIXER
		name 'ALC Function'
		value None
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 None
			item.1 Left
			item.2 Right
			item.3 Stereo
		}
	}
	control.34 {
		iface MIXER
		name 'ALC Max Volume'
		value 6
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.35 {
		iface MIXER
		name 'ALC ZC Timeout'
		value 3
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 3'
		}
	}
	control.36 {
		iface MIXER
		name 'ALC ZC Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.37 {
		iface MIXER
		name 'ALC NG Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.38 {
		iface MIXER
		name 'ALC NG Type'
		value 'Constant Gain'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Constant Gain'
			item.1 Mute
		}
	}
	control.39 {
		iface MIXER
		name 'ALC NG Threshold'
		value 23
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
		}
	}
	control.40 {
		iface MIXER
		name 'Side Tone Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.41 {
		iface MIXER
		name 'Side Tone Volume'
		value 7
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.42 {
		iface MIXER
		name 'ALC Headphone Mux'
		value Left
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Stereo
			item.1 Right
			item.2 Left
			item.3 None
		}
	}
	control.43 {
		iface MIXER
		name 'ALC Headphone Volume'
		value 7
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.44 {
		iface MIXER
		name 'Out3 Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.45 {
		iface MIXER
		name 'Out3 ZC Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.46 {
		iface MIXER
		name 'Out3 Mux'
		value Left
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Left
			item.1 VREF
			item.2 'Left + Right'
			item.3 Mono
		}
	}
	control.47 {
		iface MIXER
		name 'Out3 LR Mux'
		value 'Master Mix'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Master Mix'
			item.1 'Headphone Mix'
		}
	}
	control.48 {
		iface MIXER
		name 'Out3 Volume'
		value 23
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
		}
	}
	control.49 {
		iface MIXER
		name 'Beep to Headphone Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.50 {
		iface MIXER
		name 'Beep to Headphone Volume'
		value 7
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.51 {
		iface MIXER
		name 'Beep to Side Tone Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.52 {
		iface MIXER
		name 'Beep to Side Tone Volume'
		value 7
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.53 {
		iface MIXER
		name 'Beep to Phone Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.54 {
		iface MIXER
		name 'Beep to Phone Volume'
		value 7
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.55 {
		iface MIXER
		name 'Aux to Headphone Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.56 {
		iface MIXER
		name 'Aux to Headphone Volume'
		value 7
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.57 {
		iface MIXER
		name 'Aux to Side Tone Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.58 {
		iface MIXER
		name 'Aux to Side Tone Volume'
		value 7
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.59 {
		iface MIXER
		name 'Aux to Phone Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.60 {
		iface MIXER
		name 'Aux to Phone Volume'
		value 7
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.61 {
		iface MIXER
		name 'Phone to Headphone Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.62 {
		iface MIXER
		name 'Phone to Master Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.63 {
		iface MIXER
		name 'Line to Headphone Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.64 {
		iface MIXER
		name 'Line to Master Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.65 {
		iface MIXER
		name 'Line to Phone Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.66 {
		iface MIXER
		name 'PCM Playback to Headphone Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.67 {
		iface MIXER
		name 'PCM Playback to Master Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.68 {
		iface MIXER
		name 'PCM Playback to Phone Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.69 {
		iface MIXER
		name 'Capture 20dB Boost Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.70 {
		iface MIXER
		name 'Capture to Phone Mux'
		value Mute
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Stereo
			item.1 Left
			item.2 Right
			item.3 Mute
		}
	}
	control.71 {
		iface MIXER
		name 'Capture to Phone 20dB Boost Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.72 {
		iface MIXER
		name 'Capture Select'
		value.0 'Mic 1'
		value.1 'Mic 1'
		comment {
			access 'read write'
			type ENUMERATED
			count 2
			item.0 'Mic 1'
			item.1 NC
			item.2 NC
			item.3 'Master Mix'
			item.4 Line
			item.5 'Headphone Mix'
			item.6 'Phone Mix'
			item.7 Phone
		}
	}
	control.73 {
		iface MIXER
		name '3D Upper Cut-off Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.74 {
		iface MIXER
		name '3D Lower Cut-off Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.75 {
		iface MIXER
		name 'Bass Control'
		value 'Linear Control'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Linear Control'
			item.1 'Adaptive Boost'
		}
	}
	control.76 {
		iface MIXER
		name 'Bass Cut-off Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.77 {
		iface MIXER
		name 'Tone Cut-off Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.78 {
		iface MIXER
		name 'Playback Attenuate (-6dB) Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.79 {
		iface MIXER
		name 'ADC Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.80 {
		iface MIXER
		name 'Capture Volume Steps'
		value.0 '+1.5dB Steps'
		value.1 '+1.5dB Steps'
		comment {
			access 'read write'
			type ENUMERATED
			count 2
			item.0 '+1.5dB Steps'
			item.1 '+0.75dB Steps'
		}
	}
	control.81 {
		iface MIXER
		name 'Capture Volume'
		value.0 48
		value.1 48
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
		}
	}
	control.82 {
		iface MIXER
		name 'Capture ZC Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.83 {
		iface MIXER
		name 'Mic 1 to Phone Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.84 {
		iface MIXER
		name 'Mic 2 to Phone Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.85 {
		iface MIXER
		name 'Mic Select Source'
		value 'Mic 1'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Mic 1'
			item.1 Differential
			item.2 'Mic 2'
			item.3 Stereo
		}
	}
	control.86 {
		iface MIXER
		name 'Mic 1 Volume'
		value 23
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
		}
	}
	control.87 {
		iface MIXER
		name 'Mic 2 Volume'
		value 23
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
		}
	}
	control.88 {
		iface MIXER
		name 'Mic 20dB Boost Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.89 {
		iface MIXER
		name 'Master Left Inv Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.90 {
		iface MIXER
		name 'Master ZC Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.91 {
		iface MIXER
		name 'Headphone ZC Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.92 {
		iface MIXER
		name 'Mono ZC Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.93 {
		iface MIXER
		name 'External Amplifier'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ftdi_sio
usbserial


!!ALSA/HDA dmesg
!!--------------

[    4.551509] usbhid: USB HID core driver
[    4.552344] mxc_hdmi_soc mxc_hdmi_soc.0: MXC HDMI Audio
[    4.553143] imx-hdmi-soc-dai imx-hdmi-soc-dai.0: Failed: Load HDMI-video first.
[    4.577168] asoc: ac97-hifi <-> imx-ssi.0 mapping ok
[    4.578332] Initialize HDMI-audio failed. Load HDMI-video first!
[    4.578337] ALSA device list:
[    4.578342]   #0: q7-imx6-ac97-audio



--nextPart1576294.ymWlTpRRuz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart1576294.ymWlTpRRuz--
