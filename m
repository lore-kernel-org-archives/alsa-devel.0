From: Vlastimil Babka <vbabka@suse.cz>
Subject: workqueue lockup due to process_unsol_events stuck in
 azx_rirb_get_response
Date: Wed, 25 Jan 2017 13:28:11 +0100
Message-ID: <855fe8a9-4167-e193-d3d1-45e9d39630b1@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

my desktop randomly experiences workqueue lockups on boot with openSUSE 
Tumbleweed kernels 4.9.x, installed around Christmas. Previously I had a (badly 
maintained) Gentoo installation with 4.4 IIRC, so I can't say if the kernel has 
regressed, or the major userspace changes exposed different timing of stuff.

This is how the workqueue lockup looks like:

kernel: BUG: workqueue lockup - pool cpus=3 node=0 flags=0x0 nice=0 stuck for 173s!
kernel: Showing busy workqueues and worker pools:
kernel: workqueue events: flags=0x0
kernel:   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=9/256
kernel:     in-flight: 60:process_unsol_events [snd_hda_core] 
process_unsol_events [snd_hda_core]
kernel:     pending: dbs_work_handler, push_to_pool, vmstat_shepherd, 
cache_reap, console_callback, sysrq_reinject_alt_sysrq, check_corrup
kernel: workqueue events_power_efficient: flags=0x80
kernel:   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=1/256
kernel:     pending: neigh_periodic_work
kernel: workqueue lru-add-drain: flags=0x8
kernel:   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=1/256
kernel:     pending: lru_add_drain_per_cpu BAR(1161)
kernel: workqueue vmstat: flags=0xc
kernel:   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=1/256
kernel:     pending: vmstat_update
kernel: workqueue ipv6_addrconf: flags=0x40008
kernel:   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=1/1
kernel:     pending: addrconf_verify_work
kernel: pool 6: cpus=3 node=0 flags=0x0 nice=0 hung=173s workers=4 idle: 134 373 30

This prevented me from getting a login prompt, as systemd is waiting for wicked. 
I have used sysrq to list the stuck tasks:

kernel: sysrq: SysRq : Show Blocked State
kernel:   task                        PC stack   pid father
kernel: wickedd-nanny   D    0  1161      1 0x00000000
kernel:  ffff9f88e3ebc000 0000000000000000 ffff9f88e3506040 ffff9f88efd59780
kernel:  ffff9f883ee90100 ffffb2dc81117d28 ffffffffa9715ff6 ffff9f88efd59780
kernel:  00ffb2dc81117d20 ffff9f88efd59780 ffff9f88def44000 ffff9f88e3506040
kernel: Call Trace:
kernel:  [<ffffffffa9715ff6>] ? __schedule+0x236/0x700
kernel:  [<ffffffffa97164fd>] schedule+0x3d/0x90
kernel:  [<ffffffffa971984e>] schedule_timeout+0x22e/0x410
kernel:  [<ffffffffa90ab6e8>] ? finish_task_switch+0x78/0x1f0
kernel:  [<ffffffffa90af94a>] ? try_to_wake_up+0x4a/0x3d0
kernel:  [<ffffffffa9717837>] wait_for_completion+0x97/0x100
kernel:  [<ffffffffa90afd70>] ? wake_up_q+0x80/0x80
kernel:  [<ffffffffa909d747>] flush_work+0xf7/0x190
kernel:  [<ffffffffa909b370>] ? flush_workqueue_prep_pwqs+0x1a0/0x1a0
kernel:  [<ffffffffa91b4191>] lru_add_drain_all+0x121/0x160
kernel:  [<ffffffffa91ddc15>] do_mlock+0x45/0x230
kernel:  [<ffffffffa91ddf33>] SyS_mlock+0x13/0x20
kernel:  [<ffffffffa971b47b>] entry_SYSCALL_64_fastpath+0x1e/0xad

Yep, stuck waiting for work item completion, but workqueue processing on cpu 3 
is stuck (and contains such item).

Then I listed backtraces of all active CPU's:

