From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Fix compile error
Date: Fri, 11 May 2018 11:52:16 +0200
Message-ID: <20180511095216.11203-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 90A672677B9
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 11:52:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Fix the compile error introduced by: "ASoC: Intel: bytcr_rt5640:
Configure PLL1 before using it".

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Mark, feel free to squash this into the original commit
---
 sound/soc/intel/boards/bytcr_rt5640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 493240194991..828be866fb00 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -210,14 +210,14 @@ static int byt_rt5640_prepare_and_enable_pll1(struct snd_soc_dai *codec_dai,
 	}
 
 	if (ret < 0) {
-		dev_err(codec_dai->codec->dev, "can't set pll: %d\n", ret);
+		dev_err(codec_dai->component->dev, "can't set pll: %d\n", ret);
 		return ret;
 	}
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
 				     rate * 512, SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		dev_err(codec_dai->codec->dev, "can't set clock %d\n", ret);
+		dev_err(codec_dai->component->dev, "can't set clock %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.0
