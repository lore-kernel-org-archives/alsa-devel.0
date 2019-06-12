From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 2/3] ASoC: SOF: acpi: add module param to
	disable pm_runtime
Date: Wed, 12 Jun 2019 11:47:25 -0500
Message-ID: <20190612164726.26768-3-pierre-louis.bossart@linux.intel.com>
References: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A11B9F80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:47:36 +0200 (CEST)
In-Reply-To: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add debug option to disable pm_runtime. This is not intended for
production devices but is very useful for platform bringup.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-acpi-dev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-acpi-dev.c b/sound/soc/sof/sof-acpi-dev.c
index c8dafb1ac54e..93a8e15bbd2c 100644
--- a/sound/soc/sof/sof-acpi-dev.c
+++ b/sound/soc/sof/sof-acpi-dev.c
@@ -29,6 +29,12 @@ static char *tplg_path;
 module_param(tplg_path, charp, 0444);
 MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
 
+static int sof_acpi_debug;
+module_param_named(sof_debug, sof_acpi_debug, int, 0444);
+MODULE_PARM_DESC(sof_debug, "SOF ACPI debug options (0x0 all off)");
+
+#define SOF_ACPI_DISABLE_PM_RUNTIME BIT(0)
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HASWELL)
 static const struct sof_dev_desc sof_acpi_haswell_desc = {
 	.machines = snd_soc_acpi_intel_haswell_machines,
@@ -121,6 +127,9 @@ static const struct dev_pm_ops sof_acpi_pm = {
 
 static void sof_acpi_probe_complete(struct device *dev)
 {
+	if (sof_acpi_debug & SOF_ACPI_DISABLE_PM_RUNTIME)
+		return;
+
 	/* allow runtime_pm */
 	pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
@@ -221,7 +230,8 @@ static int sof_acpi_probe(struct platform_device *pdev)
 
 static int sof_acpi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	if (!(sof_acpi_debug & SOF_ACPI_DISABLE_PM_RUNTIME))
+		pm_runtime_disable(&pdev->dev);
 
 	/* call sof helper for DSP hardware remove */
 	snd_sof_device_remove(&pdev->dev);
-- 
2.20.1
