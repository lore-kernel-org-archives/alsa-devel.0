From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH 2/3] ASoC: SOF: add runtime idle callback
Date: Wed, 12 Jun 2019 15:22:57 +0300
Message-ID: <20190612122258.4363-3-kai.vehmanen@linux.intel.com>
References: <20190612122258.4363-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42CA0F896CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 14:22:13 +0200 (CEST)
In-Reply-To: <20190612122258.4363-1-kai.vehmanen@linux.intel.com>
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
Cc: kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add ability to implement a SOF device level runtime idle callback.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda.h    | 1 +
 sound/soc/sof/pm.c           | 8 ++++++++
 sound/soc/sof/sof-acpi-dev.c | 2 +-
 sound/soc/sof/sof-pci-dev.c  | 2 +-
 sound/soc/sof/sof-priv.h     | 2 ++
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 455046612b949..a292299a95243 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -445,6 +445,7 @@ int hda_dsp_suspend(struct snd_sof_dev *sdev, int state);
 int hda_dsp_resume(struct snd_sof_dev *sdev);
 int hda_dsp_runtime_suspend(struct snd_sof_dev *sdev, int state);
 int hda_dsp_runtime_resume(struct snd_sof_dev *sdev);
+int hda_dsp_runtime_idle(struct snd_sof_dev *sdev);
 void hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev);
 void hda_dsp_dump_skl(struct snd_sof_dev *sdev, u32 flags);
 void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags);
diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 8ef1d51025d8b..e859610c69fed 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -369,6 +369,14 @@ int snd_sof_runtime_suspend(struct device *dev)
 }
 EXPORT_SYMBOL(snd_sof_runtime_suspend);
 
+int snd_sof_runtime_idle(struct device *dev)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+
+	return snd_sof_dsp_runtime_idle(sdev);
+}
+EXPORT_SYMBOL(snd_sof_runtime_idle);
+
 int snd_sof_runtime_resume(struct device *dev)
 {
 	return sof_resume(dev, true);
diff --git a/sound/soc/sof/sof-acpi-dev.c b/sound/soc/sof/sof-acpi-dev.c
index c8dafb1ac54e2..ea7b8b8954128 100644
--- a/sound/soc/sof/sof-acpi-dev.c
+++ b/sound/soc/sof/sof-acpi-dev.c
@@ -116,7 +116,7 @@ static const struct sof_dev_desc sof_acpi_cherrytrail_desc = {
 static const struct dev_pm_ops sof_acpi_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(snd_sof_suspend, snd_sof_resume)
 	SET_RUNTIME_PM_OPS(snd_sof_runtime_suspend, snd_sof_runtime_resume,
-			   NULL)
+			   snd_sof_runtime_idle)
 };
 
 static void sof_acpi_probe_complete(struct device *dev)
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index ab58d4f9119fb..cbb6566d25664 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -206,7 +206,7 @@ static const struct sof_dev_desc kbl_desc = {
 static const struct dev_pm_ops sof_pci_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(snd_sof_suspend, snd_sof_resume)
 	SET_RUNTIME_PM_OPS(snd_sof_runtime_suspend, snd_sof_runtime_resume,
-			   NULL)
+			   snd_sof_runtime_idle)
 };
 
 static void sof_pci_probe_complete(struct device *dev)
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 17f3d2a5a7019..96306cfd9b751 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -170,6 +170,7 @@ struct snd_sof_dsp_ops {
 	int (*runtime_suspend)(struct snd_sof_dev *sof_dev,
 			       int state); /* optional */
 	int (*runtime_resume)(struct snd_sof_dev *sof_dev); /* optional */
+	int (*runtime_idle)(struct snd_sof_dev *sof_dev); /* optional */
 	void (*set_hw_params_upon_resume)(struct snd_sof_dev *sdev); /* optional */
 
 	/* DSP clocking */
@@ -437,6 +438,7 @@ int snd_sof_device_remove(struct device *dev);
 
 int snd_sof_runtime_suspend(struct device *dev);
 int snd_sof_runtime_resume(struct device *dev);
+int snd_sof_runtime_idle(struct device *dev);
 int snd_sof_resume(struct device *dev);
 int snd_sof_suspend(struct device *dev);
 
-- 
2.17.1
