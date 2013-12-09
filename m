From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
	mask to 32bits
Date: Mon, 9 Dec 2013 17:03:00 +0000
Message-ID: <20131209170300.GW4360@n2100.arm.linux.org.uk>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
 <20131205095619.GC4360@n2100.arm.linux.org.uk> <52A09CDA.6010700@ti.com>
 <20131205192853.GH4360@n2100.arm.linux.org.uk> <s5h4n6nhxbt.wl%tiwai@suse.de>
 <20131205210707.GI4360@n2100.arm.linux.org.uk> <s5htxemgzyx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id DE78C26172C
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 18:03:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htxemgzyx.wl%tiwai@suse.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 06, 2013 at 09:12:22AM +0100, Takashi Iwai wrote:
> But, it's still unclear why only get_coherent_dma_mask() takes max_pfn
> into account for the check of dma_to_pfn(dev, mask).
> 
> In dma_supported(), 
> 
> 	unsigned long limit;
> 	limit = dma_to_pfn(dev, mask);
> 	if (limit < arm_dma_pfn_limit)
> 		return 0;
> 
> while in get_coherent_dma_mask(),
> 
> 	unsigned long max_dma_pfn;
> 	max_dma_pfn = min(max_pfn, arm_dma_pfn_limit);
> 	if (dma_to_pfn(dev, mask) < max_dma_pfn)
> 		return 0;
> 
> So, the current code looks to me that the results from
> dma_set_coherent_mask() and the actual allocation may conflict.

Yes, that's also wrong.  Both should be the same, and both should take
max_pfn into account.

The reason why max_pfn needs to be taken into account is that is the top
of memory - arm_dma_pfn_limit is hard-coded to 4GiB if there's no DMA
zone.  With some buses (eg, ONAP) this results in a failure as
dma_to_pfn(dev, 32-bit) is less than 4GiB.

> If adding warnings is the purpose of the open code, we can create a
> function like __dma_supported(struct device *dev, u64 mask, bool warning)
> and call it from the both places.

Yes, that's a good idea.  Revised version of the patch.  Peter, can you
retest please, thanks.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f6b6bfa88ecf..86c564e52ea7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -158,6 +158,44 @@ struct dma_map_ops arm_coherent_dma_ops = {
 };
 EXPORT_SYMBOL(arm_coherent_dma_ops);
 
+static int __dma_supported(struct device *dev, u64 mask, bool warn)
+{
+	unsigned long max_dma_pfn;
+
+	/*
+	 * If the mask allows for more memory than we can address,
+	 * and we actually have that much memory, then we must
+	 * indicate that DMA to this device is not supported.
+	 */
+	if (sizeof(mask) != sizeof(dma_addr_t) &&
+	    mask > (dma_addr_t)~0 &&
+	    dma_to_pfn(dev, ~0) < max_pfn) {
+		if (warn) {
+			dev_warn(dev, "Coherent DMA mask %#llx is larger than dma_addr_t allows\n",
+				 mask);
+			dev_warn(dev, "Driver did not use or check the return value from dma_set_coherent_mask()?\n");
+		}
+		return 0;
+	}
+
+	max_dma_pfn = min(max_pfn, arm_dma_pfn_limit);
+
+	/*
+	 * Translate the device's DMA mask to a PFN limit.  This
+	 * PFN number includes the page which we can DMA to.
+	 */
+	if (dma_to_pfn(dev, mask) < max_dma_pfn) {
+		if (warn)
+			dev_warn(dev, "Coherent DMA mask %#llx (pfn %#lx-%#lx) covers a smaller range of system memory than the DMA zone pfn 0x0-%#lx\n",
+				 mask,
+				 dma_to_pfn(dev, 0), dma_to_pfn(dev, mask) + 1,
+				 max_dma_pfn + 1);
+		return 0;
+	}
+
+	return 1;
+}
+
 static u64 get_coherent_dma_mask(struct device *dev)
 {
 	u64 mask = (u64)DMA_BIT_MASK(32);
@@ -176,34 +214,8 @@ static u64 get_coherent_dma_mask(struct device *dev)
 			return 0;
 		}
 
-		max_dma_pfn = min(max_pfn, arm_dma_pfn_limit);
-
-		/*
-		 * If the mask allows for more memory than we can address,
-		 * and we actually have that much memory, then fail the
-		 * allocation.
-		 */
-		if (sizeof(mask) != sizeof(dma_addr_t) &&
-		    mask > (dma_addr_t)~0 &&
-		    dma_to_pfn(dev, ~0) > max_dma_pfn) {
-			dev_warn(dev, "Coherent DMA mask %#llx is larger than dma_addr_t allows\n",
-				 mask);
-			dev_warn(dev, "Driver did not use or check the return value from dma_set_coherent_mask()?\n");
-			return 0;
-		}
-
-		/*
-		 * Now check that the mask, when translated to a PFN,
-		 * fits within the allowable addresses which we can
-		 * allocate.
-		 */
-		if (dma_to_pfn(dev, mask) < max_dma_pfn) {
-			dev_warn(dev, "Coherent DMA mask %#llx (pfn %#lx-%#lx) covers a smaller range of system memory than the DMA zone pfn 0x0-%#lx\n",
-				 mask,
-				 dma_to_pfn(dev, 0), dma_to_pfn(dev, mask) + 1,
-				 arm_dma_pfn_limit + 1);
+		if (!__dma_supported(dev, mask, true))
 			return 0;
-		}
 	}
 
 	return mask;
@@ -1032,28 +1044,7 @@ void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
  */
 int dma_supported(struct device *dev, u64 mask)
 {
-	unsigned long limit;
-
-	/*
-	 * If the mask allows for more memory than we can address,
-	 * and we actually have that much memory, then we must
-	 * indicate that DMA to this device is not supported.
-	 */
-	if (sizeof(mask) != sizeof(dma_addr_t) &&
-	    mask > (dma_addr_t)~0 &&
-	    dma_to_pfn(dev, ~0) > arm_dma_pfn_limit)
-		return 0;
-
-	/*
-	 * Translate the device's DMA mask to a PFN limit.  This
-	 * PFN number includes the page which we can DMA to.
-	 */
-	limit = dma_to_pfn(dev, mask);
-
-	if (limit < arm_dma_pfn_limit)
-		return 0;
-
-	return 1;
+	return __dma_supported(dev, mask, false);
 }
 EXPORT_SYMBOL(dma_supported);
 
