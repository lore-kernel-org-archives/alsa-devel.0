From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/2] ALSA: hda: use snd_adsp_enable in HDA
	driver
Date: Thu, 18 Jun 2015 12:08:25 +0530
Message-ID: <1434609505-776-3-git-send-email-vinod.koul@intel.com>
References: <1434609505-776-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 40DC5266189
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 08:36:58 +0200 (CEST)
In-Reply-To: <1434609505-776-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The SKL platform support aDSP, so we add a new caps AZX_DCAPS_ADSP for
this.  On platforms with aDSP we still load the HDA driver till ASoC
SKL driver is merged and ecosystem around it matured. Later on we need
to move this based on BIOS configuration of platform

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_controller.h |  1 +
 sound/pci/hda/hda_intel.c      | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 314105cd5061..e30aec1af780 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -50,6 +50,7 @@
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 #define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 #define AZX_DCAPS_SEPARATE_STREAM_TAG	(1 << 30) /* capture and playback use separate stream tag */
+#define AZX_DCAPS_ADSP		(1 << 31)	/* Intel aDSP support */
 
 enum {
 	AZX_SNOOP_TYPE_NONE,
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ea0df95bff5d..b91610bd4fba 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1894,6 +1894,14 @@ static int azx_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
+	/*
+	 * check if this device has aDSP caps and DSP is disabled in
+	 * configuration, then go ahead, otherwise ASoC driver will load for
+	 * this device
+	 */
+	if ((pci_id->driver_data && AZX_DCAPS_ADSP) && (snd_adsp_enable == true))
+		return -ENODEV;
+
 	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
 			   0, &card);
 	if (err < 0) {
@@ -2101,7 +2109,7 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
-	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE | AZX_DCAPS_ADSP },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
-- 
1.9.1
