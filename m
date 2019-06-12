From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/15] ASoC: SOF: Intel: hda: add function for
	hda stop chip
Date: Wed, 12 Jun 2019 12:23:43 -0500
Message-ID: <20190612172347.22338-12-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86A2BF89735
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
Cc: tiwai@suse.de, broonie@kernel.org, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>

Add common hda_dsp_ctrl_stop_chip() function to stop controller with
the same function handling both HDA and non-HDA cases. This function
disables IRQs and clears status masks. When CONFIG_SND_SOC_SOF_HDA
is defined, also disables the CORB/RIRB, and stops i/o.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-ctrl.c | 67 ++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h      |  2 +-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index 07bc123112c9..688ab8d895a9 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -263,3 +263,70 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 
 	return ret;
 }
+
+void hda_dsp_ctrl_stop_chip(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct hdac_stream *stream;
+	int sd_offset;
+
+	if (!bus->chip_init)
+		return;
+
+	/* disable interrupts in stream descriptor */
+	list_for_each_entry(stream, &bus->stream_list, list) {
+		sd_offset = SOF_STREAM_SD_OFFSET(stream);
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
+					sd_offset +
+					SOF_HDA_ADSP_REG_CL_SD_CTL,
+					SOF_HDA_CL_DMA_SD_INT_MASK,
+					0);
+	}
+
+	/* disable SIE for all streams */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
+				SOF_HDA_INT_ALL_STREAM,	0);
+
+	/* disable controller CIE and GIE */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
+				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
+				0);
+
+	/* clear stream status */
+	list_for_each_entry(stream, &bus->stream_list, list) {
+		sd_offset = SOF_STREAM_SD_OFFSET(stream);
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
+					sd_offset +
+					SOF_HDA_ADSP_REG_CL_SD_STS,
+					SOF_HDA_CL_DMA_SD_INT_MASK,
+					SOF_HDA_CL_DMA_SD_INT_MASK);
+	}
+
+	/* clear WAKESTS */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
+				SOF_HDA_WAKESTS_INT_MASK,
+				SOF_HDA_WAKESTS_INT_MASK);
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* clear rirb status */
+	snd_hdac_chip_writeb(bus, RIRBSTS, RIRB_INT_MASK);
+#endif
+
+	/* clear interrupt status register */
+	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTSTS,
+			  SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_ALL_STREAM);
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* disable CORB/RIRB */
+	snd_hdac_bus_stop_cmd_io(bus);
+#endif
+	/* disable position buffer */
+	if (bus->posbuf.addr) {
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
+				  SOF_HDA_ADSP_DPLBASE, 0);
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
+				  SOF_HDA_ADSP_DPUBASE, 0);
+	}
+
+	bus->chip_init = false;
+}
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 8812dae9cf7a..50653859e0a0 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -538,7 +538,7 @@ int hda_dsp_ctrl_link_reset(struct snd_sof_dev *sdev, bool reset);
 void hda_dsp_ctrl_misc_clock_gating(struct snd_sof_dev *sdev, bool enable);
 int hda_dsp_ctrl_clock_power_gating(struct snd_sof_dev *sdev, bool enable);
 int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset);
-
+void hda_dsp_ctrl_stop_chip(struct snd_sof_dev *sdev);
 /*
  * HDA bus operations.
  */
-- 
2.20.1
