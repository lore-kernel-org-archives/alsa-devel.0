From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: bytcr-rt5640: fix settings in
	internal clock mode
Date: Wed,  4 Jan 2017 15:44:52 -0600
Message-ID: <1483566293-27911-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F4142675DC
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 22:45:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Frequency value of zero did not make sense, use same 24.576MHz
setting and only change the clock source in idle mode

Suggested-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index e33e477..8d2fb2d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -142,7 +142,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		 * for Jack detection and button press
 		 */
 		ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_RCCLK,
-					     0,
+					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 		if (!ret) {
 			if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk)
-- 
2.7.4
