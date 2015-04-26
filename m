From: Firo Yang <firogm@gmail.com>
Subject: [PATCH] ASoC: Intel: fix Coccinelle kfree warning
Date: Sun, 26 Apr 2015 23:42:12 +0800
Message-ID: <1430062932-26668-1-git-send-email-firogm@gmail.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: lgirdwood@gmail.com
Cc: kernel-janitors@vger.kernel.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, yang.jie@intel.com, han.lu@intel.com, jarkko.nikula@linux.intel.com, pawel.piskorski@intel.com, alsa-devel@alsa-project.org, Firo Yang <firogm@gmail.com>
List-Id: alsa-devel@alsa-project.org

It's not necessary to use kfree() to free memory allocated with
devm_kzalloc in a probe function and using kfree leads to a double free.

Signed-off-by: Firo Yang <firogm@gmail.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 344a1e9..324eceb 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2201,7 +2201,6 @@ dma_err:
 dsp_new_err:
 	sst_ipc_fini(ipc);
 ipc_init_err:
-	kfree(hsw);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sst_hsw_dsp_init);
-- 
2.1.0

