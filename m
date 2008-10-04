From: Jan Engelhardt <jengelh@medozas.de>
Subject: snd-hda-intel overly loud when using OSS interface
Date: Sat, 4 Oct 2008 08:52:16 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0809241609500.23238@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sovereign.computergmbh.de (sovereign.computergmbh.de
	[85.214.69.204]) by alsa0.perex.cz (Postfix) with ESMTP id 7DE8F243EC
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Oct 2008 14:52:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id C3EF91C07380B
	for <alsa-devel@alsa-project.org>; Sat,  4 Oct 2008 08:52:16 -0400 (EDT)
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

Hi,


[don't forget to Cc me]

I've got a Dell Precision 390 workstation, onboard sound running with 
snd-hda-intel module.

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 01)
00:1b.0 0403: 8086:27d8 (rev 01)

When audio is output using the OSS interface (mpg123 or mplayer -ao 
oss), output is overly loud and the PCM mixer control has no effect.

Master tuned in to 13% (alsamixer says dB gain=-40.50) is about the 
level as when using the ALSA interface running with Master 58% (dB 
gain=-19.50) with PCM 63% (dB gain=-19.50).


$ uname -a
Linux nuqneh 2.6.24-19-generic #1 SMP Thu Jul 10 22:38:03 PDT 2008 x86_64 GNU/Linux

/proc/asound:
$ cat cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xefffc000 irq 16
$ cat devices 
  0: [ 0]   : control
  1:        : sequencer
  4: [ 0- 0]: hardware dependent
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer
$ cat hwdep 
00-00: HDA Codec 0
$ cat modules 
 0 snd_hda_intel
$ cat pcm 
00-00: STAC92xx Analog : STAC92xx Analog : playback 1 : capture 1
$ cat timers 
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
  Client application 22482 : running
P0-0-1: PCM capture 0-0-1 : SLAVE
$ cat version 
Advanced Linux Sound Architecture Driver Version 1.0.16.
Compiled on Jul 11 2008 for kernel 2.6.24-19-generic (SMP).


$ cat /proc/asound/card0/codec#0 
Codec: SigmaTel STAC9200
Address: 0
Vendor Id: 0x83847690
Subsystem Id: 0x102801de
Revision Id: 0x102201
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
GPIO: io=4, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x0a
  Processing caps: benign=0, ncoeff=0
Node 0x04 [Audio Input] wcaps 0x140311: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
  Connection: 1
     0x08
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x1e0]: 44100 48000 88200 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x06 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
  Delay: 3 samples
Node 0x07 [Audio Selector] wcaps 0x300901: Stereo R/L
  Connection: 3
     0x02* 0x08 0x0a
Node 0x08 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 3 samples
Node 0x09 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x400001f1: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 2
     0x05* 0x0a
Node 0x0a [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x0c
Node 0x0b [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x12 0x12]
  Connection: 1
     0x07
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 5
     0x10* 0x0f 0x0e 0x0d 0x12
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x02214030: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=30, enabled=1
  Connection: 1
     0x0b
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect Trigger ImpSense
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x10 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19021: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x11 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x90100140: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x4, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x13
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x01813122: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x2, Sequence = 0x2
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x13 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
