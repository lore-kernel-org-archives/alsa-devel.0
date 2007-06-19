From: Nathan Allen Stratton <nathan@robotics.net>
Subject: $1000 bounty for getting audio working under linux on
	a Osprey 440
Date: Tue, 19 Jun 2007 14:26:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0706191425360.15975@barney.robotics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barney.robotics.net (cyber.robotics.net [209.150.98.82])
	by alsa0.perex.cz (Postfix) with ESMTP id AABD4243F8
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 20:26:55 +0200 (CEST)
Received: from barney.robotics.net (barney.robotics.net [209.150.98.82])
	by barney.robotics.net (8.12.10/8.12.10) with ESMTP id l5JIQuFX015989
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2007 14:26:56 -0400
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


Need to get audio working on Osprey 440 card.

http://www.viewcast.com/pages.asp?page=osprey-440

The card is bt878 based, and ViewCast says it is supported on linux
however not something they support. Audio is not detected by default, but
does how up when you do a modprobe snd-bt87x load-all(see below). However
I have not been able to pull audio from the card (only get high pitched
noise). Bid may require patching bt878.c if modprobe options don't work.
Only mono support is required.

[root@video share]# amixer
Simple mixer control 'Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 48
  Mono: 30 [62%]
Simple mixer control 'Bass Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 48
  Mono: 24 [50%]
Simple mixer control 'PCM',0
  Capabilities: pvolume cvolume pswitch pswitch-joined cswitch
cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 44 Capture 0 - 15
  Mono: Capture 15 [100%] [15.00dB] [on]
  Front Left: Playback 44 [100%] [3.00dB] [on]
  Front Right: Playback 44 [100%] [3.00dB] [on]
Simple mixer control 'PCM Capture Source',0
  Capabilities: enum
  Items: 'PCM' 'Mic' 'Input 2'
  Item0: 'Input 2'
Simple mixer control 'PCM',1
  Capabilities: cvolume
  Capture channels: Mono
  Limits: Capture 0 - 656
  Mono: Capture 0 [0%] [-41.00dB]
Simple mixer control 'Mic',0
  Capabilities: cvolume
  Capture channels: Mono
  Limits: Capture 0 - 15
  Mono: Capture 0 [0%] [16.00dB]
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
[root@video share]# amixer -c 1
Simple mixer control 'FM',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Mic/Line',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume
  Capture channels: Mono
  Limits: Capture 0 - 15
  Mono: Capture 15 [100%]
Simple mixer control 'Capture Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'TV Tuner',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]

::::::::::::::
cards
::::::::::::::
 0 [INport         ]: USB-Audio - INport
                      Xitel INport at usb-0000:00:1d.0-1, full speed
 1 [Bt878          ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xd8001000, irq 16
 2 [Bt878_1        ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xd8003000, irq 17
 3 [Bt878_2        ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xd8005000, irq 18
 4 [Bt878_3        ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xd8007000, irq 19
::::::::::::::
devices
::::::::::::::
  2:        : timer
  3:        : sequencer
  4: [ 0- 0]: digital audio playback
  5: [ 0- 0]: digital audio capture
  6: [ 0]   : control
  7: [ 1- 1]: digital audio capture
  8: [ 1- 0]: digital audio capture
  9: [ 1]   : control
 10: [ 2- 1]: digital audio capture
 11: [ 2- 0]: digital audio capture
 12: [ 2]   : control
 13: [ 3- 1]: digital audio capture
 14: [ 3- 0]: digital audio capture
 15: [ 3]   : control
 16: [ 4- 1]: digital audio capture
 17: [ 4- 0]: digital audio capture
 18: [ 4]   : control
::::::::::::::
hwdep
::::::::::::::

*** INport: directory ***

::::::::::::::
modules
::::::::::::::
 0 snd_usb_audio
 1 snd_bt87x
 2 snd_bt87x
 3 snd_bt87x
 4 snd_bt87x

*** oss: directory ***

::::::::::::::
pcm
::::::::::::::
00-00: USB Audio : USB Audio : playback 1 : capture 1
01-01: Bt87x Analog : Bt87x Analog : capture 1
01-00: Bt87x Digital : Bt87x Digital : capture 1
02-01: Bt87x Analog : Bt87x Analog : capture 1
02-00: Bt87x Digital : Bt87x Digital : capture 1
03-01: Bt87x Analog : Bt87x Analog : capture 1
03-00: Bt87x Digital : Bt87x Digital : capture 1
04-01: Bt87x Analog : Bt87x Analog : capture 1
04-00: Bt87x Digital : Bt87x Digital : capture 1

*** seq: directory ***

::::::::::::::
timers
::::::::::::::
G0: system timer : 1000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P1-0-1: PCM capture 1-0-1 : SLAVE
P1-1-1: PCM capture 1-1-1 : SLAVE
P2-0-1: PCM capture 2-0-1 : SLAVE
P2-1-1: PCM capture 2-1-1 : SLAVE
P3-0-1: PCM capture 3-0-1 : SLAVE
P3-1-1: PCM capture 3-1-1 : SLAVE
P4-0-1: PCM capture 4-0-1 : SLAVE
P4-1-1: PCM capture 4-1-1 : SLAVE
::::::::::::::
version
::::::::::::::
Advanced Linux Sound Architecture Driver Version 1.0.14rc3 (Wed Mar 14
07:25:50 2007 UTC).


unknown card 0x878-0x70:0xff07, using default rate 32000
please mail id, board name, and, if it works, the correct digital_rate
option to <alsa-devel@lists.sf.net>
ACPI: PCI Interrupt 0000:06:04.1[A] -> GSI 16 (level, low) -> IRQ 16
unknown card 0x878-0x70:0xff07, using default rate 32000
please mail id, board name, and, if it works, the correct digital_rate
option to <alsa-devel@lists.sf.net>
ACPI: PCI Interrupt 0000:06:05.1[A] -> GSI 17 (level, low) -> IRQ 17
unknown card 0x878-0x70:0xff07, using default rate 32000
please mail id, board name, and, if it works, the correct digital_rate
option to <alsa-devel@lists.sf.net>
ACPI: PCI Interrupt 0000:06:06.1[A] -> GSI 18 (level, low) -> IRQ 18
unknown card 0x878-0x70:0xff07, using default rate 32000
please mail id, board name, and, if it works, the correct digital_rate
option to <alsa-devel@lists.sf.net>
ACPI: PCI Interrupt 0000:06:07.1[A] -> GSI 19 (level, low) -> IRQ 19

><>
Nathan Stratton                         CTO, Voila IP Communications
nathan at robotics.net                  nathan at voilaip.com
http://www.robotics.net                 http://www.voilaip.com
