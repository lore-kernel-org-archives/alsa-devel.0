From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 08/13] ASoC: Add SoundWire stream programming
	interface
Date: Wed, 28 Mar 2018 15:08:33 +0530
Message-ID: <1522229918-4748-9-git-send-email-vinod.koul@intel.com>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0949A266F93
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 11:34:53 +0200 (CEST)
In-Reply-To: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

SoundWire stream needs to be propagated to all the DAIs(cpu, codec).
So, add a snd_soc_dai_set_sdw_stream() API for the same.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dai.h |  5 +++++
 sound/soc/soc-core.c    | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 58acd00cae19..78fa068560cf 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -129,6 +129,9 @@ int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width);
 
+int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
+				void *stream, int direction);
+
 int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
 	unsigned int tx_num, unsigned int *tx_slot,
 	unsigned int rx_num, unsigned int *rx_slot);
@@ -168,6 +171,8 @@ struct snd_soc_dai_ops {
 		unsigned int rx_num, unsigned int *rx_slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
+	int (*set_sdw_stream)(struct snd_soc_dai *dai,
+			void *stream, int direction);
 	/*
 	 * DAI digital mute - optional.
 	 * Called by soc-core to minimise any pops.
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0edac80df34..690e56a35237 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2882,6 +2882,26 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
 
 /**
+ * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
+ * @dai: DAI
+ * @stream: STREAM
+ * @direction: Stream direction(Playback/Capture)
+ * SoundWire subsystem doesn't have a notion of direction and we reuse
+ * the ASoC stream direction to configure sink/source ports.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
+				void *stream, int direction)
+{
+	if (dai->driver->ops->set_sdw_stream)
+		return dai->driver->ops->set_sdw_stream(dai, stream, direction);
+	else
+		return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_sdw_stream);
+
+/**
  * snd_soc_dai_set_channel_map - configure DAI audio channel map
  * @dai: DAI
  * @tx_num: how many TX channels
-- 
2.7.4
