From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Add xtensa support" to the asoc
	tree
Date: Sat, 27 Apr 2019 18:52:56 +0100 (BST)
Message-ID: <20190427175256.E2E78441D3C@finisterre.ee.mobilebroadband>
References: <20190412160519.30207-14-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4259935795579732932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190412160519.30207-14-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Daniel Baluta <daniel.baluta@gmail.com>, sound-open-firmware@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

--===============4259935795579732932==
Content-Type: text/plain

The patch

   ASoC: SOF: Add xtensa support

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

>From e657c18a01c85d2c4ec0e96d52be8ba42b956593 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Apr 2019 11:05:18 -0500
Subject: [PATCH] ASoC: SOF: Add xtensa support

Add common directory for xtensa architecture

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/xtensa.h    |  44 +++++++++++
 sound/soc/sof/xtensa/Kconfig  |   2 +
 sound/soc/sof/xtensa/Makefile |   5 ++
 sound/soc/sof/xtensa/core.c   | 138 ++++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 include/sound/sof/xtensa.h
 create mode 100644 sound/soc/sof/xtensa/Kconfig
 create mode 100644 sound/soc/sof/xtensa/Makefile
 create mode 100644 sound/soc/sof/xtensa/core.c

diff --git a/include/sound/sof/xtensa.h b/include/sound/sof/xtensa.h
new file mode 100644
index 000000000000..a7189984000d
--- /dev/null
+++ b/include/sound/sof/xtensa.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_XTENSA_H__
+#define __INCLUDE_SOUND_SOF_XTENSA_H__
+
+#include <sound/sof/header.h>
+
+/*
+ * Architecture specific debug
+ */
+
+/* Xtensa Firmware Oops data */
+struct sof_ipc_dsp_oops_xtensa {
+	struct sof_ipc_hdr hdr;
+	uint32_t exccause;
+	uint32_t excvaddr;
+	uint32_t ps;
+	uint32_t epc1;
+	uint32_t epc2;
+	uint32_t epc3;
+	uint32_t epc4;
+	uint32_t epc5;
+	uint32_t epc6;
+	uint32_t epc7;
+	uint32_t eps2;
+	uint32_t eps3;
+	uint32_t eps4;
+	uint32_t eps5;
+	uint32_t eps6;
+	uint32_t eps7;
+	uint32_t depc;
+	uint32_t intenable;
+	uint32_t interrupt;
+	uint32_t sar;
+	uint32_t stack;
+}  __packed;
+
+#endif
diff --git a/sound/soc/sof/xtensa/Kconfig b/sound/soc/sof/xtensa/Kconfig
new file mode 100644
index 000000000000..8a9343b85146
--- /dev/null
+++ b/sound/soc/sof/xtensa/Kconfig
@@ -0,0 +1,2 @@
+config SND_SOC_SOF_XTENSA
+	tristate
diff --git a/sound/soc/sof/xtensa/Makefile b/sound/soc/sof/xtensa/Makefile
new file mode 100644
index 000000000000..cc89c7472a38
--- /dev/null
+++ b/sound/soc/sof/xtensa/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+snd-sof-xtensa-dsp-objs := core.o
+
+obj-$(CONFIG_SND_SOC_SOF_XTENSA) += snd-sof-xtensa-dsp.o
diff --git a/sound/soc/sof/xtensa/core.c b/sound/soc/sof/xtensa/core.c
new file mode 100644
index 000000000000..c3ad23a85b99
--- /dev/null
+++ b/sound/soc/sof/xtensa/core.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Author: Pan Xiuli <xiuli.pan@linux.intel.com>
+//
+
+#include <linux/module.h>
+#include <sound/sof.h>
+#include <sound/sof/xtensa.h>
+#include "../sof-priv.h"
+
+struct xtensa_exception_cause {
+	u32 id;
+	const char *msg;
+	const char *description;
+};
+
+/*
+ * From 4.4.1.5 table 4-64 Exception Causes of Xtensa
+ * Instruction Set Architecture (ISA) Reference Manual
+ */
+static const struct xtensa_exception_cause xtensa_exception_causes[] = {
+	{0, "IllegalInstructionCause", "Illegal instruction"},
+	{1, "SyscallCause", "SYSCALL instruction"},
+	{2, "InstructionFetchErrorCause",
+	"Processor internal physical address or data error during instruction fetch"},
+	{3, "LoadStoreErrorCause",
+	"Processor internal physical address or data error during load or store"},
+	{4, "Level1InterruptCause",
+	"Level-1 interrupt as indicated by set level-1 bits in the INTERRUPT register"},
+	{5, "AllocaCause",
+	"MOVSP instruction, if caller’s registers are not in the register file"},
+	{6, "IntegerDivideByZeroCause",
+	"QUOS, QUOU, REMS, or REMU divisor operand is zero"},
+	{8, "PrivilegedCause",
+	"Attempt to execute a privileged operation when CRING ? 0"},
+	{9, "LoadStoreAlignmentCause", "Load or store to an unaligned address"},
+	{12, "InstrPIFDataErrorCause",
+	"PIF data error during instruction fetch"},
+	{13, "LoadStorePIFDataErrorCause",
+	"Synchronous PIF data error during LoadStore access"},
+	{14, "InstrPIFAddrErrorCause",
+	"PIF address error during instruction fetch"},
+	{15, "LoadStorePIFAddrErrorCause",
+	"Synchronous PIF address error during LoadStore access"},
+	{16, "InstTLBMissCause", "Error during Instruction TLB refill"},
+	{17, "InstTLBMultiHitCause",
+	"Multiple instruction TLB entries matched"},
+	{18, "InstFetchPrivilegeCause",
+	"An instruction fetch referenced a virtual address at a ring level less than CRING"},
+	{20, "InstFetchProhibitedCause",
+	"An instruction fetch referenced a page mapped with an attribute that does not permit instruction fetch"},
+	{24, "LoadStoreTLBMissCause",
+	"Error during TLB refill for a load or store"},
+	{25, "LoadStoreTLBMultiHitCause",
+	"Multiple TLB entries matched for a load or store"},
+	{26, "LoadStorePrivilegeCause",
+	"A load or store referenced a virtual address at a ring level less than CRING"},
+	{28, "LoadProhibitedCause",
+	"A load referenced a page mapped with an attribute that does not permit loads"},
+	{32, "Coprocessor0Disabled",
+	"Coprocessor 0 instruction when cp0 disabled"},
+	{33, "Coprocessor1Disabled",
+	"Coprocessor 1 instruction when cp1 disabled"},
+	{34, "Coprocessor2Disabled",
+	"Coprocessor 2 instruction when cp2 disabled"},
+	{35, "Coprocessor3Disabled",
+	"Coprocessor 3 instruction when cp3 disabled"},
+	{36, "Coprocessor4Disabled",
+	"Coprocessor 4 instruction when cp4 disabled"},
+	{37, "Coprocessor5Disabled",
+	"Coprocessor 5 instruction when cp5 disabled"},
+	{38, "Coprocessor6Disabled",
+	"Coprocessor 6 instruction when cp6 disabled"},
+	{39, "Coprocessor7Disabled",
+	"Coprocessor 7 instruction when cp7 disabled"},
+};
+
+/* only need xtensa atm */
+static void xtensa_dsp_oops(struct snd_sof_dev *sdev, void *oops)
+{
+	struct sof_ipc_dsp_oops_xtensa *xoops = oops;
+	int i;
+
+	dev_err(sdev->dev, "error: DSP Firmware Oops\n");
+	for (i = 0; i < ARRAY_SIZE(xtensa_exception_causes); i++) {
+		if (xtensa_exception_causes[i].id == xoops->exccause) {
+			dev_err(sdev->dev, "error: Exception Cause: %s, %s\n",
+				xtensa_exception_causes[i].msg,
+				xtensa_exception_causes[i].description);
+		}
+	}
+	dev_err(sdev->dev, "EXCCAUSE 0x%8.8x EXCVADDR 0x%8.8x PS       0x%8.8x SAR     0x%8.8x\n",
+		xoops->exccause, xoops->excvaddr, xoops->ps, xoops->sar);
+	dev_err(sdev->dev, "EPC1     0x%8.8x EPC2     0x%8.8x EPC3     0x%8.8x EPC4    0x%8.8x",
+		xoops->epc1, xoops->epc2, xoops->epc3, xoops->epc4);
+	dev_err(sdev->dev, "EPC5     0x%8.8x EPC6     0x%8.8x EPC7     0x%8.8x DEPC    0x%8.8x",
+		xoops->epc5, xoops->epc6, xoops->epc7, xoops->depc);
+	dev_err(sdev->dev, "EPS2     0x%8.8x EPS3     0x%8.8x EPS4     0x%8.8x EPS5    0x%8.8x",
+		xoops->eps2, xoops->eps3, xoops->eps4, xoops->eps5);
+	dev_err(sdev->dev, "EPS6     0x%8.8x EPS7     0x%8.8x INTENABL 0x%8.8x INTERRU 0x%8.8x",
+		xoops->eps6, xoops->eps7, xoops->intenable, xoops->interrupt);
+}
+
+static void xtensa_stack(struct snd_sof_dev *sdev, void *oops, u32 *stack,
+			 u32 stack_words)
+{
+	struct sof_ipc_dsp_oops_xtensa *xoops = oops;
+	u32 stack_ptr = xoops->stack;
+	/* 4 * 8chars + 3 ws + 1 terminating NUL */
+	unsigned char buf[4 * 8 + 3 + 1];
+	int i;
+
+	dev_err(sdev->dev, "stack dump from 0x%8.8x\n", stack_ptr);
+
+	/*
+	 * example output:
+	 * 0x0049fbb0: 8000f2d0 0049fc00 6f6c6c61 00632e63
+	 */
+	for (i = 0; i < stack_words; i += 4) {
+		hex_dump_to_buffer(stack + i * 4, 16, 16, 4,
+				   buf, sizeof(buf), false);
+		dev_err(sdev->dev, "0x%08x: %s\n", stack_ptr + i, buf);
+	}
+}
+
+const struct sof_arch_ops sof_xtensa_arch_ops = {
+	.dsp_oops = xtensa_dsp_oops,
+	.dsp_stack = xtensa_stack,
+};
+EXPORT_SYMBOL(sof_xtensa_arch_ops);
+
+MODULE_DESCRIPTION("SOF Xtensa DSP support");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.20.1


--===============4259935795579732932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4259935795579732932==--
