From: Tomas Cernaj <tomas@cernaj.de>
Subject: hda: broken PCM over spdif after AC3; suggestion
Date: Tue, 21 Oct 2008 02:37:28 +0200
Message-ID: <1224549448.647.21.camel@trpazlik>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lgXFDoCpoUazT+M7S/Lb"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.cernaj.de (lvps80-237-163-12.dedicated.hosteurope.de
	[80.237.163.12]) by alsa0.perex.cz (Postfix) with ESMTP id 5BB49246B3
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 02:37:48 +0200 (CEST)
Received: from [192.168.1.35] (dslb-088-068-244-083.pools.arcor-ip.net
	[88.68.244.83])
	by mail.cernaj.de (Postfix) with ESMTP id 6A2F8C916001
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 02:37:29 +0200 (CEST)
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


--=-lgXFDoCpoUazT+M7S/Lb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

trying to track down a long standing bug concerning PCM output over
spdif and analog ports simultaneously after AC3 passthrough (see
https://bugs.launchpad.net/bugs/25632 ), I've been digging into the
inner workings of HD Audio...

It seems to me that after playing DVDs with AC3 passthrough the stream
associated with the default alsa device is only connected to the front
Audio Output widget but not at the same time to the Digital output
widget, as I would have expected. I've attached the contents
of /proc/asound/Intel/codec#0 during music playback to this mail; you
can see the different streams connected to nodes 0x02 and 0x03.

I'm not familiar with the hda driver, but I suspect that after AC3
passthrough the multi-out configuration isn't reset to what it's
supposed to be.

Is there a way to work around this issue, or am I completely missing the
point?

Thanks for your help,
Tomas


--=-lgXFDoCpoUazT+M7S/Lb
Content-Disposition: attachment; filename=output.txt
Content-Type: text/plain; name=output.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Codec: Analog Devices AD1986A
Address: 0
Vendor Id: 0x11d41986
Subsystem Id: 0x144dc504
Revision Id: 0x100500
No Modem Function Group found
Default PCM:
    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
GPIO: io=0, o=1, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  Converter: stream=0, channel=0
  Digital: Enabled GenLevel
  Digital category: 0x0
  PCM:
    rates [0x60]: 44100 48000
    bits [0x2]: 16
    formats [0x5]: PCM AC3
  Delay: 3 samples
  Connection: 2
     0x01* 0x06
Node 0x03 [Audio Output] wcaps 0x44d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1a 0x1a]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Processing caps: benign=1, ncoeff=70
Node 0x04 [Audio Output] wcaps 0x40d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1a 0x1a]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x40d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1a 0x1a]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
Node 0x06 [Audio Input] wcaps 0x100511: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
  Connection: 1
     0x12
Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 8
     0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x08 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x09 [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80] [0x80]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Connection: 2
     0x04 0x05
Node 0x0a [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x07* 0x04 0x05
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x07* 0x04
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x04* 0x07
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x05* 0x08
Node 0x0e [Audio Selector] wcaps 0x300100: Mono
  Connection: 2
     0x08* 0x11
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 8
     0x1f 0x20 0x1d 0x1d 0x27* 0x28 0x29 0x2a
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x20 0x1c* 0x1f
Node 0x11 [Audio Selector] wcaps 0x300941: Stereo R/L
  Connection: 2
     0x0f* 0x2b
  Processing caps: benign=1, ncoeff=0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 8
     0x11 0x22 0x00 0x21 0x10 0x07* 0x08 0x23
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x11
Node 0x14 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80]
  Connection: 1
     0x23
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x19 0x19]
  Connection: 1
     0x22
Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x21
Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x10
Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x8f]
  Connection: 2
     0x19* 0x24
Node 0x19 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x1a [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x11 0x11]
  Pincap 0x081f: OUT HP Detect Trigger ImpSense
  Pin Default 0x0221411f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0a
Node 0x1b [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x16 0x16]
  Pincap 0x081001f: OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x2: EAPD
  Pin Default 0x91174110: [Fixed] Speaker at Int Rear
    Conn = Analog, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x1c [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0837: IN OUT Detect Trigger ImpSense
  Pin Default 0x410130f0: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0c
Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x410190f0: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0d
Node 0x1e [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x0810: OUT
  Pin Default 0x511711f0: [N/A] Speaker at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x1f [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19120: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x20 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x418130f0: [N/A] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
Node 0x21 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0827: IN Detect Trigger ImpSense
  Pin Default 0x5997e1f0: [N/A] Aux at Int ATAPI
    Conn = Analog, Color = White
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x22 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x593311f0: [N/A] CD at Int ATAPI
    Conn = ATAPI, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x23 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x59b771f0: [N/A] Telephony at Int ATAPI
    Conn = Analog, Color = Yellow
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x24 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x51f711f0: [N/A] Other at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x0145f1f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Other
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x26 [Power Widget] wcaps 0x500500: Mono
  Power: setting=D0, actual=D0
  Connection: 8
     0x07* 0x08 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x27 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1f 0x1d
Node 0x28 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1f 0x20
Node 0x29 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1d 0x20
Node 0x2a [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 3
     0x1f 0x1d 0x20
Node 0x2b [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x0f

--=-lgXFDoCpoUazT+M7S/Lb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-lgXFDoCpoUazT+M7S/Lb--
