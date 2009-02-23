From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: idt blue jack patch
Date: Mon, 23 Feb 2009 17:53:51 +0800
Message-ID: <20090223095351.GA18093@localhost>
References: <68720af30902180104k40a3377cs95ae80446af61f0d@mail.gmail.com>
	<fd3eb9bf0902180144r476fd065ued924b5b26a6675@mail.gmail.com>
	<s5hk57nzs1h.wl%tiwai@suse.de> <20090219030212.GA26505@localhost>
	<1235013772.27435.118.camel@razman>
	<20090220010001.GA7520@localhost> <s5hbpsx10yg.wl%tiwai@suse.de>
	<20090221014214.GB6175@localhost>
	<s5hljrzu53u.wl%tiwai@suse.de> <s5h7i3h4joz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id E629010384C
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 10:54:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7i3h4joz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Paulo Cavalcanti <promac@gmail.com>, Vedran =?utf-8?Q?Mileti=C4=87?= <rivanvx@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 23, 2009 at 10:54:36AM +0200, Takashi Iwai wrote:
> At Sat, 21 Feb 2009 17:28:21 +0100,
> I wrote:
> > > > Regarding the default pin configurations.
> > > > I made a series of patches to add the interface to change the default
> > > > pincfg values dynamically via hwdep sysfs.  The patches are found in
> > > > test/hda-pincfg branch of sound git tree
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > > > 
> > > > and included in the very latest alsa-driver-unstable snapshot
> > > >     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
> > > > 
> > > > Basically, you can get / set the default pincfg values on the fly, and
> > > > trigger the codec reconfiguration after that.
> > > > 
> > > > The init_pin_configs file shows the initial default pincfgs set by BIOS.
> > > > 
> > > > 	# cat /sys/class/sound/hwC0D0/init_pin_configs
> > > > 	0x14 0x9993013f
> > > > 	0x15 0x01014c10
> > > > 	0x16 0x99030120
> > > > 	0x18 0x01a19c30
> > > > 	0x19 0x02a11c31
> > > > 	0x1a 0x01813c32
> > > > 	0x1b 0x02211c1f
> > > > 	0x1c 0x99330133
> > > > 	0x1d 0x411111f0
> > > > 	0x1e 0x411111f0
> > > > 	0x1f 0x411111f0
> > > > 
> > > > Then, you can override the default value by writing to
> > > > override_pin_configs sysfs file.
> > > > 
> > > > 	# cat /sys/class/sound/hwC0D0/override_pin_configs
> > > > 	# echo 0x1d 0x02a11c30 > /sys/class/sound/hwC0D0/override_pin_configs
> > > > 	# cat /sys/class/sound/hwC0D0/override_pin_configs
> > > > 	0x1d 0x02a11c30
> > > > 
> > > > Note that this value won't appear in init_pin_configs.
> > > > 
> > > > Also, there is another file, cur_pin_configs.  This contains the
> > > > pincfgs that are set by the driver explicitly.  For example,
> > > > the static pincfg table in patch_sigmatel.c appears here.
> > > > 
> > > > Then you can trigger the codec reconfiguration by
> > > > 
> > > > 	# echo 1 > /sys/class/sound/hwC0D0/reconfig
> > > > 
> > > > This will re-setup the driver based on the given pin configs.
> > > 
> > > Cool!  This interface will greatly ease the developer-user interactions.
> > > 
> > > Without knowing this feature, I had to write a patch for Paulo,
> > > and compile/verify it before sending it to him. Paulo also have to
> > > pull the kernel source, apply the patch, compile and run it...
> > > 
> > > Now you turned that tedious process into two simple echo commands :-)
> > > 
> > > > Unfortunately, in the current scenario, it can't override the static
> > > > pincfg table in the driver like in patch_sigmatel.c.  It's just for
> > > > fixing and BIOS setup.
> > > 
> > > Unfortunately patch_sigmatel has a long list of static pincfgs, i.e.:
> > > 
> > >         static unsigned int ref927x_pin_configs[14] = {
> > >                 0x02214020, 0x02a19080, 0x0181304e, 0x01014010,
> > >                 0x01a19040, 0x01011012, 0x01016011, 0x0101201f,
> > >                 0x183301f0, 0x18a001f0, 0x18a001f0, 0x01442070,
> > >                 0x01c42190, 0x40000100,
> > >         };
> > > 
> > > This effectively prohibits itself from being dynamically reconfigured
> > > via the override_pin_configs interface... 
> > 
> > Right.  Considering the implementation again, I think it must be
> > relatively easy to fix that.  Just changing the order of the evaluation
> > of pincfg, and add the check not to overwrite the value.
> > 
> > I'll work on it in the next week.
> 
> Fixed now on sound-unstable tree, together with renaming of override_pin
> and cur_pin to user_pin and driver_pin.
> 
> It'd be appreciated if someone can test it with a device with
> Sigmatel/IDT (as I have no such hardware)...

