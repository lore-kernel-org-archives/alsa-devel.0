From: Joel Wiramu Pauling <aenertia@aenertia.net>
Subject: Via Envyht-s and ICE1724 driver.
Date: Sun, 04 Jul 2004 15:53:46 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1088913226.10057.50.camel@rincewind.aenertia.net>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-XMTmNiJxXbF7T17SLGv6"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-XMTmNiJxXbF7T17SLGv6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi There Using a Gainward Hollywood@home 7.1 Card (This card uses the
via envy24ht-s chip).

There are a number of variously other branded cards comming out with
this chip(Dick Smith, Asound, XHT,) So I suggest that modifying/testing
the ice1724 driver to accomodate the envy24ht-s a little better would be
a good idea. 

By the way this is a nice sounding card for its price (~$20 US) and has
7.1 analog outputs and a digital out. 

I beleive the card uses the envy24 chip in a strange way, making it far
inferiour to say a terratec aureon which uses the envy24ht...

This hexus.net review explains it a little better, via has a marketing
page on the hts version aswell.
http://www.hexus.net/content/reviews/review.php?dXJsX3Jldmlld19JRD02ODcmdXJsX3BhZ2U9MQ==


Ok Now for the Bug/Device info.

I get this kernel message when loading the driver
Jul  3 21:34:54 rincewind kernel: ALSA sound/pci/ice1712/ice1724.c:1786:
invalid EEPROM version 1

Driver however loads fine, and operates pretty well considering it's not
officially supported (yet??).
Some applications (some sdl games i.e enigma) play sound too fast. 
Most that i've tried so far are ok.

I'll cut and paste whats in /proc/asound If there is any other
information that would be better/help let me know and i'll send it on.

First of pci devices listsing:

17: PCI 08.0: 0401 Multimedia audio controller
  [Created at pci.244]
  Unique ID: RE4e.yDajJf_9bW7
  SysFS ID: /devices/pci0000:00/0000:00:08.0
  SysFS BusID: 0000:00:08.0
  Hardware Class: sound
  Model: "IC Ensemble ICE1724 [Envy24HT]"
  Vendor: pci 0x1412 "IC Ensemble Inc"
  Device: pci 0x1724 "ICE1724 [Envy24HT]"
  SubVendor: pci 0x1412 "IC Ensemble Inc"
  SubDevice: pci 0x1724 
  Revision: 0x01
  Driver: "ICE1724"
  I/O Ports: 0x9400-0x941f (rw)
  I/O Ports: 0x9800-0x987f (rw)
  IRQ: 5 (173234 events)
  Driver Info #0:
    Driver Status: snd-ice1724 is active
    Driver Activation Cmd: "modprobe snd-ice1724"
  Config Status: cfg=no, avail=yes, need=no, active=unknown

/proc/asound/card0:
rincewind:/proc/asound/card0 # cat ice1724
AMP Ltd AUDIO2000 at 0x9400, irq 5

EEPROM:
  Subvendor        : 0x12142417
  Size             : 28 bytes
  Version          : 1
  System Config    : 0x2
  ACLink           : 0x2
  I2S              : 0x10
  S/PDIF           : 0xc1
  GPIO direction   : 0xff
  GPIO mask        : 0xff
  GPIO state       : 0xff
  Extra #18        : 0x1
  Extra #19        : 0x0
  Extra #20        : 0x0
  Extra #21        : 0x0
  Extra #22        : 0x0
  Extra #23        : 0x0
  Extra #24        : 0x0
  Extra #25        : 0x0
  Extra #26        : 0x0
  Extra #27        : 0x0

