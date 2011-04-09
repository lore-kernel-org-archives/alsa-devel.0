From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ASoC: sst_platform: Fix lock acquring
Date: Sat, 9 Apr 2011 18:41:47 +0800
Message-ID: <20110409104147.GB29911@qtel.sh.intel.com>
References: <20110408073848.30438.39586.stgit@localhost>
	<20110408074042.GS29324@qtel.sh.intel.com>
	<438BB0150E931F4B9CE701519A446301085184E6C2@bgsmsx502.gar.corp.intel.com>
	<20110409102206.GA29911@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 82AAA24503
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 12:42:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110409102206.GA29911@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 09, 2011 at 06:22:06PM +0800, Lu Guanqun wrote:
> On Sat, Apr 09, 2011 at 12:51:07PM +0800, Koul, Vinod wrote:
> > On Fri, Apr 08, 2011 at 01:11:48PM +0530, Lu Guanqun wrote:
> > > On Fri, Apr 08, 2011 at 03:38:48PM +0800, Lu Guanqun wrote:
> > > > Fix the possible dead lock shown below:
> > > >
> > > > spin_lock
> > > > sst_get_stream_status
> > > > sst_period_elapsed
> > > > intel_sst_interrupt
> > > > handle_IRQ_event
> > > > handle_fasteoi_irq
> > > > do_IRQ
> > > > common_interrupt
> > > > spin_lock
> > > > sst_set_stream_status
> > > > sst_platform_pcm_trigger
> > > >
> > > > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> > Sorry, I am little unsure about this yet.
> > Can you send more details of the deadlock you see.
> > Which scenario it is hit, would help to send the debug trace :)
> 
> Hi Vinod,
> 
> I don't get the actual debug trace, so I have to manually reveal the
> possible deadlock...
> 

I compile the kernel with lockdep enabled. without this patch, it will
complain with the below message:

[  161.686829] =================================
[  161.686910] [ INFO: inconsistent lock state ]
[  161.686998] ---------------------------------
[  161.687059] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[  161.687127] swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  161.687181]  (&(&stream->status_lock)->rlock){?.+...}, at: [<c14a1b8c>] sst_period_elapsed+0x27/0x41
[  161.687314] {HARDIRQ-ON-W} state was registered at:
[  161.687365]   [<c105f017>] __lock_acquire+0x5ca/0x13b3
[  161.687439]   [<c1060334>] lock_acquire+0xfa/0x136
[  161.687504]   [<c15f963a>] _raw_spin_lock+0x25/0x34
[  161.687574]   [<c14a1d46>] sst_platform_open+0x120/0x2a2
[  161.687644]   [<c147bab4>] soc_pcm_open+0x91/0x4c3
[  161.687713]   [<c143b540>] snd_pcm_open_substream+0x46/0x96
[  161.687746]   [<c143b70a>] snd_pcm_open+0x17a/0x341
[  161.687746]   [<c143b936>] snd_pcm_playback_open+0x2f/0x35
[  161.687746]   [<c142c5ef>] snd_open+0x1fb/0x360
[  161.687746]   [<c10c60a2>] chrdev_open+0x1cf/0x208
[  161.687746]   [<c10c1501>] __dentry_open+0x1d1/0x2db
[  161.687746]   [<c10c2193>] nameidata_to_filp+0x26/0x33
[  161.687746]   [<c10ccf7c>] do_last+0x3b7/0x495
[  161.687746]   [<c10cd1fc>] do_filp_open+0x1a2/0x407
[  161.687746]   [<c10c21e4>] do_sys_open+0x44/0xc5
[  161.687746]   [<c10c2283>] sys_open+0x1e/0x26
[  161.687746]   [<c15fa135>] syscall_call+0x7/0xb
[  161.687746] irq event stamp: 858548
[  161.687746] hardirqs last  enabled at (858545): [<c1007f9a>] mwait_idle+0xf6/0x12a
[  161.687746] hardirqs last disabled at (858546): [<c1002d67>] common_interrupt+0x27/0x34
[  161.687746] softirqs last  enabled at (858548): [<c103b7b4>] _local_bh_enable+0xd/0xf
[  161.687746] softirqs last disabled at (858547): [<c103bbb5>] irq_enter+0x30/0x61
[  161.687746]
[  161.687746] other info that might help us debug this:
[  161.687746] no locks held by swapper/0.
[  161.687746]
[  161.687746] stack backtrace:
[  161.687746] Pid: 0, comm: swapper Not tainted 2.6.37.6+ #75
[  161.687746] Call Trace:
[  161.687746]  [<c15f6a1a>] ? printk+0xf/0x11
[  161.687746]  [<c105e593>] print_usage_bug+0x151/0x15d
[  161.687746]  [<c105ddd8>] ? check_usage_forwards+0x0/0xa9
[  161.687746]  [<c105e83a>] mark_lock+0x29b/0x4ae
[  161.687746]  [<c105efa3>] __lock_acquire+0x556/0x13b3
[  161.687746]  [<c1090941>] ? perf_pmu_enable+0x1d/0x1f
[  161.687746]  [<c1051e23>] ? __run_hrtimer+0x22f/0x2c7
[  161.687746]  [<c14a1b8c>] ? sst_period_elapsed+0x27/0x41
[  161.687746]  [<c1060334>] lock_acquire+0xfa/0x136
[  161.687746]  [<c14a1b8c>] ? sst_period_elapsed+0x27/0x41
[  161.687746]  [<c15f963a>] _raw_spin_lock+0x25/0x34
[  161.687746]  [<c14a1b8c>] ? sst_period_elapsed+0x27/0x41
[  161.687746]  [<c14a1b8c>] sst_period_elapsed+0x27/0x41
[  161.687746]  [<c14232a1>] intel_sst_interrupt+0x78/0x19d
[  161.687746]  [<c107516f>] handle_IRQ_event+0xb7/0x208
[  161.687746]  [<c1076c6a>] handle_fasteoi_irq+0x90/0xc7
[  161.687746]  [<c1076bda>] ? handle_fasteoi_irq+0x0/0xc7
[  161.687746]  <IRQ>  [<c10042de>] ? do_IRQ+0x3e/0x97
[  161.687746]  [<c1002d6e>] ? common_interrupt+0x2e/0x34
[  161.687746]  [<c106007b>] ? lock_release+0x36/0x1f5
[  161.687746]  [<c1007fa2>] ? mwait_idle+0xfe/0x12a
[  161.687746]  [<c1001529>] ? cpu_idle+0x4d/0x129
[  161.687746]  [<c15c034b>] ? rest_init+0xab/0xb0
[  161.687746]  [<c1a2576d>] ? start_kernel+0x2dd/0x2e2
[  161.687746]  [<c1a250d5>] ? i386_start_kernel+0xd5/0xdc

with this patch, I don't see such messages coming out.

--
guanqun
