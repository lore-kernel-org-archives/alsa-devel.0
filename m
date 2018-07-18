From: "He, Bo" <bo.he@intel.com>
Subject: [PATCH] ALSA: core: fix unsigned int pages overflow when comapred
Date: Wed, 18 Jul 2018 11:52:45 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52980C51@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "Zhang, Jun" <jun.zhang@intel.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

we see the below kernel panic on stress suspend resume test in
snd_malloc_sgbuf_pages(), snd_dma_alloc_pages_fallback() alloc
chunk maybe larger than the left pages due to the pages alignment,
which will cause the pages overflow.

while (pages > 0) {
	...
	pages -= chunk;
}

the patch is change the pages from unsigned int to int to fix the issue.

BUG: unable to handle kernel paging request at ffff88000deb4000
IP: [<ffffffff81404fa9>] memset_erms+0x9/0x10
Call Trace:
 [<ffffffff818f222f>] snd_dma_alloc_pages+0xff/0x210
 [<ffffffff818f23af>] snd_dma_alloc_pages_fallback+0x6f/0x90
 [<ffffffff818f2b85>] snd_malloc_sgbuf_pages+0x145/0x370
 [<ffffffff818f229e>] snd_dma_alloc_pages+0x16e/0x210
 [<ffffffffc011930d>] hdac_ext_dma_alloc_pages+0x1d/0x40 [snd_hda_ext_core]
 [<ffffffffc010729a>] snd_hdac_dsp_prepare+0xca/0x1c0 [snd_hda_core]
 [<ffffffffc01880f9>] skl_dsp_prepare+0x99/0xf0 [snd_soc_skl]
 [<ffffffffc0162a7e>] bxt_load_base_firmware+0x9e/0x5c0 [snd_soc_skl_ipc]
 [<ffffffffc01630ec>] bxt_set_dsp_D0+0x14c/0x300 [snd_soc_skl_ipc]
 [<ffffffffc015f9c3>] skl_dsp_get_core+0x43/0xd0 [snd_soc_skl_ipc]
 [<ffffffffc015fa60>] skl_dsp_wake+0x10/0x20 [snd_soc_skl_ipc]
 [<ffffffffc0188e3e>] skl_resume_dsp+0x7e/0x140 [snd_soc_skl]
 [<ffffffffc0183c4a>] skl_resume+0xda/0x170 [snd_soc_skl]
 [<ffffffff81452726>] pci_pm_resume+0x76/0xe0
 [<ffffffff816616da>] dpm_run_callback+0x5a/0x180
 [<ffffffff81661e3c>] device_resume+0xdc/0x2c0
 [<ffffffff81663818>] dpm_resume+0x118/0x310
 [<ffffffff81663e11>] dpm_resume_end+0x11/0x20
 [<ffffffff810f8bcc>] suspend_devices_and_enter+0x11c/0x2b0
 [<ffffffff810f90bd>] pm_suspend+0x35d/0x3d0
 [<ffffffff810f78a6>] state_store+0x66/0x90
 [<ffffffff813f80e2>] kobj_attr_store+0x12/0x20
 [<ffffffff812a37bc>] sysfs_kf_write+0x3c/0x50
 [<ffffffff812a2cbd>] kernfs_fop_write+0x11d/0x1a0
 [<ffffffff8121dfaa>] __vfs_write+0x3a/0x150
 [<ffffffff8121f2b1>] vfs_write+0xb1/0x1a0
 [<ffffffff81220898>] SyS_write+0x58/0xc0
 [<ffffffff81001fca>] do_syscall_64+0x6a/0xe0
 [<ffffffff81b06560>] entry_SYSCALL_64_after_swapgs+0x5d/0xd7

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: zhang jun <jun.zhang@intel.com>
---
 sound/core/sgbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 84fffab..33449ee 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -68,7 +68,8 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 			     size_t *res_size)
 {
 	struct snd_sg_buf *sgbuf;
-	unsigned int i, pages, chunk, maxpages;
+	unsigned int i, chunk, maxpages;
+	int pages;
 	struct snd_dma_buffer tmpb;
 	struct snd_sg_page *table;
 	struct page **pgtable;
-- 
2.7.4
