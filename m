From: Tony Hoyle <tmh@nodomain.org>
Subject: Getting board to work on 2.6.30
Date: Tue, 23 Jun 2009 12:21:11 +0100
Message-ID: <4A40BAA7.2070603@nodomain.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080104090206050405010806"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 8916D2469D
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 13:21:15 +0200 (CEST)
Received: by bwz11 with SMTP id 11so3761888bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2009 04:21:14 -0700 (PDT)
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

This is a multi-part message in MIME format.
--------------080104090206050405010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm trying to get sound working on a board I'm working with.  The sound 
works correctly on 2.6.24.7 but not 2.6.30.

I has an intel HDA (Poulson) chipset and a sigmatel 9202 codec. 
Physically there's only one output - the speakers, and no input, so from 
a testing point of view it either works or it doesn't.

Kernel output from both looks similar:

2.6.24.7:

[   19.942029] ALSA sound/pci/hda/hda_intel.c:916: HDA snoop disabled, 
try to enable ... OK
[   20.157458] ALSA sound/pci/hda/hda_codec.c:2760: autoconfig: 
line_outs=1 (0xd/0x0/0x0/0x0/0x0)
[   20.157467] ALSA sound/pci/hda/hda_codec.c:2764:    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[   20.157474] ALSA sound/pci/hda/hda_codec.c:2768:    hp_outs=1 
(0xa/0x0/0x0/0x0/0x0)
[   20.157481] ALSA sound/pci/hda/hda_codec.c:2776:    inputs: mic=0x0, 
fmic=0xb, line=0xc, fline=0x0, cd=0x11, aux=0x0

2.6.30 (running alsa snapshot from last night):

    19.379811] ALSA sound/pci/hda/hda_codec.c:3795: autoconfig: 
line_outs=1 (0x10/0x0/0x0/0x0/0x0)
[   19.379824] ALSA sound/pci/hda/hda_codec.c:3799:    speaker_outs=2 
(0xa/0x7/0x0/0x0/0x0)
[   19.379833] ALSA sound/pci/hda/hda_codec.c:3803:    hp_outs=1 
(0xd/0x0/0x0/0x0/0x0)
[   19.379842] ALSA sound/pci/hda/hda_codec.c:3804:    mono: mono_out=0x10
[   19.379849] ALSA sound/pci/hda/hda_codec.c:3807:    dig-out=0x8/0x0
[   19.379856] ALSA sound/pci/hda/hda_codec.c:3815:    inputs: mic=0xb, 
fmic=0x0, line=0xc, fline=0x0, cd=0x11, aux=0x0
[   19.390010] input: HDA Intel MID CD at Ext Rear Jack as 
/class/input/input3
[   19.401109] input: HDA Intel MID Line In at Ext Rear Jack as 
/class/input/input4
[   19.414726] input: HDA Intel MID Mic at Ext Rear Jack as 
/class/input/input5
[   19.430427] input: HDA Intel MID Line Out at Ext Rear Jack as 
/class/input/input6
[   19.447561] input: HDA Intel MID HP Out at Ext Front Jack as 
/class/input/input7

It seems to be creating the outputs as inputs?  This seems wrong.

I've tried every model setting I could find and reckon I need to create 
a new one.. but don't actually know what to create to get things working 
- there are lots of differences in the alsa between the two kernels and 
it isn't something that looks easy to pin down short of going nuts with 
git bisect.

Can someone give me a pointer where to start looking at this?

Tony

--------------080104090206050405010806
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="codec#0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="codec#0"

Codec: SigmaTel STAC9202
Address: 0
Function Id: 0x1
Vendor Id: 0x83847632
Subsystem Id: 0x00000100
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
GPIO: io=4, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x14
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
     0x07
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x1e0]: 44100 48000 88200 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x06 [Audio Selector] wcaps 0x300901: Stereo R/L
  Connection: 3
     0x02* 0x07 0x14
Node 0x07 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x01110014: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 3 samples
Node 0x08 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x01410013: [Jack] SPDIF Out at Ext Rear
    Conn = 1/8, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x3
  Pin-ctls: 0x40: OUT
  Connection: 2
     0x05* 0x14
Node 0x09 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x07 0x07]
  Connection: 1
     0x0f
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x02111011: [Jack] Speaker at Ext Front
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0e
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a10021: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x0e
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01810022: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x2
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=03, enabled=1
  Connection: 1
     0x0e
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x02214012: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x0e
Node 0x0e [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x17 0x17]
  Connection: 1
     0x06
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 5
     0x0b* 0x0c 0x0d 0x0a 0x11
Node 0x10 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x01010031: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x12
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x01310023: [Jack] CD at Ext Rear
    Conn = 1/8, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x3
  Pin-ctls: 0x20: IN
Node 0x12 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x06
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x14 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 2
     0x09* 0x15
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x01d10024: [Jack] Digitial In at Ext Rear
    Conn = 1/8, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x4
  Pin-ctls: 0x20: IN

--------------080104090206050405010806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080104090206050405010806--
