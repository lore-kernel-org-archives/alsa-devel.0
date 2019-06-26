From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 1/3] ASoC: SOF: Intel: hda: reduce ifdef usage
	for hda
Date: Wed, 26 Jun 2019 13:22:27 -0700
Message-ID: <20190626202229.16312-2-ranjani.sridharan@linux.intel.com>
References: <20190626202229.16312-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08C51F896B7
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 22:22:32 +0200 (CEST)
In-Reply-To: <20190626202229.16312-1-ranjani.sridharan@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rander Wang <rander.wang@linux.intel.com>

Move the code for hda to one point

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index f2c5a12db930..481cfa0b225e 100644
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
2.17.1
