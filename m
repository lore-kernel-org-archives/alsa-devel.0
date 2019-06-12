From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 3/3] ASoC: SOF: pci: add module param to
	disable pm_runtime
Date: Wed, 12 Jun 2019 11:47:26 -0500
Message-ID: <20190612164726.26768-4-pierre-louis.bossart@linux.intel.com>
References: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A379F806F5
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:47:37 +0200 (CEST)
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
 sound/soc/sof/sof-pci-dev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index ab58d4f9119f..ffe485f4ba71 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -29,6 +29,12 @@ static char *tplg_path;
 module_param(tplg_path, charp, 0444);
 MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
 
+static int sof_pci_debug;
+module_param_named(sof_debug, sof_pci_debug, int, 0444);
+MODULE_PARM_DESC(sof_debug, "SOF PCI debug options (0x0 all off)");
+
+#define SOF_PCI_DISABLE_PM_RUNTIME BIT(0)
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
 static const struct sof_dev_desc bxt_desc = {
 	.machines		= snd_soc_acpi_intel_bxt_machines,
@@ -213,6 +219,9 @@ static void sof_pci_probe_complete(struct device *dev)
 {
 	dev_dbg(dev, "Completing SOF PCI probe");
 
+	if (sof_pci_debug & SOF_PCI_DISABLE_PM_RUNTIME)
+		return;
+
 	/* allow runtime_pm */
 	pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
@@ -333,7 +342,8 @@ static void sof_pci_remove(struct pci_dev *pci)
 	snd_sof_device_remove(&pci->dev);
 
 	/* follow recommendation in pci-driver.c to increment usage counter */
-	pm_runtime_get_noresume(&pci->dev);
+	if (!(sof_pci_debug & SOF_PCI_DISABLE_PM_RUNTIME))
+		pm_runtime_get_noresume(&pci->dev);
 
 	/* release pci regions and disable device */
 	pci_release_regions(pci);
-- 
2.20.1
