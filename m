From: "Avuton Olrich" <avuton@gmail.com>
Subject: v2.6.25.3 BUG (due to usb audio device?)
Date: Sun, 11 May 2008 09:53:01 -0700
Message-ID: <3aa654a40805110953s66a27271y4356cb3d032dcb38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 841422464D
	for <alsa-devel@alsa-project.org>;
	Sun, 11 May 2008 18:53:14 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1199316ywk.2
	for <alsa-devel@alsa-project.org>; Sun, 11 May 2008 09:53:02 -0700 (PDT)
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
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This locks up KDE due to kmixer somehow trying to stay attached to the
audio device after resume from suspend-to-disk. This is the second
time of dealing with this (or a similar bug) with the usb audio
device:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006867.html

I got it working by using the head of the git tree recommended in that
thread (unfortunately I don't have the hash it was related to).

http://avuton.googlepages.com/config.gz
http://avuton.googlepages.com/proc-version
http://avuton.googlepages.com/lspci-vvv

[ 1432.710102] BUG: unable to handle kernel paging request at 00100100
[ 1432.710102] IP: [<c039be3d>] snd_ctl_dev_disconnect+0x5d/0x90
[ 1432.710102] *pde = 00000000
[ 1432.710102] Oops: 0000 [#1] PREEMPT
[ 1432.710102] Modules linked in: netconsole configfs snd_pcm_oss snd_mixer_oss
[ 1432.710102]
[ 1432.710102] Pid: 176, comm: khubd Not tainted (2.6.25.3 #1)
[ 1432.710102] EIP: 0060:[<c039be3d>] EFLAGS: 00010246 CPU: 0
[ 1432.710102] EIP is at snd_ctl_dev_disconnect+0x5d/0x90
[ 1432.710102] EAX: 00000000 EBX: 00100100 ECX: 00020004 EDX: 0000001d
[ 1432.710102] ESI: f7c7dd68 EDI: f7c7dc00 EBP: f7c7dd4c ESP: f7d33e68
[ 1432.710102]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[ 1432.710102] Process khubd (pid: 176, ti=f7d32000 task=f7d30000
task.ti=f7d32000)
[ 1432.710102] Stack: 00000000 f7d654e0 f7c7dc00 f7c7dd40 00000000
c039e0b6 c01a8630 f7d654e0
[ 1432.710102]        c039e35a 00000000 f7c7dc00 c05502c0 f7c7e080
c039a561 f7d33ec4 f7d6d9c0
[ 1432.710102]        f7d6c400 f7d6c41c c03be425 f7c7dc00 c04f0755
f7c3dc5c f7d6c400 f7d6c41c
[ 1432.710102] Call Trace:
[ 1432.710102]  [<c039e0b6>] snd_device_disconnect+0x56/0x80
[ 1432.710102]  [<c01a8630>] sysfs_ilookup_test+0x0/0x10
[ 1432.710102]  [<c039e35a>] snd_device_disconnect_all+0x2a/0x50
[ 1432.710102]  [<c039a561>] snd_card_disconnect+0x141/0x1b0
[ 1432.710102]  [<c03be425>] usb_audio_disconnect+0x55/0x130
[ 1432.710102]  [<c035ba18>] usb_unbind_interface+0x38/0x90
[ 1432.710102]  [<c030df81>] __device_release_driver+0x51/0x90
[ 1432.710102]  [<c030e3ad>] device_release_driver+0x1d/0x40
[ 1432.710102]  [<c030d881>] bus_remove_device+0x51/0x80
[ 1432.710102]  [<c030bf3c>] device_del+0xdc/0x150
[ 1432.710102]  [<c035902a>] usb_disable_device+0x7a/0xe0
[ 1432.710102]  [<c0354be9>] usb_disconnect+0x89/0xe0
[ 1432.710102]  [<c0355996>] hub_thread+0x2f6/0xc90
[ 1432.710102]  [<c0116e0b>] pick_next_task_fair+0x7b/0xb0
[ 1432.710102]  [<c012dc40>] autoremove_wake_function+0x0/0x40
[ 1432.710102]  [<c03556a0>] hub_thread+0x0/0xc90
[ 1432.710102]  [<c012d912>] kthread+0x42/0x70
[ 1432.710102]  [<c012d8d0>] kthread+0x0/0x70
[ 1432.710102]  [<c0104b1f>] kernel_thread_helper+0x7/0x18
[ 1432.710102]  =======================
[ 1432.710102] Code: 18 b9 01 00 00 00 ba 03 00 00 00 c7 04 24 00 00
00 00 e8 d7 c7 d7 ff 8d 43 20 b9 04 00 02 00 ba 1d 00 00 00 e8 65 9a
dd ff 8b 1b <8b> 03 0f 18 00 90 39 f3 75 c9 89 e8 e8 12 5a d9 ff 89 fa
31 c0
[ 1432.710102] EIP: [<c039be3d>] snd_ctl_dev_disconnect+0x5d/0x90
SS:ESP 0068:f7d33e68
[ 1432.710127] ---[ end trace 1c91addd529faaa2 ]---
-- 
avuton
--
 "I've got a fever. And the only prescription is more cowbell." --
Christopher Walken