Registers:
  PSDOUT03 : 0x00000000
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x02
  CCS05    : 0x02
  CCS06    : 0x10
  CCS07    : 0xc1
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0x00
  CCS11    : 0x00
  CCS12    : 0x12
  CCS13    : 0x80
  CCS14    : 0x00
  CCS15    : 0xff
  CCS16    : 0xff
  CCS17    : 0x00
  CCS18    : 0xff
  CCS19    : 0x00
  CCS1a    : 0x00
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x2a
  CCS1f    : 0x00
  MT00     : 0x00
  MT01     : 0x00
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x3c
  MT05     : 0x08
  MT06     : 0x00
  MT07     : 0x00
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x00
  MT11     : 0x18
  MT12     : 0xbc
  MT13     : 0x7b
  MT14     : 0xff
  MT15     : 0x05
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x00
  MT19     : 0x03
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0xff
  MT1d     : 0x01
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x20
  MT22     : 0xb8
  MT23     : 0x7b
  MT24     : 0xff
  MT25     : 0x03
  MT26     : 0xff
  MT27     : 0x01
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x00
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00

cat id
AUDIO2000

rincewind:/proc/asound/card0 # cat oss_mixer
VOLUME "Master" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "PCM" 0
SPEAKER "PC Speaker" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "Headphone" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "Aux" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "Phone" 0
PHONEOUT "Master Mono" 0
VIDEO "Video" 0
RADIO "" 0
MONITOR "" 0

rincewind:/proc/asound/card0/codec97#0 # cat *
0-0/0: ICEnsemble VT1616i

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : IC Ensemble/KS Waves

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 LDAC SDAC CDAC DSA=0 VRA
Extended status  : LDAC SDAC CDAC VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
0:00 = 6d50
0:02 = 0909
0:04 = 1f1f
0:06 = 001f
0:08 = 0000
0:0a = 001e
0:0c = 001f
0:0e = 005f
0:10 = 1f1f
0:12 = 1f1f
0:14 = 1f1f
0:16 = 1f1f
0:18 = 0101
0:1a = 0606
0:1c = 0000
0:1e = 0000
0:20 = 2000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 01c1
0:2a = 01c1
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 1f1f
0:38 = 1f1f
0:3a = 0000
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
0:5a = 8a30
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 4943
0:7e = 4552

rincewind:/proc/asound/card0/pcm0c # cat *
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
cat: sub0: Is a directory
0
rincewind:/proc/asound/card0/pcm0c #

rincewind:/proc/asound/card0/pcm0c/sub0 # cat *
closed
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
256
closed
closed
rincewind:/proc/asound/card0/pcm0c/sub0 #



rincewind:/proc/asound/card0/pcm0p # cat *
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
cat: sub0: Is a directory
0
rincewind:/proc/asound/card0/pcm0p #

rincewind:/proc/asound/card0/pcm0p/sub0 # cat *
closed
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
256
closed
closed
rincewind:/proc/asound/card0/pcm0p/sub0 #



rincewind:/proc/asound/card0/pcm1p # cat *
card: 0
device: 1
subdevice: 0
stream: PLAYBACK
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
cat: sub0: Is a directory
0
rincewind:/proc/asound/card0/pcm1p #

rincewind:/proc/asound/card0/pcm1p/sub0 # cat *
closed
card: 0
device: 1
subdevice: 0
stream: PLAYBACK
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
64
closed
closed
rincewind:/proc/asound/card0/pcm1p/sub0 #

rincewind:/proc/asound/oss # cat *
  0: [0- 0]: mixer
  3: [0- 3]: digital audio
12: [0-12]: digital audio
  1:       : sequencer
  8:       : sequencer
Sound Driver:3.8.1a-980706 (ALSA v1.0.3 emulation code)
Kernel: Linux rincewind 2.6.4-52-default #1 Wed Apr 7 02:15:23 UTC 2004
x86_64
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
AMP Ltd AUDIO2000 at 0x9400, irq 5

Audio devices:
0: ICE1724 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: ICEnsemble VT1616i

rincewind:/proc/asound # cat *
cat: AUDIO2000: Is a directory
cat: card0: Is a directory
0 [AUDIO2000      ]: ICE1724 - AMP Ltd AUDIO2000
                     AMP Ltd AUDIO2000 at 0x9400, irq 5
  0: [0- 0]: ctl
17: [0- 1]: digital audio playback
16: [0- 0]: digital audio playback
24: [0- 0]: digital audio capture
  1:       : sequencer
