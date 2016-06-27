From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 02/11] ASoC: Add dai_ops to set the stream tag.
Date: Mon, 27 Jun 2016 09:17:55 +0530
Message-ID: <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E73482650DA
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:33 +0200 (CEST)
In-Reply-To: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Hardik T Shah <hardik.t.shah@intel.com>

Stream tag is unique stream identifier for each HDA stream. It's
programmed in both host and codec to identify link the stream is
transported.  The platform driver allocates the stream and calls
this ops to program the stream tag in the codec dai.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dai.h | 12 ++++++++++++
 sound/soc/soc-core.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de..52e52b4 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -140,6 +140,11 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 
 int snd_soc_dai_is_dummy(struct snd_soc_dai *dai);
 
+
+/* Stream tag programming for codec and cpu dai */
+int snd_soc_dai_program_stream_tag(struct snd_soc_pcm_runtime *rtd,
+						int stream_tag);
+
 struct snd_soc_dai_ops {
 	/*
 	 * DAI clocking configuration, all optional.
@@ -175,6 +180,13 @@ struct snd_soc_dai_ops {
 	int (*mute_stream)(struct snd_soc_dai *dai, int mute, int stream);
 
 	/*
+	 * stream_tag - optional
+	 * Can be used by to program same stream tag for both cpu dai
+	 * and codec dai.
+	 */
+	int (*program_stream_tag)(struct snd_soc_dai *, int);
+
+	/*
 	 * ALSA PCM audio operations - all optional.
 	 * Called by soc-core during audio PCM operations.
 	 */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d2e62b15..b096a2f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2528,6 +2528,41 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
 
 /**
+ * snd_soc_dai_program_stream_tag - used to program same stream tag for both
+ *				cpu dai and codec dai.
+ * @rtd: The runtime for which the DAI link format should be changed
+ * @stream_tag: Stream tag to be programmed.
+ *
+ * Returns 0 on success, otherwise a negative error code.
+ */
+int snd_soc_dai_program_stream_tag(struct snd_soc_pcm_runtime *rtd,
+						int stream_tag)
+{
+	int i;
+	const struct snd_soc_dai_ops *codec_dai_ops;
+	struct snd_soc_dai *codec_dai;
+	int ret = 0;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (!codec_dai->driver)
+			continue;
+
+		codec_dai_ops = codec_dai->driver->ops;
+		if (codec_dai_ops->program_stream_tag) {
+			ret = codec_dai_ops->program_stream_tag(
+					codec_dai, stream_tag);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_program_stream_tag);
+
+/**
  * snd_soc_dai_set_channel_map - configure DAI audio channel map
  * @dai: DAI
  * @tx_num: how many TX channels
-- 
1.9.1
