From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: skl.c match braces for if-else
Date: Tue, 23 Jun 2015 22:40:13 +0530
Message-ID: <1435079413-28094-3-git-send-email-vinod.koul@intel.com>
References: <1435079413-28094-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BBC626057F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 19:08:38 +0200 (CEST)
In-Reply-To: <1435079413-28094-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Coding style madates that if-else should match braces even if one of them is
a single line statement

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0ab02af0325a..1e70e3962c76 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -394,9 +394,9 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
 
 	/* allow 64bit DMA address if supported by H/W */
-	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64)))
+	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
 		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
-	else {
+	} else {
 		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
 		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
 	}
-- 
1.9.1
