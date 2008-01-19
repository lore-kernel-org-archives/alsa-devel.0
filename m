From: Philippe Paravicini <philippe@paravicini.com>
Subject: Support for Compaq Presario F700 - model 755US -
	NVidia MCP67 Audio - Codec Conexant 5051
Date: Fri, 18 Jan 2008 16:55:05 -0800
Message-ID: <200801181655.05217.philippe@paravicini.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com (smtp123.sbc.mail.sp1.yahoo.com
	[69.147.64.96]) by alsa0.perex.cz (Postfix) with SMTP id 7A4092437B
	for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2008 01:55:05 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I recently purchased the laptop listed above and installed kubuntu-7.10-desktop-amd64 Feisty on it.

The sound card works, but, much to my chagrin, plugging in the headphone jack does not mute the speaker.  

<wining>
This is less than ideal for me because I use Skype quite a bit, and work in a no-walls small office with other people.  Having the ability to use my headset for talking on the phone and drowning out ambient noise is important.
</wining><deepbreath/>

I have googled high and low and have tried various suggested solutions, including changing:

	options snd-hda-intel model=laptop

in /etc/modprobe.d/alsa-base to various settings (laptop-hp, laptop-eahd, test).

I have also downloaded, compiled and installed the 1.0.15 driver and utils according to the instructions at:

  https://help.ubuntu.com/community/HdaIntelSoundHowto

without success.

I consulted the page at:

http://www.mjmwired.net/kernel/Documentation/sound/alsa/ALSA-Configuration.txt

dated 2007-10-11 and could note see support for the Conexant 5051 Codec or NVidia MCP67 Audio.

Has anyone had experience with this soundcard/codec  and gotten the headphones jack to mute the speakers correctly ?

Any help would be greatly appreciated. I  am a java programmer with very high reverence for linux C-programmers and would be happy to help test a patch for this device (I may need a little help to get going), or trade for java programming/consulting.
Please let me know if you additional information other than the one listed below.

Thank you kindly for any help.

Sincerely, 

Philippe Paravicini

lspci -v outputs:
...
00:07.0 Audio device: nVidia Corporation MCP67 High Definition Audio (rev a1)
  Subsystem: Hewlett-Packard Company Unknown device 30ea
...

lspci -vn
...
00:07.0 0403: 10de:055c (rev a1)
  Subsystem: 103c:30ea
  Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
  Memory at f6480000 (32-bit, non-prefetchable) [size=16K]
  Capabilities: [44] Power Management version 2
  Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/0 Enable-
  Capabilities: [6c] HyperTransport: MSI Mapping
...

cat /proc/asound/card0/codec#0

Codec: Conexant ID 5051
Address: 0
Vendor Id: 0x14f15051
Subsystem Id: 0x103c30ea
Revision Id: 0x100000
Modem Function Group: 0x2
Default PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=0
  Amp-Out vals:  [0x3a 0x3a]
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=0
  Amp-Out vals:  [0x4a 0x4a]
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x12 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=0
  Amp-In vals:  [0x06 0x06] [0x35 0x35]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: 0x0
  Connection: 2
     0x1d 0x17*
Node 0x15 [Audio Input] wcaps 0x100d1b: Stereo Amp-In
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=0
  Amp-In vals:  [0x4a 0x4a]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: 0x0
  Connection: 1
     0x18
Node 0x16 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x081c: OUT HP Detect
  Pin Default 0x02211030: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Power: 0x0
  Connection: 2
     0x10* 0x11
Node 0x17 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-In vals:
  Pincap 0x081224: IN Detect
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Power: 0x0
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-In vals:
  Pincap 0x081224: IN Detect
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x19 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0814: OUT Detect
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
  Connection: 2
     0x10 0x11*
Node 0x1a [Pin Complex] wcaps 0x400501: Stereo
  Pincap 0x0810010: OUT EAPD
  Pin Default 0x95170110: [Fixed] Speaker at Int Top
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 2
     0x10* 0x11
Node 0x1b [Pin Complex] wcaps 0x400500: Mono
  Pincap 0x0810010: OUT EAPD
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 2
     0x10* 0x11
Node 0x1c [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x224511f0: [Jack] SPDIF Out at Sep Front
    Conn = Optical, Color = Black
  Pin-ctls: 0x00:
  Power: 0x0
  Connection: 1
     0x12
Node 0x1d [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-In vals:
  Pincap 0x0820: IN
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
