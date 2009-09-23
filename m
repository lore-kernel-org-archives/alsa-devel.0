From: Liviu Andronic <landronimirc@gmail.com>
Subject: sound issues on an HP Pavilion DV3-1075 (solved)
Date: Wed, 23 Sep 2009 08:55:34 +0100
Message-ID: <68b1e2610909230055r603e46em3e18aca9ad566078@mail.gmail.com>
References: <68b1e2610909220419j2cd1d86eu97a8f3202fa907be@mail.gmail.com>
	<68b1e2610909220421o77cc27fbg9597aa638c16c919@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id A6F1C24444
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 09:55:35 +0200 (CEST)
Received: by ewy25 with SMTP id 25so443684ewy.45
	for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2009 00:55:35 -0700 (PDT)
In-Reply-To: <68b1e2610909220421o77cc27fbg9597aa638c16c919@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear ALSA devels
I am writing on an ALSA-related issue that I managed to solve, on Debian
testing with kernel 2.6.30 and ALSA 1.0.21. For background and exact
symptoms please see these two threads. [1] [2]

The first issue was that there was no sound. I solved it by manually
configuring it as follows:
debian-liv:/home/liviu# cat /etc/modprobe.d/sound
## ALSA portion
alias char-major-116 snd
alias snd-card-0 snd-hda-intel
alias snd-card-1 snd-usb-audio

## module options should go here
options snd-hda-intel index=0 model=hp-dv5 enable_msi=1
options snd-usb-audio index=1

The second issue concerned the external speakers/headphones: when such
devices were plugged in, the internal speakers were not muted and the audio
stream was not redirected to the external headset (that is, there was no
sound in the headphones); although I didn't check, the microphone was
probably not working, too. The issue was solved by adding position-fix=1.
Thus, the following line was used
options snd-hda-intel index=0 model=hp-dv5 enable-msi=1 position-fix=1

I have similar issues on Ubuntu Jackalope, and it seems that on Ubuntu it is
quite often that audio cards on HP Pavilions misbehave by default (no sound,
no sound in headphones, etc.).

Best regards
Liviu

[1] http://www.mail-archive.com/debian-user@lists.debian.org/msg555984.html
[2] http://www.pubbs.net/debian/200909/102780/


### Debug messages ###
liviu@debian-liv:~$ cat /proc/asound/card*/codec* | grep Codec
Codec: IDT 92HD71B7X
Codec: ATI RS690/780 HDMI

liviu@debian-liv:~$ cat /proc/asound/cards
0 [SB             ]: HDA-Intel - HDA ATI SB
                       HDA ATI SB at 0xd2400000 irq 16
1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xd2310000 irq 29
liviu@debian-liv:~$ cat /proc/asound/devices
  0: [ 0]   : control
   1:        : sequencer
  4: [ 0- 0]: hardware dependent
16: [ 0- 0]: digital audio playback
17: [ 0- 1]: digital audio playback
24: [ 0- 0]: digital audio capture
32: [ 1]   : control
33:        : timer
36: [ 1- 0]: hardware dependent
51: [ 1- 3]: digital audio playback


liviu@debian-liv:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: STAC92xx Analog [STAC92xx Analog]
   Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI]
   Subdevices: 1/1
  Subdevice #0: subdevice #0


liviu@debian-liv:~$ aplay -L
default:CARD=SB
    HDA ATI SB, STAC92xx Analog
    Default Audio Device
front:CARD=SB,DEV=0
    HDA ATI SB, STAC92xx Analog
     Front speakers
surround40:CARD=SB,DEV=0
    HDA ATI SB, STAC92xx Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=SB,DEV=0
    HDA ATI SB, STAC92xx Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=SB,DEV=0
    HDA ATI SB, STAC92xx Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=SB,DEV=0
    HDA ATI SB, STAC92xx Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=SB,DEV=0
    HDA ATI SB, STAC92xx Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=SB,DEV=0
    HDA ATI SB, STAC92xx Digital
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)
hdmi:CARD=HDMI
    HDA ATI HDMI, ATI HDMI
    HDMI Audio Output


-Computer-
Processor : 2x AMD Turion(tm) X2 Dual-Core Mobile RM-72
Memory : 3802MB (907MB used)
Operating System : Debian GNU/Linux squeeze/sid
User Name : liviu (Liviu)
Date/Time : Tue 22 Sep 2009 12:58:23 BST
-Display-
Resolution : 1280x800 pixels
OpenGL Renderer : ATI Radeon HD 3200 Graphics
X11 Vendor : The X.Org Foundation
-Multimedia-
Audio Adapter : HDA-Intel - HDA ATI SB
Audio Adapter : HDA-Intel - HDA ATI HDMI
-Input Devices-
Macintosh mouse button emulation
AT Translated Set 2 keyboard
Video Bus
Power Button
Power Button
Lid Switch
PC Speaker
ST LIS3LV02DL Accelerometer
HP Webcam
SynPS/2 Synaptics TouchPad
HDA Digital PCBeep
HDA ATI SB Mic at Ext Front Jack
HDA ATI SB HP Out at Ext Front Jack
-Printers (CUPS)-
psc_1200_first


-Version-
Kernel : Linux 2.6.30-1-amd64 (x86_64)
Compiled : #1 SMP Sat Aug 15 18:09:19 UTC 2009
C Library : GNU C Library version 2.9 (stable)
Default C Compiler : GNU C Compiler version 4.3.4 (Debian 4.3.4-2)
Distribution : Debian GNU/Linux squeeze/sid
-Current Session-
Computer Name : debian-liv
User Name : liviu (Liviu)
Home Directory : /home/liviu
Desktop Environment : XFCE 4
-Misc-
Uptime : 2 hours, 19 minutes
Load Average : 0.57, 0.67, 0.73


liviu@debian-liv:~$ lspci -vv
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
Subsystem: Hewlett-Packard Company Device 1506
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin ? routed to IRQ 16
Region 0: Memory at d2400000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: HDA Intel

[..]

01:05.1 Audio device: ATI Technologies Inc RS780 Azalia controller
Subsystem: ATI Technologies Inc RS780 Azalia controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 19
Region 0: Memory at d2310000 (32-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: HDA Intel


liviu@debian-liv:~$ lsmod | grep -i snd
snd_hda_codec_atihdmi     3952  1
snd_hda_codec_idt      62480  1
snd_hda_intel          26680  9
snd_hda_codec          75248  3
snd_hda_codec_atihdmi,snd_hda_codec_idt,snd_hda_intel
snd_hwdep               8152  1 snd_hda_codec
snd_pcm_oss            37200  0
snd_mixer_oss          15072  2 snd_pcm_oss
snd_pcm                78504  4 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_seq_midi            6976  0
snd_rawmidi            23008  1 snd_seq_midi
snd_seq_midi_event      7712  1 snd_seq_midi
snd_seq                51392  2 snd_seq_midi,snd_seq_midi_event
snd_timer              21824  3 snd_pcm,snd_seq
snd_seq_device          7476  3 snd_seq_midi,snd_rawmidi,snd_seq
snd                    63912  25
snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore               7984  2 snd
snd_page_alloc         10000  2 snd_hda_intel,snd_pcm


-- 
Do you know how to read?
http://www.alienetworks.com/srtest.cfm
Do you know how to write?
http://garbl.home.comcast.net/~garbl/stylemanual/e.htm#e-mail




-- 
Do you know how to read?
http://www.alienetworks.com/srtest.cfm
Do you know how to write?
http://garbl.home.comcast.net/~garbl/stylemanual/e.htm#e-mail
