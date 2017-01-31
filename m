From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht-bsw-rt5645: select ASRC
	source based on routing quirk" to the asoc tree
Date: Tue, 31 Jan 2017 21:17:35 +0000
Message-ID: <E1cYfnz-0000ya-Pk@debutante>
References: <1485461385-14544-17-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A1CD72673FE
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:44 +0100 (CET)
In-Reply-To: <1485461385-14544-17-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht-bsw-rt5645: select ASRC source based on routing quirk

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d74390b5fe47710e94b03b550d1b8b8f249cd416 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:44 -0600
Subject: [PATCH] ASoC: Intel: cht-bsw-rt5645: select ASRC source based on
 routing quirk

Some platforms use AIF2, use routing information to set ASRC as needed

Suggested-by: Bard Liao <bardliao@realtek.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=95681
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 24b07601fb81..b175eee5d416 100644
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
2.11.0
