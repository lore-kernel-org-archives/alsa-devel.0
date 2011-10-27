From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/13] ASoC: Convert wm8991 MICBIAS to a supply
	widget
Date: Thu, 27 Oct 2011 09:54:49 +0200
Message-ID: <1319702091-19273-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111027075405.GA18360@opensource.wolfsonmicro.com>
	<1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 414C124664
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 09:55:02 +0200 (CEST)
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
 sound/soc/codecs/wm8991.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index c9ab3ba..1d46d59 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -770,8 +770,8 @@ static const struct snd_soc_dapm_widget wm8991_dapm_widgets[] = {
 		NULL, 0),
 
 	/* MICBIAS */
-	SND_SOC_DAPM_MICBIAS("MICBIAS", WM8991_POWER_MANAGEMENT_1,
-		WM8991_MICBIAS_ENA_BIT, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS", WM8991_POWER_MANAGEMENT_1,
+			    WM8991_MICBIAS_ENA_BIT, 0, NULL, 0),
 
 	SND_SOC_DAPM_OUTPUT("LON"),
 	SND_SOC_DAPM_OUTPUT("LOP"),
-- 
1.7.6.3
