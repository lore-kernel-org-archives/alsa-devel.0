From: Christian Esken <esken@kde.org>
Subject: Testers wanted: New SB X-Fi driver
Date: Sat, 27 Jun 2009 14:05:45 +0200
Message-ID: <200906271405.45651.esken@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48]) by alsa0.perex.cz (Postfix) with ESMTP id CB31A24686
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 14:05:52 +0200 (CEST)
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net
	[151.189.8.34]) by mx.arcor.de (Postfix) with ESMTP id 3B77E2AEE66
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 14:05:50 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 2F9E645C8DF
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 14:05:50 +0200 (CEST)
Received: from firefly.localnet (dslb-092-072-192-118.pools.arcor-ip.net
	[92.72.192.118])
	by mail-in-06.arcor-online.net (Postfix) with ESMTPS id 7330F39A6ED
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 14:05:46 +0200 (CEST)
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

unfortunately I cannot playback anything (PCM) with the new SB X-Fi driver.
  Driver: ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-
driver-snapshot.tar.bz2
  Distribution: openSuSE 11.1
  Kernel: 2.6.27.23-0.1-xen

My card is a "X-Fi Titanium" (PCI device code: 1102:000b). The card is 
recognized by the driver, and any mixer (alsamixer, kmix) also recognizes the 
card.

But playing back isn't possible. I tried speaker-test, audacity, amarok and 
aplay. Most applications  hang, some also produce an error in the 
/var/log/messages (see 
below).

I then used "./configure --with-debug=full --with-cards=ctxfi" due to the 
possible hd-audio conflict, but it didn't make a difference.

Is there anything else I could try?

 Christian


--- Console output from speaker-test ---
bash # LANG=en speaker-test

speaker-test 1.0.18

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 512 to 65536
Period size range from 32 to 32768
Using max buffer size 65536
Periods = 4
was set period_size = 16384
was set buffer_size = 65536
 0 - Front Left
Write error: -5,Input/output error
xrun_recovery failed: -5,Input/output error
Transfer failed: Operation not permitted
------------------------------------------------------------------------

--- output in /var/log/messages when running speaker-test ---
Jun 27 12:52:53 firefly kernel: ALSA /home/chris/Desktop/alsa-
driver/acore/../alsa-kernel/core/pcm_lib.c:1693: playback write error (DMA or 
IRQ trouble?)
------------------------------------------------------------------------

---output in /var/log/messages when running amarok with pulseudio ---
 20 11:11:00 firefly pulseaudio[5649]: module-alsa-sink.c: ALSA woke us up to 
write new data to the device, but there was actually nothing to write! Most
likely this is an ALSA driver bug.
------------------------------------------------------------------------



--- Hardware information ---
firefly:~ # lspci -nn  | grep -i audio
00:07.0 Audio device [0403]: nVidia Corporation MCP65 High Definition Audio 
[10de:044a] (rev a1)
01:07.0 Multimedia audio controller [0401]: Cirrus Logic CS 4614/22/24/30 
[CrystalClear SoundFusion Audio Accelerator] [1013:6003] (rev 01)
05:00.0 Audio device [0403]: Creative Labs Device [1102:000b] (rev 03)


--- Hardware information from lshal ---
udi = '/org/freedesktop/Hal/devices/pci_1102_b_sound_card_0'
  info.capabilities = {'sound'} (string list)
  info.category = 'sound'  (string)
  info.parent = '/org/freedesktop/Hal/devices/pci_1102_b'  (string)
  info.product = 'Creative X-Fi 20K2 SB0880 Sound Card'  (string)
  info.subsystem = 'sound'  (string)
  info.udi = '/org/freedesktop/Hal/devices/pci_1102_b_sound_card_0'  (string)
  linux.hotplug_type = 2  (0x2)  (int)
  linux.subsystem = 'sound'  (string)
  linux.sysfs_path = 
'/sys/devices/pci0000:00/0000:00:0e.0/0000:05:00.0/sound/card0'  (string)
  sound.card = 0  (0x0)  (int)
  sound.card_id = 'Creative X-Fi 20K2 SB0880'  (string)
  sound.originating_device = '/org/freedesktop/Hal/devices/pci_1102_b'  
(string)
