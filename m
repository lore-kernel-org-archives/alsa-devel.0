From: Davide Canali <davide@davidecanali.com>
Subject: HDA Intel ALC259
Date: Mon, 19 Apr 2010 12:10:19 +0200
Message-ID: <4BCC2C0B.9040909@davidecanali.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth13.prod.mesa1.secureserver.net
	(smtpauth13.prod.mesa1.secureserver.net [64.202.165.37])
	by alsa0.perex.cz (Postfix) with SMTP id 5419D24673
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 12:10:41 +0200 (CEST)
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

Recently I bought a HP G62 120SL laptop. It has a HDA Intel ALC259 sound 
card.

I had to follow several steps to make the audio system work properly: I 
write you the information here to allow you to add better support to 
this sound card, since I see that many users are having the same issues 
with this model.

I'm using ubuntu lucid lynx (beta), with kernel:
$ uname -a
Linux nebula 2.6.32-21-generic #32-Ubuntu SMP Fri Apr 16 08:09:38 UTC 
2010 x86_64 GNU/Linux

As I bought the laptop, the headphones were working but there was no 
sound from the integrated speakers. After installing the package 
linux-backports-modules-alsa-lucid-generic, the situation was switched: 
internal speakers started to work, but the headphones produced no sound.

After messing up a bit with HDAAnalyzer, I found a modification that 
allows both internal speakers and the audio out jack to work.
The diff file is:

Diff for codec 0/0 (0x10ec0270):
---
+++
@@ -200,17 +200,17 @@
    Amp-Out vals: [0x00 0x00]
    Pincap 0x0000001c: OUT HP Detect
    Pin Default 0x0321401f: [Jack] HP Out at Ext Left
      Conn = 1/8, Color = Green
      DefAssociation = 0x1, Sequence = 0xf
    Pin-ctls: 0xc0: OUT HP
    Unsolicited: tag=0x04, enabled=1
    Connection: 2
-     0x0c 0x0d*
+     0x0c* 0x0d
  Node 0x22 [Audio Selector] wcaps 0x30010b: Stereo Amp-In
    Amp-In caps: N/A
    Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 
0x00] [0x00 0x00] [0x00 0x00]
    Connection: 7
       0x18* 0x19 0x1a 0x1b 0x1d 0x0b 0x12
  Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
    Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
    Amp-In vals: [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 
0x80] [0x80 0x80]

The only issue remaining now is audio input: sound recorded using the 
internal microphone, or an external one connected to the mic in jack 
results in a very low quality and scratchy audio.

Further information about this sound card and the ALSA version I'm using:
$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.22.1.
Compiled on Apr 14 2010 for kernel 2.6.32-21-generic (SMP).

$ cat /proc/asound/cards
  0 [Intel          ]: HDA-Intel - HDA Intel
                       HDA Intel at 0xd4400000 irq 34

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC259 Analog [ALC259 Analog]
   Subdevices: 0/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 3: INTEL HDMI 0 [INTEL HDMI 0]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 7: INTEL HDMI 1 [INTEL HDMI 1]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

$ aplay -L
pulse
     Playback/recording through the PulseAudio sound server
front:CARD=Intel,DEV=0
     HDA Intel, ALC259 Analog
     Front speakers
surround40:CARD=Intel,DEV=0
     HDA Intel, ALC259 Analog
     4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
     HDA Intel, ALC259 Analog
     4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
     HDA Intel, ALC259 Analog
     5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
     HDA Intel, ALC259 Analog
     5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
     HDA Intel, ALC259 Analog
     7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
hdmi:CARD=Intel,DEV=0
     HDA Intel, INTEL HDMI 0
     HDMI Audio Output

$ sudo lshw -class multimedia
   *-multimedia
        description: Audio device
        product: 5 Series/3400 Series Chipset High Definition Audio
        vendor: Intel Corporation
        physical id: 1b
        bus info: pci@0000:00:1b.0
        version: 05
        width: 64 bits
        clock: 33MHz
        capabilities: pm msi pciexpress bus_master cap_list
        configuration: driver=HDA Intel latency=0
        resources: irq:34 memory:d4400000-d4403fff


Please let me know if you need further information. Thank you.

     Davide
