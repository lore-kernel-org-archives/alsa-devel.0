From: Harsha Priya <harshapriya.n@intel.com>
Subject: [v2 2/3] ASoC: Intel: Fix pop noise of dmic recording
	in kabylake platform using rt5514
Date: Wed, 26 Jul 2017 13:47:44 -0700
Message-ID: <1501102065-11083-3-git-send-email-harshapriya.n@intel.com>
References: <1501102065-11083-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4119D267578
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 22:48:03 +0200 (CEST)
In-Reply-To: <1501102065-11083-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes the pop noise in dmic recording using rt5514 on kabylake platform.
This patch enables the rt5514 to use MCLK instead of BLCK as the sysclock which fixes
the pop noise.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index cfde894..cfd89ca 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -351,19 +351,10 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 				return ret;
 			}
 
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-				RT5514_PLL1_S_BCLK, RT5514_AIF1_BCLK_FREQ,
-						RT5514_AIF1_SYSCLK_FREQ);
-			if (ret < 0) {
-				dev_err(rtd->dev, "set bclk err: %d\n", ret);
-				return ret;
-			}
-
 			ret = snd_soc_dai_set_sysclk(codec_dai,
-				RT5514_SCLK_S_PLL1, RT5514_AIF1_SYSCLK_FREQ,
-							SND_SOC_CLOCK_IN);
+				RT5514_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
 			if (ret < 0) {
-				dev_err(rtd->dev, "set sclk err: %d\n", ret);
+				dev_err(rtd->dev, "set sysclk err: %d\n", ret);
 				return ret;
 			}
 		}
-- 
1.9.1
