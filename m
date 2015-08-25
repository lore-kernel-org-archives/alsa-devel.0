From: Alexnader Kuleshov <kuleshovmail@gmail.com>
Subject: ALSA/usb-audio: snd_usb_autoresume possible recursive locking
 detected
Date: Tue, 25 Aug 2015 19:32:56 +0600
Message-ID: <20150825133256.GA1804@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello all,

Today I've update to 4.2.0-rc8+ and started to get following lines in the
dmesg output:

[   13.884092] =============================================
[   13.884092] [ INFO: possible recursive locking detected ]
[   13.884094] 4.2.0-rc8+ #61 Not tainted
[   13.884094] ---------------------------------------------
[   13.884095] pulseaudio/980 is trying to acquire lock:
[   13.884096]  (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0355dac>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.884103] 
               but task is already holding lock:
[   13.884104]  (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0355dac>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.884107] 
               other info that might help us debug this:
[   13.884108]  Possible unsafe locking scenario:

[   13.884109]        CPU0
[   13.884110]        ----
[   13.884110]   lock(&chip->shutdown_rwsem);
[   13.884111]   lock(&chip->shutdown_rwsem);
[   13.884112] 
                *** DEADLOCK ***

[   13.884113]  May be due to missing lock nesting notation

[   13.884114] 2 locks held by pulseaudio/980:
[   13.884115]  #0:  (&pcm->open_mutex){+.+.+.}, at: [<ffffffffa02ac9bc>] snd_pcm_open+0xa9/0x1f8 [snd_pcm]
[   13.884120]  #1:  (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0355dac>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.884124] 
               stack backtrace:
