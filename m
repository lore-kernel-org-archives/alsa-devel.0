From: Orestes Mas <orestes@tsc.upc.es>
Subject: Deeper problem reporting
Date: 11 Oct 2002 15:32:08 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <1034343128.9268.40.camel@oersted>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-user>
To: alsa-user@sourceforge.net
Cc: alsa-devel@sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some days ago I reported some problems on the ALSA system I have. After
some deeper investigations, I can offer more information on them:

1) Starting multimedia applications: All multimedia players, like xmms,
xine, realplay, etc. hang during a minute or so when they start, with
normal behavior from then. However, I discovered it only happens when I
start them from within KDE2. They start normally when I use WindowMaker
(I've not tried Gnome). Moreover, after waiting some time, Xine triggers
the error "Xine engine error: There is no available input plugin to
handle 'xine-ui version 0.9.8". In WindowMaker Xine works nicely.
In the other hand, sounds generated directly by KDE (desktop events)
present no delays.
I think this is a problem of the KDE sound daemon, but I have not enough
skills to solve it without help.

2) Sound volume too low: I've an intel motherboard with a i845 chipset
(ICH4). To put sound to work, I've had to use the latest ALSA version
borrowed directly from CVS. Now the sound works OK (except for the
problem stated in 1), but with noticeabily low volume. I've used
alsamixer to put all volumes to the maximum, ***but I've noticed that
the master volume control doesn't work at all (I can change level, but
the sound's volume isn't affected)***

Can anyone point me in the good direction to solve these problems?

I include some listings of the /proc/asound directory for they may help.

Thanks.

Kernel: 2.4.18
ALSA version 0.9.0rc3 (CVS version)

-------------- /proc/asound/cards
~$ cat /proc/asound/cards
0 [card0          ]: ICH - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 at 0xfebffc00, irq 5

-------------- /proc/asound/devices
~$ cat /proc/asound/devices
  0: [0- 0]: ctl
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

-------------- /proc/asound/pcm
~$ cat /proc/asound/pcm
00-00: Intel ICH : Intel 82801DB-ICH4 : playback 1 : capture 1

-------------- /proc/asound/timers
~$ cat /proc/asound/timers
G0: system timer : 10000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE

-------------- /proc/asound/card0/ac97#0
~$ cat /proc/asound/card0/ac97#0
0-0/0: Analog Devices AD1981A

Capabilities     : -headphone out-
DAC resolution   : 20-bit
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
Extended ID      : codec=3D0 rev=3D1 AMAP DSA=3D0 VRA
Extended status  : VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz

AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000

-------------- /proc/asound/card0/ac97#0regs
0:00 =3D 0090     0:20 =3D 0000     0:40 =3D 0000     0:60 =3D 8080
0:02 =3D 0000     0:22 =3D 0000     0:42 =3D 0000     0:62 =3D 0000
0:04 =3D 1f1f     0:24 =3D 0000     0:44 =3D 0000     0:64 =3D 8000
0:06 =3D 0015     0:26 =3D 000f     0:46 =3D 0000     0:66 =3D 0000
0:08 =3D 0000     0:28 =3D 0601     0:48 =3D 0000     0:68 =3D 0000
0:0a =3D 0000     0:2a =3D 0001     0:4a =3D 0000     0:6a =3D 0000
0:0c =3D 0003     0:2c =3D ac44     0:4c =3D 0000     0:6c =3D 0000
0:0e =3D 801f     0:2e =3D 0000     0:4e =3D 0000     0:6e =3D 0000
0:10 =3D 0000     0:30 =3D 0000     0:50 =3D 0000     0:70 =3D 0000
0:12 =3D 0606     0:32 =3D bb80     0:52 =3D 0000     0:72 =3D 000c
0:14 =3D 0000     0:34 =3D 0000     0:54 =3D 0000     0:74 =3D 1000
0:16 =3D 0000     0:36 =3D 0000     0:56 =3D 0000     0:76 =3D 0010
0:18 =3D 0000     0:38 =3D 0000     0:58 =3D 0000     0:78 =3D 0000
0:1a =3D 0505     0:3a =3D 2000     0:5a =3D 0000     0:7a =3D 0000
0:1c =3D 0707     0:3c =3D 0000     0:5c =3D 0000     0:7c =3D 4144
0:1e =3D 0000     0:3e =3D 0000     0:5e =3D 0000     0:7e =3D 5372

-------------- /proc/asound/card0/ac97#0regs
orestes@oersted:~$ cat /proc/asound/card0/intel8x0
Intel8x0

Global control        : 0x00000002
Global status         : 0x10700000
SDM                   : 0x00000002
AC'97 codecs ready    : tertiary
AC'97 codecs SDIN     : 2 0 0

-------------- /proc/asound/card0/ac97#0regs
orestes@oersted:~$ cat /proc/asound/card0/oss_mixer
VOLUME "Master" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "PCM" 0
SPEAKER "" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "Aux" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "Phone" 0
PHONEOUT "" 0
VIDEO "Video" 0
RADIO "" 0
MONITOR "" 0

I'hope this is enough to help trace the problem...
--=20
****************************************
* Orestes Mas                          *
* Universitat Polit=E8cnica de Catalunya *
* Gran Capit=E0 s/n M=F2dul D4             *
* Tel.: +34.93.401.70.72               *
* Fax.: +34.93.401.72.00               *
* email: orestes@tsc.upc.es            *
****************************************



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
