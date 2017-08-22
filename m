From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/14] ASoC: Intel: bytcr_rt5640: simplify MCLK
	quirk tests
Date: Tue, 22 Aug 2017 15:32:36 -0500
Message-ID: <20170822203239.19891-12-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 68A28267079
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:16 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

remove redundant tests to check MCLK (align with other
machine drivers)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 15b1e29..7cee09d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -178,7 +178,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	}
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk) {
+		if (priv->mclk) {
 			ret = clk_prepare_enable(priv->mclk);
 			if (ret < 0) {
 				dev_err(card->dev,
@@ -199,7 +199,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 		if (!ret) {
-			if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk)
+			if (priv->mclk)
 				clk_disable_unprepare(priv->mclk);
 		}
 	}
@@ -549,7 +549,7 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
 
-	if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk) {
+	if (priv->mclk) {
 		/*
 		 * The firmware might enable the clock at
 		 * boot (this information may or may not
-- 
2.9.3
