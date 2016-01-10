From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Use CGCTL.MISCBDCGE for
	Phrase detection notification" to the asoc tree
Date: Sun, 10 Jan 2016 12:22:32 +0000
Message-ID: <E1aIF0y-0008Rp-JG@debutante>
References: <1450431729-27259-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E2DD26063D
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:38 +0100 (CET)
In-Reply-To: <1450431729-27259-9-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Dharageswari.R" <dharageswari.r@intel.com>, Jayachandran B <jayachandran.b@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Use CGCTL.MISCBDCGE for Phrase detection notification

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

>From 721c3e36f774150f453216efcf5e1895577ac68c Mon Sep 17 00:00:00 2001
From: "Dharageswari.R" <dharageswari.r@intel.com>
Date: Fri, 18 Dec 2015 15:12:04 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Use CGCTL.MISCBDCGE for Phrase
 detection notification

Per HW recommendation, SW shall clear the CGCTL.MISCBDCGE and set
it back once data is transferred. So clear this when we get the
IPC and track using a driver flag, and set back on closure

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.7.0.rc3