kernel: sysrq: SysRq : Show backtrace of all active CPUs
kernel: NMI backtrace for cpu 3
kernel: CPU: 3 PID: 60 Comm: kworker/3:1 Not tainted 4.9.3-1-default #1
kernel: Hardware name: Gigabyte Technology Co., Ltd. GA-870A-UD3/GA-870A-UD3, 
BIOS F5 08/01/2011
kernel: Workqueue: events process_unsol_events [snd_hda_core]
kernel:  ffff9f88efcc3a90 ffffffffa93c4f70 0000000000000000 0000000000000003
kernel:  ffff9f88efcc3ac0 ffffffffa93c8e44 ffffffffa9055c80 0000000000000003
kernel:  0000000000000001 ffffffffa9cc43c0 ffff9f88efcc3ae0 ffffffffa93c8f66
kernel: Call Trace:
kernel:  <IRQ>
kernel:  [<ffffffffa93c4f70>] dump_stack+0x63/0x83
kernel:  [<ffffffffa93c8e44>] nmi_cpu_backtrace+0x94/0xa0
kernel:  [<ffffffffa9055c80>] ? irq_force_complete_move+0x150/0x150
kernel:  [<ffffffffa93c8f66>] nmi_trigger_cpumask_backtrace+0x116/0x150
kernel:  [<ffffffffa9055cf9>] arch_trigger_cpumask_backtrace+0x19/0x20
kernel:  [<ffffffffa94ce877>] sysrq_handle_showallcpus+0x17/0x20
kernel:  [<ffffffffa94cef1b>] __handle_sysrq+0xfb/0x150
[ snip keyboard event processing ]
kernel:  [<ffffffffa903128d>] handle_irq+0x1d/0x30
kernel:  [<ffffffffa971ddab>] do_IRQ+0x4b/0xd0
kernel:  [<ffffffffa971be02>] common_interrupt+0x82/0x82
kernel:  <EOI>
kernel:  [<ffffffffa93d1ef3>] ? delay_tsc+0x43/0x90
kernel:  [<ffffffffa93d1e2d>] __const_udelay+0x2d/0x30
kernel:  [<ffffffffc0c08403>] azx_rirb_get_response+0xb3/0x280 [snd_hda_codec]
kernel:  [<ffffffffc0c08b43>] azx_get_response+0x33/0x40 [snd_hda_codec]
kernel:  [<ffffffffc0b86303>] snd_hdac_bus_exec_verb_unlocked+0x83/0x170 
[snd_hda_core]
kernel:  [<ffffffffa952e85c>] ? __pm_runtime_resume+0x4c/0x60
kernel:  [<ffffffffc0bfe4fa>] codec_exec_verb+0x8a/0x110 [snd_hda_codec]
kernel:  [<ffffffffc0b86f97>] snd_hdac_exec_verb+0x17/0x40 [snd_hda_core]
kernel:  [<ffffffffc0b87944>] snd_hdac_codec_read+0x34/0x50 [snd_hda_core]
kernel:  [<ffffffffc0c20501>] dspio_read+0x51/0x70 [snd_hda_codec_ca0132]
kernel:  [<ffffffffc0c20566>] ca0132_process_dsp_response+0x46/0x160 
[snd_hda_codec_ca0132]
kernel:  [<ffffffffc0c02fe5>] call_jack_callback.isra.1+0x25/0xa0 [snd_hda_codec]
kernel:  [<ffffffffc0c033c6>] snd_hda_jack_unsol_event+0x66/0x80 [snd_hda_codec]
kernel:  [<ffffffffc0bfd077>] hda_codec_unsol_event+0x17/0x20 [snd_hda_codec]
kernel:  [<ffffffffc0b86193>] process_unsol_events+0x63/0x70 [snd_hda_core]
kernel:  [<ffffffffa909e4d3>] process_one_work+0x1f3/0x4d0
kernel:  [<ffffffffa909e7f8>] worker_thread+0x48/0x4e0
kernel:  [<ffffffffa909e7b0>] ? process_one_work+0x4d0/0x4d0
kernel:  [<ffffffffa909e7b0>] ? process_one_work+0x4d0/0x4d0
kernel:  [<ffffffffa90a46da>] kthread+0xca/0xe0
kernel:  [<ffffffffa90a4610>] ? kthread_park+0x60/0x60
kernel:  [<ffffffffa971b6f5>] ret_from_fork+0x25/0x30

This backtrace looks stable on multiple retries. I've rebooted and added 
module_blacklist=snd_hda_core on the command line to work around this for now. 
Here's the relevant lspci. The card I use right now is an onboard audio with 3 
output jacks for 5.1. The Creative Audigy is currently unused, as should be the 
HDMI stuff.

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel 
HDA) (rev 40)
         Subsystem: Gigabyte Technology Co., Ltd Device a102
         Flags: bus master, slow devsel, latency 32, IRQ 7, NUMA node 0
         Memory at fe024000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [50] Power Management version 2
         Kernel modules: snd_hda_intel

01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde/Pitcairn 
HDMI Audio [Radeon HD 7700/7800 Series]
         Subsystem: PC Partner Limited / Sapphire Technology Device aab0
         Flags: bus master, fast devsel, latency 0, IRQ 10, NUMA node 0
         Memory at fd4fc000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [48] Vendor Specific Information: Len=08 <?>
         Capabilities: [50] Power Management version 3
         Capabilities: [58] Express Legacy Endpoint, MSI 00
         Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
         Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
         Capabilities: [150] Advanced Error Reporting
         Kernel modules: snd_hda_intel

02:00.0 Audio device: Creative Labs Sound Core3D [Sound Blaster Recon3D / 
Z-Series] (rev 01)
         Subsystem: Creative Labs SB1570 SB Audigy Fx
         Flags: bus master, fast devsel, latency 0, IRQ 10, NUMA node 0
         Memory at fd3fc000 (64-bit, non-prefetchable) [size=16K]
         Memory at fd3f8000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
         Capabilities: [70] Express Endpoint, MSI 00
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [140] Virtual Channel
         Capabilities: [170] Device Serial Number 00-00-00-00-00-00-00-00
         Capabilities: [180] Power Budgeting <?>
         Kernel modules: snd_hda_intel

Let me know what else to dump or try.
Thanks,
Vlastimil
