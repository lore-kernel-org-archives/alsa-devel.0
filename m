From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/9] ASoC: Intel: Skylake: Fix CLDMA buffer
	wrap case
Date: Thu, 12 Nov 2015 00:16:46 +0530
Message-ID: <1447267609-27816-7-git-send-email-vinod.koul@intel.com>
References: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DF2332605C0
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 19:43:45 +0100 (CET)
In-Reply-To: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

When downloading the firmware/module, if the ring buffer boundary
is reached, we need to wrap to the zeroth position. On next copy
we need to copy till end of buffer and the remaining buffer needs
to be copied from zeroth position.

In this case copy was not handled correctly when wrap condition
is reached which caused invalid data to be copied resulting in
invalid hash failure.

This patch fixes the issue by handling copy at the boundary
condition correctly.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index f62dc339a1ce..0647c3aeec0f 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -180,6 +180,21 @@ static void skl_cldma_fill_buffer(struct sst_dsp *ctx, unsigned int size,
 			ctx->cl_dev.dma_buffer_offset, trigger);
 	dev_dbg(ctx->dev, "spib position: %d\n", ctx->cl_dev.curr_spib_pos);
 
+	/*
+	 * Check if the size exceeds buffer boundary. If it exceeds
+	 * max_buffer size, then copy till buffer size and then copy
+	 * remaining buffer from the start of ring buffer.
+	 */
+	if (ctx->cl_dev.dma_buffer_offset + size > ctx->cl_dev.bufsize) {
+		unsigned int size_b = ctx->cl_dev.bufsize -
+					ctx->cl_dev.dma_buffer_offset;
+		memcpy(ctx->cl_dev.dmab_data.area + ctx->cl_dev.dma_buffer_offset,
+			curr_pos, size_b);
+		size -= size_b;
+		curr_pos += size_b;
+		ctx->cl_dev.dma_buffer_offset = 0;
+	}
+
 	memcpy(ctx->cl_dev.dmab_data.area + ctx->cl_dev.dma_buffer_offset,
 			curr_pos, size);
 
-- 
1.9.1
