From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 01/15] soundwire: intel: filter SoundWire
	controller device search
Date: Wed, 22 May 2019 14:47:17 -0500
Message-ID: <20190522194732.25704-2-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA184F80C20
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 21:47:50 +0200 (CEST)
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The convention is that the SoundWire controller device is a child of
the HDAudio controller. However there can be more than one child
exposed in the DSDT table, and the current namespace walk returns the
last (incorrect) device.

Intel documentation states that bits 28..31 of the _ADR field
represent the link type, with SoundWire assigned the value 4.

Add a filter and terminate early when a valid _ADR is provided,
otherwise keep iterating to find the next child.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d3d6b54c5791..771a53a5c033 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -14,6 +14,7 @@
 #include <linux/soundwire/sdw_intel.h>
 #include "intel.h"
 
+#define SDW_LINK_TYPE		4 /* from Intel ACPI documentation */
 #define SDW_MAX_LINKS		4
 #define SDW_SHIM_LCAP		0x0
 #define SDW_SHIM_BASE		0x2C000
@@ -150,6 +151,12 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 {
 	struct sdw_intel_res *res = cdata;
 	struct acpi_device *adev;
+	acpi_status status;
+	u64 adr;
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
+	if (ACPI_FAILURE(status))
+		return AE_OK; /* keep going */
 
 	if (acpi_bus_get_device(handle, &adev)) {
 		pr_err("%s: Couldn't find ACPI handle\n", __func__);
@@ -157,7 +164,19 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 	}
 
 	res->handle = handle;
-	return AE_OK;
+
+	/*
+	 * On some Intel platforms, multiple children of the HDAS
+	 * device can be found, but only one of them is the SoundWire
+	 * controller. The SNDW device is always exposed with
+	 * Name(_ADR, 0x40000000), with bits 31..28 representing the
+	 * SoundWire link so filter accordingly
+	 */
+	if ((adr & GENMASK(31, 28)) >> 28 != SDW_LINK_TYPE)
+		return AE_OK; /* keep going */
+
+	/* device found, stop namespace walk */
+	return AE_CTRL_TERMINATE;
 }
 
 /**
-- 
2.20.1
