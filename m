From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/21] ASoC: SOF: Intel: hda: reduce ifdef
	usage for hda
Date: Mon, 22 Jul 2019 09:13:52 -0500
Message-ID: <20190722141402.7194-12-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3597F80483
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:19 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Rander Wang <rander.wang@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rander Wang <rander.wang@linux.intel.com>

Move the code for hda to one point

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 4315896b3f07..3d711d354fb9 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -359,6 +359,16 @@ static int hda_resume(struct snd_sof_dev *sdev)
 		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+
+	/* turn off the links that were off before suspend */
+	list_for_each_entry(hlink, &bus->hlink_list, list) {
+		if (!hlink->ref_count)
+			snd_hdac_ext_bus_link_power_down(hlink);
+	}
+
+	/* check dma status and clean up CORB/RIRB buffers */
+	if (!bus->cmd_dma_state)
+		snd_hdac_bus_stop_cmd_io(bus);
 #else
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, false);
@@ -391,18 +401,6 @@ static int hda_resume(struct snd_sof_dev *sdev)
 	hda_dsp_ctrl_ppcap_enable(sdev, true);
 	hda_dsp_ctrl_ppcap_int_enable(sdev, true);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* turn off the links that were off before suspend */
-	list_for_each_entry(hlink, &bus->hlink_list, list) {
-		if (!hlink->ref_count)
-			snd_hdac_ext_bus_link_power_down(hlink);
-	}
-
-	/* check dma status and clean up CORB/RIRB buffers */
-	if (!bus->cmd_dma_state)
-		snd_hdac_bus_stop_cmd_io(bus);
-#endif
-
 	return 0;
 }
 
-- 
2.20.1
