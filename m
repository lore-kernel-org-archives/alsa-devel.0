From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: Enable jack detection"
	to the asoc tree
Date: Tue, 23 Jul 2019 12:29:12 +0100 (BST)
Message-ID: <20190723112912.F390E2742BAC@ypsilon.sirena.org.uk>
References: <20190722141402.7194-13-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 547C3F80482
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:13 +0200 (CEST)
In-Reply-To: <20190722141402.7194-13-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Rander Wang <rander.wang@linux.intel.com>
Cc: tiwai@suse.de, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: Enable jack detection

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From fd15f2f5e272145269bcbf834e0e0b560a575891 Mon Sep 17 00:00:00 2001
From: Rander Wang <rander.wang@linux.intel.com>
Date: Mon, 22 Jul 2019 09:13:53 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: Enable jack detection

In commit 7d4f606c50ff ("ALSA: hda - WAKEEN feature enabling for
runtime pm"), legacy HD-A driver sets hda controller in reset mode after
entering runtime-suspend. And when resuming from suspend mode, it checks
hda controller & codec status to detect headphone hotplug event. Now
this patch does the same job in SOF runtime pm functions.

And we need to check all the non-hdmi codecs for some cases like playback
with HDMI or capture with DMIC connected to dsp. In these cases, only
controller is active and codecs are suspended, so codecs can't send
unsolicited event to controller. The jack polling operation will activate
codecs and unsolicited event can work even codecs become suspended later.

Tested on whiskylake with hda codecs.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-13-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 44 +++++++++++++++++++++++++++++++--
 sound/soc/sof/intel/hda-dsp.c   | 21 ++++++++--------
 sound/soc/sof/intel/hda.h       |  2 ++
 3 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 0d8437b080bf..3ca6795a89ba 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -10,6 +10,7 @@
 
 #include <linux/module.h>
 #include <sound/hdaudio_ext.h>
+#include <sound/hda_register.h>
 #include <sound/hda_codec.h>
 #include <sound/hda_i915.h>
 #include <sound/sof.h>
@@ -37,16 +38,55 @@ static void hda_codec_load_module(struct hda_codec *codec)
 static void hda_codec_load_module(struct hda_codec *codec) {}
 #endif
 
+/* enable controller wake up event for all codecs with jack connectors */
+void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev)
+{
+	struct hda_bus *hbus = sof_to_hbus(sdev);
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct hda_codec *codec;
+	unsigned int mask = 0;
+
+	list_for_each_codec(codec, hbus)
+		if (codec->jacktbl.used)
+			mask |= BIT(codec->core.addr);
+
+	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, mask);
+}
+
+/* check jack status after resuming from suspend mode */
+void hda_codec_jack_check(struct snd_sof_dev *sdev)
+{
+	struct hda_bus *hbus = sof_to_hbus(sdev);
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct hda_codec *codec;
+
+	/* disable controller Wake Up event*/
+	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
+
+	list_for_each_codec(codec, hbus)
+		/*
+		 * Wake up all jack-detecting codecs regardless whether an event
+		 * has been recorded in STATESTS
+		 */
+		if (codec->jacktbl.used)
+			schedule_delayed_work(&codec->jackpoll_work,
+					      codec->jackpoll_interval);
+}
+#else
+void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev) {}
+void hda_codec_jack_check(struct snd_sof_dev *sdev) {}
 #endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
+EXPORT_SYMBOL(hda_codec_jack_wake_enable);
+EXPORT_SYMBOL(hda_codec_jack_check);
 
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 {
-	struct hda_bus *hbus = sof_to_hbus(sdev);
-	struct hdac_device *hdev;
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 	struct hdac_hda_priv *hda_priv;
 #endif
+	struct hda_bus *hbus = sof_to_hbus(sdev);
+	struct hdac_device *hdev;
 	u32 hda_cmd = (address << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	u32 resp = -1;
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 3d711d354fb9..f9579edbca68 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -295,6 +295,9 @@ static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
 	hda_dsp_ipc_int_disable(sdev);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	if (runtime_suspend)
+		hda_codec_jack_wake_enable(sdev);
+
 	/* power down all hda link */
 	snd_hdac_ext_bus_link_power_down_all(bus);
 #endif
@@ -329,7 +332,7 @@ static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
 	return 0;
 }
 
-static int hda_resume(struct snd_sof_dev *sdev)
+static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	struct hdac_bus *bus = sof_to_bus(sdev);
@@ -343,7 +346,6 @@ static int hda_resume(struct snd_sof_dev *sdev)
 	 */
 	snd_sof_pci_update_bits(sdev, PCI_TCSEL, 0x07, 0);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* reset and start hda controller */
 	ret = hda_dsp_ctrl_init_chip(sdev, true);
 	if (ret < 0) {
@@ -352,13 +354,10 @@ static int hda_resume(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
-	hda_dsp_ctrl_misc_clock_gating(sdev, false);
-
-	/* Reset stream-to-link mapping */
-	list_for_each_entry(hlink, &bus->hlink_list, list)
-		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
-
-	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* check jack status */
+	if (runtime_resume)
+		hda_codec_jack_check(sdev);
 
 	/* turn off the links that were off before suspend */
 	list_for_each_entry(hlink, &bus->hlink_list, list) {
@@ -407,13 +406,13 @@ static int hda_resume(struct snd_sof_dev *sdev)
 int hda_dsp_resume(struct snd_sof_dev *sdev)
 {
 	/* init hda controller. DSP cores will be powered up during fw boot */
-	return hda_resume(sdev);
+	return hda_resume(sdev, false);
 }
 
 int hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
 {
 	/* init hda controller. DSP cores will be powered up during fw boot */
-	return hda_resume(sdev);
+	return hda_resume(sdev, true);
 }
 
 int hda_dsp_runtime_idle(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 70909debfeb5..028e865d5e20 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -557,6 +557,8 @@ void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev,
  * HDA Codec operations.
  */
 int hda_codec_probe_bus(struct snd_sof_dev *sdev);
+void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev);
+void hda_codec_jack_check(struct snd_sof_dev *sdev);
 
 #endif /* CONFIG_SND_SOC_SOF_HDA */
 
-- 
2.20.1
