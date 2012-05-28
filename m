From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 15/15] ASoC: mxs-saif: Use
	clk_prepare_enable/clk_disable_unprepare
Date: Mon, 28 May 2012 12:21:01 -0300
Message-ID: <CAOMZO5BbCLyxwnsupgVaRr9DYNT+E=Th2UoBEOGzXxh1d-9D5w@mail.gmail.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
	<1337987696-31728-15-git-send-email-festevam@gmail.com>
	<20120528145117.GI4032@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id B1126243E0
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 17:21:01 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so2474163bkc.38
	for <alsa-devel@alsa-project.org>; Mon, 28 May 2012 08:21:01 -0700 (PDT)
In-Reply-To: <20120528145117.GI4032@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@freescale.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Shawn,

On Mon, May 28, 2012 at 11:51 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, May 25, 2012 at 08:14:56PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Prepare the clock before enabling it.
>
> Applied, thanks.

With this patch applied I have just realized the following (only
during the first 'aplay', subsequent 'aplay's do not show it):

root@freescale /home$ aplay audio48k16S.wav
Playing WAVE 'audio48k16S.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Stereo
[   16.170000]
[   16.170000] =========================================================
[   16.170000] [ INFO: possible irq lock inversion dependency detected ]
[   16.170000] 3.4.0-next-20120524-00008-g5e6603c-dirty #962 Not tainted
[   16.170000] ---------------------------------------------------------
[   16.170000] swapper/0 just changed the state of lock:
[   16.170000]  (&(&substream->self_group.lock)->rlock){..-...}, at:
[<c022fda8>] snd_pcm_period_elapsed+0x34/0xd0
[   16.170000] but this lock took another, SOFTIRQ-unsafe lock in the past:
[   16.170000]  (prepare_lock){+.+...}
[   16.170000]
[   16.170000] and interrupts could create inverse lock ordering between them.
[   16.170000]
[   16.170000]
[   16.170000] other info that might help us debug this:
[   16.170000]  Possible interrupt unsafe locking scenario:
[   16.170000]
[   16.170000]        CPU0                    CPU1
[   16.170000]        ----                    ----
[   16.170000]   lock(prepare_lock);
[   16.170000]                                local_irq_disable();
[   16.170000]
lock(&(&substream->self_group.lock)->rlock);
[   16.170000]                                lock(prepare_lock);
[   16.170000]   <Interrupt>
[   16.170000]     lock(&(&substream->self_group.lock)->rlock);
[   16.170000]
[   16.170000]  *** DEADLOCK ***
[   16.170000]
[   16.170000] 1 lock held by swapper/0:
[   16.170000]  #0:  (snd_pcm_link_rwlock){...-..}, at: [<c022fd98>]
snd_pcm_period_elapsed+0x24/0xd0
[   16.170000]
[   16.170000] the shortest dependencies between 2nd lock and 1st lock:
[   16.170000]  -> (prepare_lock){+.+...} ops: 110 {
[   16.170000]     HARDIRQ-ON-W at:
[   16.170000]   [<c005bc10>] __lock_acquire+0xb04/0x1b98
[   16.170000]   [<c005cd44>] lock_acquire+0xa0/0x108
[   16.170000]   [<c02e4c20>] mutex_lock_nested+0x54/0x29c
[   16.170000]   [<c021d250>] clk_prepare+0x18/0x38
[   16.170000]   [<c04029f8>] mxs_machine_init+0x30/0x74
[   16.170000]   [<c03ff7b8>] customize_machine+0x1c/0x28
[   16.170000]   [<c000874c>] do_one_initcall+0x30/0x17c
[   16.170000]   [<c03fe340>] kernel_init+0x114/0x1f0
[   16.170000]   [<c001014c>] kernel_thread_exit+0x0/0x8
[   16.170000]     SOFTIRQ-ON-W at:
[   16.170000]   [<c005bc34>] __lock_acquire+0xb28/0x1b98
[   16.170000]   [<c005cd44>] lock_acquire+0xa0/0x108
[   16.170000]   [<c02e4c20>] mutex_lock_nested+0x54/0x29c
[   16.170000]   [<c021d250>] clk_prepare+0x18/0x38
[   16.170000]   [<c04029f8>] mxs_machine_init+0x30/0x74
[   16.170000]   [<c03ff7b8>] customize_machine+0x1c/0x28
[   16.170000]   [<c000874c>] do_one_initcall+0x30/0x17c
[   16.170000]   [<c03fe340>] kernel_init+0x114/0x1f0
[   16.170000]   [<c001014c>] kernel_thread_exit+0x0/0x8
[   16.170000]     INITIAL USE at:
[   16.170000]   [<c005b4d4>] __lock_acquire+0x3c8/0x1b98
[   16.170000]   [<c005cd44>] lock_acquire+0xa0/0x108
[   16.170000]   [<c02e4c20>] mutex_lock_nested+0x54/0x29c
[   16.170000]   [<c021c7b8>] __clk_init+0x20/0x3e4
[   16.170000]   [<c021cc64>] clk_register+0xe8/0x1b0
[   16.170000]   [<c021d570>] clk_register_fixed_rate+0x8c/0xe0
[   16.170000]   [<c04107b8>] mx28_clocks_init+0x7c/0xdac
[   16.170000]   [<c0400270>] time_init+0x20/0x30
[   16.170000]   [<c03fe794>] start_kernel+0x1a0/0x2a0
[   16.170000]   [<40008040>] 0x40008040
[   16.170000]   }
[   16.170000]   ... key      at: [<c044fb9c>] prepare_lock+0x38/0x48
[   16.170000]   ... acquired at:
[   16.170000]    [<c005cd44>] lock_acquire+0xa0/0x108
[   16.170000]    [<c02e4c20>] mutex_lock_nested+0x54/0x29c
[   16.170000]    [<c021d250>] clk_prepare+0x18/0x38
[   16.170000]    [<c024474c>] mxs_saif_trigger+0xd8/0x184
[   16.170000]    [<c023f8c0>] soc_pcm_trigger+0x94/0x9c
[   16.170000]    [<c0228804>] snd_pcm_do_start+0x28/0x2c
[   16.170000]    [<c0228718>] snd_pcm_action_single+0x38/0x78
[   16.170000]    [<c02306fc>] snd_pcm_lib_write1+0x2e4/0x340
[   16.170000]    [<c02307f8>] snd_pcm_lib_write+0x44/0x64
[   16.170000]    [<c022d0e0>] snd_pcm_playback_ioctl1+0xec/0x46c
[   16.170000]    [<c00d8834>] do_vfs_ioctl+0x7c/0x584
[   16.170000]    [<c00d8d74>] sys_ioctl+0x38/0x60
[   16.170000]    [<c000f180>] ret_fast_syscall+0x0/0x38
[   16.170000]
[   16.170000] -> (&(&substream->self_group.lock)->rlock){..-...} ops: 36 {
[   16.170000]    IN-SOFTIRQ-W at:
[   16.170000]  [<c005bbf4>] __lock_acquire+0xae8/0x1b98
[   16.170000]  [<c005cd44>] lock_acquire+0xa0/0x108
[   16.170000]  [<c02e67fc>] _raw_spin_lock+0x2c/0x3c
[   16.170000]  [<c022fda8>] snd_pcm_period_elapsed+0x34/0xd0
[   16.170000]  [<c01bed28>] mxs_dma_tasklet+0x18/0x1c
[   16.170000]  [<c00235e4>] tasklet_action+0xc8/0xd8
[   16.170000]  [<c0023b38>] __do_softirq+0xa0/0x1e0
[   16.170000]  [<c0023e10>] irq_exit+0x8c/0x94
[   16.170000]  [<c0010080>] handle_IRQ+0x34/0x84
[   16.170000]  [<c000edd8>] __irq_svc+0x38/0x60
[   16.170000]  [<c001029c>] default_idle+0x40/0x48
[   16.170000]  [<c00105b8>] cpu_idle+0x68/0xd0
[   16.170000]  [<c03fe854>] start_kernel+0x260/0x2a0
[   16.170000]    INITIAL USE at:
[   16.170000]  [<c005b4d4>] __lock_acquire+0x3c8/0x1b98
[   16.170000]  [<c005cd44>] lock_acquire+0xa0/0x108
[   16.170000]  [<c02e67fc>] _raw_spin_lock+0x2c/0x3c
[   16.170000]  [<c022978c>] snd_pcm_sync_ptr+0xb8/0x16c
[   16.170000]  [<c022c038>] snd_pcm_common_ioctl1+0x204/0xd48
[   16.170000]  [<c022d024>] snd_pcm_playback_ioctl1+0x30/0x46c
[   16.170000]  [<c00d8834>] do_vfs_ioctl+0x7c/0x584
[   16.170000]  [<c00d8d74>] sys_ioctl+0x38/0x60
[   16.170000]  [<c000f180>] ret_fast_syscall+0x0/0x38
[   16.170000]  }
[   16.170000]  ... key      at: [<c099e694>] __key.25802+0x0/0x8
[   16.170000]  ... acquired at:
[   16.170000]    [<c005a030>] check_usage_forwards+0xa0/0x10c
[   16.170000]    [<c0059120>] mark_lock+0x1d4/0x62c
[   16.170000]    [<c005bbf4>] __lock_acquire+0xae8/0x1b98
[   16.170000]    [<c005cd44>] lock_acquire+0xa0/0x108
[   16.170000]    [<c02e67fc>] _raw_spin_lock+0x2c/0x3c
[   16.170000]    [<c022fda8>] snd_pcm_period_elapsed+0x34/0xd0
[   16.170000]    [<c01bed28>] mxs_dma_tasklet+0x18/0x1c
[   16.170000]    [<c00235e4>] tasklet_action+0xc8/0xd8
[   16.170000]    [<c0023b38>] __do_softirq+0xa0/0x1e0
[   16.170000]    [<c0023e10>] irq_exit+0x8c/0x94
[   16.170000]    [<c0010080>] handle_IRQ+0x34/0x84
[   16.170000]    [<c000edd8>] __irq_svc+0x38/0x60
[   16.170000]    [<c001029c>] default_idle+0x40/0x48
[   16.170000]    [<c00105b8>] cpu_idle+0x68/0xd0
[   16.170000]    [<c03fe854>] start_kernel+0x260/0x2a0
[   16.170000]
[   16.170000]
[   16.170000] stack backtrace:
[   16.170000] [<c00148f0>] (unwind_backtrace+0x0/0xf4) from
[<c0059f20>] (print_irq_inversion_bug+0x1a0/0x210)
[   16.170000] [<c0059f20>] (print_irq_inversion_bug+0x1a0/0x210) from
[<c005a030>] (check_usage_forwards+0xa0/0x10c)
[   16.170000] [<c005a030>] (check_usage_forwards+0xa0/0x10c) from
[<c0059120>] (mark_lock+0x1d4/0x62c)
[   16.170000] [<c0059120>] (mark_lock+0x1d4/0x62c) from [<c005bbf4>]
(__lock_acquire+0xae8/0x1b98)
[   16.170000] [<c005bbf4>] (__lock_acquire+0xae8/0x1b98) from
[<c005cd44>] (lock_acquire+0xa0/0x108)
[   16.170000] [<c005cd44>] (lock_acquire+0xa0/0x108) from
[<c02e67fc>] (_raw_spin_lock+0x2c/0x3c)
[   16.170000] [<c02e67fc>] (_raw_spin_lock+0x2c/0x3c) from
[<c022fda8>] (snd_pcm_period_elapsed+0x34/0xd0)
[   16.170000] [<c022fda8>] (snd_pcm_period_elapsed+0x34/0xd0) from
[<c01bed28>] (mxs_dma_tasklet+0x18/0x1c)
[   16.170000] [<c01bed28>] (mxs_dma_tasklet+0x18/0x1c) from
[<c00235e4>] (tasklet_action+0xc8/0xd8)
[   16.170000] [<c00235e4>] (tasklet_action+0xc8/0xd8) from
[<c0023b38>] (__do_softirq+0xa0/0x1e0)
[   16.170000] [<c0023b38>] (__do_softirq+0xa0/0x1e0) from
[<c0023e10>] (irq_exit+0x8c/0x94)
[   16.170000] [<c0023e10>] (irq_exit+0x8c/0x94) from [<c0010080>]
(handle_IRQ+0x34/0x84)
[   16.170000] [<c0010080>] (handle_IRQ+0x34/0x84) from [<c000edd8>]
(__irq_svc+0x38/0x60)
[   16.170000] [<c000edd8>] (__irq_svc+0x38/0x60) from [<c001029c>]
(default_idle+0x40/0x48)
[   16.170000] [<c001029c>] (default_idle+0x40/0x48) from [<c00105b8>]
(cpu_idle+0x68/0xd0)
[   16.170000] [<c00105b8>] (cpu_idle+0x68/0xd0) from [<c03fe854>]
(start_kernel+0x260/0x2a0)

Will debug this, but any suggestion is appreaciated.

Thanks,

Fabio Estevam
