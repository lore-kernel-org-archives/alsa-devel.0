From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 18/19] ASoC: SOF: Intel: APL: add ipc dump
	function
Date: Tue, 30 Apr 2019 18:09:33 -0500
Message-ID: <20190430230934.4321-19-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 554CAF89732
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:08 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pan Xiuli <xiuli.pan@linux.intel.com>

Add IPC dump function for APL plaform

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/apl.c |  1 +
 sound/soc/sof/intel/hda.c | 18 ++++++++++++++++++
 sound/soc/sof/intel/hda.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index d1fb2f2ba1e1..f215d80dce2c 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -55,6 +55,7 @@ const struct snd_sof_dsp_ops sof_apl_ops = {
 	.debug_map	= apl_dsp_debugfs,
 	.debug_map_count	= ARRAY_SIZE(apl_dsp_debugfs),
 	.dbg_dump	= hda_dsp_dump,
+	.ipc_dump	= hda_ipc_dump,
 
 	/* stream callbacks */
 	.pcm_open	= hda_dsp_pcm_open,
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index b8fc19790f3b..c7d419d340c8 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -179,6 +179,24 @@ void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags)
 	}
 }
 
+void hda_ipc_dump(struct snd_sof_dev *sdev)
+{
+	u32 hipcie;
+	u32 hipct;
+	u32 hipcctl;
+
+	/* read IPC status */
+	hipcie = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCIE);
+	hipct = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCT);
+	hipcctl = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCCTL);
+
+	/* dump the IPC regs */
+	/* TODO: parse the raw msg */
+	dev_err(sdev->dev,
+		"error: host status 0x%8.8x dsp status 0x%8.8x mask 0x%8.8x\n",
+		hipcie, hipct, hipcctl);
+}
+
 static int hda_init(struct snd_sof_dev *sdev)
 {
 	struct hda_bus *hbus;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 4b00e5d88565..92d45c43b4b1 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -447,6 +447,7 @@ int hda_dsp_runtime_resume(struct snd_sof_dev *sdev);
 void hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev);
 void hda_dsp_dump_skl(struct snd_sof_dev *sdev, u32 flags);
 void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags);
+void hda_ipc_dump(struct snd_sof_dev *sdev);
 
 /*
  * DSP PCM Operations.
-- 
2.17.1
