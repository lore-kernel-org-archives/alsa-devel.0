From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: enable
	differential mic quirk" to the asoc tree
Date: Mon, 15 Aug 2016 15:16:09 +0100
Message-ID: <E1bZIgT-0007Rf-2b@debutante>
References: <1471037280-17433-4-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50722267886
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:16:16 +0200 (CEST)
In-Reply-To: <1471037280-17433-4-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: enable differential mic quirk

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

>From 5d98f58fd66ea164d7e317d57de77b7d7c1391ff Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Aug 2016 16:27:46 -0500
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: enable differential mic quirk

Some Baytrail-CR devices rely on analog mics connected with
differential pairs and not the single-ended default
Add quirk and enable it for T00TAF

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 421a53cfa53f..085e57f95fb2 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -41,6 +41,7 @@ enum {
 #define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
 #define BYT_RT5640_DMIC_EN	BIT(16)
 #define BYT_RT5640_MONO_SPEAKER BIT(17)
+#define BYT_RT5640_DIFF_MIC     BIT(18) /* defaut is single-ended */
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_DMIC_EN;
@@ -148,7 +149,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
 		},
 		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
-						 BYT_RT5640_MONO_SPEAKER
+						 BYT_RT5640_MONO_SPEAKER |
+						 BYT_RT5640_DIFF_MIC
 						 ),
 	},
 	{
@@ -223,6 +225,11 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
+	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC) {
+		snd_soc_update_bits(codec,  RT5640_IN1_IN2, RT5640_IN_DF1,
+				    RT5640_IN_DF1);
+	}
+
 	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
 		ret = rt5640_dmic_enable(codec, 0, 0);
 		if (ret)
-- 
2.8.1
