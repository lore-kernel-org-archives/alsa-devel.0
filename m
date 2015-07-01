From: yang.a.fang@intel.com
Subject: [PATCH v2] ASoC: ts3a227e: do not report jack status
	when there is i2c read err
Date: Wed,  1 Jul 2015 16:24:48 -0700
Message-ID: <1435793088-25971-1-git-send-email-yang.a.fang@intel.com>
References: <1435724282-109761-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E26F265068
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 01:25:45 +0200 (CEST)
In-Reply-To: <1435724282-109761-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, praveen.k.jain@intel.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

After suspend -> resume the ts3a227e_interrupt sometimes comes before i2c
controller resume is called .regmap_read will return incorrect status
and report a wrong jack status.This patch will disable irq on suspend
and enable irq again on the resume to make sure interrupt is coming
after TI resumes. Also We should return if there is read err,the
interrupt will come again since it is level triggered and we are not yet
clear the interrupt.

In addtion,cht_bsw_max98090_ti machine driver registered additional
notifier base on jack event which will program the audio codec.there
will be codec timeout err if such event occurs prior to i2c controller
is resumed.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/ts3a227e.c |   47 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 12232d7..611c09c 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -23,11 +23,13 @@
 #include "ts3a227e.h"
 
 struct ts3a227e {
+	struct device *dev;
 	struct regmap *regmap;
 	struct snd_soc_jack *jack;
 	bool plugged;
 	bool mic_present;
 	unsigned int buttons_held;
+	int irq;
 };
 
 /* Button values to be reported on the jack */
@@ -189,16 +191,28 @@ static irqreturn_t ts3a227e_interrupt(int irq, void *data)
 	struct ts3a227e *ts3a227e = (struct ts3a227e *)data;
 	struct regmap *regmap = ts3a227e->regmap;
 	unsigned int int_reg, kp_int_reg, acc_reg, i;
+	struct device *dev = ts3a227e->dev;
+	int ret;
 
 	/* Check for plug/unplug. */
-	regmap_read(regmap, TS3A227E_REG_INTERRUPT, &int_reg);
+	ret = regmap_read(regmap, TS3A227E_REG_INTERRUPT, &int_reg);
+	if (ret) {
+		dev_err(dev, "failed to clear interrupt ret=%d\n", ret);
+		return IRQ_HANDLED;
+	}
+
 	if (int_reg & (DETECTION_COMPLETE_EVENT | INS_REM_EVENT)) {
 		regmap_read(regmap, TS3A227E_REG_ACCESSORY_STATUS, &acc_reg);
 		ts3a227e_new_jack_state(ts3a227e, acc_reg);
 	}
 
 	/* Report any key events. */
-	regmap_read(regmap, TS3A227E_REG_KP_INTERRUPT, &kp_int_reg);
+	ret = regmap_read(regmap, TS3A227E_REG_KP_INTERRUPT, &kp_int_reg);
+	if (ret) {
+		dev_err(dev, "failed to clear key interrupt ret=%d\n", ret);
+		return IRQ_HANDLED;
+	}
+
 	for (i = 0; i < TS3A227E_NUM_BUTTONS; i++) {
 		if (kp_int_reg & PRESS_MASK(i))
 			ts3a227e->buttons_held |= (1 << i);
@@ -283,6 +297,8 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, ts3a227e);
+	ts3a227e->dev = dev;
+	ts3a227e->irq = i2c->irq;
 
 	ts3a227e->regmap = devm_regmap_init_i2c(i2c, &ts3a227e_regmap_config);
 	if (IS_ERR(ts3a227e->regmap))
@@ -320,6 +336,32 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int ts3a227e_suspend(struct device *dev)
+{
+	struct ts3a227e *ts3a227e = dev_get_drvdata(dev);
+
+	dev_dbg(ts3a227e->dev, "suspend disable irq\n");
+	disable_irq(ts3a227e->irq);
+
+	return 0;
+}
+
+static int ts3a227e_resume(struct device *dev)
+{
+	struct ts3a227e *ts3a227e = dev_get_drvdata(dev);
+
+	dev_dbg(ts3a227e->dev, "resume enable irq\n");
+	enable_irq(ts3a227e->irq);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops ts3a227e_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(ts3a227e_suspend, ts3a227e_resume)
+};
+
 static const struct i2c_device_id ts3a227e_i2c_ids[] = {
 	{ "ts3a227e", 0 },
 	{ }
@@ -336,6 +378,7 @@ static struct i2c_driver ts3a227e_driver = {
 	.driver = {
 		.name = "ts3a227e",
 		.owner = THIS_MODULE,
+		.pm = &ts3a227e_pm,
 		.of_match_table = of_match_ptr(ts3a227e_of_match),
 	},
 	.probe = ts3a227e_i2c_probe,
-- 
1.7.9.5