Hi Takashi,

Here are the good behaviors:

- the driver_pin_configs matches the numbers defined in source code
- the init_pin_configs/user_pin_configs will be exactly restored between module reloading
- setting user_pin_configs and doing reconfig did changed the 0x0c pin from output to input.

However,

- after reconfig, Surround, Center and LFE channels are muted and have to be
  turned on again in alsamixer.
- if reconfig while playing audio, it will trigger a panic:

[  355.810682] ALSA sound/pci/hda/hda_hwdep.c:167: hda-codec: reconfiguring
[  355.817969] ALSA sound/core/timer.c:809: timer ffff88003a8038b8 is busy?
[  355.825058] ALSA sound/core/device.c:102: device free ffff88003a620160 (from stac92xx_free+0x62/0xa0 [snd_hda_codec_idt]), not found
[  355.833556] general protection fault: 0000 [#1] SMP
[  355.833559] last sysfs file: /sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D2/reconfig
[  355.833561] CPU 3
[  355.833563] Modules linked in: snd_hda_codec_intelhdmi snd_hda_codec_idt snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq snd_timer snd_seq_device snd soundcore snd_page_alloc [last unloaded: snd_hda_codec]
[  355.833572] Pid: 0, comm: swapper Not tainted 2.6.29-rc3 #5
[  355.833574] RIP: 0010:[<ffffffffa0052588>]  [<ffffffffa0052588>] snd_pcm_period_elapsed+0x38/0x410 [snd_pcm]
[  355.833584] RSP: 0018:ffff88003b4cfe80  EFLAGS: 00010002
[  355.833586] RAX: 0000000000000003 RBX: ffff88003a591458 RCX: ffffffff81a90210
[  355.833588] RDX: 0000000000009d9c RSI: ffff8800041699a0 RDI: ffff8800396af098
[  355.833589] RBP: ffff88003b4cfec0 R08: 0000000000000001 R09: 0000000000000001
[  355.833591] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000001a0
[  355.833592] R13: ffff8800396af098 R14: 6b6b6b6b6b6b6b6b R15: 0000000080000010
[  355.833594] FS:  0000000000000000(0000) GS:ffff88003bbfe210(0000) knlGS:0000000000000000
[  355.833596] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  355.833598] CR2: 00007fb7ea522558 CR3: 0000000039856000 CR4: 00000000000406e0
[  355.833600] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  355.833601] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  355.833603] Process swapper (pid: 0, threadinfo ffff88003b4c8000, task ffff88003b4c4440)
[  355.833604] Stack:
[  355.833605]  ffff88003b4cfea0 ffffffff811a38af ffff88003a5f92b8 ffff88003a591458
[  355.833609]  00000000000001a0 0000000000000004 ffff88003a5f92b8 0000000080000010
[  355.833612]  ffff88003b4cff10 ffffffffa00ba63e ffff88003b4c4440 ffff88003a5f9300
[  355.833615] Call Trace:
[  355.833617]  <IRQ> <0> [<ffffffff811a38af>] ? _raw_spin_unlock+0x7f/0xb0
[  355.833623]  [<ffffffffa00ba63e>] azx_interrupt+0x18e/0x1a0 [snd_hda_intel]
[  355.833629]  [<ffffffff8108ead5>] handle_IRQ_event+0x35/0x80
[  355.833633]  [<ffffffff810905b2>] handle_fasteoi_irq+0x82/0x100
[  355.833636]  [<ffffffff8100f175>] do_IRQ+0xb5/0x1b0
[  355.833639]  [<ffffffff8100d193>] ret_from_intr+0x0/0x2e
[  355.833642]  <EOI> <0>Code: 89 5d d8 4c 89 65 e0 4c 89 75 f0 4c 89 7d f8 49 89 fd 48 85 ff 0f 84 c8 02 00 00 4c 8b b7 a8 00 00 00 4d 85 f6 0f 84 b8 02 00 00 <49> 8b 86 a8 02 00 00 48 85 c0 74 02 ff d0 48 c7 c7 80 c9 05 a0
[  355.833665] RIP  [<ffffffffa0052588>] snd_pcm_period_elapsed+0x38/0x410 [snd_pcm]
[  355.833672]  RSP <ffff88003b4cfe80>
[  355.833676] ---[ end trace 5c74b30f4153ef47 ]---
[  355.833677] Kernel panic - not syncing: Fatal exception in interrupt
[  355.833681] ------------[ cut here ]------------
[  355.833682] WARNING: at kernel/smp.c:299 smp_call_function_many+0x219/0x280()
[  355.833684] Hardware name:
[  355.833685] Modules linked in: snd_hda_codec_intelhdmi snd_hda_codec_idt snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq snd_timer snd_seq_device snd soundcore snd_page_alloc [last unloaded: snd_hda_codec]
[  355.833693] Pid: 0, comm: swapper Tainted: G      D    2.6.29-rc3 #5
[  355.833694] Call Trace:
[  355.833695]  <IRQ>  [<ffffffff81044b10>] warn_slowpath+0xd0/0x130
[  355.833702]  [<ffffffff8106ce0d>] ? trace_hardirqs_off+0xd/0x10
[  355.833706]  [<ffffffff814437cf>] ? _spin_lock_irqsave+0x2f/0x90
[  355.833708]  [<ffffffff81443488>] ? _spin_unlock_irqrestore+0x68/0x70
[  355.833711]  [<ffffffff8106cd59>] ? trace_hardirqs_off_caller+0x29/0xd0
[  355.833714]  [<ffffffff811a38af>] ? _raw_spin_unlock+0x7f/0xb0
[  355.833716]  [<ffffffff814434b6>] ? _spin_unlock+0x26/0x30
[  355.833719]  [<ffffffff8106ce0d>] ? trace_hardirqs_off+0xd/0x10
[  355.833722]  [<ffffffff81440c50>] ? __mutex_unlock_slowpath+0x130/0x1a0
[  355.833725]  [<ffffffff8106ce0d>] ? trace_hardirqs_off+0xd/0x10
[  355.833727]  [<ffffffff81440c50>] ? __mutex_unlock_slowpath+0x130/0x1a0
[  355.833729]  [<ffffffff81440cc9>] ? mutex_unlock+0x9/0x10
[  355.833732]  [<ffffffff8107f934>] ? crash_kexec+0x74/0x100
[  355.833735]  [<ffffffff81443488>] ? _spin_unlock_irqrestore+0x68/0x70
[  355.833738]  [<ffffffff81078ad9>] smp_call_function_many+0x219/0x280
[  355.833741]  [<ffffffff81013f10>] ? stop_this_cpu+0x0/0x40
[  355.833743]  [<ffffffff81443488>] ? _spin_unlock_irqrestore+0x68/0x70
[  355.833746]  [<ffffffff81078b60>] smp_call_function+0x20/0x30
[  355.833749]  [<ffffffff8101f5e0>] native_smp_send_stop+0x30/0x90
[  355.833753]  [<ffffffff8143f50a>] panic+0xaf/0x16f
[  355.833755]  [<ffffffff81443488>] ? _spin_unlock_irqrestore+0x68/0x70
[  355.833758]  [<ffffffff8106ce0d>] ? trace_hardirqs_off+0xd/0x10
[  355.833760]  [<ffffffff81443488>] ? _spin_unlock_irqrestore+0x68/0x70
[  355.833763]  [<ffffffff81061147>] ? down_trylock+0x37/0x50
[  355.833765]  [<ffffffff810456d1>] ? console_unblank+0x21/0x90
[  355.833768]  [<ffffffff81444dcc>] oops_end+0xec/0x100
[  355.833771]  [<ffffffff810103f6>] die+0x56/0x90
[  355.833773]  [<ffffffff81444928>] do_general_protection+0x158/0x180
[  355.833775]  [<ffffffff81443ea5>] general_protection+0x25/0x30
[  355.833782]  [<ffffffffa0052588>] ? snd_pcm_period_elapsed+0x38/0x410 [snd_pcm]
[  355.833785]  [<ffffffff811a38af>] ? _raw_spin_unlock+0x7f/0xb0
[  355.833789]  [<ffffffffa00ba63e>] azx_interrupt+0x18e/0x1a0 [snd_hda_intel]
[  355.833792]  [<ffffffff8108ead5>] handle_IRQ_event+0x35/0x80
[  355.833795]  [<ffffffff810905b2>] handle_fasteoi_irq+0x82/0x100
[  355.833798]  [<ffffffff8100f175>] do_IRQ+0xb5/0x1b0
[  355.833800]  [<ffffffff8100d193>] ret_from_intr+0x0/0x2e
[  355.833801]  <EOI> <4>---[ end trace 5c74b30f4153ef48 ]---
[  355.833807] Rebooting in 10 seconds..

