From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 16/19] ASoC: Intel: bytcr-rt5640: enable ASRC
Date: Thu, 17 Dec 2015 20:35:53 -0600
Message-ID: <1450406156-22246-17-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C2FEF265835
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:37:32 +0100 (CET)
In-Reply-To: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: bardliao@realtek.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

Sound is noisy when using BCLK as reference, enable ASRC in rt5640
codec

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index a81389d..0f2385f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -153,6 +153,11 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 
 	card->dapm.idle_bias_off = true;
 
+	rt5640_sel_asrc_clk_src(codec,
+				RT5640_DA_STEREO_FILTER |
+				RT5640_AD_STEREO_FILTER,
+				RT5640_CLK_SEL_ASRC);
+
 	ret = snd_soc_add_card_controls(card, byt_rt5640_controls,
 					ARRAY_SIZE(byt_rt5640_controls));
 	if (ret) {
-- 
1.9.1
