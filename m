From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/6] ASoC: SOF: Introduce
	snd_sof_dsp_get_mailbox_offset
Date: Wed,  7 Aug 2019 10:01:59 -0500
Message-ID: <20190807150203.26359-3-pierre-louis.bossart@linux.intel.com>
References: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8184DF80483
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 17:02:29 +0200 (CEST)
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

This will allow us to export mailbox offset in order to
read the fw_ready message from.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.h      | 9 +++++++++
 sound/soc/sof/sof-priv.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 793c1aea0c53..c820606f19a1 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -119,6 +119,15 @@ static inline int snd_sof_dsp_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 	return sdev->mmio_bar;
 }
 
+static inline int snd_sof_dsp_get_mailbox_offset(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->get_mailbox_offset)
+		return sof_ops(sdev)->get_mailbox_offset(sdev);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
 /* power management */
 static inline int snd_sof_dsp_resume(struct snd_sof_dev *sdev)
 {
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 1cec3f23f9cd..3aefb8ec3ef9 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -198,6 +198,8 @@ struct snd_sof_dsp_ops {
 	/* misc */
 	int (*get_bar_index)(struct snd_sof_dev *sdev,
 			     u32 type); /* optional */
+	int (*get_mailbox_offset)(struct snd_sof_dev *sdev);/* mandatory for common loader code */
+
 	/* DAI ops */
 	struct snd_soc_dai_driver *drv;
 	int num_drv;
-- 
2.20.1
