From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] soundwire: intel: Fix uninitialized adev deref
Date: Tue,  7 Aug 2018 12:11:13 +0530
Message-ID: <20180807064113.8114-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E8E26786A
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 08:41:48 +0200 (CEST)
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
Cc: Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, dan.carpenter@oracle.com, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

In case of error, we can dereference uninitialized 'adev'

drivers/soundwire/intel_init.c:154 sdw_intel_acpi_cb()
error: uninitialized symbol 'adev'.

Fix that by not using adev for warn print and make it pr_err.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/intel_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d1ea6b4d0ad3..5c8a20d99878 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -151,7 +151,7 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 	struct acpi_device *adev;
 
 	if (acpi_bus_get_device(handle, &adev)) {
-		dev_err(&adev->dev, "Couldn't find ACPI handle\n");
+		pr_err("%s: Couldn't find ACPI handle\n", __func__);
 		return AE_NOT_FOUND;
 	}
 
-- 
2.14.4
