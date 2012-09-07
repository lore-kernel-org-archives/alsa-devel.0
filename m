From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm5110: Enable bypass mode for MICVDD
Date: Fri,  7 Sep 2012 13:01:56 +0800
Message-ID: <1346994116-17873-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1346994116-17873-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71D3326036E
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 07:02:17 +0200 (CEST)
In-Reply-To: <1346994116-17873-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index e7f8d17..acd30f4 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -362,7 +362,7 @@ SND_SOC_DAPM_SUPPLY("ASYNCOPCLK", ARIZONA_OUTPUT_ASYNC_CLOCK,
 SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
 SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0, 0),
 SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
 SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDL", 0, 0),
 SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0, 0),
 
-- 
1.7.10.4
