From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ASoC: ti: Fix typos in ti/Kconfig
Date: Tue, 13 Aug 2019 12:42:35 +0900
Message-ID: <20190813034235.30673-1-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes some spelling typo in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 2197f3e1eaed..87a9b9dd4e98 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -12,7 +12,7 @@ config SND_SOC_TI_SDMA_PCM
 
 comment "Texas Instruments DAI support for:"
 config SND_SOC_DAVINCI_ASP
-	tristate "daVinci Audio Serial Port (ASP) or McBSP suport"
+	tristate "daVinci Audio Serial Port (ASP) or McBSP support"
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	select SND_SOC_TI_EDMA_PCM
 	help
@@ -33,7 +33,7 @@ config SND_SOC_DAVINCI_MCASP
 	  - Keystone devices
 
 config SND_SOC_DAVINCI_VCIF
-	tristate "daVinci Voice Interface (VCIF) suport"
+	tristate "daVinci Voice Interface (VCIF) support"
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	select SND_SOC_TI_EDMA_PCM
 	help
-- 
2.23.0.rc2
