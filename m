From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_spdif: Select regmap-mmio
Date: Sun,  8 Sep 2013 17:22:24 +0100
Message-ID: <1378657344-6279-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EC6026257D
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2013 18:22:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmial.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The S/PDIF driver needs regmap so select it to make sure it gets
included in the build.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 704e246..b7ab71f 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -198,6 +198,7 @@ config SND_SOC_IMX_SPDIF
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_SPDIF
 	select SND_SOC_SPDIF
+	select REGMAP_MMIO
 	help
 	  SoC Audio support for i.MX boards with S/PDIF
 	  Say Y if you want to add support for SoC audio on an i.MX board with
-- 
1.8.4.rc3
