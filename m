From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix CLDMA buffer wrap
	case" to the asoc tree
Date: Wed, 18 Nov 2015 18:47:10 +0000
Message-ID: <E1Zz7l8-0001MY-Ek@debutante>
References: <1447267609-27816-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 889DE265A3F
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:47:17 +0100 (CET)
In-Reply-To: <1447267609-27816-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix CLDMA buffer wrap case

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e797af53b8814dfbc3c6ac134c528b8ab480f275 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 13 Nov 2015 19:22:10 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix CLDMA buffer wrap case

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index 4ddabe30b62a..b03d9db0acad 100644
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
2.6.2
