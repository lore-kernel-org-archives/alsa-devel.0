From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: 2.6.34-rc: sound hungs (ice1724)
Date: Wed, 14 Apr 2010 00:23:37 +0400
Message-ID: <x2ra4423d671004131323s58d606c4i33101f32f366568c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 98456103879
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 22:23:39 +0200 (CEST)
Received: by bwz20 with SMTP id 20so9388060bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 13:23:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi

Could you please help me how to debug an issue.
Sometimes soung hungs, it happens few days (up to a week) after boot.
I have no idea how to reproduce it or how to debug it.
That's why it is very hard to bisect, I have not tried, the better way
should exist.
The problem appeared somewhere after 2.6.33.

Card is M-Audio Revo 5.1 (1412:1724).

After it hungs ALSA continues to play last sound frame forever.
When I try to play something else playing frame changes.
Only reboot heals it.

rmmod hungs at
INFO: task rmmod:30356 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
rmmod         D db281e7c     0 30356   2345 0x00000004
 db281e8c 00000086 00000002 db281e7c cc2d7b90 00000000 c14e8b80 09c3638a
 c10252a0 00000001 c14e2000 c14e2000 c14e8b80 c14e8b80 cc2d7a00 db281e8c
 00000246 db281e8c c1043d23 00000001 f6923000 f69231b4 db281e9c db281ebc
Call Trace:
 [<c10252a0>] ? __wake_up+0x40/0x50
 [<c1043d23>] ? prepare_to_wait+0x43/0x70
 [<f8ce328d>] snd_card_free+0x5d/0x90 [snd]
 [<c1043af0>] ? autoremove_wake_function+0x0/0x40
 [<f9ebcaa6>] snd_vt1724_remove+0x13/0x25 [snd_ice1724]
 [<c11cddb9>] pci_device_remove+0x19/0x40
 [<c1239f3e>] __device_release_driver+0x3e/0x90
 [<c123a017>] driver_detach+0x87/0x90
 [<c1239323>] bus_remove_driver+0x63/0xa0
 [<c123a526>] driver_unregister+0x46/0x80
 [<c10d616d>] ? sysfs_remove_file+0xd/0x10
 [<c11cdfed>] pci_unregister_driver+0x2d/0x80
 [<f9ebca91>] alsa_card_ice1724_exit+0xd/0xf [snd_ice1724]
 [<c1057bee>] sys_delete_module+0x15e/0x210
 [<c107f91f>] ? remove_vma+0x3f/0x60
 [<c1080902>] ? do_munmap+0x202/0x2d0
 [<c1002b50>] sysenter_do_call+0x12/0x26

CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_PCI=y
CONFIG_SND_ICE1724=m
