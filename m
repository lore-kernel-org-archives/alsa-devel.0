From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/6] ASoC: SOF: Introduce
	snd_sof_dsp_get_window_offset
Date: Wed,  7 Aug 2019 10:02:00 -0500
Message-ID: <20190807150203.26359-4-pierre-louis.bossart@linux.intel.com>
References: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1413AF804CB
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 17:02:30 +0200 (CEST)
In-Reply-To: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
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

This will allow us to export the offset for a memory window.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.h      | 9 +++++++++
 sound/soc/sof/sof-priv.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index c820606f19a1..824d36fe59fd 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -128,6 +128,15 @@ static inline int snd_sof_dsp_get_mailbox_offset(struct snd_sof_dev *sdev)
 	return -ENOTSUPP;
 }
 
+static inline int snd_sof_dsp_get_window_offset(struct snd_sof_dev *sdev,
+						u32 id)
+{
+	if (sof_ops(sdev)->get_window_offset)
+		return sof_ops(sdev)->get_window_offset(sdev, id);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
 /* power management */
 static inline int snd_sof_dsp_resume(struct snd_sof_dev *sdev)
 {
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 3aefb8ec3ef9..de11f28bae3a 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -199,6 +199,8 @@ struct snd_sof_dsp_ops {
 	int (*get_bar_index)(struct snd_sof_dev *sdev,
 			     u32 type); /* optional */
 	int (*get_mailbox_offset)(struct snd_sof_dev *sdev);/* mandatory for common loader code */
+	int (*get_window_offset)(struct snd_sof_dev *sdev,
+				 u32 id);/* mandatory for common loader code */
 
 	/* DAI ops */
 	struct snd_soc_dai_driver *drv;
-- 
2.20.1
