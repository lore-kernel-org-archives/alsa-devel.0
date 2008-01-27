From: Zoran Rilak <zoran.rilak@gmail.com>
Subject: Microphone dead: Gateway MX6543, hda-intel, STAC925x
Date: Sun, 27 Jan 2008 04:20:25 -0500
Message-ID: <1201425625.6484.7.camel@flipbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DBC42440F
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 10:20:29 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so288228ana.80
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 01:20:28 -0800 (PST)
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

Hello,

    I've searched the archives and haven't found a solution for this
particular model (STAC9250).  Front mic does not work.  I have tried
other models, aside from m2-2, and all four possible values for
position_fix as well, but to no avail.  

    If anyone is willing to tackle this, please point me to what other
information I should provide in order to get to the bottom of this.  I
am using Ubuntu kernel 2.6.22-14  and ALSA 1.0.15 compiled from source.

Here are my /proc/asound/card0/codec#* files:

--- /proc/asound/card0/codec#0 ---
Codec: SigmaTel STAC9250
Address: 0
Vendor Id: 0x83847634
Subsystem Id: 0x107b0367
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Power: 0x0
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x14
Node 0x04 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x07
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM:
    rates [0x1e0]: 44100 48000 88200 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x06 [Audio Selector] wcaps 0x300901: Stereo
  Connection: 3
     0x02* 0x07 0x14
Node 0x07 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x40c003f3: [N/A] SPDIF In at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x08 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x424503f2: [N/A] SPDIF Out at Ext Front
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 2
     0x05* 0x14
Node 0x09 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x0f 0x0f]
  Connection: 1
     0x0f
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x04180011: [Jack] Speaker at Ext Right
    Conn = DIN, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0e
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x50a103f0: [N/A] Mic at Int N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x90100212: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x0e [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x0d 0x0d]
  Connection: 1
     0x06
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 5
     0x0b* 0x0c 0x0d 0x0a 0x11
Node 0x10 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x400003f1: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x12
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x9033032e: [Fixed] CD at Int N/A
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x12 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x06
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x14 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x09
--- end codec#0 ---

--- /proc/asound/card0/codec#1 ---
Codec: Motorola Si3054
Address: 1
Vendor Id: 0x10573057
Subsystem Id: 0x10001
Revision Id: 0x100100
Modem Function Group: 0x1
--- end codec#1 ---
