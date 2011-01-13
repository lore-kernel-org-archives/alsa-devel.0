From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: tegra: Remove TEGRA_I2S_AUDIO from
	Kconfig
Date: Thu, 13 Jan 2011 15:21:53 -0700
Message-ID: <1294957313-15834-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DF298103B23
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 23:22:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

That config variable doesn't exist in the mainline kernel, and hence
the dependency shouldn't either.

In linux-tegra-2.6.36, the dependency did exist to avoid a conflict with
the old non-ALSA Tegra I2S driver. However, this isn't and won't be
upstreamed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index 5514f1c..66b504f 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -8,7 +8,6 @@ config SND_TEGRA_SOC
 config SND_TEGRA_SOC_I2S
 	tristate
 	depends on SND_TEGRA_SOC
-	depends on !TEGRA_I2S_AUDIO
 	default m
 	help
 	  Say Y or M if you want to add support for codecs attached to the
-- 
1.7.0.4
