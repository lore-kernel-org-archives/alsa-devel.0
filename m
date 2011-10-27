From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/13] ASoC: Convert wm8983 MICBIAS to a supply
	widget
Date: Thu, 27 Oct 2011 09:54:45 +0200
Message-ID: <1319702091-19273-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111027075405.GA18360@opensource.wolfsonmicro.com>
	<1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A36D724661
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 09:55:01 +0200 (CEST)
In-Reply-To: <1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8983.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 93ee284..58e067b 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -481,7 +481,8 @@ static const struct snd_soc_dapm_widget wm8983_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("OUT4 Out", WM8983_POWER_MANAGEMENT_3,
 			 8, 0, NULL, 0),
 
-	SND_SOC_DAPM_MICBIAS("Mic Bias", WM8983_POWER_MANAGEMENT_1, 4, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Bias", WM8983_POWER_MANAGEMENT_1, 4, 0,
+			    NULL, 0),
 
 	SND_SOC_DAPM_INPUT("LIN"),
 	SND_SOC_DAPM_INPUT("LIP"),
-- 
1.7.6.3
