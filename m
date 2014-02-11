From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 2/2] ASoC: fsl: Make Freescale SAI/ESAI/SPDIF
	to be visible in Kconfig
Date: Tue, 11 Feb 2014 10:47:05 +0800
Message-ID: <1392086825-15737-2-git-send-email-Li.Xiubo@freescale.com>
References: <1392086825-15737-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 by alsa0.perex.cz (Postfix) with ESMTP id D65312610C5
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 04:50:58 +0100 (CET)
In-Reply-To: <1392086825-15737-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, Guangyu.Chen@freescale.com, shawn.guo@linaro.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>, tiwai@suse.de, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

For simple card since the whole idea is to support any CODEC and
any CPU DAI with the same driver, we should probably just make sure
that all the individual CODEC and CPU DAI drivers can be enabled in
Kconfig. That way we don't have to have specific Kconfig entries for
boards and loose some of the benefit of the generic card.

This will make the Freescale SAI/ESAI/SPDIF device be visible in
Kconfig.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d0914c0..f397144 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,5 +1,5 @@
 config SND_SOC_FSL_SAI
-	tristate
+	tristate "ALSA SoC support for the Freescale SAI device"
 	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
@@ -7,11 +7,11 @@ config SND_SOC_FSL_SSI
 	tristate
 
 config SND_SOC_FSL_SPDIF
-	tristate
+	tristate "ALSA SoC support for the Freescale SPDIF device"
 	select REGMAP_MMIO
 
 config SND_SOC_FSL_ESAI
-	tristate
+	tristate "ALSA SoC support for the Freescale ESAI device"
 	select REGMAP_MMIO
 
 config SND_SOC_FSL_UTILS
-- 
1.8.4
