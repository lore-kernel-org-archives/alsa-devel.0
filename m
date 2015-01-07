From: mengdong.lin@intel.com
Subject: [PATCH v2 3/3] ASoC: Intel: Select RT5672 ASRC clock
	source on Cherrytrail and Braswell
Date: Wed,  7 Jan 2015 10:19:23 +0800
Message-ID: <1420597163-4186-1-git-send-email-mengdong.lin@intel.com>
References: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CFD052617AB
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 03:11:39 +0100 (CET)
In-Reply-To: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, bardliao@realtek.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

On Cherrytrail and Braswell, the I2S BCLK is 100FS which cannot be supported
by RT5672 in slave mode and can cause noise. This patch selects codec ASRC
clock source to track I2S1 clock so that codec ASRC can be enabled to suppress
the noise.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Reviewed-by: Bard Liao <bardliao@realtek.com>

diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index 9b8b561..54a8f72 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -140,6 +140,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
 	struct snd_soc_dai *codec_dai = runtime->codec_dai;
+	struct snd_soc_codec *codec = codec_dai->codec;
 
 	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
 	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
@@ -148,6 +149,19 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
+	/* Select codec ASRC clock source to track I2S1 clock, because codec
+	 * is in slave mode and 100fs I2S format (BCLK = 100 * LRCLK) cannot
+	 * be supported by RT5672. Otherwise, ASRC will be disabled and cause
+	 * noise.
+	 */
+	rt5670_sel_asrc_clk_src(codec,
+				RT5670_DA_STEREO_FILTER
+				| RT5670_DA_MONO_L_FILTER
+				| RT5670_DA_MONO_R_FILTER
+				| RT5670_AD_STEREO_FILTER
+				| RT5670_AD_MONO_L_FILTER
+				| RT5670_AD_MONO_R_FILTER,
+				RT5670_CLK_SEL_I2S1_ASRC);
 	return 0;
 }
 
-- 
1.9.1
