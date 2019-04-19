From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: codecs: rt5682: initialize mutex before
	using
Date: Fri, 19 Apr 2019 15:53:49 -0500
Message-ID: <20190419205349.23200-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F000F801D9
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 22:53:57 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Xun Zhang <xun2.zhang@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Xun Zhang <xun2.zhang@intel.com>

In rt5682 codec driver, a mutex called "calibrate_mutex" is used
in rt5682_calibrate() before initialization, which causes warning
in lock debug. Move the initialization before the usage of mutex.

Signed-off-by: Xun Zhang <xun2.zhang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
