From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 06/21] ASoC: SOF: Introduce
	snd_sof_dsp_get_bar_index ops
Date: Mon, 22 Jul 2019 09:13:47 -0500
Message-ID: <20190722141402.7194-7-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6C7AF80482
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:16 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Baluta <daniel.baluta@nxp.com>

FW encapsulates information about section types (e.g DRAM, IRAM)
inside module block header. This information can be used in order
to correctly load the section to the appropriate place in memory.

SOF Linux driver needs to know for each platform how to map the
section type with the corresponding memory BAR. So, this patch
introduces get_bar_index, a new operation inside snd_sof_dsp_ops.

Intel platforms, usually load all the section in a contiguous memory
area (usually denoted by sdev->mmio_bar) so things are relatively
simple there. Anyhow, on i.MX8 IRAM and DRAM for example are mapped
to distinct BARs.

By default, if no get_bar function is provided the core implementation
will always return sdev->mmio_bar so that there will be no need for
a change to existing Intel code.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.h      | 19 +++++++++++++++++++
 sound/soc/sof/sof-priv.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index b9bdf45889da..ee87053953ff 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -100,6 +100,25 @@ static inline int snd_sof_dsp_post_fw_run(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+/* misc */
+
+/**
+ * snd_sof_dsp_get_bar_index - Maps a section type with a BAR index
+ *
+ * @sdev: sof device
+ * @type: section type as described by snd_sof_fw_blk_type
+ *
+ * Returns the corresponding BAR index (a positive integer) or -EINVAL
+ * in case there is no mapping
+ */
+static inline int snd_sof_dsp_get_bar_index(struct snd_sof_dev *sdev, u32 type)
+{
+	if (sof_ops(sdev)->get_bar_index)
+		return sof_ops(sdev)->get_bar_index(sdev, type);
+
+	return sdev->mmio_bar;
+}
+
 /* power management */
 static inline int snd_sof_dsp_resume(struct snd_sof_dev *sdev)
 {
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index fa5cb7d2a660..a6ec9115a9fb 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -196,6 +196,9 @@ struct snd_sof_dsp_ops {
 	int (*trace_trigger)(struct snd_sof_dev *sdev,
 			     int cmd); /* optional */
 
+	/* misc */
+	int (*get_bar_index)(struct snd_sof_dev *sdev,
+			     u32 type); /* optional */
 	/* DAI ops */
 	struct snd_soc_dai_driver *drv;
 	int num_drv;
-- 
2.20.1
