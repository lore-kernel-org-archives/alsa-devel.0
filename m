From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: ALSA hang on 4.13.0-rc7
Date: Wed, 30 Aug 2017 12:15:20 +0200
Message-ID: <20170830101520.GA281@x4>
References: <20170830100334.GA281@x4>
 <20170830100544.GA283@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ud10.udmedia.de (ud10.udmedia.de [194.117.254.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A2C266C5E
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 12:15:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170830100544.GA283@x4>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 2017.08.30 at 12:05 +0200, Markus Trippelsdorf wrote:
> On 2017.08.30 at 12:03 +0200, Markus Trippelsdorf wrote:
> > On my system ALSA sometimes hangs:
> > 
> >  sysrq: SysRq : Show Blocked State                                         
> >    task                        PC stack   pid father                       
> >  output:ALSA def D    0   171      1 0x00000000                            
> >  Call Trace:                  
> >   ? __schedule+0x17c/0x720    
> >   ? schedule_preempt_disabled+0x2d/0x80                                    
> >   ? __mutex_lock_slowpath+0x141/0x420                                      
> >   ? snd_pcm_common_ioctl1+0x2f/0x1400                                      
> >   ? snd_pcm_common_ioctl1+0x2f/0x1400                                      
> >   ? snd_card_file_remove+0x76/0x120                                        
> >   ? snd_pcm_playback_ioctl+0x1c7/0x560                                     
> >   ? dput+0xb6/0x1e0           
> >   ? SyS_ioctl+0xa7/0x860      
> >   ? task_work_run+0x70/0xa0   
> >   ? entry_SYSCALL_64_fastpath+0x13/0x94  
> > 
> > Only a reboot will fix the issue.
> 
> I've attached the output of "alsa-info.sh --no-upload".

With lock debugging on:

 DEBUG_LOCKS_WARN_ON(depth <= 0)
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 494 at kernel/locking/lockdep.c:3617 lock_release+0x3bc/0x780
 CPU: 0 PID: 494 Comm: mplayer Not tainted 4.13.0-rc7-00015-g36fde05f3fb5-dirty #58
 Hardware name: System manufacturer System Product Name/M4A78T-E, BIOS 3503    04/13/2011
 task: ffff880212943a80 task.stack: ffffc90000f98000
 RIP: 0010:lock_release+0x3bc/0x780
 RSP: 0018:ffffc90000f9bc80 EFLAGS: 00010082
 RAX: 000000000000001f RBX: ffff88021515c400 RCX: 0000000000000000
 RDX: ffffffff8111005e RSI: 0000000000000001 RDI: ffffffff820335a0
 RBP: ffffc90000f9bcf8 R08: 0000000000000001 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff8802150d8b40
 R13: ffffc90000f9bd18 R14: ffff880212943a80 R15: ffff880212943a80
 FS:  00007f2f4d021780(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055b8dfaf4c10 CR3: 00000001e7d34000 CR4: 00000000000006f0
 Call Trace:
  ? snd_pcm_drain+0x295/0x500
  __mutex_unlock_slowpath+0x3e/0x2e0
  ? snd_pcm_drain+0x282/0x500
  mutex_unlock+0xd/0x20
  snd_pcm_drain+0x295/0x500
  ? do_task_dead+0x40/0x40
  snd_pcm_kernel_ioctl+0x369/0x560
  snd_pcm_oss_sync+0x53/0x480
  snd_pcm_oss_ioctl+0x861/0x1700
  ? mntput+0x8c/0x400
  SyS_ioctl+0xa8/0x900
  ? trace_hardirqs_on_thunk+0x1a/0x1c
  entry_SYSCALL_64_fastpath+0x18/0xad
 RIP: 0033:0x7f2f4dd76b07
 RSP: 002b:00007ffe051df0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 000055b8e2351a60 RCX: 00007f2f4dd76b07
 RDX: 0000000000000000 RSI: 0000000000005001 RDI: 0000000000000004
 RBP: 0000000000000003 R08: 00007f2f4de15af8 R09: 00007f2f4d021780
 R10: 0000000000000059 R11: 0000000000000246 R12: 000055b8dfe94de0
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000001000
 Code: 2b c5 34 00 85 c0 48 8b 4d b8 74 25 44 8b 05 64 c2 f3 01 45 85 c0 75 19 48 c7 c6 8b 58 dd 81 48 c7 c7 8c 23 dd 81 e8 9d bd 00 00 <0f> ff 48 8b 4d b8 48 89 4d b8 e8 f5 c4 34 00 85 c0 0f 84 7f fe 
 ---[ end trace 5f19aa03d29c4872 ]---


-- 
Markus
