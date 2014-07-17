From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl_sai: Fix incorrect register writing in fsl_sai_isr()
Date: Thu, 17 Jul 2014 21:21:38 +0800
Message-ID: <25a59f4a687232e0dd90376d640fbfd0eae65e2a.1405603108.git.nicoleotsuka@gmail.com>
References: <cover.1405603108.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1405603108.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, b02247@freescale.com, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

In the rx irq handling part, we should clear the flags in RCSR not TCSR.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index b10dbd8..1b6ee2c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -106,7 +106,7 @@ irq_rx:
 	xcsr &= ~FSL_SAI_CSR_xF_MASK;
 
 	if (flags)
-		regmap_write(sai->regmap, FSL_SAI_TCSR, flags | xcsr);
+		regmap_write(sai->regmap, FSL_SAI_RCSR, flags | xcsr);
 
 out:
 	if (irq_none)
-- 
1.8.4
