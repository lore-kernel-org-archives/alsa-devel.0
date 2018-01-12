From: Mark Brown <broonie@kernel.org>
Subject: Applied "ACPI: utils: Introduce
	acpi_dev_get_first_match_name()" to the asoc tree
Date: Fri, 12 Jan 2018 20:01:30 +0000
Message-ID: <E1ea5W6-0008Se-D4@debutante>
References: <20180105160935.48588-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AE924266F23
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 21:01:36 +0100 (CET)
In-Reply-To: <20180105160935.48588-2-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Erik Schmauss <erik.schmauss@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ACPI: utils: Introduce acpi_dev_get_first_match_name()

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

>From 67dcf8a3e06582cb6b02952335b5612beb97889f Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 5 Jan 2018 18:09:33 +0200
Subject: [PATCH] ACPI: utils: Introduce acpi_dev_get_first_match_name()

Sometimes the user wants to have device name of the match rather than
just checking if device present or not. To make life easier for such
users introduce acpi_dev_get_first_match_name() helper based on code
for acpi_dev_present().

For example, GPIO driver for Intel Merrifield needs to know the device
name of pin control to be able to apply GPIO mapping table to the proper
device.

To be more consistent with the purpose rename

  struct acpi_dev_present_info  -> struct acpi_dev_match_info
  acpi_dev_present_cb()         -> acpi_dev_match_cb()

in the utils.c file.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/utils.c    | 41 ++++++++++++++++++++++++++++++++++-------
 include/acpi/acpi_bus.h |  3 +++
 include/linux/acpi.h    |  6 ++++++
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 9d49a1acebe3..78db97687f26 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -737,16 +737,17 @@ bool acpi_dev_found(const char *hid)
 }
 EXPORT_SYMBOL(acpi_dev_found);
 
-struct acpi_dev_present_info {
+struct acpi_dev_match_info {
+	const char *dev_name;
 	struct acpi_device_id hid[2];
 	const char *uid;
 	s64 hrv;
 };
 
-static int acpi_dev_present_cb(struct device *dev, void *data)
+static int acpi_dev_match_cb(struct device *dev, void *data)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
-	struct acpi_dev_present_info *match = data;
+	struct acpi_dev_match_info *match = data;
 	unsigned long long hrv;
 	acpi_status status;
 
@@ -757,6 +758,8 @@ static int acpi_dev_present_cb(struct device *dev, void *data)
 	    strcmp(adev->pnp.unique_id, match->uid)))
 		return 0;
 
+	match->dev_name = acpi_dev_name(adev);
+
 	if (match->hrv == -1)
 		return 1;
 
@@ -789,20 +792,44 @@ static int acpi_dev_present_cb(struct device *dev, void *data)
  */
 bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 {
-	struct acpi_dev_present_info match = {};
+	struct acpi_dev_match_info match = {};
 	struct device *dev;
 
 	strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
 	match.uid = uid;
 	match.hrv = hrv;
 
-	dev = bus_find_device(&acpi_bus_type, NULL, &match,
-			      acpi_dev_present_cb);
-
+	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
 	return !!dev;
 }
 EXPORT_SYMBOL(acpi_dev_present);
 
+/**
+ * acpi_dev_get_first_match_name - Return name of first match of ACPI device
+ * @hid: Hardware ID of the device.
+ * @uid: Unique ID of the device, pass NULL to not check _UID
+ * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
+ *
+ * Return device name if a matching device was present
+ * at the moment of invocation, or NULL otherwise.
+ *
+ * See additional information in acpi_dev_present() as well.
+ */
+const char *
+acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv)
+{
+	struct acpi_dev_match_info match = {};
+	struct device *dev;
+
+	strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
+	match.uid = uid;
+	match.hrv = hrv;
+
+	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
+	return dev ? match.dev_name : NULL;
+}
+EXPORT_SYMBOL(acpi_dev_get_first_match_name);
+
 /*
  * acpi_backlight= handling, this is done here rather then in video_detect.c
  * because __setup cannot be used in modules.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 79287629c888..c9608b0b80c6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -91,6 +91,9 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 bool acpi_dev_found(const char *hid);
 bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
 
+const char *
+acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv);
+
 #ifdef CONFIG_ACPI
 
 #include <linux/proc_fs.h>
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index dc1ebfeeb5ec..d918f1ea84e6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -640,6 +640,12 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 	return false;
 }
 
+static inline const char *
+acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv)
+{
+	return NULL;
+}
+
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
 	return false;
-- 
2.15.1
