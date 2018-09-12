From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH v3 1/3] ASoC: Revert "ASoC: Intel: Skylake: Acquire irq after RIRB allocation"
Date: Wed, 12 Sep 2018 13:43:43 -0600
Message-ID: <20180912194343.200443-1-yuzhao@google.com>
References: <20180911211246.31914-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911211246.31914-1-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Naveen Manohar <naveen.m@intel.com>, Yu Zhao <yuzhao@google.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.

The patch claims it fixes accessing memory with null pointer on
skl_interrupt() and snd_hdac_bus_update_rirb() path, but in fact it
has no effect.

There are two problems: 1) skl_init_chip() is called twice, before
and after dma buffer is allocate. The first call sets bus->chip_init
which prevents the second from initializing bus->corb.buf and
rirb.buf from bus->rb.area. 2) snd_hdac_bus_init_chip() enables
interrupt before snd_hdac_bus_init_cmd_io() initializing dma buffers.
There is a small window which skl_interrupt() can be called if irq
has been acquired. If so, it crashes when using null dma buffer
pointers.

Will fix the problems in the following patches. Also attaching the
crash for future reference.

[   16.949148] general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
<snipped>
[   16.950903] Call Trace:
[   16.950906]  <IRQ>
[   16.950918]  skl_interrupt+0x19e/0x2d6 [snd_soc_skl]
[   16.950926]  ? dma_supported+0xb5/0xb5 [snd_soc_skl]
[   16.950933]  __handle_irq_event_percpu+0x27a/0x6c8
[   16.950937]  ? __irq_wake_thread+0x1d1/0x1d1
[   16.950942]  ? __do_softirq+0x57a/0x69e
[   16.950944]  handle_irq_event_percpu+0x95/0x1ba
[   16.950948]  ? _raw_spin_unlock+0x65/0xdc
[   16.950951]  ? __handle_irq_event_percpu+0x6c8/0x6c8
[   16.950953]  ? _raw_spin_unlock+0x65/0xdc
[   16.950957]  ? time_cpufreq_notifier+0x483/0x483
[   16.950959]  handle_irq_event+0x89/0x123
[   16.950962]  handle_fasteoi_irq+0x16f/0x425
[   16.950965]  handle_irq+0x1fe/0x28e
[   16.950969]  do_IRQ+0x6e/0x12e
[   16.950972]  common_interrupt+0x7a/0x7a
[   16.950974]  </IRQ>
<snipped>
[   16.951031] RIP: snd_hdac_bus_update_rirb+0x19b/0x4cf [snd_hda_core] RSP: ffff88015c807c08
[   16.951036] ---[ end trace 58bf9ece1775bc92 ]---

Fixes: 2eeeb4f4733b ("ASoC: Intel: Skylake: Acquire irq after RIRB allocation")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 sound/soc/intel/skylake/skl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index e7fd14daeb4f..d174cbe35f7a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -912,7 +912,11 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	snd_hdac_bus_parse_capabilities(bus);
 
+	if (skl_acquire_irq(bus, 0) < 0)
+		return -EBUSY;
+
 	pci_set_master(pci);
+	synchronize_irq(bus->irq);
 
 	gcap = snd_hdac_chip_readw(bus, GCAP);
 	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
@@ -945,12 +949,6 @@ static int skl_first_init(struct hdac_bus *bus)
 	if (err < 0)
 		return err;
 
-	err = skl_acquire_irq(bus, 0);
-	if (err < 0)
-		return err;
-
-	synchronize_irq(bus->irq);
-
 	/* initialize chip */
 	skl_init_pci(skl);
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
