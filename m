From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/13] ASoC: Convert wm8400 MICBIAS to a supply
	widget
Date: Thu, 27 Oct 2011 09:54:38 +0200
Message-ID: <1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111027075405.GA18360@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD09D24659
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 09:54:59 +0200 (CEST)
In-Reply-To: <20111027075405.GA18360@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8400.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index dc13be2..be310ea 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -766,8 +766,8 @@ SND_SOC_DAPM_PGA("ROPGA", WM8400_POWER_MANAGEMENT_3, WM8400_ROPGA_ENA_SHIFT, 0,
 	NULL, 0),
 
 /* MICBIAS */
-SND_SOC_DAPM_MICBIAS("MICBIAS", WM8400_POWER_MANAGEMENT_1,
-	WM8400_MIC1BIAS_ENA_SHIFT, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS", WM8400_POWER_MANAGEMENT_1,
+		    WM8400_MIC1BIAS_ENA_SHIFT, 0, NULL, 0),
 
 SND_SOC_DAPM_OUTPUT("LON"),
 SND_SOC_DAPM_OUTPUT("LOP"),
-- 
1.7.6.3
