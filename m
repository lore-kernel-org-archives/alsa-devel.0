From: The Source <thesourcehim@gmail.com>
Subject: snd-ctxfi oops
Date: Fri, 12 Jun 2009 07:52:22 +0400
Message-ID: <4A31D0F6.5080901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C9CD244B0
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 05:52:26 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1925080bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2009 20:52:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello. I use snd-ctxfi from 8 June snapshot. I hadn't oopses since I 
installed this driver but recently I got one again:

Kernel failure message 1:
BUG: sleeping function called from invalid context at mm/slub.c:1599
in_atomic(): 0, irqs_disabled(): 1, pid: 2537, name: gstreamer-prope
Pid: 2537, comm: gstreamer-prope Tainted: P           
2.6.29.4-167.fc11.x86_64 #1
Call Trace:
  [<ffffffff8103ff0f>] __might_sleep+0x10b/0x110
  [<ffffffff810cd734>] __kmalloc+0x73/0x130
  [<ffffffffa0b4b142>] ? daio_rsc_init+0xaa/0x125 [snd_ctxfi]
  [<ffffffffa0b4b212>] dao_rsc_init+0x55/0x1c0 [snd_ctxfi]
  [<ffffffffa0b4b3d2>] dao_rsc_reinit+0x55/0x5d [snd_ctxfi]
  [<ffffffff813abd6c>] ? _spin_lock_irqsave+0x32/0x3b
  [<ffffffffa0b454fe>] atc_spdif_out_passthru+0x92/0x136 [snd_ctxfi]
  [<ffffffffa0b4744d>] ct_pcm_playback_open+0x8b/0x11a [snd_ctxfi]
  [<ffffffffa0b34498>] snd_pcm_open_substream+0x46/0x83 [snd_pcm]
  [<ffffffffa0b345a8>] snd_pcm_open+0xd3/0x1db [snd_pcm]
  [<ffffffff810406fd>] ? default_wake_function+0x0/0x14
  [<ffffffffa0b3471a>] snd_pcm_playback_open+0x31/0x36 [snd_pcm]
  [<ffffffff813abe16>] ? lock_kernel+0x21/0x31
  [<ffffffffa00ec57d>] snd_open+0x105/0x184 [snd]
  [<ffffffff810d7da3>] chrdev_open+0x152/0x171
  [<ffffffff810d7c51>] ? chrdev_open+0x0/0x171
  [<ffffffff810d3922>] __dentry_open+0x143/0x273
  [<ffffffff810d3b22>] nameidata_to_filp+0x42/0x53
  [<ffffffff810df1bd>] do_filp_open+0x3fd/0x7b8
  [<ffffffff810e0f0b>] ? vfs_ioctl+0x22/0x87
  [<ffffffff811b95b2>] ? might_fault+0x1f/0x21
  [<ffffffff811b96b1>] ? __strncpy_from_user+0x1e/0x49
  [<ffffffff810e859c>] ? alloc_fd+0x11b/0x12d
  [<ffffffff810d3712>] do_sys_open+0x59/0xda
  [<ffffffff810d37c6>] sys_open+0x20/0x22
  [<ffffffff8101133a>] system_call_fastpath+0x16/0x1b
