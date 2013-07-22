From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: mxs: Depends on COMMON_CLK
Date: Mon, 22 Jul 2013 12:19:47 +0100
Message-ID: <1374491987-28645-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D23261A3B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 13:19:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The SAIF driver is a clock provider so specifically needs the common
clock implementedation.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/mxs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
index 7daf860..219235c 100644
--- a/sound/soc/mxs/Kconfig
+++ b/sound/soc/mxs/Kconfig
@@ -1,6 +1,7 @@
 menuconfig SND_MXS_SOC
 	tristate "SoC Audio for Freescale MXS CPUs"
 	depends on ARCH_MXS || COMPILE_TEST
+	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
1.8.3.2
