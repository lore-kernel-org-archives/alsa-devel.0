From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: tegra: drop Kconfig description for
	SND_SOC_TEGRA_DAS
Date: Thu,  5 Apr 2012 13:13:49 -0600
Message-ID: <1333653229-21345-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 57F88104499
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 21:13:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

The DAS, I2S, and SPDIF Kconfig options are intended to be selected by
the Kconfig options for ASoC machine drivers. As such, they don't need
to be user-visible themselves. Drop the description from the DAS variable
to achieve this. I2S and SPDIF already don't have a description.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index 23ab00d..16632b1 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -5,7 +5,7 @@ config SND_SOC_TEGRA
 	  Say Y or M here if you want support for SoC audio on Tegra.
 
 config SND_SOC_TEGRA_DAS
-	tristate "Tegra Digital Audio Switch driver"
+	tristate
 	depends on SND_SOC_TEGRA
 	help
 	  Say Y or M if you want to add support for the Tegra DAS module.
-- 
1.7.0.4
