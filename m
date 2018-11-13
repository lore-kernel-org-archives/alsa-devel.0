From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: add ACP3.0 PCI driver" to the asoc
	tree
Date: Tue, 13 Nov 2018 19:46:30 +0000 (GMT)
Message-ID: <20181113194630.64A18440078@finisterre.ee.mobilebroadband>
References: <1542000903-19020-3-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AFF8267AEE
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 20:46:41 +0100 (CET)
In-Reply-To: <1542000903-19020-3-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Cc: alsa-devel@alsa-project.org, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Sanju R Mehta <sanju.mehta@amd.com>, Alexander.Deucher@amd.com, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Vishnuvardhanrao.Ravulapati@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: add ACP3.0 PCI driver

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

>From e30d9128def6ca0715a89b9a3133a94521dc0b51 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Date: Mon, 12 Nov 2018 11:04:53 +0530
Subject: [PATCH] ASoC: AMD: add ACP3.0 PCI driver

ACP 3.0 is a PCI audio device. This patch adds PCI driver to bind
to this device and get PCI resources.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Signed-off-by: Sanju R Mehta <sanju.mehta@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x.h     | 13 +++++
 sound/soc/amd/raven/pci-acp3x.c | 97 +++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 sound/soc/amd/raven/acp3x.h
 create mode 100644 sound/soc/amd/raven/pci-acp3x.c

diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
new file mode 100644
index 000000000000..e9b4df0c6726
--- /dev/null
+++ b/sound/soc/amd/raven/acp3x.h
@@ -0,0 +1,13 @@
+#include "chip_offset_byte.h"
+
+#define ACP3x_PHY_BASE_ADDRESS 0x1240000
+
+static inline u32 rv_readl(void __iomem *base_addr)
+{
+	return readl(base_addr - ACP3x_PHY_BASE_ADDRESS);
+}
+
+static inline void rv_writel(u32 val, void __iomem *base_addr)
+{
+	writel(val, base_addr - ACP3x_PHY_BASE_ADDRESS);
+}
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
new file mode 100644
index 000000000000..27588ed066c9
--- /dev/null
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -0,0 +1,97 @@
+/*
+ * AMD ALSA SoC PCM Driver
+ *
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include "acp3x.h"
+
+struct acp3x_dev_data {
+	void __iomem *acp3x_base;
+};
+
+static int snd_acp3x_probe(struct pci_dev *pci,
+			   const struct pci_device_id *pci_id)
+{
+	int ret;
+	u32 addr;
+	struct acp3x_dev_data *adata;
+
+	if (pci_enable_device(pci)) {
+		dev_err(&pci->dev, "pci_enable_device failed\n");
+		return -ENODEV;
+	}
+
+	ret = pci_request_regions(pci, "AMD ACP3x audio");
+	if (ret < 0) {
+		dev_err(&pci->dev, "pci_request_regions failed\n");
+		goto disable_pci;
+	}
+
+	adata = devm_kzalloc(&pci->dev, sizeof(struct acp3x_dev_data),
+			     GFP_KERNEL);
+	if (!adata) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+
+	addr = pci_resource_start(pci, 0);
+	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
+	if (!adata->acp3x_base) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+	pci_set_master(pci);
+	pci_set_drvdata(pci, adata);
+	return 0;
+
+release_regions:
+	pci_release_regions(pci);
+disable_pci:
+	pci_disable_device(pci);
+
+	return ret;
+}
+
+static void snd_acp3x_remove(struct pci_dev *pci)
+{
+	struct acp3x_dev_data *adata = pci_get_drvdata(pci);
+
+	iounmap(adata->acp3x_base);
+	pci_release_regions(pci);
+	pci_disable_device(pci);
+}
+
+static const struct pci_device_id snd_acp3x_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x15e2),
+	.class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
+	.class_mask = 0xffffff },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, snd_acp3x_ids);
+
+static struct pci_driver acp3x_driver  = {
+	.name = KBUILD_MODNAME,
+	.id_table = snd_acp3x_ids,
+	.probe = snd_acp3x_probe,
+	.remove = snd_acp3x_remove,
+};
+
+module_pci_driver(acp3x_driver);
+
+MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
+MODULE_DESCRIPTION("AMD ACP3x PCI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.19.1
