From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 14/22] soundwire: intel_init: fix alignment issues
Date: Wed,  1 May 2019 10:57:37 -0500
Message-ID: <20190501155745.21806-15-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Use Linux style

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index e0f2903101c7..9ad6045720c4 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -69,7 +69,7 @@ static struct sdw_intel_ctx
 	/* Found controller, find links supported */
 	count = 0;
 	ret = fwnode_property_read_u8_array(acpi_fwnode_handle(adev),
-				  "mipi-sdw-master-count", &count, 1);
+					    "mipi-sdw-master-count", &count, 1);
 
 	/* Don't fail on error, continue and use hw value */
 	if (ret) {
@@ -87,7 +87,7 @@ static struct sdw_intel_ctx
 	/* Check count is within bounds */
 	if (count > SDW_MAX_LINKS) {
 		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
-						count, SDW_MAX_LINKS);
+			count, SDW_MAX_LINKS);
 		return NULL;
 	}
 
@@ -147,7 +147,7 @@ static struct sdw_intel_ctx
 }
 
 static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
-					void *cdata, void **return_value)
+				     void *cdata, void **return_value)
 {
 	struct sdw_intel_res *res = cdata;
 	struct acpi_device *adev;
@@ -174,9 +174,9 @@ void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
 	acpi_status status;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
-					parent_handle, 1,
-					sdw_intel_acpi_cb,
-					NULL, res, NULL);
+				     parent_handle, 1,
+				     sdw_intel_acpi_cb,
+				     NULL, res, NULL);
 	if (ACPI_FAILURE(status))
 		return NULL;
 
-- 
2.17.1
