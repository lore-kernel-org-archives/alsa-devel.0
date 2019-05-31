From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ASoC: SOF: Intel: hda: Fix COMPILE_TEST build error
Date: Fri, 31 May 2019 22:25:26 +0800
Message-ID: <20190531142526.12712-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, pierre-louis.bossart@linux.intel.com, yingjiang.zhu@linux.intel.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

while building without PCI:

sound/soc/sof/intel/hda.o: In function `hda_dsp_probe':
hda.c:(.text+0x79c): undefined reference to `pci_ioremap_bar'
hda.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'
hda.c:(.text+0x7c4): undefined reference to `pci_ioremap_bar'
hda.c:(.text+0x7c4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e13ef82a9ab8 ("ASoC: SOF: add COMPILE_TEST for PCI options")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sof/intel/hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 68db2ac..c1703c4 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -231,7 +231,9 @@ static int hda_init(struct snd_sof_dev *sdev)
 
 	/* initialise hdac bus */
 	bus->addr = pci_resource_start(pci, 0);
+#if IS_ENABLED(CONFIG_PCI)
 	bus->remap_addr = pci_ioremap_bar(pci, 0);
+#endif
 	if (!bus->remap_addr) {
 		dev_err(bus->dev, "error: ioremap error\n");
 		return -ENXIO;
@@ -458,7 +460,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		goto hdac_bus_unmap;
 
 	/* DSP base */
+#if IS_ENABLED(CONFIG_PCI)
 	sdev->bar[HDA_DSP_BAR] = pci_ioremap_bar(pci, HDA_DSP_BAR);
+#endif
 	if (!sdev->bar[HDA_DSP_BAR]) {
 		dev_err(sdev->dev, "error: ioremap error\n");
 		ret = -ENXIO;
-- 
2.7.4
