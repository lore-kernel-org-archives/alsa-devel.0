From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/5] ASoC: tegra: Make 'ahub_auxdata' static
Date: Mon, 21 Jan 2013 14:59:24 +0530
Message-ID: <1358760566-3803-4-git-send-email-sachin.kamat@linaro.org>
References: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f50.google.com (mail-da0-f50.google.com
 [209.85.210.50])
 by alsa0.perex.cz (Postfix) with ESMTP id D190F26523F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 10:38:21 +0100 (CET)
Received: by mail-da0-f50.google.com with SMTP id h15so2625843dan.37
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 01:38:20 -0800 (PST)
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
Cc: sachin.kamat@linaro.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warning:
sound/soc/tegra/tegra30_ahub.c:302:23: warning:
symbol 'ahub_auxdata' was not declared. Should it be static?

Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/tegra/tegra30_ahub.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index f354dc3..ad217cc 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -299,7 +299,7 @@ static const char * const configlink_clocks[] = {
 	"spdif_in",
 };
 
-struct of_dev_auxdata ahub_auxdata[] = {
+static struct of_dev_auxdata ahub_auxdata[] = {
 	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080300, "tegra30-i2s.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080400, "tegra30-i2s.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080500, "tegra30-i2s.2", NULL),
-- 
1.7.4.1
