From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/7] ASoC: max98090: Reset codec on resume
Date: Fri, 16 May 2014 16:55:21 +0300
Message-ID: <1400248525-21900-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AFC326087D
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 15:55:43 +0200 (CEST)
In-Reply-To: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Make sure we reset codec and clear any IRQs on resume. This matches
the init sequence in probe.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 4accf9ba447e..b3f447cc050c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2392,9 +2392,32 @@ static int max98090_runtime_suspend(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM
+static int max98090_resume(struct device *dev)
+{
+	struct max98090_priv *max98090 = dev_get_drvdata(dev);
+	unsigned int status;
+
+	max98090_reset(max98090);
+
+	/* clear IRQ status */
+	regmap_read(max98090->regmap, M98090_REG_DEVICE_STATUS, &status);
+
+	regcache_sync(max98090->regmap);
+
+	return 0;
+}
+
+static int max98090_suspend(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 static const struct dev_pm_ops max98090_pm = {
 	SET_RUNTIME_PM_OPS(max98090_runtime_suspend,
 		max98090_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(max98090_suspend, max98090_resume)
 };
 
 static const struct i2c_device_id max98090_i2c_id[] = {
-- 
2.0.0.rc0
