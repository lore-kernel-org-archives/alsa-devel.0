From: Matthias =?ISO-8859-1?Q?Bl=E4sing?= <mblaesing@doppel-helix.eu>
Subject: Exposure of the input devices of Conexant CX20561
	amplifier
Date: Sun, 20 Sep 2009 20:50:38 +0200
Message-ID: <1253472638.5880.20.camel@prometheus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mjjCyNqSU5hpMbg7UGBa"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from h1622217.stratoserver.net (h1622217.stratoserver.net
	[85.214.125.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 784C22414B
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 20:50:48 +0200 (CEST)
Received: from [192.168.1.127] (p50906D0A.dip.t-dialin.net [80.144.109.10])
	by h1622217.stratoserver.net (Postfix) with ESMTPSA id 79B3969D40AF
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 20:50:40 +0200 (CEST)
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


--=-mjjCyNqSU5hpMbg7UGBa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

it would be nice if I could control the input channels of my lenovo
laptop (Lenovo R500). These are configured for microphone input, but the
amplifier can be deactivated, so that it can work with the higher
line-in level.

The resulting quality is not good, but at least usable.

The volume control is joint, but the amplifier control are seperated.
With the HDAAnalyser I could find the Nodes (0x17 (rear) and 0x18
(front)) can be used to control the amplification. The setting can be
changed between 0 and 4, where 0 makes it possible to use the input for
line-in, while 4 is better suited for microphone input.

I'm not sure whether it would be better to expose this as a stepped
control or just a switch (amplifier on/off).

These are the loaded modules (from kernel 2.6.31):

snd_usb_audio          74152  3 
snd_usb_lib            13904  1 snd_usb_audio
snd_hda_codec_conexant    17684  1 
snd_seq_dummy           2748  0 
snd_seq_oss            24620  0 
snd_hda_intel          24064  9 
snd_hda_codec          65724  2 snd_hda_codec_conexant,snd_hda_intel
snd_seq_midi            6232  0 
snd_hwdep               6772  3 snd_usb_audio,snd_hda_codec
snd_rawmidi            19600  2 snd_usb_lib,snd_seq_midi
snd_seq_midi_event      6580  2 snd_seq_oss,snd_seq_midi
snd_pcm_oss            33516  0 
snd_mixer_oss          13416  1 snd_pcm_oss
snd_seq                44744  7
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_pcm                64872  6
snd_usb_audio,snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              18448  2 snd_seq,snd_pcm
snd_seq_device          6424  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd_page_alloc          8556  2 snd_hda_intel,snd_pcm
snd                    52452  35
snd_usb_audio,snd_hda_codec_conexant,snd_seq_oss,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_rawmidi,snd_pcm_oss,snd_mixer_oss,snd_seq,snd_pcm,snd_timer,snd_seq_device
soundcore               6876  1 snd

I attached the /proc/asound/card0/codec#0 info to this email. If you
need further information - please ask.

Matthias

--=-mjjCyNqSU5hpMbg7UGBa
Content-Disposition: attachment; filename="codec-info"
Content-Type: text/plain; name="codec-info"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Codec: Conexant CX20561 (Hermosa)
Address: 0
Function Id: 0x2
Vendor Id: 0x14f15051
Subsystem Id: 0x17aa20fd
Revision Id: 0x100000
Modem Function Group: 0x2
Default PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=0
  Amp-Out vals:  [0x4a 0x4a]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=0
  Amp-Out vals:  [0x4a 0x4a]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
Node 0x12 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=0
  Amp-In vals:  [0x2a 0x2a] [0x2c 0x2c]
  Converter: stream=1, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
  Connection: 2
     0x1d 0x17*
Node 0x15 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=0
  Amp-In vals:  [0x30 0x30]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
  Connection: 1
     0x18
Node 0x16 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x022140f0: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=37, enabled=1
  Power: setting=D0, actual=D0
  Connection: 2
     0x10* 0x11
Node 0x17 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001224: IN Detect
    Vref caps: 50 80
  Pin Default 0x61a190f0: [N/A] Mic at Sep Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=38, enabled=1
  Power: setting=D0, actual=D0
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001224: IN Detect
    Vref caps: 50 80
  Pin Default 0x02a190f0: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=39, enabled=1
  Power: setting=D0, actual=D0
Node 0x19 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=37, enabled=1
  Power: setting=D0, actual=D0
  Connection: 2
     0x10* 0x11
Node 0x1a [Pin Complex] wcaps 0x400501: Stereo
  Pincap 0x00010010: OUT EAPD
  EAPD 0x2: EAPD
  Pin Default 0x901701f0: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power: setting=D0, actual=D0
  Connection: 2
     0x10* 0x11
Node 0x1b [Pin Complex] wcaps 0x400500: Mono
  Pincap 0x00010010: OUT EAPD
  EAPD 0x2: EAPD
  Pin Default 0x40f001f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power: setting=D0, actual=D0
  Connection: 2
     0x10* 0x11
Node 0x1c [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x40f001f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power: setting=D0, actual=D0
  Connection: 1
     0x12
Node 0x1d [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-In vals:  [0x03 0x03]
  Pincap 0x00000020: IN
  Pin Default 0x90a701f0: [Fixed] Mic at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power: setting=D0, actual=D0
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono

--=-mjjCyNqSU5hpMbg7UGBa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-mjjCyNqSU5hpMbg7UGBa--
