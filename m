From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: rt5682: initialize mutex before
	using" to the asoc tree
Date: Thu, 25 Apr 2019 20:24:34 +0100 (BST)
Message-ID: <20190425192434.C3746441D3E@finisterre.ee.mobilebroadband>
References: <20190419205349.23200-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0F72F89737
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 21:24:47 +0200 (CEST)
In-Reply-To: <20190419205349.23200-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Xun Zhang <xun2.zhang@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard liao <yung-chuan.liao@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: rt5682: initialize mutex before using

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From c46ab1510de1d3dd9871ae36fbec0da3e0d2d6c5 Mon Sep 17 00:00:00 2001
From: Xun Zhang <xun2.zhang@intel.com>
Date: Fri, 19 Apr 2019 15:53:49 -0500
Subject: [PATCH] ASoC: codecs: rt5682: initialize mutex before using

In rt5682 codec driver, a mutex called "calibrate_mutex" is used
in rt5682_calibrate() before initialization, which causes warning
in lock debug. Move the initialization before the usage of mutex.

Signed-off-by: Xun Zhang <xun2.zhang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 86a7fa31c294..505fb3d7b1c5 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2588,6 +2588,7 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 	rt5682_reset(rt5682->regmap);
 
+	mutex_init(&rt5682->calibrate_mutex);
 	rt5682_calibrate(rt5682);
 
 	ret = regmap_multi_reg_write(rt5682->regmap, patch_list,
@@ -2654,7 +2655,6 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 	INIT_DELAYED_WORK(&rt5682->jd_check_work,
 				rt5682_jd_check_handler);
 
-	mutex_init(&rt5682->calibrate_mutex);
 
 	if (i2c->irq) {
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
-- 
2.20.1
