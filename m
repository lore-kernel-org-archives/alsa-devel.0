From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: BDL definitions should
	be __le32" to the asoc tree
Date: Wed, 25 Jul 2018 17:40:29 +0100 (BST)
Message-ID: <20180725164029.5A36C1123B08@debutante.sirena.org.uk>
References: <20180724211248.29427-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EA642267750
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:40:29 +0200 (CEST)
In-Reply-To: <20180724211248.29427-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: BDL definitions should be __le32

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 86efd35ec1e34094914494dacb83077e5df2d1b8 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 24 Jul 2018 16:12:45 -0500
Subject: [PATCH] ASoC: Intel: Skylake: BDL definitions should be __le32

Make sure definitions are consistent with usage.
Detected with Sparse.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 8 ++++----
 sound/soc/intel/skylake/skl-sst-cldma.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index d2b1d60fec02..5bc0d38da7e3 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -83,9 +83,9 @@ static void skl_cldma_stream_clear(struct sst_dsp  *ctx)
 /* Code loader helper APIs */
 static void skl_cldma_setup_bdle(struct sst_dsp *ctx,
 		struct snd_dma_buffer *dmab_data,
-		u32 **bdlp, int size, int with_ioc)
+		__le32 **bdlp, int size, int with_ioc)
 {
-	u32 *bdl = *bdlp;
+	__le32 *bdl = *bdlp;
 
 	ctx->cl_dev.frags = 0;
 	while (size > 0) {
@@ -330,7 +330,7 @@ void skl_cldma_process_intr(struct sst_dsp *ctx)
 int skl_cldma_prepare(struct sst_dsp *ctx)
 {
 	int ret;
-	u32 *bdl;
+	__le32 *bdl;
 
 	ctx->cl_dev.bufsize = SKL_MAX_BUFFER_SIZE;
 
@@ -359,7 +359,7 @@ int skl_cldma_prepare(struct sst_dsp *ctx)
 		ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
 		return ret;
 	}
-	bdl = (u32 *)ctx->cl_dev.dmab_bdl.area;
+	bdl = (__le32 *)ctx->cl_dev.dmab_bdl.area;
 
 	/* Allocate BDLs */
 	ctx->cl_dev.ops.cl_setup_bdle(ctx, &ctx->cl_dev.dmab_data,
diff --git a/sound/soc/intel/skylake/skl-sst-cldma.h b/sound/soc/intel/skylake/skl-sst-cldma.h
index 5b730a1a0ae4..ec736921a083 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.h
+++ b/sound/soc/intel/skylake/skl-sst-cldma.h
@@ -203,7 +203,7 @@ struct sst_dsp;
 struct skl_cl_dev_ops {
 	void (*cl_setup_bdle)(struct sst_dsp *ctx,
 			struct snd_dma_buffer *dmab_data,
-			u32 **bdlp, int size, int with_ioc);
+			__le32 **bdlp, int size, int with_ioc);
 	void (*cl_setup_controller)(struct sst_dsp *ctx,
 			struct snd_dma_buffer *dmab_bdl,
 			unsigned int max_size, u32 page_count);
-- 
2.18.0
