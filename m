From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: fix DSP oops definitions in FW
	ABI" to the asoc tree
Date: Mon,  3 Jun 2019 19:01:55 +0100 (BST)
Message-ID: <20190603180155.68DB2440046@finisterre.sirena.org.uk>
References: <20190603161821.7486-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A079F896DB
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:01:56 +0200 (CEST)
In-Reply-To: <20190603161821.7486-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: fix DSP oops definitions in FW ABI

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 14104eb6a351a5bad21fdd2cf05ca46ad5e5beab Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Mon, 3 Jun 2019 11:18:15 -0500
Subject: [PATCH] ASoC: SOF: fix DSP oops definitions in FW ABI

The definitions for DSP oops structures were not aligned
correctly to current FW ABI version 3.6.0, leading to
invalid data being printed out to debug logs. Fix the structs
and update related platform code accordingly.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/header.h  | 21 +++++++++++++++++++++
 include/sound/sof/xtensa.h  |  9 +++++++--
 sound/soc/sof/intel/bdw.c   | 17 ++++++++++-------
 sound/soc/sof/intel/byt.c   | 15 +++++++++------
 sound/soc/sof/intel/hda.c   | 16 ++++++++++------
 sound/soc/sof/xtensa/core.c |  2 +-
 6 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/include/sound/sof/header.h b/include/sound/sof/header.h
index 0aeb2c8ad6fd..1efcf7b18ec2 100644
--- a/include/sound/sof/header.h
+++ b/include/sound/sof/header.h
@@ -155,6 +155,27 @@ struct sof_ipc_compound_hdr {
 	uint32_t count;		/**< count of 0 means end of compound sequence */
 }  __packed;
 
+/**
+ * OOPS header architecture specific data.
+ */
+struct sof_ipc_dsp_oops_arch_hdr {
+	uint32_t arch;		/* Identifier of architecture */
+	uint32_t totalsize;	/* Total size of oops message */
+}  __packed;
+
+/**
+ * OOPS header platform specific data.
+ */
+struct sof_ipc_dsp_oops_plat_hdr {
+	uint32_t configidhi;	/* ConfigID hi 32bits */
+	uint32_t configidlo;	/* ConfigID lo 32bits */
+	uint32_t numaregs;	/* Special regs num */
+	uint32_t stackoffset;	/* Offset to stack pointer from beginning of
+				 * oops message
+				 */
+	uint32_t stackptr;	/* Stack ptr */
+}  __packed;
+
 /** @}*/
 
 #endif
