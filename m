From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: Add sysfs entry in order
	to store FW version" to the asoc tree
Date: Mon, 05 Dec 2016 17:23:26 +0000
Message-ID: <E1cDwz8-0007bE-Rj@finisterre>
References: <20161109084736.28265-4-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA2DC266DBC
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 18:23:35 +0100 (CET)
In-Reply-To: <20161109084736.28265-4-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: Add sysfs entry in order to store FW version

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fade74dfab7cdba55a197db08f3d15cf2319bf4c Mon Sep 17 00:00:00 2001
From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Date: Mon, 5 Dec 2016 17:45:02 +0100
Subject: [PATCH] ASoC: Intel: atom: Add sysfs entry in order to store FW
 version

This patch is adding a sysfs entry in order to be able to get
access to SST FW version.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index 9b6e27385dc9..f9ba71315e33 100644
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
@@ -242,6 +243,32 @@ int sst_alloc_drv_context(struct intel_sst_drv **ctx,
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
@@ -315,8 +342,19 @@ int sst_context_init(struct intel_sst_drv *ctx)
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
@@ -330,6 +368,7 @@ void sst_context_cleanup(struct intel_sst_drv *ctx)
 	pm_runtime_disable(ctx->dev);
 	sst_unregister(ctx->dev);
 	sst_set_fw_state_locked(ctx, SST_SHUTDOWN);
+	sysfs_remove_group(&ctx->dev->kobj, &sst_fw_version_attr_group);
 	flush_scheduled_work();
 	destroy_workqueue(ctx->post_msg_wq);
 	pm_qos_remove_request(ctx->qos);
-- 
2.10.2
