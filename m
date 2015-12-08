From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support for active
	suspend" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:20 +0000
Message-ID: <E1a6NfU-00040j-Bc@debutante>
References: <1449165601-11226-12-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B31F26066B
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:26 +0100 (CET)
In-Reply-To: <1449165601-11226-12-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support for active suspend

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

>From 4557c305d4fc9356563a1d41fa6fe29e494f0460 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 3 Dec 2015 23:30:00 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support for active suspend

Some of the usecases can be marked as 'ignore_suspend' by
machine. For these on suspend we should keep audio controller
ON by saving the state and not suspending the device

For this we need to maintain a counter for these streams and be
active on suspend when such a stream is opened.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 27 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c     | 28 ++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.h     |  2 ++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 6570e5753e49..b89ae6f7c096 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -109,6 +109,31 @@ static enum hdac_ext_stream_type skl_get_host_stream_type(struct hdac_ext_bus *e
 		return HDAC_EXT_STREAM_TYPE_COUPLED;
 }
 
+/*
+ * check if the stream opened is marked as ignore_suspend by machine, if so
+ * then enable suspend_active refcount
+ *
+ * The count supend_active does not need lock as it is used in open/close
+ * and suspend context
+ */
+static void skl_set_suspend_active(struct snd_pcm_substream *substream,
+					 struct snd_soc_dai *dai, bool enable)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct snd_soc_dapm_widget *w;
+	struct skl *skl = ebus_to_skl(ebus);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		w = dai->playback_widget;
+	else
+		w = dai->capture_widget;
+
+	if (w->ignore_suspend && enable)
+		skl->supend_active++;
+	else if (w->ignore_suspend && !enable)
+		skl->supend_active--;
+}
+
 static int skl_pcm_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -146,6 +171,7 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 
 	dev_dbg(dai->dev, "stream tag set in dma params=%d\n",
 				 dma_params->stream_tag);
+	skl_set_suspend_active(substream, dai, true);
 	snd_pcm_set_sync(substream);
 
 	return 0;
@@ -257,6 +283,7 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 	 * dma_params
 	 */
 	snd_soc_dai_set_dma_data(dai, substream, NULL);
+	skl_set_suspend_active(substream, dai, false);
 
 	kfree(dma_params);
 }
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index d3e87b6f93fe..2c16325d1ce1 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -169,16 +169,40 @@ static int skl_suspend(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct skl *skl  = ebus_to_skl(ebus);
 
-	return _skl_suspend(ebus);
+	/*
+	 * Do not suspend if streams which are marked ignore suspend are
+	 * running, we need to save the state for these and continue
+	 */
+	if (skl->supend_active) {
+		pci_save_state(pci);
+		pci_disable_device(pci);
+		return 0;
+	} else {
+		return _skl_suspend(ebus);
+	}
 }
 
 static int skl_resume(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct skl *skl  = ebus_to_skl(ebus);
+	int ret;
 
-	return _skl_resume(ebus);
+	/*
+	 * resume only when we are not in suspend active, otherwise need to
+	 * restore the device
+	 */
+	if (skl->supend_active) {
+		pci_restore_state(pci);
+		ret = pci_enable_device(pci);
+	} else {
+		ret = _skl_resume(ebus);
+	}
+
+	return ret;
 }
 #endif /* CONFIG_PM_SLEEP */
 
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 774c29cf84dc..3d167eed0f59 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -70,6 +70,8 @@ struct skl {
 	struct list_head ppl_list;
 
 	const char *fw_name;
+
+	int supend_active;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.6.2
