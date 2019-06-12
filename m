From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/15] ASoC: SOF: Intel: hda: use the SOF
	defined ppcap functions
Date: Wed, 12 Jun 2019 12:23:42 -0500
Message-ID: <20190612172347.22338-11-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E7DEF89734
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:24:00 +0200 (CEST)
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

Unify ppcap function setup by using SOF common functions
for both HDA and non-HDA cases.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index c6eea3079ab7..883134d535b3 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -307,18 +307,14 @@ static int hda_suspend(struct snd_sof_dev *sdev, int state)
 		return ret;
 	}
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* disable ppcap interrupt */
-	snd_hdac_ext_bus_ppcap_int_enable(bus, false);
-	snd_hdac_ext_bus_ppcap_enable(bus, false);
+	hda_dsp_ctrl_ppcap_enable(sdev, false);
+	hda_dsp_ctrl_ppcap_int_enable(sdev, false);
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* disable hda bus irq and i/o */
 	snd_hdac_bus_stop_chip(bus);
 #else
-	/* disable ppcap interrupt */
-	hda_dsp_ctrl_ppcap_enable(sdev, false);
-	hda_dsp_ctrl_ppcap_int_enable(sdev, false);
-
 	/* disable hda bus irq */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
@@ -370,10 +366,6 @@ static int hda_resume(struct snd_sof_dev *sdev)
 		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
-
-	/* enable ppcap interrupt */
-	snd_hdac_ext_bus_ppcap_enable(bus, true);
-	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
 #else
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, false);
@@ -400,11 +392,11 @@ static int hda_resume(struct snd_sof_dev *sdev)
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN);
 
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+#endif
 
 	/* enable ppcap interrupt */
 	hda_dsp_ctrl_ppcap_enable(sdev, true);
 	hda_dsp_ctrl_ppcap_int_enable(sdev, true);
-#endif
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* turn off the links that were off before suspend */
-- 
2.20.1
