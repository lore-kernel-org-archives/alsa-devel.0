From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] regulator: Implement deferred disable
	support
Date: Mon, 12 Sep 2011 17:59:16 +0100
Message-ID: <1315846757-21084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D08C11038D2
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 18:59:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It is a reasonably common pattern for hardware to require some delay after
being quiesced before the disable has finalised, especially in mixed signal
devices. For example, an active discharge may be required to ensure that
the circuit starts up again in a known state. Avoid having to implement
such delays in the regulator API by providing regulator_deferred_disable()
which will do a regulator_disable() a specified number of milliseconds
after it is called.

Due to the reference counting done on regulators a deferred disable can
be cancelled by doing another regulator_enable().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/core.c           |   59 ++++++++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |    7 ++++
 include/linux/regulator/driver.h   |    3 ++
 3 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9a33fe2..026f3d4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1552,6 +1552,63 @@ int regulator_force_disable(struct regulator *regulator)
 }
 EXPORT_SYMBOL_GPL(regulator_force_disable);
 
+static void regulator_disable_work(struct work_struct *work)
+{
+	struct regulator_dev *rdev = container_of(work, struct regulator_dev,
+						  disable_work.work);
+	int count, i, ret;
+
+	mutex_lock(&rdev->mutex);
+
+	BUG_ON(!rdev->deferred_disables);
+
+	count = rdev->deferred_disables;
+	rdev->deferred_disables = 0;
+
+	for (i = 0; i < count; i++) {
+		ret = _regulator_disable(rdev);
+		if (ret != 0)
+			rdev_err(rdev, "Deferred disable failed: %d\n", ret);
+	}
+
+	mutex_unlock(&rdev->mutex);
+
+	if (rdev->supply) {
+		for (i = 0; i < count; i++) {
+			ret = regulator_disable(rdev->supply);
+			if (ret != 0) {
+				rdev_err(rdev,
+					 "Supply disable failed: %d\n", ret);
+			}
+		}
+	}
+}
+
+/**
+ * regulator_disable_deferred - disable regulator output with delay
+ * @regulator: regulator source
+ * @ms: miliseconds until the regulator is disabled
+ *
+ * Execute regulator_disable() on the regulator after a delay.  This
+ * is intended for use with devices that require some time to quiesce.
+ *
+ * NOTE: this will only disable the regulator output if no other consumer
+ * devices have it enabled, the regulator device supports disabling and
+ * machine constraints permit this operation.
+ */
+int regulator_disable_deferred(struct regulator *regulator, int ms)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+
+	mutex_lock(&rdev->mutex);
+	rdev->deferred_disables++;
+	mutex_unlock(&rdev->mutex);
+
+	return schedule_delayed_work(&rdev->disable_work,
+				     msecs_to_jiffies(ms));
+}
+EXPORT_SYMBOL_GPL(regulator_disable_deferred);
+
 static int _regulator_is_enabled(struct regulator_dev *rdev)
 {
 	/* If we don't know then assume that the regulator is always on */
@@ -2622,6 +2679,7 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
 	INIT_LIST_HEAD(&rdev->consumer_list);
 	INIT_LIST_HEAD(&rdev->list);
 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
+	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
 
 	/* preform any regulator specific init */
 	if (init_data->regulator_init) {
@@ -2729,6 +2787,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove_recursive(rdev->debugfs);
 #endif
+	flush_work_sync(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index b47771a..f7756d1 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -141,6 +141,7 @@ int regulator_enable(struct regulator *regulator);
 int regulator_disable(struct regulator *regulator);
 int regulator_force_disable(struct regulator *regulator);
 int regulator_is_enabled(struct regulator *regulator);
+int regulator_disable_deferred(struct regulator *regulator, int ms);
 
 int regulator_bulk_get(struct device *dev, int num_consumers,
 		       struct regulator_bulk_data *consumers);
@@ -211,6 +212,12 @@ static inline int regulator_disable(struct regulator *regulator)
 	return 0;
 }
 
+static inline int regulator_disable_deferred(struct regulator *regulator,
+					     int ms)
+{
+	return 0;
+}
+
 static inline int regulator_is_enabled(struct regulator *regulator)
 {
 	return 1;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 03a1798..52c89ae 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -200,6 +200,9 @@ struct regulator_dev {
 	struct regulation_constraints *constraints;
 	struct regulator *supply;	/* for tree */
 
+	struct delayed_work disable_work;
+	int deferred_disables;
+
 	void *reg_data;		/* regulator_dev data */
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.7.5.4
