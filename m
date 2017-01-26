From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 16/17] ASoC: Intel: cht-bsw-rt5645: select ASRC
	source based on routing quirk
Date: Thu, 26 Jan 2017 14:09:44 -0600
Message-ID: <1485461385-14544-17-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A899E2677A4
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:30 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Some platforms use AIF2, use routing information to set ASRC as needed

Suggested-by: Bard Liao <bardliao@realtek.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=95681
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 111d45f..a97eef6 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -265,13 +265,24 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_dai *codec_dai = runtime->codec_dai;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 
-	/* Select clk_i2s1_asrc as ASRC clock source */
-	rt5645_sel_asrc_clk_src(codec,
-				RT5645_DA_STEREO_FILTER |
-				RT5645_DA_MONO_L_FILTER |
-				RT5645_DA_MONO_R_FILTER |
-				RT5645_AD_STEREO_FILTER,
-				RT5645_CLK_SEL_I2S1_ASRC);
+	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
+	    (cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
+		/* Select clk_i2s2_asrc as ASRC clock source */
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_DA_STEREO_FILTER |
+					RT5645_DA_MONO_L_FILTER |
+					RT5645_DA_MONO_R_FILTER |
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S2_ASRC);
+	} else {
+		/* Select clk_i2s1_asrc as ASRC clock source */
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_DA_STEREO_FILTER |
+					RT5645_DA_MONO_L_FILTER |
+					RT5645_DA_MONO_R_FILTER |
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+	}
 
 	if (cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) {
 		ret = snd_soc_dapm_add_routes(&card->dapm,
-- 
2.7.4
