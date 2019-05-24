From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/5] ASoC: SOF: trace: move to opt-in with
	Kconfig and module parameter
Date: Fri, 24 May 2019 14:23:07 -0500
Message-ID: <20190524192309.6359-4-pierre-louis.bossart@linux.intel.com>
References: <20190524192309.6359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7E85F89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 21:23:21 +0200 (CEST)
In-Reply-To: <20190524192309.6359-1-pierre-louis.bossart@linux.intel.com>
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

In a number of debug cases, the DMA-based trace can add problems
(e.g. with HDaudio channel allocation). It also generates additional
traffic on the bus and if the DMA handling is unreliable will prevent
audio use-cases from working normally. Using the trace also requires
tools to be installed on the target.

The trace can be instead handled as dynamic debug. We can use a
Kconfig to force the trace to be enabled in all cases, or use a module
parameter to enable it on a need-basis, e.g. by setting "options
snd_sof sof_debug=0x1" in a /etc/modprobe.d file.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/Kconfig    |  8 ++++++++
 sound/soc/sof/core.c     | 26 ++++++++++++++++++++------
 sound/soc/sof/sof-priv.h |  1 +
 sound/soc/sof/trace.c    | 17 ++++++++++++++++-
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index a9a1d502daae..b56b0a4982cd 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -131,6 +131,14 @@ config SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE
 	  Say Y if you want to enable caching the memory windows.
 	  If unsure, select "N".
 
+config SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE
+	bool "SOF enable firmware trace"
+	help
+	  The firmware trace can be enabled either at build-time with
+	  this option, or dynamically by setting flags in the SOF core
+	  module parameter (similar to dynamic debug)
+	  If unsure, select "N".
+
 endif ## SND_SOC_SOF_DEBUG
 
 endif ## SND_SOC_SOF_OPTIONS
diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 5beda47cdf9f..70b471be07b2 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -16,6 +16,12 @@
 #include "sof-priv.h"
 #include "ops.h"
 
+static int sof_core_debug;
+module_param_named(sof_debug, sof_core_debug, int, 0444);
+MODULE_PARM_DESC(sof_debug, "SOF core debug options (0x0 all off)");
+
+#define SOF_CORE_ENABLE_TRACE BIT(0)
+
 /* SOF defaults if not provided by the platform in ms */
 #define TIMEOUT_DEFAULT_IPC_MS  5
 #define TIMEOUT_DEFAULT_BOOT_MS 100
@@ -350,12 +356,20 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 		goto fw_run_err;
 	}
 
-	/* init DMA trace */
-	ret = snd_sof_init_trace(sdev);
-	if (ret < 0) {
-		/* non fatal */
-		dev_warn(sdev->dev,
-			 "warning: failed to initialize trace %d\n", ret);
+	if (IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE) ||
+	    (sof_core_debug & SOF_CORE_ENABLE_TRACE)) {
+		sdev->dtrace_is_supported = true;
+
+		/* init DMA trace */
+		ret = snd_sof_init_trace(sdev);
+		if (ret < 0) {
+			/* non fatal */
+			dev_warn(sdev->dev,
+				 "warning: failed to initialize trace %d\n",
+				 ret);
+		}
+	} else {
+		dev_dbg(sdev->dev, "SOF firmware trace disabled\n");
 	}
 
 	/* hereafter all FW boot flows are for PM reasons */
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 01a6219c326b..03d852293d27 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -415,6 +415,7 @@ struct snd_sof_dev {
 	int dma_trace_pages;
 	wait_queue_head_t trace_sleep;
 	u32 host_offset;
+	u32 dtrace_is_supported; /* set with Kconfig or module parameter */
 	u32 dtrace_is_enabled;
 	u32 dtrace_error;
 	u32 dtrace_draining;
diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index b02520f8e595..2613dd3e0dfc 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -165,6 +165,9 @@ int snd_sof_init_trace_ipc(struct snd_sof_dev *sdev)
 	struct sof_ipc_reply ipc_reply;
 	int ret;
 
+	if (!sdev->dtrace_is_supported)
+		return 0;
+
 	if (sdev->dtrace_is_enabled || !sdev->dma_trace_pages)
 		return -EINVAL;
 
@@ -217,6 +220,9 @@ int snd_sof_init_trace(struct snd_sof_dev *sdev)
 {
 	int ret;
 
+	if (!sdev->dtrace_is_supported)
+		return 0;
+
 	/* set false before start initialization */
 	sdev->dtrace_is_enabled = false;
 
@@ -272,6 +278,9 @@ EXPORT_SYMBOL(snd_sof_init_trace);
 int snd_sof_trace_update_pos(struct snd_sof_dev *sdev,
 			     struct sof_ipc_dma_trace_posn *posn)
 {
+	if (!sdev->dtrace_is_supported)
+		return 0;
+
 	if (sdev->dtrace_is_enabled && sdev->host_offset != posn->host_offset) {
 		sdev->host_offset = posn->host_offset;
 		wake_up(&sdev->trace_sleep);
@@ -288,6 +297,9 @@ int snd_sof_trace_update_pos(struct snd_sof_dev *sdev,
 /* an error has occurred within the DSP that prevents further trace */
 void snd_sof_trace_notify_for_error(struct snd_sof_dev *sdev)
 {
+	if (!sdev->dtrace_is_supported)
+		return;
+
 	if (sdev->dtrace_is_enabled) {
 		dev_err(sdev->dev, "error: waking up any trace sleepers\n");
 		sdev->dtrace_error = true;
@@ -300,7 +312,7 @@ void snd_sof_release_trace(struct snd_sof_dev *sdev)
 {
 	int ret;
 
-	if (!sdev->dtrace_is_enabled)
+	if (!sdev->dtrace_is_supported || !sdev->dtrace_is_enabled)
 		return;
 
 	ret = snd_sof_dma_trace_trigger(sdev, SNDRV_PCM_TRIGGER_STOP);
@@ -321,6 +333,9 @@ EXPORT_SYMBOL(snd_sof_release_trace);
 
 void snd_sof_free_trace(struct snd_sof_dev *sdev)
 {
+	if (!sdev->dtrace_is_supported)
+		return;
+
 	snd_sof_release_trace(sdev);
 
 	snd_dma_free_pages(&sdev->dmatb);
-- 
2.20.1
