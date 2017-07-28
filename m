From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v3 1/3] ASoC: Intel: Enabling ASRC for RT5663
	codec on kabylake platform
Date: Thu, 27 Jul 2017 17:41:25 -0700
Message-ID: <1501202487-12617-2-git-send-email-harshapriya.n@intel.com>
References: <1501202487-12617-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 1174C267621
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 02:41:39 +0200 (CEST)
In-Reply-To: <1501202487-12617-1-git-send-email-harshapriya.n@intel.com>
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

This patch fixes the cracking noise in rt5663 headphones for kabylake platform
by calling rt5663_sel_asrc_clk_src() for RT5663_AD_STEREO_FILTER to set ASRC.

The ASRC function is for asynchronous MCLK and LRCK. For RT5663 ASRC should be
enabled to  support special i2s clock format like Intel's 100fs.
ASRC function will track i2s clock and generate a corresponding
system clock for codec. Calling this function helps select the clock source
for both RT5663_AD_STEREO_FILTER and RT5663_DA_STEREO_FILTER filters
which fixes the crackling sound.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 3fe4a08..cfde894 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -319,7 +319,9 @@ static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	/* use ASRC for internal clocks, as PLL rate isn't multiple of BCLK */
-	rt5663_sel_asrc_clk_src(codec_dai->codec, RT5663_DA_STEREO_FILTER, 1);
+	rt5663_sel_asrc_clk_src(codec_dai->codec,
+			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
+			RT5663_CLK_SEL_I2S1_ASRC);
 
 	ret = snd_soc_dai_set_sysclk(codec_dai,
 			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
-- 
1.9.1
