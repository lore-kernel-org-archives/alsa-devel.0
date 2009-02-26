From: Chuck Ebbert <cebbert@redhat.com>
Subject: possible recursive locking in snd_pcm_playback_ioctl()
Date: Wed, 25 Feb 2009 19:09:37 -0500
Message-ID: <20090225190937.467a9fa2@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 4695C10381E
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2009 01:09:46 +0100 (CET)
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1Q09jQe017023
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 19:09:45 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1Q09jNC016272
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 19:09:45 -0500
Received: from dhcp-100-2-144.bos.redhat.com (dhcp-100-2-144.bos.redhat.com
	[10.16.2.144])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1Q09jXf027283
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 19:09:45 -0500
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

https://bugzilla.redhat.com/show_bug.cgi?id=486729

[ INFO: possible recursive locking detected ]
2.6.29-0.137.rc5.git4.fc11.x86_64 #1
---------------------------------------------
pulseaudio/4381 is trying to acquire lock:
 (&substream->self_group.lock/1){....}, at: [<ffffffffa0161309>]
snd_pcm_action_group+0x53/0x217 [snd_pcm]

but task is already holding lock:
 (&substream->self_group.lock/1){....}, at: [<ffffffffa0161309>]
snd_pcm_action_group+0x53/0x217 [snd_pcm]

other info that might help us debug this:
4 locks held by pulseaudio/4381:
 #0:  (snd_pcm_link_rwlock){....}, at: [<ffffffffa0160450>]
snd_pcm_stream_lock_irq+0x1d/0x2d [snd_pcm]
 #1:  (&substream->self_group.lock){....}, at: [<ffffffffa016045c>]
snd_pcm_stream_lock_irq+0x29/0x2d [snd_pcm]
 #2:  (&substream->group->lock){....}, at: [<ffffffffa0161619>]
snd_pcm_action+0x33/0x90 [snd_pcm]
 #3:  (&substream->self_group.lock/1){....}, at: [<ffffffffa0161309>]
snd_pcm_action_group+0x53/0x217 [snd_pcm]

stack backtrace:
Pid: 4381, comm: pulseaudio Not tainted 2.6.29-0.137.rc5.git4.fc11.x86_64 #1
Call Trace:
 [<ffffffff8106faa1>] __lock_acquire+0x83b/0xc0d
 [<ffffffff8106e500>] ? check_usage_backwards+0x4a/0x53
 [<ffffffff8106ff05>] lock_acquire+0x92/0xc0
 [<ffffffffa0161309>] ? snd_pcm_action_group+0x53/0x217 [snd_pcm]
 [<ffffffff81394c10>] _spin_lock_nested+0x34/0x67
 [<ffffffffa0161309>] ? snd_pcm_action_group+0x53/0x217 [snd_pcm]
 [<ffffffffa0161309>] snd_pcm_action_group+0x53/0x217 [snd_pcm]
 [<ffffffffa016164f>] snd_pcm_action+0x69/0x90 [snd_pcm]
 [<ffffffffa016045c>] ? snd_pcm_stream_lock_irq+0x29/0x2d [snd_pcm]
 [<ffffffffa0161690>] snd_pcm_stop+0x1a/0x1c [snd_pcm]
 [<ffffffffa0161722>] snd_pcm_drop+0x90/0xa6 [snd_pcm]
 [<ffffffffa01642e9>] snd_pcm_common_ioctl1+0xb76/0xc26 [snd_pcm]
 [<ffffffff8101781b>] ? native_sched_clock+0x2d/0x5a
 [<ffffffff810170b5>] ? sched_clock+0x9/0xc
 [<ffffffff8106d04d>] ? lock_release_holdtime+0x2c/0x11d
 [<ffffffff81167865>] ? avc_has_perm_noaudit+0x444/0x497
 [<ffffffff8116788c>] ? avc_has_perm_noaudit+0x46b/0x497
 [<ffffffff81167458>] ? avc_has_perm_noaudit+0x37/0x497
 [<ffffffffa01648ed>] snd_pcm_playback_ioctl1+0x282/0x29f [snd_pcm]
 [<ffffffff8106d04d>] ? lock_release_holdtime+0x2c/0x11d
 [<ffffffffa016529d>] snd_pcm_playback_ioctl+0x2f/0x33 [snd_pcm]
 [<ffffffff810ee59b>] vfs_ioctl+0x22/0x87
 [<ffffffff810eea6b>] do_vfs_ioctl+0x46b/0x4ac
 [<ffffffff810eeb02>] sys_ioctl+0x56/0x79
 [<ffffffff8101133a>] system_call_fastpath+0x16/0x1b
