From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH v2 3/3] ASoC: SOF: Intel: implement runtime
	idle for CNL/APL
Date: Tue, 18 Jun 2019 13:18:04 +0300
Message-ID: <20190618101804.21670-4-kai.vehmanen@linux.intel.com>
References: <20190618101804.21670-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 955EEF89729
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 12:17:25 +0200 (CEST)
In-Reply-To: <20190618101804.21670-1-kai.vehmanen@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, libin.yang@intel.com, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Implement runtime idle for CNL/APL devices using similar runtime
PM idle logic as the Intel AZX HDA driver. If any HDA codecs are
powered when runtime suspend request comes, return -EBUSY. By doing
this, strict ordering is enforced between HDA codec and the HDA
controller.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/sof/intel/apl.c     |  1 +
 sound/soc/sof/intel/cnl.c     |  1 +
 sound/soc/sof/intel/hda-dsp.c | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index 43d1c9f31ec4c..fd2e26d797961 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -93,6 +93,7 @@ const struct snd_sof_dsp_ops sof_apl_ops = {
 	.resume			= hda_dsp_resume,
 	.runtime_suspend	= hda_dsp_runtime_suspend,
 	.runtime_resume		= hda_dsp_runtime_resume,
+	.runtime_idle		= hda_dsp_runtime_idle,
 	.set_hw_params_upon_resume = hda_dsp_set_hw_params_upon_resume,
 };
 EXPORT_SYMBOL(sof_apl_ops);
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 3840f81767fab..f2b392998f20d 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -251,6 +251,7 @@ const struct snd_sof_dsp_ops sof_cnl_ops = {
 	.resume			= hda_dsp_resume,
 	.runtime_suspend	= hda_dsp_runtime_suspend,
 	.runtime_resume		= hda_dsp_runtime_resume,
+	.runtime_idle		= hda_dsp_runtime_idle,
 	.set_hw_params_upon_resume = hda_dsp_set_hw_params_upon_resume,
 };
 EXPORT_SYMBOL(sof_cnl_ops);
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index f2c5a12db930a..91de4785b6a3e 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -418,6 +418,19 @@ int hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
 	return hda_resume(sdev);
 }
 
+int hda_dsp_runtime_idle(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *hbus = sof_to_bus(sdev);
+
+	if (hbus->codec_powered) {
+		dev_dbg(sdev->dev, "some codecs still powered (%08X), not idle\n",
+			(unsigned int)hbus->codec_powered);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 int hda_dsp_runtime_suspend(struct snd_sof_dev *sdev, int state)
 {
 	/* stop hda controller and power dsp off */
-- 
2.17.1
