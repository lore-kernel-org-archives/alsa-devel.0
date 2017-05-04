From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH] ALSA: hda: Use loop counter for hdac_wait_for_cmd_dmas() timeout
Date: Thu,  4 May 2017 11:18:29 +0100
Message-ID: <20170504101829.28325-1-chris@chris-wilson.co.uk>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: intel-gfx@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, "# v4 . 7+" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

hdac_wait_for_cmd_dmas() uses a jiffie timeout to ensure that we do not
wait forever for stuck hardware. However, it is called from an
irq-disabled context which prevents jiffie from advancing and so the
loop doesn't terminate if the hardware fails. This can then cause NMI
watchdog warnings, such as:

    NMI watchdog: Watchdog detected hard LOCKUP on cpu 3
    Modules linked in: snd_hda_intel i915 vgem snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul snd_hda_codec_realtek snd_hda_codec_generic ghash_clmulni_intel e1000e snd_hda_codec snd_hwdep snd_hda_core snd_pcm ptp mei_me prime_numbers pps_core mei lpc_ich i2c_hid i2c_designware_platform i2c_designware_core [last unloaded: i915]
    irq event stamp: 13366
    hardirqs last  enabled at (13365): [<ffffffff81891a87>] _raw_spin_unlock_irq+0x27/0x50
    hardirqs last disabled at (13366): [<ffffffff818918d2>] _raw_spin_lock_irq+0x12/0x50
    softirqs last  enabled at (12744): [<ffffffff81085c79>] __do_softirq+0x1d9/0x4c0
    softirqs last disabled at (12721): [<ffffffff810860d9>] irq_exit+0xa9/0xc0
    CPU: 3 PID: 10443 Comm: kworker/u8:11 Tainted: G     U          4.11.0-rc4-CI-CI_DRM_319+ #1
    Hardware name:                  /NUC5i5RYB, BIOS RYBDWi35.86A.0362.2017.0118.0940 01/18/2017
    Workqueue: events_unbound async_run_entry_fn
    task: ffff88024cd32740 task.stack: ffffc9000162c000
    RIP: 0010:preempt_count_add+0xe/0xc0
    RSP: 0018:ffffc9000162fbd8 EFLAGS: 00000082
    RAX: 0000000080000001 RBX: 0000000704b96558 RCX: 0000000000000002
    RDX: 0000000000000000 RSI: ffffffff81c74f2d RDI: 0000000000000001
    RBP: ffffc9000162fc08 R08: 00000000bbcc90cc R09: 23c7b07100000000
    R10: ffffffff827901a8 R11: ffff88024cd32740 R12: 0000000704b92baa
    R13: 0000000000003ea0 R14: 0000000000000003 R15: ffffffffa00061f0
    FS:  0000000000000000(0000) GS:ffff880256d80000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007f90f84a5144 CR3: 0000000003e0f000 CR4: 00000000003406e0
    Call Trace:
     ? delay_tsc+0x3d/0xc0
     __delay+0xa/0x10
     __const_udelay+0x31/0x40
     snd_hdac_bus_stop_cmd_io+0x96/0xe0 [snd_hda_core]
     ? azx_dev_disconnect+0x20/0x20 [snd_hda_intel]
     snd_hdac_bus_stop_chip+0xb1/0x100 [snd_hda_core]
     azx_stop_chip+0x9/0x10 [snd_hda_codec]
     azx_suspend+0x72/0x220 [snd_hda_intel]
     pci_pm_suspend+0x71/0x140
     dpm_run_callback+0x6f/0x330
     ? pci_pm_freeze+0xe0/0xe0
     __device_suspend+0xf9/0x370
     ? dpm_watchdog_set+0x60/0x60
     async_suspend+0x1a/0x90
     async_run_entry_fn+0x34/0x160
     process_one_work+0x1f4/0x6d0
     ? process_one_work+0x16e/0x6d0
     worker_thread+0x49/0x4a0
     kthread+0x107/0x140
     ? process_one_work+0x6d0/0x6d0
     ? kthread_create_on_node+0x40/0x40
     ret_from_fork+0x2e/0x40

Fixes: 38b19ed7f81e ("ALSA: hda: fix to wait for RIRB & CORB DMA to set")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=100419
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: <stable@vger.kernel.org> # v4.7+
---
 sound/hda/hdac_controller.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index ee08c389b4d6..7f8806b03982 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -85,14 +85,14 @@ static void hdac_wait_for_cmd_dmas(struct hdac_bus *bus)
 {
 	unsigned long timeout;
 
-	timeout = jiffies + msecs_to_jiffies(100);
+	timeout = 100 * 100; /* 100ms */
 	while ((snd_hdac_chip_readb(bus, RIRBCTL) & AZX_RBCTL_DMA_EN)
-		&& time_before(jiffies, timeout))
+	       && timeout--)
 		udelay(10);
 
-	timeout = jiffies + msecs_to_jiffies(100);
+	timeout = 100 * 100; /* 100ms */
 	while ((snd_hdac_chip_readb(bus, CORBCTL) & AZX_CORBCTL_RUN)
-		&& time_before(jiffies, timeout))
+	       && timeout--)
 		udelay(10);
 }
 
-- 
2.11.0
