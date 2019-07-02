From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH v2 2/3] ASoC: SOF: add runtime idle callback
Date: Tue,  2 Jul 2019 16:24:27 +0300
Message-ID: <20190702132428.13129-3-kai.vehmanen@linux.intel.com>
References: <20190702132428.13129-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2AA5F800C1
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 16:17:15 +0200 (CEST)
In-Reply-To: <20190702132428.13129-1-kai.vehmanen@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tiwai@suse.de, libin.yang@intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add ability to implement a SOF device level runtime idle callback.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/sof/intel/hda.h    | 1 +
 sound/soc/sof/ops.h          | 8 ++++++++
 sound/soc/sof/pm.c           | 8 ++++++++
 sound/soc/sof/sof-acpi-dev.c | 2 +-
 sound/soc/sof/sof-pci-dev.c  | 2 +-
 sound/soc/sof/sof-priv.h     | 2 ++
 6 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 73d7cc08afc22..d9c17146200b3 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -457,6 +457,7 @@ int hda_dsp_suspend(struct snd_sof_dev *sdev, int state);
 int hda_dsp_resume(struct snd_sof_dev *sdev);
 int hda_dsp_runtime_suspend(struct snd_sof_dev *sdev, int state);
 int hda_dsp_runtime_resume(struct snd_sof_dev *sdev);
+int hda_dsp_runtime_idle(struct snd_sof_dev *sdev);
 int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev);
 void hda_dsp_dump_skl(struct snd_sof_dev *sdev, u32 flags);
 void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags);
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 45a3d10911634..b9bdf45889da1 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -134,6 +134,14 @@ static inline int snd_sof_dsp_runtime_suspend(struct snd_sof_dev *sdev,
 	return 0;
 }
 
+static inline int snd_sof_dsp_runtime_idle(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->runtime_idle)
+		return sof_ops(sdev)->runtime_idle(sdev);
+
+	return 0;
+}
+
 static inline int snd_sof_dsp_hw_params_upon_resume(struct snd_sof_dev *sdev)
 {
 	if (sof_ops(sdev)->set_hw_params_upon_resume)
diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 8eeb3a1029f24..278abfd10490d 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -394,6 +394,14 @@ int snd_sof_runtime_suspend(struct device *dev)
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
index e2b19782f01ac..65d1bac4c6b8b 100644
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
index 58621db4fd31a..b8c0b2a226845 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -176,6 +176,7 @@ struct snd_sof_dsp_ops {
 	int (*runtime_suspend)(struct snd_sof_dev *sof_dev,
 			       int state); /* optional */
 	int (*runtime_resume)(struct snd_sof_dev *sof_dev); /* optional */
+	int (*runtime_idle)(struct snd_sof_dev *sof_dev); /* optional */
 	int (*set_hw_params_upon_resume)(struct snd_sof_dev *sdev); /* optional */
 
 	/* DSP clocking */
@@ -446,6 +447,7 @@ int snd_sof_device_remove(struct device *dev);
 
 int snd_sof_runtime_suspend(struct device *dev);
 int snd_sof_runtime_resume(struct device *dev);
+int snd_sof_runtime_idle(struct device *dev);
 int snd_sof_resume(struct device *dev);
 int snd_sof_suspend(struct device *dev);
 
-- 
2.17.1
