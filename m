From: Pete <peterpion@yahoo.com>
Subject: Re: Xrun stack trace for 1010LT
Date: Fri, 5 Dec 2008 13:39:33 -0800 (PST)
Message-ID: <351954.41071.qm@web65406.mail.ac4.yahoo.com>
References: <20081205194119.GA3669@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65406.mail.ac4.yahoo.com (web65406.mail.ac4.yahoo.com
	[76.13.9.26]) by alsa0.perex.cz (Postfix) with SMTP id 8B0FA2444F
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 22:39:34 +0100 (CET)
In-Reply-To: <20081205194119.GA3669@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@sound-man.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I was confusing the two. Ill work on the kernel over the weekend. In the meantime I recompiled it without the rt patch today and have this in my stack trace:

Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623613] Pid: 4785, comm: arecord Not tainted 2.6.24.1 #1
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623636]  [<c02a5a07>] snd_pcm_period_elapsed+0x247/0x2f0
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623653]  [<f88ed832>] do_get_write_access+0x232/0x520 [jbd]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623678]  [<c02b9cf9>] snd_ice1712_interrupt+0xa9/0x1a0
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623694]  [<c0168000>] handle_IRQ_event+0x30/0x60
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623705]  [<c016996d>] handle_level_irq+0x7d/0xf0
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623715]  [<c010711b>] do_IRQ+0x3b/0x70
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623724]  [<c01b3693>] __block_prepare_write+0x233/0x410
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623736]  [<c0105523>] common_interrupt+0x23/0x30
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623749]  [<f88f007b>] journal_commit_transaction+0xe9b/0xf10 [jbd]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623764]  [<c0345597>] _spin_unlock+0x7/0x20
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623776]  [<f88ee8f2>] journal_dirty_data+0xb2/0x250 [jbd]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623793]  [<f890f8a8>] ext3_journal_dirty_data+0x18/0x50 [ext3]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623811]  [<f89104b0>] ext3_get_block+0x0/0x100 [ext3]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623830]  [<f890eb12>] walk_page_buffers+0x32/0x70 [ext3]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623849]  [<f89116d4>] ext3_ordered_write_end+0x74/0x180 [ext3]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623866]  [<f890f890>] ext3_journal_dirty_data+0x0/0x50 [ext3]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623887]  [<c016f6ee>] generic_file_buffered_write+0x18e/0x670
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623911]  [<f89176a4>] __ext3_journal_stop+0x24/0x50 [ext3]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623931]  [<c01ae4b0>] __mark_inode_dirty+0x30/0x1a0
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623948]  [<c016fe74>] __generic_file_aio_write_nolock+0x2a4/0x540
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623970]  [<c01318d5>] irq_exit+0x45/0x50
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623981]  [<c0170175>] generic_file_aio_write+0x65/0xe0
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623998]  [<f890d830>] ext3_file_write+0x30/0xc0 [ext3]
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.624016]  [<c01908c5>] do_sync_write+0xd5/0x120
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.624035]  [<c0140600>] autoremove_wake_function+0x0/0x40
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.624047]  [<c0143cac>] hrtimer_nanosleep+0x5c/0x100
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.624064]  [<c01907f0>] do_sync_write+0x0/0x120
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.624070]  [<c01911c9>] vfs_write+0xb9/0x170
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.624080]  [<c0191901>] sys_write+0x41/0x70
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.624090]  [<c01044d2>] sysenter_past_esp+0x6b/0xa9
Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.624108]  =======================

Several times over.  Would this suggest that the ext3 filesystem is my problem? What is going on exactly?

Thanks, Pete


nice values are irrelevant to processes with rtprio. Any rtprio process
will have priority over any process with just a nice value. jackd -R
defaults to rtprio 10 (in a range of 0-99). You can raise that by 
specifying the value on the command line eg. jackd -R -P80
which would increase it to 80 (usually unnecessary and possibly
inadvisable). You can look at what's running with rtprio on your system
with ps, eg.:   ps -Leo pid,cmd,rtprio

rtprio makes use of SCHED_FIFO or SCHED_RR (as opposed to SCHED_NORMAL).
These are static soft realtime scheduling policies provided by the
standard kernel. The -rt kernels attempt to get closer to hard realtime.
Don't confuse the two.

On the current kernels, a non-root user has to belong to a realtime
scheduling group (eg. the audio group) and the kernel config needs to
have CONFIG_RT_GROUP_SCHED=y to allow rtprio to be used. The relevant
configuration must also be present in /etc/security/limits.conf. There
are plenty of articles on the web describing how to set up limits.conf.

John
