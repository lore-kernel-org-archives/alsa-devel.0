From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: Intel: remove unused functions
Date: Wed,  8 Apr 2015 18:34:25 +0530
Message-ID: <1428498265-9066-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

these functions were never called by anyone.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/intel/atom/sst/sst_pvt.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index 2d74249..adb32fe 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -111,30 +111,6 @@ int sst_wait_interruptible(struct intel_sst_drv *sst_drv_ctx,
 
 }
 
-static unsigned long long read_shim_data(struct intel_sst_drv *sst, int addr)
-{
-	unsigned long long val = 0;
-
-	switch (sst->dev_id) {
-	case SST_MRFLD_PCI_ID:
-	case SST_BYT_ACPI_ID:
-		val = sst_shim_read64(sst->shim, addr);
-		break;
-	}
-	return val;
-}
-
-static void write_shim_data(struct intel_sst_drv *sst, int addr,
-				unsigned long long data)
-{
-	switch (sst->dev_id) {
-	case SST_MRFLD_PCI_ID:
-	case SST_BYT_ACPI_ID:
-		sst_shim_write64(sst->shim, addr, (u64) data);
-		break;
-	}
-}
-
 /*
  * sst_wait_timeout - wait on event for timeout
  *
-- 
1.8.1.2
