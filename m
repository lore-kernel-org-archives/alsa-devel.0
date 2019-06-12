From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/15] ASoC: SOF: Intel: hda: clear stream
	status and wakests properly
Date: Wed, 12 Jun 2019 12:23:45 -0500
Message-ID: <20190612172347.22338-14-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CB15F896EA
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:24:02 +0200 (CEST)
In-Reply-To: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Stream status and WAKESTS registers need to be cleared by writing
to them with snd_sof_dsp_write(). snd_sof_dsp_update_bits() only
writes if the value is changed and will result in not clearing
the status.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-ctrl.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index 688ab8d895a9..ea63f83a509b 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -217,17 +217,14 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 	/* clear stream status */
 	list_for_each_entry(stream, &bus->stream_list, list) {
 		sd_offset = SOF_STREAM_SD_OFFSET(stream);
-		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
-					sd_offset +
-					SOF_HDA_ADSP_REG_CL_SD_STS,
-					SOF_HDA_CL_DMA_SD_INT_MASK,
-					SOF_HDA_CL_DMA_SD_INT_MASK);
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
+				  sd_offset + SOF_HDA_ADSP_REG_CL_SD_STS,
+				  SOF_HDA_CL_DMA_SD_INT_MASK);
 	}
 
 	/* clear WAKESTS */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
-				SOF_HDA_WAKESTS_INT_MASK,
-				SOF_HDA_WAKESTS_INT_MASK);
+	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
+			  SOF_HDA_WAKESTS_INT_MASK);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* clear rirb status */
@@ -295,17 +292,14 @@ void hda_dsp_ctrl_stop_chip(struct snd_sof_dev *sdev)
 	/* clear stream status */
 	list_for_each_entry(stream, &bus->stream_list, list) {
 		sd_offset = SOF_STREAM_SD_OFFSET(stream);
-		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
-					sd_offset +
-					SOF_HDA_ADSP_REG_CL_SD_STS,
-					SOF_HDA_CL_DMA_SD_INT_MASK,
-					SOF_HDA_CL_DMA_SD_INT_MASK);
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
+				  sd_offset + SOF_HDA_ADSP_REG_CL_SD_STS,
+				  SOF_HDA_CL_DMA_SD_INT_MASK);
 	}
 
 	/* clear WAKESTS */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
-				SOF_HDA_WAKESTS_INT_MASK,
-				SOF_HDA_WAKESTS_INT_MASK);
+	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
+			  SOF_HDA_WAKESTS_INT_MASK);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* clear rirb status */
-- 
2.20.1
