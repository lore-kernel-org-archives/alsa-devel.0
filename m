From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/5] ASoC: tegra20_ac97: Remove __devinitconst
	attribute
Date: Mon, 21 Jan 2013 14:59:23 +0530
Message-ID: <1358760566-3803-3-git-send-email-sachin.kamat@linaro.org>
References: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 43C70261734
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 10:38:18 +0100 (CET)
Received: by mail-pa0-f49.google.com with SMTP id bi1so3284182pad.8
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 01:38:17 -0800 (PST)
In-Reply-To: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: Lucas Stach <dev@lynxeye.de>, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.de, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

__devinitconst has been removed from the kernel and gives
the following build errors:
sound/soc/tegra/tegra20_ac97.c:460:58: error: Expected ; at end of declaration
sound/soc/tegra/tegra20_ac97.c:460:58: error: got __devinitconst

Cc: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
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
