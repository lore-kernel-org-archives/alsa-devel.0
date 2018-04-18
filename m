From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Wed, 18 Apr 2018 16:29:01 +0530
Message-ID: <1524049146-8725-9-git-send-email-vinod.koul@intel.com>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E49D2676AD
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 12:54:59 +0200 (CEST)
In-Reply-To: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
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
 include/sound/soc-dai.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 8ad11669e4d8..e654427b6885 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -170,6 +170,8 @@ struct snd_soc_dai_ops {
 		unsigned int rx_num, unsigned int *rx_slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
+	int (*set_sdw_stream)(struct snd_soc_dai *dai,
+			void *stream, int direction);
 	/*
 	 * DAI digital mute - optional.
 	 * Called by soc-core to minimise any pops.
@@ -358,4 +360,25 @@ static inline void *snd_soc_dai_get_drvdata(struct snd_soc_dai *dai)
 	return dev_get_drvdata(dai->dev);
 }
 
+/**
+ * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
+ * @dai: DAI
+ * @stream: STREAM
+ * @direction: Stream direction(Playback/Capture)
+ * SoundWire subsystem doesn't have a notion of direction and we reuse
+ * the ASoC stream direction to configure sink/source ports.
+ * Playback maps to source on the TX and sink on Rx. Vice-versa for Capture.
+ *
+ * This should be invoked with NULL to clear the stream set previously.
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
+				void *stream, int direction)
+{
+	if (dai->driver->ops->set_sdw_stream)
+		return dai->driver->ops->set_sdw_stream(dai, stream, direction);
+	else
+		return -ENOTSUPP;
+}
+
 #endif
-- 
2.7.4
