From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH asoc] ASoC: ak4458: ak4458_regmap can be
	static
Date: Fri, 16 Feb 2018 21:55:28 +0800
Message-ID: <20180216135527.GA1304@lkp-ne02>
References: <201802162144.qKMmP0uq%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E31ED266FC9
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 14:55:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201802162144.qKMmP0uq%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Mihai Serban <mihai.serban@nxp.com>
List-Id: alsa-devel@alsa-project.org


Fixes: 08660086eff9 ("ASoC: ak4458: Add support for AK4458 DAC driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ak4458.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index b579cda..c976216 100644
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