diff --git a/include/sound/sof/xtensa.h b/include/sound/sof/xtensa.h
index a7189984000d..d25c764b10e8 100644
--- a/include/sound/sof/xtensa.h
+++ b/include/sound/sof/xtensa.h
@@ -17,7 +17,8 @@
 
 /* Xtensa Firmware Oops data */
 struct sof_ipc_dsp_oops_xtensa {
-	struct sof_ipc_hdr hdr;
+	struct sof_ipc_dsp_oops_arch_hdr arch_hdr;
+	struct sof_ipc_dsp_oops_plat_hdr plat_hdr;
 	uint32_t exccause;
 	uint32_t excvaddr;
 	uint32_t ps;
@@ -38,7 +39,11 @@ struct sof_ipc_dsp_oops_xtensa {
 	uint32_t intenable;
 	uint32_t interrupt;
 	uint32_t sar;
-	uint32_t stack;
+	uint32_t debugcause;
+	uint32_t windowbase;
+	uint32_t windowstart;
+	uint32_t excsave1;
+	uint32_t ar[];
 }  __packed;
 
 #endif
diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 8ff3ee520aea..70d524ef9bc0 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -220,17 +220,20 @@ static void bdw_get_registers(struct snd_sof_dev *sdev,
 			      struct sof_ipc_panic_info *panic_info,
 			      u32 *stack, size_t stack_words)
 {
-	/* first read regsisters */
-	sof_mailbox_read(sdev, sdev->dsp_oops_offset, xoops, sizeof(*xoops));
+	u32 offset = sdev->dsp_oops_offset;
+
+	/* first read registers */
+	sof_mailbox_read(sdev, offset, xoops, sizeof(*xoops));
+
+	/* note: variable AR register array is not read */
 
 	/* then get panic info */
-	sof_mailbox_read(sdev, sdev->dsp_oops_offset + sizeof(*xoops),
-			 panic_info, sizeof(*panic_info));
+	offset += xoops->arch_hdr.totalsize;
+	sof_mailbox_read(sdev, offset, panic_info, sizeof(*panic_info));
 
 	/* then get the stack */
-	sof_mailbox_read(sdev, sdev->dsp_oops_offset + sizeof(*xoops) +
-			   sizeof(*panic_info), stack,
-			   stack_words * sizeof(u32));
+	offset += sizeof(*panic_info);
+	sof_mailbox_read(sdev, offset, stack, stack_words * sizeof(u32));
 }
 
 static void bdw_dump(struct snd_sof_dev *sdev, u32 flags)
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 9e4c07eb889b..39d1ae01c45d 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -265,17 +265,20 @@ static void byt_get_registers(struct snd_sof_dev *sdev,
 			      struct sof_ipc_panic_info *panic_info,
 			      u32 *stack, size_t stack_words)
 {
+	u32 offset = sdev->dsp_oops_offset;
+
 	/* first read regsisters */
-	sof_mailbox_read(sdev, sdev->dsp_oops_offset, xoops, sizeof(*xoops));
+	sof_mailbox_read(sdev, offset, xoops, sizeof(*xoops));
+
+	/* note: variable AR register array is not read */
 
 	/* then get panic info */
-	sof_mailbox_read(sdev, sdev->dsp_oops_offset + sizeof(*xoops),
-			 panic_info, sizeof(*panic_info));
+	offset += xoops->arch_hdr.totalsize;
+	sof_mailbox_read(sdev, offset, panic_info, sizeof(*panic_info));
 
 	/* then get the stack */
-	sof_mailbox_read(sdev, sdev->dsp_oops_offset + sizeof(*xoops) +
-			   sizeof(*panic_info), stack,
-			   stack_words * sizeof(u32));
+	offset += sizeof(*panic_info);
+	sof_mailbox_read(sdev, offset, stack, stack_words * sizeof(u32));
 }
 
 static void byt_dump(struct snd_sof_dev *sdev, u32 flags)
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e47f03dc62f0..8f5c68861bbc 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -108,17 +108,21 @@ static void hda_dsp_get_registers(struct snd_sof_dev *sdev,
 				  struct sof_ipc_panic_info *panic_info,
 				  u32 *stack, size_t stack_words)
 {
+	u32 offset = sdev->dsp_oops_offset;
+
 	/* first read registers */
-	sof_block_read(sdev, sdev->mmio_bar, sdev->dsp_oops_offset, xoops,
-		       sizeof(*xoops));
+	sof_mailbox_read(sdev, offset, xoops, sizeof(*xoops));
+
+	/* note: variable AR register array is not read */
 
 	/* then get panic info */
-	sof_block_read(sdev, sdev->mmio_bar, sdev->dsp_oops_offset +
-		       sizeof(*xoops), panic_info, sizeof(*panic_info));
+	offset += xoops->arch_hdr.totalsize;
+	sof_block_read(sdev, sdev->mmio_bar, offset,
+		       panic_info, sizeof(*panic_info));
 
 	/* then get the stack */
-	sof_block_read(sdev, sdev->mmio_bar, sdev->dsp_oops_offset +
-		       sizeof(*xoops) + sizeof(*panic_info), stack,
+	offset += sizeof(*panic_info);
+	sof_block_read(sdev, sdev->mmio_bar, offset, stack,
 		       stack_words * sizeof(u32));
 }
 
diff --git a/sound/soc/sof/xtensa/core.c b/sound/soc/sof/xtensa/core.c
index c3ad23a85b99..46a4905a9dce 100644
--- a/sound/soc/sof/xtensa/core.c
+++ b/sound/soc/sof/xtensa/core.c
@@ -110,7 +110,7 @@ static void xtensa_stack(struct snd_sof_dev *sdev, void *oops, u32 *stack,
 			 u32 stack_words)
 {
 	struct sof_ipc_dsp_oops_xtensa *xoops = oops;
-	u32 stack_ptr = xoops->stack;
+	u32 stack_ptr = xoops->plat_hdr.stackptr;
 	/* 4 * 8chars + 3 ws + 1 terminating NUL */
 	unsigned char buf[4 * 8 + 3 + 1];
 	int i;
-- 
2.20.1
