From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/13] ASoC: Convert wm8995 MICBIASes to supply
	widgets
Date: Thu, 27 Oct 2011 09:54:50 +0200
Message-ID: <1319702091-19273-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111027075405.GA18360@opensource.wolfsonmicro.com>
	<1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4EEEB2466C
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
 sound/soc/codecs/wm8995.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 78eeb21..4d109b1 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -688,8 +688,10 @@ static const struct snd_soc_dapm_widget wm8995_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("IN1R PGA", SND_SOC_NOPM, 0, 0,
 		&in1r_pga, 1),
 
-	SND_SOC_DAPM_MICBIAS("MICBIAS1", WM8995_POWER_MANAGEMENT_1, 8, 0),
-	SND_SOC_DAPM_MICBIAS("MICBIAS2", WM8995_POWER_MANAGEMENT_1, 9, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS1", WM8995_POWER_MANAGEMENT_1, 8, 0,
+			    NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS2", WM8995_POWER_MANAGEMENT_1, 9, 0,
+			    NULL, 0),
 
 	SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8995_AIF1_CLOCKING_1, 0, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8995_AIF2_CLOCKING_1, 0, 0, NULL, 0),
-- 
1.7.6.3
