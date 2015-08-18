From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Add Kconfig option for
	topology" to the asoc tree
Date: Mon, 17 Aug 2015 23:05:14 -0700
Message-ID: <E1ZRa1K-0001Kk-AO@finisterre>
References: <1439654427-26109-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id BB404260449
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 08:05:16 +0200 (CEST)
In-Reply-To: <1439654427-26109-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Add Kconfig option for topology

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

>From 78b50f39142612d01073595d33e7cc48f03a5a2f Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Sat, 15 Aug 2015 08:24:20 -0700
Subject: [PATCH] ASoC: topology: Add Kconfig option for topology

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
index 2ae9619..1d651b8 100644
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
index e189903..669648b 100644
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
