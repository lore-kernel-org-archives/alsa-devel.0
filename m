From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: topology: Add Kconfig option for topology
Date: Sat, 15 Aug 2015 09:00:27 -0700
Message-ID: <1439654427-26109-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A1F8D26510A
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 18:01:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, mengdong.lin@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Allow the topology code to be compiled out so that users who don't need
topology don't need to havve the code compiled in, saving them some
memory.

Some more configuration could be added to remove some of the hooks into
the core data structures but that is probably best done with some
refactoring to use functions to do the updates of the data structures
rather than ifdefing in the code as we'd need to do at the minute.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h | 12 ++++++++++++
 sound/soc/Kconfig            |  3 +++
 sound/soc/Makefile           |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 865a141..427bc41 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -141,6 +141,8 @@ struct snd_soc_tplg_ops {
 	int io_ops_count;
 };
 
+#ifdef CONFIG_SND_SOC_TOPOLOGY
+
 /* gets a pointer to data from the firmware block header */
 static inline const void *snd_soc_tplg_get_data(struct snd_soc_tplg_hdr *hdr)
 {
@@ -165,4 +167,14 @@ int snd_soc_tplg_widget_bind_event(struct snd_soc_dapm_widget *w,
 	const struct snd_soc_tplg_widget_events *events, int num_events,
 	u16 event_type);
 
+#else
+
+static inline int snd_soc_tplg_component_remove(struct snd_soc_component *comp,
+						u32 index)
+{
+	return 0;
+}
+
+#endif
+
 #endif
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 467ee1a..225bfda 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -30,6 +30,9 @@ config SND_SOC_GENERIC_DMAENGINE_PCM
 	bool
 	select SND_DMAENGINE_PCM
 
+config SND_SOC_TOPOLOGY
+	bool
+
 # All the supported SoCs
 source "sound/soc/adi/Kconfig"
 source "sound/soc/atmel/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 19fd711..134aca1 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,6 +1,9 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
 snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o soc-devres.o soc-ops.o
+
+ifneq ($(CONFIG_SND_SOC_TOPOLOGY),)
 snd-soc-core-objs += soc-topology.o
+endif
 
 ifneq ($(CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM),)
 snd-soc-core-objs += soc-generic-dmaengine-pcm.o
-- 
2.5.0