[   13.884125] CPU: 0 PID: 980 Comm: pulseaudio Not tainted 4.2.0-rc8+ #61
[   13.884126] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H-BK/Z97X-UD5H-BK, BIOS F6 06/17/2014
[   13.884127]  0000000000000000 000000003d4c66e6 ffff88040897b4d8 ffffffff815ba622
[   13.884129]  0000000000000000 ffffffff82399320 ffff88040897b598 ffffffff810dd54e
[   13.884130]  ffff88040ac486a8 0000000000000000 0000000000000001 ffffffff82399320
[   13.884132] Call Trace:
[   13.884134]  [<ffffffff815ba622>] dump_stack+0x4c/0x65
[   13.884137]  [<ffffffff810dd54e>] validate_chain.isra.9+0x75d/0xf59
[   13.884139]  [<ffffffff815c62b3>] ? _raw_spin_unlock_irq+0x28/0x34
[   13.884140]  [<ffffffff810e0964>] __lock_acquire+0x753/0xabf
[   13.884142]  [<ffffffff81163819>] ? kfree+0xb8/0x10d
[   13.884143]  [<ffffffff810e1131>] lock_acquire+0x7b/0x9c
[   13.884146]  [<ffffffffa0355dac>] ? snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.884147]  [<ffffffff815c4896>] down_read+0x44/0x8d
[   13.884150]  [<ffffffffa0355dac>] ? snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.884152]  [<ffffffffa0355dac>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.884153]  [<ffffffff815c37e5>] ? __mutex_unlock_slowpath+0x110/0x11b
[   13.884156]  [<ffffffffa0359338>] snd_usb_mixer_set_ctl_value+0x9a/0x16d [snd_usb_audio]
[   13.884159]  [<ffffffffa035957e>] snd_usb_set_cur_mix_value+0x4d/0x77 [snd_usb_audio]
[   13.884161]  [<ffffffffa0359db9>] restore_mixer_value+0x74/0x87 [snd_usb_audio]
[   13.884164]  [<ffffffffa035b581>] snd_usb_mixer_resume+0x64/0x70 [snd_usb_audio]
[   13.884166]  [<ffffffffa035505c>] __usb_audio_resume+0x5c/0xd8 [snd_usb_audio]
[   13.884169]  [<ffffffff81413ca4>] ? usb_runtime_suspend+0x63/0x63
[   13.884171]  [<ffffffffa03550e6>] usb_audio_reset_resume+0xe/0x10 [snd_usb_audio]
[   13.884172]  [<ffffffff81412fde>] usb_resume_interface.isra.1+0x6c/0xbd
[   13.884174]  [<ffffffff814130cf>] usb_resume_both+0xa0/0xc0
[   13.884175]  [<ffffffff81413cb9>] usb_runtime_resume+0x15/0x17
[   13.884178]  [<ffffffff813b92b0>] __rpm_callback+0x35/0x5d
[   13.884179]  [<ffffffff81413ca4>] ? usb_runtime_suspend+0x63/0x63
[   13.884180]  [<ffffffff813b9330>] rpm_callback+0x58/0x77
[   13.884182]  [<ffffffff81413ca4>] ? usb_runtime_suspend+0x63/0x63
[   13.884183]  [<ffffffff813ba0db>] rpm_resume+0x370/0x412
[   13.884184]  [<ffffffff813ba06c>] rpm_resume+0x301/0x412
[   13.884186]  [<ffffffff813ba1e3>] __pm_runtime_resume+0x66/0x82
[   13.884187]  [<ffffffff81412e10>] usb_autopm_get_interface+0x1e/0x48
[   13.884190]  [<ffffffffa0355dcc>] snd_usb_autoresume+0x3d/0x52 [snd_usb_audio]
[   13.884191]  [<ffffffff810d84b9>] ? __init_waitqueue_head+0x37/0x4b
[   13.884194]  [<ffffffffa035e765>] snd_usb_pcm_open+0x181/0x3bb [snd_usb_audio]
[   13.884197]  [<ffffffffa035e9ad>] snd_usb_capture_open+0xe/0x10 [snd_usb_audio]
[   13.884200]  [<ffffffffa02ac8c6>] snd_pcm_open_substream+0x50/0x9d [snd_pcm]
[   13.884203]  [<ffffffffa02ac9ce>] snd_pcm_open+0xbb/0x1f8 [snd_pcm]
[   13.884204]  [<ffffffff810de87d>] ? trace_hardirqs_on+0xd/0xf
[   13.884206]  [<ffffffff810c5550>] ? wake_up_q+0x53/0x53
[   13.884209]  [<ffffffffa02acb49>] snd_pcm_capture_open+0x3e/0x61 [snd_pcm]
[   13.884212]  [<ffffffffa028232d>] snd_open+0x130/0x13f [snd]
[   13.884214]  [<ffffffff811788c5>] chrdev_open+0x13b/0x175
[   13.884215]  [<ffffffff8117878a>] ? cdev_put+0x20/0x20
[   13.884217]  [<ffffffff81172f31>] do_dentry_open.isra.1+0x1d2/0x2c9
[   13.884218]  [<ffffffff8117d0e4>] ? __inode_permission+0x84/0x95
[   13.884219]  [<ffffffff81173bf6>] vfs_open+0x50/0x54
[   13.884221]  [<ffffffff811815e0>] path_openat+0xa90/0xd0f
[   13.884222]  [<ffffffff810e0900>] ? __lock_acquire+0x6ef/0xabf
[   13.884223]  [<ffffffff8118269e>] do_filp_open+0x48/0xac
[   13.884225]  [<ffffffff815c6203>] ? _raw_spin_unlock+0x23/0x2e
[   13.884227]  [<ffffffff8118f5b7>] ? __alloc_fd+0x144/0x156
[   13.884228]  [<ffffffff81173f3a>] do_sys_open+0x154/0x1f7
[   13.884229]  [<ffffffff81173ff6>] SyS_open+0x19/0x1b
[   13.884231]  [<ffffffff815c6a57>] entry_SYSCALL_64_fastpath+0x12/0x6f

Previous version of the kernel was 4.2.0-rc6+.
