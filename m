From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: imx: Enable COMPILE_TEST builds
Date: Mon, 15 Jul 2013 17:04:02 +0100
Message-ID: <1373904242-30250-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 616152619DE
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:04:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since DT based boards don't have any dependency on arch/arm enable them
if COMPILE_TEST is enabled.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index aa43854..87e28bc 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -98,7 +98,7 @@ endif # SND_POWERPC_SOC
 
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the i.MX CPUs.
-- 
1.8.3.2
