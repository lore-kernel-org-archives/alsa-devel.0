From: Bo Shen <voice.shen@atmel.com>
Subject: [v2 4/5] ARM: atmel-ssc: change phybase type to dma_addr_t
Date: Wed,  3 Jul 2013 16:37:59 +0800
Message-ID: <1372840680-2253-5-git-send-email-voice.shen@atmel.com>
References: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, lars@metafoo.de, richard.genoud@gmail.com, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

as the phybase paramter only used for DMA operation, change
it's type from resource_size_t to dma_addr_t

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Change in v2:
  - new patch
---
 include/linux/atmel-ssc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index deb0ae5..66a0e53 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -11,7 +11,7 @@ struct atmel_ssc_platform_data {
 
 struct ssc_device {
 	struct list_head	list;
-	resource_size_t		phybase;
+	dma_addr_t		phybase;
 	void __iomem		*regs;
 	struct platform_device	*pdev;
 	struct atmel_ssc_platform_data *pdata;
-- 
1.7.9.5

