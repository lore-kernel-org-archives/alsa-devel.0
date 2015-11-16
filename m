From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: constify sst_block_ops
	structures" to the asoc tree
Date: Mon, 16 Nov 2015 17:51:47 +0000
Message-ID: <E1ZyNwR-0006nf-Rk@debutante>
References: <1447197532-24055-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 950A0260502
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:51:58 +0100 (CET)
In-Reply-To: <1447197532-24055-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: constify sst_block_ops structures

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

>From 93189ea425498339b13e5f74d254070d4a2b7d37 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 11 Nov 2015 00:18:52 +0100
Subject: [PATCH] ASoC: Intel: constify sst_block_ops structures

The sst_block_ops structure is never modified, and is thus declared as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp-priv.h     | 6 +++---
 sound/soc/intel/common/sst-firmware.c     | 4 ++--
 sound/soc/intel/haswell/sst-haswell-dsp.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 4452cda28874..81aa1ed64201 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -243,7 +243,7 @@ struct sst_mem_block {
 	u32 size;			/* block size */
 	u32 index;			/* block index 0..N */
 	enum sst_mem_type type;		/* block memory type IRAM/DRAM */
-	struct sst_block_ops *ops;	/* block operations, if any */
+	const struct sst_block_ops *ops;/* block operations, if any */
 
 	/* block status */
 	u32 bytes_used;			/* bytes in use by modules */
@@ -378,8 +378,8 @@ void sst_block_free_scratch(struct sst_dsp *dsp);
 
 /* Register the DSPs memory blocks - would be nice to read from ACPI */
 struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
-	u32 size, enum sst_mem_type type, struct sst_block_ops *ops, u32 index,
-	void *private);
+	u32 size, enum sst_mem_type type, const struct sst_block_ops *ops,
+	u32 index, void *private);
 void sst_mem_block_unregister_all(struct sst_dsp *dsp);
 
 /* Create/Free DMA resources */
diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 1636a1eeb002..bee04a9707d8 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -1014,8 +1014,8 @@ EXPORT_SYMBOL_GPL(sst_module_runtime_restore);
 
 /* register a DSP memory block for use with FW based modules */
 struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
-	u32 size, enum sst_mem_type type, struct sst_block_ops *ops, u32 index,
-	void *private)
+	u32 size, enum sst_mem_type type, const struct sst_block_ops *ops,
+	u32 index, void *private)
 {
 	struct sst_mem_block *block;
 
diff --git a/sound/soc/intel/haswell/sst-haswell-dsp.c b/sound/soc/intel/haswell/sst-haswell-dsp.c
index 7f94920c8a4d..b2bec36d074c 100644
--- a/sound/soc/intel/haswell/sst-haswell-dsp.c
+++ b/sound/soc/intel/haswell/sst-haswell-dsp.c
@@ -607,7 +607,7 @@ static int hsw_block_disable(struct sst_mem_block *block)
 	return 0;
 }
 
-static struct sst_block_ops sst_hsw_ops = {
+static const struct sst_block_ops sst_hsw_ops = {
 	.enable = hsw_block_enable,
 	.disable = hsw_block_disable,
 };
-- 
2.6.2
