From: "Howdy Pierce" <howdy@cardinalpeak.com>
Subject: left/right bleed or crossover
Date: Mon, 2 Jul 2007 16:25:12 -0600
Message-ID: <006601c7bcf7$dc13d620$6a00a8c0@cardinalpeak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.plus.mail.mud.yahoo.com
	(smtp106.plus.mail.mud.yahoo.com [68.142.206.239])
	by alsa0.perex.cz (Postfix) with SMTP id D6BD0103895
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 00:25:38 +0200 (CEST)
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

I'm encountering the following problem on Fedora Core 6 running on a Dell
Optiplex 745.  This is a pretty vanilla computer with an ICH8 chipset and
integrated AD1983 sound capabilities. 

I have wired up a funky line-input cable so that I have completely separate
audio sources playing on the left and right inputs.

When I either play these through to the speaker output directly (using
alsamixer), or record the audio using arecord, the result is that there is a
slight bit of bleeding or crossover, so I can faintly hear the left input on
the right channel, and vice versa.  If I record a wav file and then play it
on another computer, the left/right bleeding follows the wav file, so it
seems that the problem is in the capture process somehow.

When I install Windows XP onto the same machine, the problem disappears, so
I can rule out hardware errors.

The application I'm working on relies on being able to reliably capture the
right and left channels of audio independently.  Since the problem can be
seen using the standard arecord/aplay tools, though, I don't think it's my
code.

I've tried all the possible combinations inside alsamixer, and I don't think
there's anything I've messed up there.

I've put the relevant system details below.  Thanks for any help you can
provide.

--Howdy 

  =============================
  Howdy Pierce
  Managing Partner
  Cardinal Peak, LLC

  work:  (303) 665-3962 x101
  cell:  (303) 589-1645
  email: howdy@cardinalpeak.com
  web:   www.cardinalpeak.com
  =============================


[root@dundee ~]# cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xdfdfc000 irq 169

[root@dundee ~]# cat /proc/asound/devices
  2:        : timer
  3:        : sequencer
  4: [ 0- 1]: digital audio playback
  5: [ 0- 0]: digital audio playback
  6: [ 0- 0]: digital audio capture
  7: [ 0]   : control

[root@dundee ~]# lspci
00:00.0 Host bridge: Intel Corporation 82Q963/Q965 Memory Controller Hub
(rev 02)
00:01.0 PCI bridge: Intel Corporation 82Q963/Q965 PCI Express Root Port (rev
02)
00:02.0 Display controller: Intel Corporation 82Q963/Q965 Integrated
Graphics Controller (rev 02)
00:02.1 Display controller: Intel Corporation 82Q963/Q965 Integrated
Graphics Controller (rev 02)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #4
(rev 02)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #5
(rev 02)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #2
(rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port
1 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port
5 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #1
(rev 02)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #2
(rev 02)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #3
(rev 02)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #1
(rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface
Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801H (ICH8 Family) 4 port SATA
IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev
02)
00:1f.5 IDE interface: Intel Corporation 82801H (ICH8 Family) 2 port SATA
IDE Controller (rev 02)
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5754 Gigabit
Ethernet PCI Express (rev 02)
04:02.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000
AGP 8x] (rev c1)

[root@dundee ~]# rpm --query --all | grep alsa
alsa-lib-1.0.12-2.fc6
alsa-lib-devel-1.0.12-2.fc6
alsa-utils-1.0.12-3.fc6

[root@dundee Intel]# cat /proc/asound/Intel/codec#0 
Codec: Analog Devices AD1983
Address: 0
Vendor Id: 0x11d41983
Subsystem Id: 0x102801da
Revision Id: 0x100400
Default PCM: rates 0x07f, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  PCM: rates 0x060, bits 0x02, types 0x5
  Connection: 2
     0x01* 0x04
Node 0x03 [Audio Output] wcaps 0x441: Stereo
  Power: 0x0
Node 0x04 [Audio Input] wcaps 0x100501: Stereo
  Power: 0x0
  Connection: 1
     0x14
Node 0x05 [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x32 0x32]
  Pincap 0x0817: OUT Detect
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 2
     0x03 0x0e*
Node 0x06 [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x25 0x25]
  Pincap 0x081f: OUT HP Detect
  Pin Default 0x0221101f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 2
     0x03 0x0e*
Node 0x07 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x0810: OUT
  Pin Default 0x991301f0: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0f
Node 0x08 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081727: IN Detect
  Pin Default 0x02a11020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0x24: IN
Node 0x09 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081727: IN Detect
  Pin Default 0x0181302e: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
Node 0x0a [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x414511f0: [N/A] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x03 0x0c 0x0d 0x0e*
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x08* 0x09
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x09* 0x08
Node 0x0e [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 3
     0x11 0x12 0x13
Node 0x0f [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x0b
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x80]
Node 0x11 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x17]
  Connection: 1
     0x03
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x0c
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x0d
Node 0x14 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0f 0x0f]
  Connection: 4
     0x0c 0x0d* 0x0e 0x0f
Node 0x15 [Power Widget] wcaps 0x500500: Mono
  Power: 0x0
  Connection: 15
     0x05 0x06* 0x07 0x08 0x09 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x12 0x13
0x14
