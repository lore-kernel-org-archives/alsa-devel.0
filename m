From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4458: ak4458_regmap can be static" to
	the asoc tree
Date: Fri, 16 Feb 2018 15:21:36 +0000
Message-ID: <E1emhpQ-0003Uw-Ei@debutante>
References: <20180216135527.GA1304@lkp-ne02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 39D91267E5E
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 16:21:58 +0100 (CET)
In-Reply-To: <20180216135527.GA1304@lkp-ne02>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>, Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>, Liam Girdwood <lgirdwood@gmail.com>, Mihai Serban <mihai.serban@nxp.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4458: ak4458_regmap can be static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 71ca54b6e87df90ecab3ce1968d60543750c7507 Mon Sep 17 00:00:00 2001
From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 16 Feb 2018 21:55:28 +0800
Subject: [PATCH] ASoC: ak4458: ak4458_regmap can be static

Fixes: 08660086eff9 ("ASoC: ak4458: Add support for AK4458 DAC driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4458.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index b579cda8e418..c9762162b53f 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -574,7 +574,7 @@ struct snd_soc_codec_driver soc_codec_dev_ak4458 = {
 	},
 };
 
-const struct regmap_config ak4458_regmap = {
+static const struct regmap_config ak4458_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -584,7 +584,7 @@ const struct regmap_config ak4458_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-const struct dev_pm_ops ak4458_pm = {
+static const struct dev_pm_ops ak4458_pm = {
 	SET_RUNTIME_PM_OPS(ak4458_runtime_suspend, ak4458_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
-- 
2.16.1
