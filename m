From: Gabriel Feceoru <gabriel.feceoru@intel.com>
Subject: Re: kernel crash in snd_hda_intel
Date: Mon, 15 Feb 2016 14:57:00 +0200
Message-ID: <56C1CB1C.2080005@intel.com>
References: <56BE0C99.7060701@intel.com> <s5hy4amb7bc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 006C426063A
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 13:50:12 +0100 (CET)
In-Reply-To: <s5hy4amb7bc.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, alsa-devel@alsa-project.org, libin.yang@linux.intel.com
List-Id: alsa-devel@alsa-project.org



On 15.02.2016 12:23, Takashi Iwai wrote:
> On Fri, 12 Feb 2016 17:47:21 +0100,
> Gabriel Feceoru wrote:
>>
>> !!! This caused a regression in the i-g-t drv_module_reload_basic test.
>>
>>
>> Reproducible easily on HSW (i5-4460) with:
>> #rmmod snd_hda_intel
>
> I couldn't reproduce this on my HSW machine.  Does it happen always
> without without the monitor plugged?

Reproducible with or without the monitor plugged in, just tested.
Play a bit with rmmod/modprobe on snd_ha_intel and you'll get it. It's 
not always first time, but easy to catch.

Gabriel.

>
>
> thanks,
>
> Takashi
>
>> The bisect shows this as the offending commit:
>>
>>
>> commit 25e4abb33df3aafa7d1efba8f82f9178268efab1
>> Author: Libin Yang <libin.yang@linux.intel.com>
>> Date:   Tue Jan 12 11:13:27 2016 +0800
>>
>>       ALSA: hda - hdmi jack created based on pcm
>>
>>       Jack is created based on pcm.
>>
>>       Apply the acomp jack rule to dyn_pcm_assign.
>>       For dyn_pcm_assign:
>>        Driver does not use hda_jack. It operates snd_jack directly.
>>        snd_jack pointer will be stored in spec->pcm.jack instead of
>>        the current spec->acomp_jack. When pcm is assigned to pin,
>>        jack will be assigned to pin automatically.
>>       For !dyn_pcm_assign:
>>        Driver continues using hda_jack for less impact on the old cases.
>>        Pcm is statically assigned to pin. So is jack. spec->pcm.jack
>>        saves the snd_jack pointer created in hda_jack.
>>
>>       Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
>>       Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>>
>>
>>
>> [   79.020523] BUG: unable to handle kernel paging request at
>> 0000000000015d80
>> [   79.021314] IP: [<ffffffff810a486b>] queued_spin_lock_slowpath+0xeb/0x180
>> [   79.022125] PGD 0
>> [   79.022881] Oops: 0002 [#1] SMP
>> [   79.023644] Modules linked in: snd_hda_codec_hdmi
>> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel(-)
>> snd_hda_codec x86_pkg_temp_thermal snd_hwdep snd_hda_core i915
>> i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt ehci_pci
>> fb_sys_fops r8169 ehci_hcd mii drm xhci_pci xhci_hcd video
>> [   79.026790] CPU: 0 PID: 1294 Comm: rmmod Tainted: G     U
>> 4.5.0-rc1+ #73
>> [   79.028322] Hardware name: Dell Inc. Inspiron 3847/088DT1       ,
>> BIOS A06 01/15/2015
>> [   79.029854] task: ffff8800dac90000 ti: ffff880212700000 task.ti:
>> ffff880212700000
>> [   79.031384] RIP: 0010:[<ffffffff810a486b>]  [<ffffffff810a486b>]
>> queued_spin_lock_slowpath+0xeb/0x180
>> [   79.032924] RSP: 0018:ffff8802127039b0  EFLAGS: 00010002
>> [   79.033698] RAX: 000000000000350c RBX: ffff8800d434ef90 RCX:
>> ffff88021fa15d80
>> [   79.035224] RDX: 0000000000015d80 RSI: 00000000d434ef88 RDI:
>> ffff8800d434ef90
>> [   79.036751] RBP: ffff8802127039b0 R08: 0000000000040000 R09:
>> 0000000000000000
>> [   79.038277] R10: ffff8800daef8998 R11: 0000000000000004 R12:
>> 0000000000000282
>> [   79.039802] R13: 0000000000000000 R14: 0000000000000006 R15:
>> ffff8800d434ef90
>> [   79.041331] FS:  00007f75be1ad700(0000) GS:ffff88021fa00000(0000)
>> knlGS:0000000000000000
>> [   79.042863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   79.043638] CR2: 0000000000015d80 CR3: 00000002101b1000 CR4:
>> 00000000001406f0
>> [   79.045166] Stack:
>> [   79.045926]  ffff8802127039d0 ffffffff81748e59 ffff8800d434ed80
>> 0000000000000005
>> [   79.047462]  ffff880212703a10 ffffffff81597e73 ffffffff817472d2
>> 0000000000000003
>> [   79.048995]  ffff8800d434ecc0 0000000000000000 0000000000000001
>> ffff8800daef8800
>> [   79.050528] Call Trace:
>> [   79.051293]  [<ffffffff81748e59>] _raw_spin_lock_irqsave+0x39/0x50
>> [   79.052071]  [<ffffffff81597e73>] input_event+0x43/0x80
>> [   79.052844]  [<ffffffff817472d2>] ? mutex_lock+0x12/0x30
>> [   79.053619]  [<ffffffff8160d9fe>] snd_jack_report+0xee/0x110
>> [   79.054396]  [<ffffffffc02da4ea>] hdmi_present_sense+0x13a/0x390
>> [snd_hda_codec_hdmi]
>> [   79.055921]  [<ffffffff8150ffee>] ? regmap_unlock_mutex+0xe/0x10
>> [   79.056699]  [<ffffffffc02da78d>] generic_hdmi_resume+0x4d/0x60
>> [snd_hda_codec_hdmi]
>> [   79.058235]  [<ffffffffc02a8bb0>] ? snd_hda_add_imux_item+0x120/0x120
>> [snd_hda_codec]
>> [   79.059771]  [<ffffffffc02a85ae>] hda_call_codec_resume+0xce/0x120
>> [snd_hda_codec]
>> [   79.061303]  [<ffffffffc02a8bb0>] ? snd_hda_add_imux_item+0x120/0x120
>> [snd_hda_codec]
>> [   79.062835]  [<ffffffffc02a8be5>] hda_codec_runtime_resume+0x35/0x50
>> [snd_hda_codec]
>> [   79.064368]  [<ffffffff81503d68>] __rpm_callback+0x28/0x70
>> [   79.065143]  [<ffffffffc02a8bb0>] ? snd_hda_add_imux_item+0x120/0x120
>> [snd_hda_codec]
>> [   79.066676]  [<ffffffff81503dd4>] rpm_callback+0x24/0x80
>> [   79.067449]  [<ffffffffc02a8bb0>] ? snd_hda_add_imux_item+0x120/0x120
>> [snd_hda_codec]
>> [   79.068983]  [<ffffffff81504646>] rpm_resume+0x426/0x620
>> [   79.069758]  [<ffffffff815055ae>] __pm_runtime_resume+0x4e/0x70
>> [   79.070536]  [<ffffffff814f9453>] __device_release_driver+0x43/0x160
>> [   79.071314]  [<ffffffff814f9593>] device_release_driver+0x23/0x30
>> [   79.072085]  [<ffffffff814f8b71>] bus_remove_device+0x101/0x170
>> [   79.072862]  [<ffffffff814f50f9>] device_del+0x139/0x270
>> [   79.073638]  [<ffffffffc00a51cb>] ? widget_tree_free.isra.1+0x8b/0xa0
>> [snd_hda_core]
>> [   79.075170]  [<ffffffffc00a3831>]
>> snd_hdac_device_unregister+0x21/0x30 [snd_hda_core]
>> [   79.076703]  [<ffffffffc02a708d>] snd_hda_codec_dev_free+0x1d/0x40
>> [snd_hda_codec]
>> [   79.078235]  [<ffffffff8160ac5c>] __snd_device_free+0x4c/0x80
>> [   79.079010]  [<ffffffff8160afb0>] snd_device_free_all+0x30/0x60
>> [   79.079787]  [<ffffffff816058a4>] release_card_device+0x34/0x90
>> [   79.080563]  [<ffffffff814f4892>] device_release+0x32/0x90
>> [   79.081338]  [<ffffffff813f74da>] kobject_release+0x7a/0x190
>> [   79.082113]  [<ffffffff813f7397>] kobject_put+0x27/0x50
>> [   79.082886]  [<ffffffff814f4b67>] put_device+0x17/0x20
>> [   79.083659]  [<ffffffff816068e8>] snd_card_free+0x58/0x70
>> [   79.084434]  [<ffffffffc00b3fd1>] azx_remove+0x31/0x40 [snd_hda_intel]
>> [   79.085214]  [<ffffffff81433da9>] pci_device_remove+0x39/0xc0
>> [   79.085990]  [<ffffffff814f94b1>] __device_release_driver+0xa1/0x160
>> [   79.086767]  [<ffffffff814f9fe6>] driver_detach+0xa6/0xb0
>> [   79.087540]  [<ffffffff814f8eb5>] bus_remove_driver+0x55/0xd0
>> [   79.088314]  [<ffffffff814fa5dc>] driver_unregister+0x2c/0x50
>> [   79.089084]  [<ffffffff814324d1>] pci_unregister_driver+0x21/0x90
>> [   79.089863]  [<ffffffffc00b5d88>] azx_driver_exit+0x10/0x288
>> [snd_hda_intel]
>> [   79.090644]  [<ffffffff810dde01>] SyS_delete_module+0x1b1/0x250
>> [   79.091422]  [<ffffffff81002017>] ? trace_hardirqs_on_thunk+0x17/0x19
>> [   79.092200]  [<ffffffff8174925b>] entry_SYSCALL_64_fastpath+0x16/0x6e
>> [   79.092977] Code: c1 e0 10 45 31 c9 85 c0 74 44 48 89 c2 c1 e8 12 48
>> c1 ea 0c 83 e8 01 83 e2 30 48 98 48 81 c2 80 5d 01 00 48 03 14 c5 e0 b4
>> d4 81 <48> 89 0a 8b 41 08 85 c0 75 09 f3 90 8b 41 08 85 c0 74 f7 4c 8b
>> [   79.095373] RIP  [<ffffffff810a486b>]
>> queued_spin_lock_slowpath+0xeb/0x180
>> [   79.096155]  RSP <ffff8802127039b0>
>> [   79.096920] CR2: 0000000000015d80
>> [   79.097687] ---[ end trace 5594cbffe0158d7f ]---
>>
>>
>>
>> $lspci -nn
>> 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
>> DRAM Controller [8086:0c00] (rev 06)
>> 00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v3/4th Gen
>> Core Processor PCI Express x16 Controller [8086:0c01] (rev 06)
>> 00:02.0 VGA compatible controller [0300]: Intel Corporation Xeon E3-1200
>> v3/4th Gen Core Processor Integrated Graphics Controller [8086:0412]
>> (rev 06)
>> 00:03.0 Audio device [0403]: Intel Corporation Xeon E3-1200 v3/4th Gen
>> Core Processor HD Audio Controller [8086:0c0c] (rev 06)
>> 00:14.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series
>> Chipset Family USB xHCI [8086:8c31] (rev 05)
>> 00:16.0 Communication controller [0780]: Intel Corporation 8 Series/C220
>> Series Chipset Family MEI Controller #1 [8086:8c3a] (rev 04)
>> 00:1a.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series
>> Chipset Family USB EHCI #2 [8086:8c2d] (rev 05)
>> 00:1b.0 Audio device [0403]: Intel Corporation 8 Series/C220 Series
>> Chipset High Definition Audio Controller [8086:8c20] (rev 05)
>> 00:1c.0 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series
>> Chipset Family PCI Express Root Port #1 [8086:8c10] (rev d5)
>> 00:1c.3 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series
>> Chipset Family PCI Express Root Port #4 [8086:8c16] (rev d5)
>> 00:1c.4 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series
>> Chipset Family PCI Express Root Port #5 [8086:8c18] (rev d5)
>> 00:1d.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series
>> Chipset Family USB EHCI #1 [8086:8c26] (rev 05)
>> 00:1f.0 ISA bridge [0601]: Intel Corporation C220 Series Chipset Family
>> H81 Express LPC Controller [8086:8c5c] (rev 05)
>> 00:1f.2 SATA controller [0106]: Intel Corporation 8 Series/C220 Series
>> Chipset Family 6-port SATA Controller 1 [AHCI mode] [8086:8c02] (rev 05)
>> 00:1f.3 SMBus [0c05]: Intel Corporation 8 Series/C220 Series Chipset
>> Family SMBus Controller [8086:8c22] (rev 05)
>> 03:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
>> (rev 0c)
>> 04:00.0 Network controller [0280]: Qualcomm Atheros QCA9565 / AR9565
>> Wireless Network Adapter [168c:0036] (rev 01)
>>
>> Regards,
>> Gabriel
>>
