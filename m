From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] regulator: core: Add devres versions of notifier registration
Date: Thu,  5 Mar 2015 15:39:20 +0000
Message-ID: <1425569962-14285-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, info@crazy-audio.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Charles Keepax <ckeepax@gmail.com>

Add devm_regulator_register_notifier, this adds the resource against the
device for the consumer supply we are registering the notifier for. There
seem to be few use-cases where this wouldn't be the users intention and
this ensures the notifiers will always be removed at the correct time.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

I have based this series of your ASoC tree Mark, because the
wm8804 patches have dependencies there. But just let me know
if you would rather I send the regulator patch against your
regulator tree.

Thanks,
Charles

 drivers/regulator/devres.c         |   85 ++++++++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |   16 +++++++
 2 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 8f785bc..6ec1d40 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -413,3 +413,88 @@ void devm_regulator_bulk_unregister_supply_alias(struct device *dev,
 		devm_regulator_unregister_supply_alias(dev, id[i]);
 }
 EXPORT_SYMBOL_GPL(devm_regulator_bulk_unregister_supply_alias);
+
+struct regulator_notifier_match {
+	struct regulator *regulator;
+	struct notifier_block *nb;
+};
+
+static int devm_regulator_match_notifier(struct device *dev, void *res,
+					 void *data)
+{
+	struct regulator_notifier_match *match = res;
+	struct regulator_notifier_match *target = data;
+
+	return match->regulator == target->regulator && match->nb == target->nb;
+}
+
+static void devm_regulator_destroy_notifier(struct device *dev, void *res)
+{
+	struct regulator_notifier_match *match = res;
+
+	regulator_unregister_notifier(match->regulator, match->nb);
+}
+
+/**
+ * devm_regulator_register_notifier - Resource managed
+ * regulator_register_notifier
+ *
+ * @regulator: regulator source
+ * @nb: notifier block
+ *
+ * The notifier will be registers under the consumer device and be
+ * automatically be unregistered when the source device is unbound.
+ */
+int devm_regulator_register_notifier(struct regulator *regulator,
+				     struct notifier_block *nb)
+{
+	struct regulator_notifier_match *match;
+	int ret;
+
+	match = devres_alloc(devm_regulator_destroy_notifier,
+			     sizeof(struct regulator_notifier_match),
+			     GFP_KERNEL);
+	if (!match)
+		return -ENOMEM;
+
+	match->regulator = regulator;
+	match->nb = nb;
+
+	ret = regulator_register_notifier(regulator, nb);
+	if (ret < 0) {
+		devres_free(match);
+		return ret;
+	}
+
+	devres_add(regulator->dev, match);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_regulator_register_notifier);
+
+/**
+ * devm_regulator_unregister_notifier - Resource managed
+ * regulator_unregister_notifier()
+ *
+ * @regulator: regulator source
+ * @nb: notifier block
+ *
+ * Unregister a notifier registered with devm_regulator_register_notifier().
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_regulator_unregister_notifier(struct regulator *regulator,
+					struct notifier_block *nb)
+{
+	struct regulator_notifier_match match;
+	int rc;
+
+	match.regulator = regulator;
+	match.nb = nb;
+
+	rc = devres_release(regulator->dev, devm_regulator_destroy_notifier,
+			    devm_regulator_match_notifier, &match);
+	if (rc != 0)
+		WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_unregister_notifier);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index d17e1ff..bd631ee 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -252,8 +252,12 @@ int regulator_list_hardware_vsel(struct regulator *regulator,
 /* regulator notifier block */
 int regulator_register_notifier(struct regulator *regulator,
 			      struct notifier_block *nb);
+int devm_regulator_register_notifier(struct regulator *regulator,
+				     struct notifier_block *nb);
 int regulator_unregister_notifier(struct regulator *regulator,
 				struct notifier_block *nb);
+void devm_regulator_unregister_notifier(struct regulator *regulator,
+					struct notifier_block *nb);
 
 /* driver data - core doesn't touch */
 void *regulator_get_drvdata(struct regulator *regulator);
@@ -515,12 +519,24 @@ static inline int regulator_register_notifier(struct regulator *regulator,
 	return 0;
 }
 
+static inline int devm_regulator_register_notifier(struct regulator *regulator,
+						   struct notifier_block *nb)
+{
+	return 0;
+}
+
 static inline int regulator_unregister_notifier(struct regulator *regulator,
 				struct notifier_block *nb)
 {
 	return 0;
 }
 
+static inline int devm_regulator_unregister_notifier(struct regulator *regulator,
+						     struct notifier_block *nb)
+{
+	return 0;
+}
+
 static inline void *regulator_get_drvdata(struct regulator *regulator)
 {
 	return NULL;
-- 
1.7.2.5
