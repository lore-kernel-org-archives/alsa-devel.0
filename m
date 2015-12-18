From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 08/13] ASoC: Intel: Skylake: Use
	CGCTL.MISCBDCGE for Phrase detection notification
Date: Fri, 18 Dec 2015 15:12:04 +0530
Message-ID: <1450431729-27259-9-git-send-email-vinod.koul@intel.com>
References: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A0A29265D47
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 10:39:20 +0100 (CET)
In-Reply-To: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Dharageswari.R" <dharageswari.r@intel.com>, tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Dharageswari.R" <dharageswari.r@intel.com>

Per HW recommendation, SW shall clear the CGCTL.MISCBDCGE and set
it back once data is transferred. So clear this when we get the
IPC and track using a driver flag, and set back on closure

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c     | 13 +++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.c | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index b89ae6f7c096..8039a0479053 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -25,6 +25,8 @@
 #include <sound/soc.h>
 #include "skl.h"
 #include "skl-topology.h"
+#include "skl-sst-dsp.h"
+#include "skl-sst-ipc.h"
 
 #define HDA_MONO 1
 #define HDA_STEREO 2
@@ -272,6 +274,7 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct skl_dma_params *dma_params = NULL;
+	struct skl *skl = ebus_to_skl(ebus);
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
@@ -285,6 +288,16 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 	snd_soc_dai_set_dma_data(dai, substream, NULL);
 	skl_set_suspend_active(substream, dai, false);
 
+	/*
+	 * check if close is for "Reference Pin" and set back the
+	 * CGCTL.MISCBDCGE if disabled by driver
+	 */
+	if (!strncmp(dai->name, "Reference Pin", 13) &&
+			skl->skl_sst->miscbdcg_disabled) {
+		skl->skl_sst->enable_miscbdcge(dai->dev, true);
+		skl->skl_sst->miscbdcg_disabled = false;
+	}
+
 	kfree(dma_params);
 }
 
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 62e665a3b8f7..543460293b00 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -16,8 +16,10 @@
 
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
+#include "skl.h"
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
+#include "sound/hdaudio_ext.h"
 
 
 #define IPC_IXC_STATUS_BITS		24
@@ -322,6 +324,19 @@ static int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
 			wake_up(&skl->boot_wait);
 			break;
 
+		case IPC_GLB_NOTIFY_PHRASE_DETECTED:
+			dev_dbg(ipc->dev, "***** Phrase Detected **********\n");
+
+			/*
+			 * Per HW recomendation, After phrase detection,
+			 * clear the CGCTL.MISCBDCGE.
+			 *
+			 * This will be set back on stream closure
+			 */
+			skl->enable_miscbdcge(ipc->dev, false);
+			skl->miscbdcg_disabled = true;
+			break;
+
 		default:
 			dev_err(ipc->dev, "ipc: Unhandled error msg=%x",
 						header.primary);
-- 
1.9.1
