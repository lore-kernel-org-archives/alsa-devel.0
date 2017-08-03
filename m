From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ASoC: Intel: constify pci_device_id.
Date: Thu,  3 Aug 2017 23:20:01 +0530
Message-ID: <1dad91af1cb7dddd45ec3a7c4bc4fadb1000848a.1501782354.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/intel/atom/sst/sst_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
index 3a0b3bf..6906ee6 100644
--- a/sound/soc/intel/atom/sst/sst_pci.c
+++ b/sound/soc/intel/atom/sst/sst_pci.c
@@ -181,7 +181,7 @@ static void intel_sst_remove(struct pci_dev *pci)
 }
 
 /* PCI Routines */
-static struct pci_device_id intel_sst_ids[] = {
+static const struct pci_device_id intel_sst_ids[] = {
 	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
 	{ 0, }
 };
-- 
2.7.4
