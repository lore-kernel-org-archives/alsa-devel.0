From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 10/10] ACPI / utils: Remove deprecated
	function since no user left
Date: Thu, 28 Mar 2019 19:17:29 +0200
Message-ID: <20190328171729.44002-11-andriy.shevchenko@linux.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38CB6F89708
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 18:17:40 +0100 (CET)
In-Reply-To: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There is no more user of acpi_dev_get_first_match_name(),
which is deprecated and has no user left, so, remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/utils.c    | 16 ----------------
 include/acpi/acpi_bus.h |  3 ---
 include/linux/acpi.h    |  6 ------
 3 files changed, 25 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 5a2bae2b6c3a..89363b245489 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -835,22 +835,6 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 }
 EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
 
-/* DEPRECATED, use acpi_dev_get_first_match_dev() instead */
-const char *
-acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv)
-{
-	struct acpi_dev_match_info match = {};
-	struct device *dev;
-
-	strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
-	match.uid = uid;
-	match.hrv = hrv;
-
-	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
-	return dev ? match.dev_name : NULL;
-}
-EXPORT_SYMBOL(acpi_dev_get_first_match_name);
-
 /*
  * acpi_backlight= handling, this is done here rather then in video_detect.c
  * because __setup cannot be used in modules.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2063e9e2f384..f7981751ac77 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -94,9 +94,6 @@ bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
 struct acpi_device *
 acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
 
-const char *
-acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv);
-
 #ifdef CONFIG_ACPI
 
 #include <linux/proc_fs.h>
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3e1d16b00513..392413075cc0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -675,12 +675,6 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 	return NULL;
 }
 
-static inline const char *
-acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv)
-{
-	return NULL;
-}
-
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
 	return false;
-- 
2.20.1
