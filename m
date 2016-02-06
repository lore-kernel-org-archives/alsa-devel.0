From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: heap out-of-bounds write in dummy_systimer_prepare
Date: Sat, 6 Feb 2016 19:26:11 +0100
Message-ID: <CACT4Y+aZ+xisrpuM6cOXbL21DuM0yVxPYXf4cD4Md9uw0C3dBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I am still seeing these eap out-of-bounds writes in
dummy_systimer_prepare. Even when we've disabled the hrtimer sysctl.
The fuzzer does not change sysctls at the moment and I think we've
overlooked a very simple possibility that can happen when sysctls are
not changed (i.e. triggered by an unprivileged user).

dummy_pcm_open does:

static int dummy_pcm_open(struct snd_pcm_substream *substream)
{
...
        dummy->timer_ops = &dummy_systimer_ops;
#ifdef CONFIG_HIGH_RES_TIMERS
        if (hrtimer)
                dummy->timer_ops = &dummy_hrtimer_ops;
#endif

There is a small window of time when we switch timer_ops to
dummy_systimer_ops and then restore it back to dummy_hrtimer_ops. If
another thread executes a timer op during that window, it happily
smashes heap thinking that there is a systimer there.

KTSAN, a data race detector (https://github.com/google/ktsan), would
catch this in a blink of an eye and give a detailed explanation of
what happens...

==================================================================
[  134.926046] BUG: KASAN: slab-out-of-bounds in
dummy_systimer_prepare+0x268/0x2a0 at addr ffff880030f00b10
[  134.926046] Write of size 4 by task syz-executor/32211
[  134.926046] =============================================================================
[  134.926046] BUG kmalloc-192 (Not tainted): kasan: bad access detected
[  134.926046] -----------------------------------------------------------------------------
[  134.926046]
[  134.926046] INFO: Allocated in dummy_hrtimer_create+0x49/0x1a0
age=5 cpu=0 pid=32211
[  134.926046] ___slab_alloc+0x564/0x5b0
[  134.926046] __slab_alloc+0x66/0xc0
[  134.926046] kmem_cache_alloc_trace+0x25c/0x300
[  134.931676] dummy_hrtimer_create+0x49/0x1a0
[  134.931676] dummy_pcm_open+0xef/0x570
[  134.932135] snd_pcm_open_substream+0x188/0x430
[  134.932135] snd_pcm_oss_open.part.17+0x5a4/0x1110
[  134.932135] snd_pcm_oss_open+0x35/0x50
[  134.932135] soundcore_open+0x30f/0x640
[  134.932135] chrdev_open+0x22a/0x4c0
[  134.932135] do_dentry_open+0x6a2/0xcb0
[  134.932135] vfs_open+0x17b/0x1f0
[  134.932135] path_openat+0xde9/0x5e30
[  134.932135] do_filp_open+0x18e/0x250
[  134.932135] do_sys_open+0x1fc/0x420
[  134.932135] SyS_open+0x2d/0x40

[  134.932135] INFO: Freed in snd_pcm_plugin_free+0xb1/0xe0 age=20
cpu=0 pid=32142
[  134.932135] __slab_free+0x1fc/0x320
[  134.932135] kfree+0x2ac/0x2c0
[  134.932135] snd_pcm_plugin_free+0xb1/0xe0
[  134.932135] snd_pcm_oss_release_substream+0x113/0x1f0
[  134.932135] snd_pcm_release_substream.part.38+0x1e8/0x2f0
[  134.937048] snd_pcm_release_substream+0x59/0x70
[  134.937048] snd_pcm_oss_release_file+0x7b/0xb0
[  134.937048] snd_pcm_oss_release+0xfa/0x280
[  134.937048] __fput+0x236/0x780
[  134.937048] ____fput+0x15/0x20
[  134.937048] task_work_run+0x170/0x210
[  134.937048] do_exit+0x8b5/0x2cb0
[  134.937048] do_group_exit+0x108/0x330
[  134.937048] get_signal+0x5e4/0x14f0
[  134.937048] do_signal+0x83/0x1c90
[  134.937048] exit_to_usermode_loop+0x1a5/0x210

[  134.937048] Call Trace:
[  134.937048]  [<ffffffff82be30ad>] dump_stack+0x6f/0xa2
[  134.937048]  [<ffffffff8175c984>] print_trailer+0xf4/0x150
[  134.937048]  [<ffffffff8176370f>] object_err+0x2f/0x40
[  134.937048]  [<ffffffff81765fb6>] kasan_report_error+0x256/0x550
[  134.937048]  [<ffffffff81455748>] ? mark_held_locks+0xc8/0x120
[  134.937048]  [<ffffffff85223e23>] ? snd_power_wait+0x2e3/0x380
[  134.937048]  [<ffffffff817664ae>] __asan_report_store4_noabort+0x3e/0x40
[  134.937048]  [<ffffffff852e0f68>] ? dummy_systimer_prepare+0x268/0x2a0
[  134.937048]  [<ffffffff852e0f68>] dummy_systimer_prepare+0x268/0x2a0
[  134.937048]  [<ffffffff852e141b>] dummy_pcm_prepare+0x7b/0xa0
[  134.937048]  [<ffffffff852563ca>] snd_pcm_do_prepare+0x5a/0x90
[  134.937048]  [<ffffffff852556b6>] snd_pcm_action_single+0x76/0x120
[  134.937048]  [<ffffffff85255ab5>] snd_pcm_action_nonatomic+0x95/0xa0
[  134.937048]  [<ffffffff85260a05>] snd_pcm_common_ioctl1+0x1045/0x21a0
[  134.937048]  [<ffffffff86659c34>] ? __mutex_unlock_slowpath+0x1f4/0x430
[  134.937048]  [<ffffffff8525f9c0>] ? snd_pcm_status_user+0x140/0x140
[  134.937048]  [<ffffffff86659e79>] ? mutex_unlock+0x9/0x10
[  134.937048]  [<ffffffff8529649c>] ? snd_pcm_oss_change_params+0xb2c/0x3580
[  134.937048]  [<ffffffff85261e02>] snd_pcm_playback_ioctl1+0x2a2/0x5e0
[  134.937048]  [<ffffffff85295970>] ?
snd_pcm_hw_param_near.constprop.26+0x8f0/0x8f0
[  134.937048]  [<ffffffff85261b60>] ? snd_pcm_common_ioctl1+0x21a0/0x21a0
[  134.937048]  [<ffffffff85262906>] snd_pcm_kernel_ioctl+0x136/0x160
[  134.937048]  [<ffffffff852908bb>] snd_pcm_oss_prepare+0x4b/0x200
[  134.937048]  [<ffffffff85298f9e>] snd_pcm_oss_make_ready+0xae/0x120
[  134.937048]  [<ffffffff8529f58f>] snd_pcm_oss_write+0x15f/0x700
[  134.937048]  [<ffffffff81456670>] ? debug_check_no_locks_freed+0x3c0/0x3c0
[  134.937048]  [<ffffffff817bacd3>] __vfs_write+0x113/0x4b0
[  134.937048]  [<ffffffff8529f430>] ? snd_pcm_oss_ioctl_compat+0x30/0x30
[  134.937048]  [<ffffffff817babc0>] ? vfs_iter_write+0x360/0x360
[  134.937048]  [<ffffffff81493f27>] ? debug_lockdep_rcu_enabled+0x77/0x90
[  134.937048]  [<ffffffff829e63c5>] ? common_file_perm+0x155/0x3a0
[  134.937048]  [<ffffffff829e6822>] ? apparmor_file_permission+0x22/0x30
[  134.937048]  [<ffffffff8291d07c>] ? security_file_permission+0x8c/0x1f0
[  134.937048]  [<ffffffff817bc162>] ? rw_verify_area+0x102/0x2c0
[  134.937048]  [<ffffffff817bc797>] vfs_write+0x167/0x4a0
[  134.937048]  [<ffffffff817bfa81>] SyS_write+0x111/0x220
[  134.937048]  [<ffffffff817bf970>] ? SyS_read+0x220/0x220
[  134.937048]  [<ffffffff81005017>] ? trace_hardirqs_on_thunk+0x17/0x19
[  134.937048]  [<ffffffff8665f176>] entry_SYSCALL_64_fastpath+0x16/0x7a
[  134.937048] ==================================================================

On commit df48ab3c2f5ffca88b7803ffbadd074bd5a0a2ef.
