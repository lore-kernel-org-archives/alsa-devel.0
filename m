From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Support registering a DAI dynamically"
	to the asoc tree
Date: Sun, 10 Jan 2016 12:07:39 +0000
Message-ID: <E1aIEmZ-0007NU-T8@debutante>
References: <ce77885082109fef7b6a7694d9c02156381b9b81.1451550513.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DE142602F1
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:07:45 +0100 (CET)
In-Reply-To: <ce77885082109fef7b6a7694d9c02156381b9b81.1451550513.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Support registering a DAI dynamically

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

>From 68003e6cf2bbd239a322bd8a28dacfaf8174fdee Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 31 Dec 2015 16:40:43 +0800
Subject: [PATCH] ASoC: Support registering a DAI dynamically

Define API snd_soc_register_dai() to add a DAI dynamically and
create the DAI widgets. Topology can use this API to register DAIs
when probing a component with topology info. These DAIs's playback
& capture widgets will be freed when the sound card is unregistered
and the DAIs will be freed when cleaning up the component.

And a dobj is embedded into the struct snd_soc_dai_driver. Topology
can use the dobj to find the DAI drivers created by it and free them
when the topology component is removed.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  1 +
 include/sound/soc.h     |  3 +++
 sound/soc/soc-core.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 212eaaf172ed..964b7de1a1cc 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -222,6 +222,7 @@ struct snd_soc_dai_driver {
 	const char *name;
 	unsigned int id;
 	unsigned int base;
+	struct snd_soc_dobj dobj;
 
 	/* DAI driver callbacks */
 	int (*probe)(struct snd_soc_dai *dai);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index af347bcdc2f6..9d1383e8d039 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1663,6 +1663,9 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 void snd_soc_remove_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *dai_link);
 
+int snd_soc_register_dai(struct snd_soc_component *component,
+	struct snd_soc_dai_driver *dai_drv);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1bd0b37b907f..c572673a5a24 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2834,6 +2834,48 @@ err:
 	return ret;
 }
 
+/**
+ * snd_soc_register_dai - Register a DAI dynamically & create its widgets
+ *
+ * @component: The component the DAIs are registered for
+ * @dai_drv: DAI driver to use for the DAI
+ *
+ * Topology can use this API to register DAIs when probing a component.
+ * These DAIs's widgets will be freed in the card cleanup and the DAIs
+ * will be freed in the component cleanup.
+ */
+int snd_soc_register_dai(struct snd_soc_component *component,
+	struct snd_soc_dai_driver *dai_drv)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	struct snd_soc_dai *dai;
+	int ret;
+
+	if (dai_drv->dobj.type != SND_SOC_DOBJ_PCM) {
+		dev_err(component->dev, "Invalid dai type %d\n",
+			dai_drv->dobj.type);
+		return -EINVAL;
+	}
+
+	lockdep_assert_held(&client_mutex);
+	dai = soc_add_dai(component, dai_drv, false);
+	if (!dai)
+		return -ENOMEM;
+
+	/* Create the DAI widgets here. After adding DAIs, topology may
+	 * also add routes that need these widgets as source or sink.
+	 */
+	ret = snd_soc_dapm_new_dai_widgets(dapm, dai);
+	if (ret != 0) {
+		dev_err(component->dev,
+			"Failed to create DAI widgets %d\n", ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_dai);
+
 static void snd_soc_component_seq_notifier(struct snd_soc_dapm_context *dapm,
 	enum snd_soc_dapm_type type, int subseq)
 {
-- 
2.7.0.rc3
