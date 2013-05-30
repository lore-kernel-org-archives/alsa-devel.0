From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ALSA: sis7019: fix error return code in sis_chip_create()
Date: Thu, 30 May 2013 19:55:34 +0800
Message-ID: <CAPgLHd_QmY-8YEh8_kVGLGYq+mwYrXfjjYjtzn-tx5tmf87Ztg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, wfp5p@virginia.edu, adam.buchbinder@gmail.com, jkosina@suse.cz, Julia.Lawall@lip6.fr
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code in the pci_set_dma_mask() error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/pci/sis7019.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index f2639a0..e413b4e 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1341,7 +1341,8 @@ static int sis_chip_create(struct snd_card *card,
 	if (rc)
 		goto error_out;
 
-	if (pci_set_dma_mask(pci, DMA_BIT_MASK(30)) < 0) {
+	rc = pci_set_dma_mask(pci, DMA_BIT_MASK(30));
+	if (rc < 0) {
 		dev_err(&pci->dev, "architecture does not support 30-bit PCI busmaster DMA");
 		goto error_out_enabled;
 	}
