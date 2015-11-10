From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ASoC: Intel: constify sst_block_ops structures
Date: Wed, 11 Nov 2015 00:18:52 +0100
Message-ID: <1447197532-24055-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jie Yang <yang.jie@linux.intel.com>
Cc: kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The sst_block_ops structure is never modified, and is thus declared as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/intel/common/sst-dsp-priv.h     |    6 +++---
 sound/soc/intel/common/sst-firmware.c     |    4 ++--
 sound/soc/intel/haswell/sst-haswell-dsp.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 2151652..d21f16d 100644
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
@@ -376,8 +376,8 @@ void sst_block_free_scratch(struct sst_dsp *dsp);
 
 /* Register the DSPs memory blocks - would be nice to read from ACPI */
 struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
-	u32 size, enum sst_mem_type type, struct sst_block_ops *ops, u32 index,
-	void *private);
+	u32 size, enum sst_mem_type type, const struct sst_block_ops *ops,
+	u32 index, void *private);
 void sst_mem_block_unregister_all(struct sst_dsp *dsp);
 
 /* Create/Free DMA resources */
diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 1636a1e..bee04a9 100644
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
index 7f94920..b2bec36 100644
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

