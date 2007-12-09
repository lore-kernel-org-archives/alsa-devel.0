From: rmgls@free.fr
Subject: no input/output analog channels on rme multiface I
Date: Sun, 09 Dec 2007 23:39:46 +0100
Message-ID: <20071209223952.10A993227FC@smtp7-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by alsa0.perex.cz (Postfix) with ESMTP id EA1B61038C9
	for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2007 23:39:53 +0100 (CET)
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 3A79B32281C
	for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2007 23:39:53 +0100 (CET)
Received: from free.fr (evr27-1-88-172-40-194.fbx.proxad.net [88.172.40.194])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 10A993227FC
	for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2007 23:39:52 +0100 (CET)
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


Hi all,

the multiface 1, does not work for me.
it is recognized as hammerfal DSP, but the amixer shows no analog in/out
(there are 8 analog I/O in the box) and of course no volume control for
any channel.

the driver: hg: 20071205, the last lib, and firmware, and utils.
unpluging the box (power off), and loading the firmware on windows gives:
in the debian (2.6.24-rc3) dmesg: 

e9652/../../alsa-kernel/pci/rme9652/hdsp.c:5037: Hammerfall-DSP: Firmware
already present, initializing card.

...

pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.


sndstat reports: Xilinx FPGA ???


and now amixer -c2:

Simple mixer control 'Line Out',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Emphasis Bit',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Input Connector',0
  Capabilities: enum
  Items: 'Optical' 'Coaxial' 'Internal'
  Item0: 'Internal'
Simple mixer control 'IEC958 Non-audio Bit',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Output also on ADAT1',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Professional Bit',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'ADAT Lock Status',1
  Capabilities: enum
  Items: 'No Lock' 'Lock' 'Sync'
  Item0: 'No Lock'
Simple mixer control 'ADAT Sync Lock Status',0
  Capabilities: enum
  Items: 'No Lock' 'Lock' 'Sync'
  Item0: 'No Lock'
Simple mixer control 'AutoSync Reference',0
  Capabilities: enum
  Items: 'Word' 'ADAT Sync' 'IEC958' 'None' 'ADAT1' 'ADAT2' 'ADAT3'
  Item0: 'None'
Simple mixer control 'External Rate',0
  Capabilities: enum
  Items: '32000' '44100' '48000' '64000' '88200' '96000' 'None'
  Item0: 'None'
Simple mixer control 'Preferred Sync Reference',0
  Capabilities: enum
  Items: 'Word' 'IEC958' 'ADAT1' 'ADAT Sync'
  Item0: 'IEC958'
Simple mixer control 'SPDIF Lock Status',0
  Capabilities: enum
  Items: 'No Lock' 'Lock' 'Sync'
  Item0: 'No Lock'
Simple mixer control 'SPDIF Sample Rate',0
  Capabilities: enum
  Items: '32000' '44100' '48000' '64000' '88200' '96000' 'None'
  Item0: 'None'
Simple mixer control 'Sample Clock Source',0
  Capabilities: enum
  Items: 'AutoSync' 'Internal 32.0 kHz' 'Internal 44.1 kHz' 'Internal 48.0 kHz' 'Internal 64.0 kHz' 'Internal 88.2 kHz' 'Internal 96.0 kHz'
  Item0: 'Internal 44.1 kHz'
Simple mixer control 'Sample Clock Source Locking',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'System Clock Mode',0
  Capabilities: enum
  Items: 'Master' 'Slave'
  Item0: 'Master'
Simple mixer control 'System Sample Rate',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 0
  Mono: 0 [0%]
Simple mixer control 'Word Clock Lock Status',0
  Capabilities: enum
  Items: 'No Lock' 'Lock' 'Sync'
  Item0: 'No Lock'

please do i miss something?

thanks

rmgls@free.fr
