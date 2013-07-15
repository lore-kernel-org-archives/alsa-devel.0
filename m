From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: mxs: Enable COMPILE_TEST builds
Date: Mon, 15 Jul 2013 17:05:46 +0100
Message-ID: <1373904346-30395-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1786226165C
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:05:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.rog, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since DT based boards don't have any dependency on arch/arm enable them
if COMPILE_TEST is enabled.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/mxs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
index 78d321c..7daf860 100644
--- a/sound/soc/mxs/Kconfig
+++ b/sound/soc/mxs/Kconfig
@@ -1,6 +1,6 @@
 menuconfig SND_MXS_SOC
 	tristate "SoC Audio for Freescale MXS CPUs"
-	depends on ARCH_MXS
+	depends on ARCH_MXS || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
1.8.3.2
