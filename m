From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/3] ASoC: Intel: bytct_rt5640: change default
	capture settings
Date: Sat, 12 Nov 2016 18:07:46 -0600
Message-ID: <1478995666-3866-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1478995666-3866-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CEC3266819
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 01:07:56 +0100 (CET)
In-Reply-To: <1478995666-3866-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Most Baytrail-CR devices use analog differential microphones,
modify capture default to avoid DMI quirks. Keep digital mics
for all other configurations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 63a7993..507a86a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -57,9 +57,7 @@ struct byt_rt5640_private {
 	struct clk *mclk;
 };
 
-static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
-					BYT_RT5640_DMIC_EN |
-					BYT_RT5640_MCLK_EN;
+static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
 
 static void log_quirks(struct device *dev)
 {
@@ -787,6 +785,13 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			/* no BIOS indications, assume SSP0-AIF2 connection */
 			byt_rt5640_quirk |= BYT_RT5640_SSP0_AIF2;
 		}
+
+		/* change defaults for Baytrail-CR capture */
+		byt_rt5640_quirk |= BYT_RT5640_IN1_MAP;
+		byt_rt5640_quirk |= BYT_RT5640_DIFF_MIC;
+	} else {
+		byt_rt5640_quirk |= (BYT_RT5640_DMIC1_MAP |
+				BYT_RT5640_DMIC_EN);
 	}
 
 	/* check quirks before creating card */
-- 
2.7.4
