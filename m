From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/4] ASoC: tegra20_ac97: Remove __devinitconst
	attribute
Date: Thu, 24 Jan 2013 14:51:16 +0530
Message-ID: <1359019278-1199-3-git-send-email-sachin.kamat@linaro.org>
References: <1359019278-1199-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f45.google.com (mail-da0-f45.google.com
 [209.85.210.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A93942615CF
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:30:20 +0100 (CET)
Received: by mail-da0-f45.google.com with SMTP id w4so4162187dam.18
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 01:30:19 -0800 (PST)
In-Reply-To: <1359019278-1199-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lucas Stach <dev@lynxeye.de>, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sachin.kamat@linaro.org, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

__devinitconst has been removed from the kernel and gives
the following build errors:
sound/soc/tegra/tegra20_ac97.c:460:58: error: Expected ; at end of declaration
sound/soc/tegra/tegra20_ac97.c:460:58: error: got __devinitconst

Cc: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra20_ac97.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index 1bae73b..336dcdd 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -457,7 +457,7 @@ static int tegra20_ac97_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra20_ac97_of_match[] __devinitconst = {
+static const struct of_device_id tegra20_ac97_of_match[] = {
 	{ .compatible = "nvidia,tegra20-ac97", },
 	{},
 };
-- 
1.7.4.1
