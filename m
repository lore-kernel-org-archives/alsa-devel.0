From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Fix compilation error due to leftover code
Date: Thu, 30 Aug 2012 17:06:15 +0300
Message-ID: <1346335575-1592-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: alsa-devel@alsa-project.org

Part of commit (which patches sound/soc/omap/mcbsp.c file):
8fef626 ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration code

since the tree where it has been applied did not had the earlier patch:
d0db84e ASoC: omap-mcbsp: Fix 6pin mux configuration
which changed code around omap_mcbsp_6pin_src_mux().

Because of the missing part from 8fef626 the sound/soc/omap/mcbsp.c does
not compile in linux-next.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark,

This patch has been generated against linux-next as of today.
The reason for this is that that is the only place where we have the upstream
patch (in 3.6-rc3):
d0db84e ASoC: omap-mcbsp: Fix 6pin mux configuration

and the 
8fef626 ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration code

commit in the same branch.

When you applied 8fef626 you mentioned that it did not applied cleanly.
The reason was that the branch did not had commit d0db84e applied prior to the
series:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/054668.html

Now I can not find the d0db84e commit in the asoc tree (not in for-3.6, for-3.7
and not in for-next branch) anymore.

I don't really know what has happened, but as of now this patch is needed to fix
the OMAP audio in linux-next.

I have also prepared a branch with the OMAP patches [1]: topic/omap rebased on
top of today's mainline and fixed up the 8fef626 to it's original content.
But I think it is already late to revert the OMAP McBSP patches from for-next
and from for-3.7 branches...

[1] git://gitorious.org/omap-audio/linux-audio.git peter/topic/for-mark/omap-3.7

CC-ing linux-next as well.

Regards,
Peter

 sound/soc/omap/mcbsp.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 935ccf6..bc06175 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -762,37 +762,6 @@ int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 
 }
 
-int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux)
-{
-	const char *signal, *src;
-
-	if (!mcbsp->pdata->mux_signal)
-		return -EINVAL;
-
-	switch (mux) {
-	case CLKR_SRC_CLKR:
-		signal = "clkr";
-		src = "clkr";
-		break;
-	case CLKR_SRC_CLKX:
-		signal = "clkr";
-		src = "clkx";
-		break;
-	case FSR_SRC_FSR:
-		signal = "fsr";
-		src = "fsr";
-		break;
-	case FSR_SRC_FSX:
-		signal = "fsr";
-		src = "fsx";
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return mcbsp->pdata->mux_signal(mcbsp->dev, signal, src);
-}
-
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
 #define THRESHOLD_PROP_BUILDER(prop)					\
-- 
1.7.12
