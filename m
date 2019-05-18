From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/12] ASoC: SOF: core: fix error handling with
	the probe workqueue
Date: Sat, 18 May 2019 15:26:55 -0500
Message-ID: <20190518202704.7772-4-pierre-louis.bossart@linux.intel.com>
References: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 673F5F806E7
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2019 22:27:25 +0200 (CEST)
In-Reply-To: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
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

In some configurations, it's a requirement to split the probe in two,
with a second part handled in a workqueue (e.g. for HDMI support
which depends on the DRM modules).

SOF already handles these configurations but the error flow is
incorrect. When an error occurs in the workqueue, the probe has
technically already completed. If we release the resources on errors,
this generates kernel oops/use-after-free when the resources are
released a second time on module removal.

GitHub issue: https://github.com/thesofproject/linux/issues/945
Fixes: c16211d6226 ("ASoC: SOF: Add Sound Open Firmware driver core")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 693ad83bffc9..5beda47cdf9f 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -393,6 +393,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 
 	return 0;
 
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
 fw_run_err:
 	snd_sof_fw_unload(sdev);
 fw_load_err:
@@ -401,6 +402,21 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	snd_sof_free_debug(sdev);
 dbg_err:
 	snd_sof_remove(sdev);
+#else
+
+	/*
+	 * when the probe_continue is handled in a work queue, the
+	 * probe does not fail so we don't release resources here.
+	 * They will be released with an explicit call to
+	 * snd_sof_device_remove() when the PCI/ACPI device is removed
+	 */
+
+fw_run_err:
+fw_load_err:
+ipc_err:
+dbg_err:
+
+#endif
 
 	return ret;
 }
-- 
2.20.1
