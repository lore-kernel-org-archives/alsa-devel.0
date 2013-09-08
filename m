From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Select regmap-mmio
Date: Sun, 8 Sep 2013 17:18:35 +0000
Message-ID: <E31481825E4C03459FC878EE97CB2EFD0CC9D473@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1378657344-6279-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 10622262626
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2013 19:18:40 +0200 (CEST)
In-Reply-To: <1378657344-6279-1-git-send-email-broonie@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmial.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Acked-by: Nicolin Chen <b42378@freescale.com>

Thank you sir.
________________________________________
From: Mark Brown [broonie@kernel.org]
Sent: Monday, September 09, 2013 12:22 AM
To: Chen Guangyu-B42378; Liam Girdwood
Cc: alsa-devel@alsa-project.org; linaro-kernel@lists.linaro.org; Mark Brown
Subject: [PATCH] ASoC: fsl_spdif: Select regmap-mmio

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
+       select REGMAP_MMIO
        help
          SoC Audio support for i.MX boards with S/PDIF
          Say Y if you want to add support for SoC audio on an i.MX board with
--
1.8.4.rc3