33:       : timer
kmalloc: 32038 bytes
vmalloc: 13696 bytes
0 snd_ice1724
cat: oss: Is a directory
00-00: ICE1724 : ICE1724 : playback 1 : capture 1
00-01: ICE1724 IEC958 : ICE1724 IEC958 : playback 1
cat: seq: Is a directory
G0: system timer : 1000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
Advanced Linux Sound Architecture Driver Version 1.0.3 (Mon Mar 01
10:12:14 2004 UTC).
Compiled on Apr  7 2004 for kernel 2.6.4-52-default.



Sorry if i'm putting redundant info in just being thourough.

Also can you use envy24 mixer with this card? I've heard it's really
good.

I havn't tried surround yet on account I have to surrond speakers. Will
let you guys know what becomes of it.



Kind regards

Joel

--=-XMTmNiJxXbF7T17SLGv6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
Hi There Using a Gainward Hollywood@home 7.1 Card (This card uses the via envy24ht-s chip).<BR>
<BR>
There are a number of variously other branded cards comming out with this chip(Dick Smith, Asound, XHT,) So I suggest that modifying/testing the ice1724 driver to accomodate the envy24ht-s a little better would be a good idea. <BR>
<BR>
By the way this is a nice sounding card for its price (~$20 US) and has 7.1 analog outputs and a digital out. <BR>
<BR>
I beleive the card uses the envy24 chip in a strange way, making it far inferiour to say a terratec aureon which uses the envy24ht...<BR>
<BR>
This hexus.net review explains it a little better, via has a marketing page on the hts version aswell.<BR>
<A HREF="http://www.hexus.net/content/reviews/review.php?dXJsX3Jldmlld19JRD02ODcmdXJsX3BhZ2U9MQ=="><U>http://www.hexus.net/content/reviews/review.php?dXJsX3Jldmlld19JRD02ODcmdXJsX3BhZ2U9MQ==</U></A><BR>
<BR>
<BR>
Ok Now for the Bug/Device info.<BR>
<BR>
I get this kernel message when loading the driver<BR>
Jul&nbsp; 3 21:34:54 rincewind kernel: ALSA sound/pci/ice1712/ice1724.c:1786: invalid EEPROM version 1<BR>
<BR>
Driver however loads fine, and operates pretty well considering it's not officially supported (yet??).<BR>
Some applications (some sdl games i.e enigma) play sound too fast. <BR>
Most that i've tried so far are ok.<BR>
<BR>
I'll cut and paste whats in /proc/asound If there is any other information that would be better/help let me know and i'll send it on.<BR>
<BR>
First of pci devices listsing:<BR>
<BR>
17: PCI 08.0: 0401 Multimedia audio controller<BR>
&nbsp; [Created at pci.244]<BR>
&nbsp; Unique ID: RE4e.yDajJf_9bW7<BR>
&nbsp; SysFS ID: /devices/pci0000:00/0000:00:08.0<BR>
&nbsp; SysFS BusID: 0000:00:08.0<BR>
&nbsp; Hardware Class: sound<BR>
&nbsp; Model: &quot;IC Ensemble ICE1724 [Envy24HT]&quot;<BR>
&nbsp; Vendor: pci 0x1412 &quot;IC Ensemble Inc&quot;<BR>
&nbsp; Device: pci 0x1724 &quot;ICE1724 [Envy24HT]&quot;<BR>
&nbsp; SubVendor: pci 0x1412 &quot;IC Ensemble Inc&quot;<BR>
&nbsp; SubDevice: pci 0x1724 <BR>
&nbsp; Revision: 0x01<BR>
&nbsp; Driver: &quot;ICE1724&quot;<BR>
&nbsp; I/O Ports: 0x9400-0x941f (rw)<BR>
&nbsp; I/O Ports: 0x9800-0x987f (rw)<BR>
&nbsp; IRQ: 5 (173234 events)<BR>
&nbsp; Driver Info #0:<BR>
&nbsp;&nbsp;&nbsp; Driver Status: snd-ice1724 is active<BR>
&nbsp;&nbsp;&nbsp; Driver Activation Cmd: &quot;modprobe snd-ice1724&quot;<BR>
&nbsp; Config Status: cfg=no, avail=yes, need=no, active=unknown<BR>
<BR>
/proc/asound/card0:<BR>
rincewind:/proc/asound/card0 # cat ice1724<BR>
AMP Ltd AUDIO2000 at 0x9400, irq 5<BR>
<BR>
EEPROM:<BR>
&nbsp; Subvendor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x12142417<BR>
&nbsp; Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 28 bytes<BR>
&nbsp; Version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 1<BR>
&nbsp; System Config&nbsp;&nbsp;&nbsp; : 0x2<BR>
&nbsp; ACLink&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x2<BR>
&nbsp; I2S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x10<BR>
&nbsp; S/PDIF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc1<BR>
&nbsp; GPIO direction&nbsp;&nbsp; : 0xff<BR>
&nbsp; GPIO mask&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; GPIO state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; Extra #18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x1<BR>
&nbsp; Extra #19&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
&nbsp; Extra #20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
&nbsp; Extra #21&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
&nbsp; Extra #22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
&nbsp; Extra #23&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
&nbsp; Extra #24&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
&nbsp; Extra #25&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
&nbsp; Extra #26&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
&nbsp; Extra #27&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0<BR>
<BR>
Registers:<BR>
&nbsp; PSDOUT03 : 0x00000000<BR>
&nbsp; CCS00&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS01&nbsp;&nbsp;&nbsp; : 0xa0<BR>
&nbsp; CCS02&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS03&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS04&nbsp;&nbsp;&nbsp; : 0x02<BR>
&nbsp; CCS05&nbsp;&nbsp;&nbsp; : 0x02<BR>
&nbsp; CCS06&nbsp;&nbsp;&nbsp; : 0x10<BR>
&nbsp; CCS07&nbsp;&nbsp;&nbsp; : 0xc1<BR>
&nbsp; CCS08&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS09&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS0a&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS0b&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS0c&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS0d&nbsp;&nbsp;&nbsp; : 0x0a<BR>
&nbsp; CCS0e&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS0f&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS10&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS11&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS12&nbsp;&nbsp;&nbsp; : 0x12<BR>
&nbsp; CCS13&nbsp;&nbsp;&nbsp; : 0x80<BR>
&nbsp; CCS14&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS15&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; CCS16&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; CCS17&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS18&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; CCS19&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS1a&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS1b&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS1c&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS1d&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; CCS1e&nbsp;&nbsp;&nbsp; : 0x2a<BR>
&nbsp; CCS1f&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT00&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT01&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT02&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT03&nbsp;&nbsp;&nbsp;&nbsp; : 0x08<BR>
&nbsp; MT04&nbsp;&nbsp;&nbsp;&nbsp; : 0x3c<BR>
&nbsp; MT05&nbsp;&nbsp;&nbsp;&nbsp; : 0x08<BR>
&nbsp; MT06&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT07&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT08&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT09&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT0a&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT0b&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT0c&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT0d&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT0e&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT0f&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT10&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT11&nbsp;&nbsp;&nbsp;&nbsp; : 0x18<BR>
&nbsp; MT12&nbsp;&nbsp;&nbsp;&nbsp; : 0xbc<BR>
&nbsp; MT13&nbsp;&nbsp;&nbsp;&nbsp; : 0x7b<BR>
&nbsp; MT14&nbsp;&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; MT15&nbsp;&nbsp;&nbsp;&nbsp; : 0x05<BR>
&nbsp; MT16&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT17&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT18&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT19&nbsp;&nbsp;&nbsp;&nbsp; : 0x03<BR>
&nbsp; MT1a&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT1b&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT1c&nbsp;&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; MT1d&nbsp;&nbsp;&nbsp;&nbsp; : 0x01<BR>
&nbsp; MT1e&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT1f&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT20&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT21&nbsp;&nbsp;&nbsp;&nbsp; : 0x20<BR>
&nbsp; MT22&nbsp;&nbsp;&nbsp;&nbsp; : 0xb8<BR>
&nbsp; MT23&nbsp;&nbsp;&nbsp;&nbsp; : 0x7b<BR>
&nbsp; MT24&nbsp;&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; MT25&nbsp;&nbsp;&nbsp;&nbsp; : 0x03<BR>
&nbsp; MT26&nbsp;&nbsp;&nbsp;&nbsp; : 0xff<BR>
&nbsp; MT27&nbsp;&nbsp;&nbsp;&nbsp; : 0x01<BR>
&nbsp; MT28&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT29&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT2a&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT2b&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT2c&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT2d&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT2e&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
&nbsp; MT2f&nbsp;&nbsp;&nbsp;&nbsp; : 0x00<BR>
<BR>
cat id<BR>
AUDIO2000<BR>
<BR>
rincewind:/proc/asound/card0 # cat oss_mixer<BR>
VOLUME &quot;Master&quot; 0<BR>
BASS &quot;&quot; 0<BR>
TREBLE &quot;&quot; 0<BR>
SYNTH &quot;&quot; 0<BR>
PCM &quot;PCM&quot; 0<BR>
SPEAKER &quot;PC Speaker&quot; 0<BR>
LINE &quot;Line&quot; 0<BR>
MIC &quot;Mic&quot; 0<BR>
CD &quot;CD&quot; 0<BR>
IMIX &quot;&quot; 0<BR>
ALTPCM &quot;Headphone&quot; 0<BR>
RECLEV &quot;&quot; 0<BR>
IGAIN &quot;Capture&quot; 0<BR>
OGAIN &quot;&quot; 0<BR>
LINE1 &quot;Aux&quot; 0<BR>
LINE2 &quot;&quot; 0<BR>
LINE3 &quot;&quot; 0<BR>
DIGITAL1 &quot;IEC958&quot; 0<BR>
DIGITAL2 &quot;&quot; 0<BR>
DIGITAL3 &quot;&quot; 0<BR>
PHONEIN &quot;Phone&quot; 0<BR>
PHONEOUT &quot;Master Mono&quot; 0<BR>
VIDEO &quot;Video&quot; 0<BR>
RADIO &quot;&quot; 0<BR>
MONITOR &quot;&quot; 0<BR>
<BR>
rincewind:/proc/asound/card0/codec97#0 # cat *<BR>
0-0/0: ICEnsemble VT1616i<BR>
<BR>
Capabilities&nbsp;&nbsp;&nbsp;&nbsp; : -headphone out-<BR>
DAC resolution&nbsp;&nbsp; : 18-bit<BR>
ADC resolution&nbsp;&nbsp; : 18-bit<BR>
3D enhancement&nbsp;&nbsp; : IC Ensemble/KS Waves<BR>
<BR>
Current setup<BR>
Mic gain&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : +20dB [+20dB]<BR>
POP path&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : pre 3D<BR>
Sim. stereo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : off<BR>
3D enhancement&nbsp;&nbsp; : on<BR>
Loudness&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : off<BR>
Mono output&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : MIX<BR>
Mic select&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Mic1<BR>
ADC/DAC loopback : off<BR>
Extended ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : codec=0 rev=0 LDAC SDAC CDAC DSA=0 VRA<BR>
Extended status&nbsp; : LDAC SDAC CDAC VRA<BR>
PCM front DAC&nbsp;&nbsp;&nbsp; : 48000Hz<BR>
PCM Surr DAC&nbsp;&nbsp;&nbsp;&nbsp; : 48000Hz<BR>
PCM LFE DAC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 48000Hz<BR>
PCM ADC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 48000Hz<BR>
0:00 = 6d50<BR>
0:02 = 0909<BR>
0:04 = 1f1f<BR>
0:06 = 001f<BR>
0:08 = 0000<BR>
0:0a = 001e<BR>
0:0c = 001f<BR>
0:0e = 005f<BR>
0:10 = 1f1f<BR>
0:12 = 1f1f<BR>
0:14 = 1f1f<BR>
0:16 = 1f1f<BR>
0:18 = 0101<BR>
0:1a = 0606<BR>
0:1c = 0000<BR>
0:1e = 0000<BR>
0:20 = 2000<BR>
0:22 = 0000<BR>
0:24 = 0000<BR>
0:26 = 000f<BR>
0:28 = 01c1<BR>
0:2a = 01c1<BR>
0:2c = bb80<BR>
0:2e = bb80<BR>
0:30 = bb80<BR>
0:32 = bb80<BR>
0:34 = 0000<BR>
0:36 = 1f1f<BR>
0:38 = 1f1f<BR>
0:3a = 0000<BR>
0:3c = 0000<BR>
0:3e = 0000<BR>
0:40 = 0000<BR>
0:42 = 0000<BR>
0:44 = 0000<BR>
0:46 = 0000<BR>
0:48 = 0000<BR>
0:4a = 0000<BR>
0:4c = 0000<BR>
0:4e = 0000<BR>
0:50 = 0000<BR>
0:52 = 0000<BR>
0:54 = 0000<BR>
0:56 = 0000<BR>
0:58 = 0000<BR>
0:5a = 8a30<BR>
0:5c = 0000<BR>
0:5e = 0000<BR>
0:60 = 0000<BR>
0:62 = 0000<BR>
0:64 = 0000<BR>
0:66 = 0000<BR>
0:68 = 0000<BR>
0:6a = 0000<BR>
0:6c = 0000<BR>
0:6e = 0000<BR>
0:70 = 0000<BR>
0:72 = 0000<BR>
0:74 = 0000<BR>
0:76 = 0000<BR>
0:78 = 0000<BR>
0:7a = 0000<BR>
0:7c = 4943<BR>
0:7e = 4552<BR>
<BR>
rincewind:/proc/asound/card0/pcm0c # cat *<BR>
card: 0<BR>
device: 0<BR>
subdevice: 0<BR>
stream: CAPTURE<BR>
id: ICE1724<BR>
name: ICE1724<BR>
subname: subdevice #0<BR>
class: 0<BR>
subclass: 0<BR>
subdevices_count: 1<BR>
subdevices_avail: 1<BR>
cat: sub0: Is a directory<BR>
0<BR>
rincewind:/proc/asound/card0/pcm0c #<BR>
<BR>
rincewind:/proc/asound/card0/pcm0c/sub0 # cat *<BR>
closed<BR>
card: 0<BR>
device: 0<BR>
subdevice: 0<BR>
stream: CAPTURE<BR>
id: ICE1724<BR>
name: ICE1724<BR>
subname: subdevice #0<BR>
class: 0<BR>
subclass: 0<BR>
subdevices_count: 1<BR>
subdevices_avail: 1<BR>
256<BR>
closed<BR>
closed<BR>
rincewind:/proc/asound/card0/pcm0c/sub0 #<BR>
<BR>
<BR>
<BR>
rincewind:/proc/asound/card0/pcm0p # cat *<BR>
card: 0<BR>
device: 0<BR>
subdevice: 0<BR>
stream: PLAYBACK<BR>
id: ICE1724<BR>
name: ICE1724<BR>
subname: subdevice #0<BR>
class: 0<BR>
subclass: 0<BR>
subdevices_count: 1<BR>
subdevices_avail: 1<BR>
cat: sub0: Is a directory<BR>
0<BR>
rincewind:/proc/asound/card0/pcm0p #<BR>
<BR>
rincewind:/proc/asound/card0/pcm0p/sub0 # cat *<BR>
closed<BR>
card: 0<BR>
device: 0<BR>
subdevice: 0<BR>
stream: PLAYBACK<BR>
id: ICE1724<BR>
name: ICE1724<BR>
subname: subdevice #0<BR>
class: 0<BR>
subclass: 0<BR>
subdevices_count: 1<BR>
subdevices_avail: 1<BR>
256<BR>
closed<BR>
closed<BR>
rincewind:/proc/asound/card0/pcm0p/sub0 #<BR>
<BR>
<BR>
<BR>
rincewind:/proc/asound/card0/pcm1p # cat *<BR>
card: 0<BR>
device: 1<BR>
subdevice: 0<BR>
stream: PLAYBACK<BR>
id: ICE1724 IEC958<BR>
name: ICE1724 IEC958<BR>
subname: subdevice #0<BR>
class: 0<BR>
subclass: 0<BR>
subdevices_count: 1<BR>
subdevices_avail: 1<BR>
cat: sub0: Is a directory<BR>
0<BR>
rincewind:/proc/asound/card0/pcm1p #<BR>
<BR>
rincewind:/proc/asound/card0/pcm1p/sub0 # cat *<BR>
closed<BR>
card: 0<BR>
device: 1<BR>
subdevice: 0<BR>
stream: PLAYBACK<BR>
id: ICE1724 IEC958<BR>
name: ICE1724 IEC958<BR>
subname: subdevice #0<BR>
class: 0<BR>
subclass: 0<BR>
subdevices_count: 1<BR>
subdevices_avail: 1<BR>
64<BR>
closed<BR>
closed<BR>
rincewind:/proc/asound/card0/pcm1p/sub0 #<BR>
<BR>
rincewind:/proc/asound/oss # cat *<BR>
&nbsp; 0: [0- 0]: mixer<BR>
&nbsp; 3: [0- 3]: digital audio<BR>
12: [0-12]: digital audio<BR>
&nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : sequencer<BR>
&nbsp; 8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : sequencer<BR>
Sound Driver:3.8.1a-980706 (ALSA v1.0.3 emulation code)<BR>
Kernel: Linux rincewind 2.6.4-52-default #1 Wed Apr 7 02:15:23 UTC 2004 x86_64<BR>
Config options: 0<BR>
<BR>
Installed drivers:<BR>
Type 10: ALSA emulation<BR>
<BR>
Card config:<BR>
AMP Ltd AUDIO2000 at 0x9400, irq 5<BR>
<BR>
Audio devices:<BR>
0: ICE1724 (DUPLEX)<BR>
<BR>
Synth devices: NOT ENABLED IN CONFIG<BR>
<BR>
Midi devices: NOT ENABLED IN CONFIG<BR>
<BR>
Timers:<BR>
7: system timer<BR>
<BR>
Mixers:<BR>
0: ICEnsemble VT1616i<BR>
<BR>
rincewind:/proc/asound # cat *<BR>
cat: AUDIO2000: Is a directory<BR>
cat: card0: Is a directory<BR>
0 [AUDIO2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]: ICE1724 - AMP Ltd AUDIO2000<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMP Ltd AUDIO2000 at 0x9400, irq 5<BR>
&nbsp; 0: [0- 0]: ctl<BR>
17: [0- 1]: digital audio playback<BR>
16: [0- 0]: digital audio playback<BR>
24: [0- 0]: digital audio capture<BR>
&nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : sequencer<BR>
33:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : timer<BR>
kmalloc: 32038 bytes<BR>
vmalloc: 13696 bytes<BR>
0 snd_ice1724<BR>
cat: oss: Is a directory<BR>
00-00: ICE1724 : ICE1724 : playback 1 : capture 1<BR>
00-01: ICE1724 IEC958 : ICE1724 IEC958 : playback 1<BR>
cat: seq: Is a directory<BR>
G0: system timer : 1000.000us (10000000 ticks)<BR>
P0-0-0: PCM playback 0-0-0 : SLAVE<BR>
P0-0-1: PCM capture 0-0-1 : SLAVE<BR>
P0-1-0: PCM playback 0-1-0 : SLAVE<BR>
Advanced Linux Sound Architecture Driver Version 1.0.3 (Mon Mar 01 10:12:14 2004 UTC).<BR>
Compiled on Apr&nbsp; 7 2004 for kernel 2.6.4-52-default.<BR>
<BR>
<BR>
<BR>
Sorry if i'm putting redundant info in just being thourough.<BR>
<BR>
Also can you use envy24 mixer with this card? I've heard it's really good.<BR>
<BR>
I havn't tried surround yet on account I have to surrond speakers. Will let you guys know what becomes of it.<BR>
<BR>
<BR>
<BR>
Kind regards<BR>
<BR>
Joel
</BODY>
</HTML>

--=-XMTmNiJxXbF7T17SLGv6--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