Thanks,
Fengguang
---

wfg@hp ~% cat /sys/class/sound/hwC0D2/init_pin_configs 
0x0a 0x0221401f
0x0b 0x02a19020
0x0c 0x01113014
0x0d 0x01114010
0x0e 0x01a19030
0x0f 0x01111012
0x10 0x01116011
0x11 0x40f000f0
0x12 0x40f000f0
0x13 0x40f000f0
0x14 0x40f000f0
0x22 0x40f000f0
0x23 0x01451140
0x24 0x40f000f0
wfg@hp ~% cat /sys/class/sound/hwC0D2/driver_pin_configs 
wfg@hp ~% cat /sys/class/sound/hwC0D2/user_pin_configs 
wfg@hp ~% head /proc/asound/card0/codec\#2
Codec: IDT 92HD73E1X5
Address: 2
Vendor Id: 0x111d7676
Subsystem Id: 0x80865002
Revision Id: 0x100202
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM


root@hp /home/wfg# modprobe snd-hda-intel model=ref
root@hp /home/wfg# cat /sys/class/sound/hwC0D2/init_pin_configs                                                           [ 1 ]  :-(
0x0a 0x0221401f
0x0b 0x02a19020
0x0c 0x01113014
0x0d 0x01114010
0x0e 0x01a19030
0x0f 0x01111012
0x10 0x01116011
0x11 0x40f000f0
0x12 0x40f000f0
0x13 0x40f000f0
0x14 0x40f000f0
0x22 0x40f000f0
0x23 0x01451140
0x24 0x40f000f0
root@hp /home/wfg# cat /sys/class/sound/hwC0D2/driver_pin_configs
0x0a 0x02214030
0x0b 0x02a19040
0x0c 0x01a19020
0x0d 0x02214030
0x0e 0x0181302e
0x0f 0x01014010
0x10 0x01014020
0x11 0x01014030
0x12 0x02319040
0x13 0x90a000f0
0x14 0x90a000f0
0x22 0x01452050
0x23 0x01452050
root@hp /home/wfg# cat /sys/class/sound/hwC0D2/user_pin_configs
root@hp /home/wfg# echo 0x0a 0x02214030 > /sys/class/sound/hwC0D2/user_pin_configs
root@hp /home/wfg# cat /sys/class/sound/hwC0D2/user_pin_configs
0x0a 0x02214030
root@hp /home/wfg# echo 1 > /sys/class/sound/hwC0D2/reconfig
root@hp /home/wfg# cat /sys/class/sound/hwC0D2/user_pin_configs
0x0a 0x02214030
root@hp /home/wfg# cat /sys/class/sound/hwC0D2/driver_pin_configs
0x0a 0x02214030
0x0b 0x02a19040
0x0c 0x01a19020
0x0d 0x02214030
0x0e 0x0181302e
0x0f 0x01014010
0x10 0x01014020
0x11 0x01014030
0x12 0x02319040
0x13 0x90a000f0
0x14 0x90a000f0
0x22 0x01452050
0x23 0x01452050
root@hp /home/wfg# cat /sys/class/sound/hwC0D2/init_pin_configs
0x0a 0x0221401f
0x0b 0x02a19020
0x0c 0x01113014
0x0d 0x01114010
0x0e 0x01a19030
0x0f 0x01111012
0x10 0x01116011
0x11 0x40f000f0
0x12 0x40f000f0
0x13 0x40f000f0
0x14 0x40f000f0
0x22 0x40f000f0
0x23 0x01451140
0x24 0x40f000f0


root@hp /home/wfg# rmmod snd_hda_intel snd_hda_codec_intelhdmi snd_hda_codec_idt snd_hda_codec
root@hp /home/wfg# modprobe snd-hda-intel          
root@hp /home/wfg# echo 0x0c 0x01813021 > /sys/class/sound/hwC0D2/user_pin_configs
root@hp /home/wfg# echo 1 > /sys/class/sound/hwC0D2/reconfig                      
root@hp /home/wfg# alsamixer 
