From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Subject: [PATCH v2 3/3] ASoC: Intel: atom: Add sysfs entry in
	order to store FW version
Date: Wed,  9 Nov 2016 09:47:36 +0100
Message-ID: <20161109084736.28265-4-sebastien.guiriec@intel.com>
References: <20161109084736.28265-1-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EF6D2665A3
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 09:51:47 +0100 (CET)
In-Reply-To: <20161109084736.28265-1-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com
Cc: Sebastien Guiriec <sebastien.guiriec@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch is adding a sysfs entry in order to be able to get
access to SST FW version.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
---
 sound/soc/intel/atom/sst/sst.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a4b458e..9d35706 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -27,6 +27,7 @@
 #include <linux/pm_qos.h>
 #include <linux/async.h>
 #include <linux/acpi.h>
+#include <linux/sysfs.h>
 #include <sound/core.h>
 #include <sound/soc.h>
 #include <asm/platform_sst_audio.h>
@@ -241,6 +242,32 @@ int sst_alloc_drv_context(struct intel_sst_drv **ctx,
 }
 EXPORT_SYMBOL_GPL(sst_alloc_drv_context);
 
+static ssize_t firmware_version_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	if (ctx->fw_version.type == 0 && ctx->fw_version.major == 0 &&
+	    ctx->fw_version.minor == 0 && ctx->fw_version.build == 0)
+		return sprintf(buf, "FW not yet loaded\n");
+	else
+		return sprintf(buf, "v%02x.%02x.%02x.%02x\n",
+			       ctx->fw_version.type, ctx->fw_version.major,
+			       ctx->fw_version.minor, ctx->fw_version.build);
+
+}
+
+DEVICE_ATTR_RO(firmware_version);
+
+static const struct attribute *sst_fw_version_attrs[] = {
+	&dev_attr_firmware_version.attr,
+	NULL,
+};
+
+static const struct attribute_group sst_fw_version_attr_group = {
+	.attrs = (struct attribute **)sst_fw_version_attrs,
+};
+
 int sst_context_init(struct intel_sst_drv *ctx)
 {
 	int ret = 0, i;
@@ -314,8 +341,19 @@ int sst_context_init(struct intel_sst_drv *ctx)
 		dev_err(ctx->dev, "Firmware download failed:%d\n", ret);
 		goto do_free_mem;
 	}
+
+	ret = sysfs_create_group(&ctx->dev->kobj,
+				 &sst_fw_version_attr_group);
+	if (ret) {
+		dev_err(ctx->dev,
+			"Unable to create sysfs\n");
+		goto err_sysfs;
+	}
+
 	sst_register(ctx->dev);
 	return 0;
+err_sysfs:
+	sysfs_remove_group(&ctx->dev->kobj, &sst_fw_version_attr_group);
 
 do_free_mem:
 	destroy_workqueue(ctx->post_msg_wq);
@@ -329,6 +367,7 @@ void sst_context_cleanup(struct intel_sst_drv *ctx)
 	pm_runtime_disable(ctx->dev);
 	sst_unregister(ctx->dev);
 	sst_set_fw_state_locked(ctx, SST_SHUTDOWN);
+	sysfs_remove_group(&ctx->dev->kobj, &sst_fw_version_attr_group);
 	flush_scheduled_work();
 	destroy_workqueue(ctx->post_msg_wq);
 	pm_qos_remove_request(ctx->qos);
-- 
2.9.3

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
