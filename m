From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/13] ASoC: Convert wm8971 MICBIAS to a supply
	widget
Date: Thu, 27 Oct 2011 09:54:43 +0200
Message-ID: <1319702091-19273-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111027075405.GA18360@opensource.wolfsonmicro.com>
	<1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F78E2465B
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
 sound/soc/codecs/wm8971.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index b444b29..3a06a95 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -224,7 +224,7 @@ static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", WM8971_PWR2, 8, 0),
 	SND_SOC_DAPM_PGA("Mono Out 1", WM8971_PWR2, 2, 0, NULL, 0),
 
-	SND_SOC_DAPM_MICBIAS("Mic Bias", WM8971_PWR1, 1, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Bias", WM8971_PWR1, 1, 0, NULL, 0),
 	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", WM8971_PWR1, 2, 0),
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8971_PWR1, 3, 0),
 
-- 
1.7.6.3
