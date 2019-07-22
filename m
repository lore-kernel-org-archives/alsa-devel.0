From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/21] ASoC: SOF: Intel: hda: set position
	buffer in init chip
Date: Mon, 22 Jul 2019 09:13:54 -0500
Message-ID: <20190722141402.7194-14-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72104F8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:21 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>

Set the HDA stream position buffer during init chip. The position buffer
needs to be set in both HDA codec and nocodec cases. Using SOF defined
function and move it to common code.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-ctrl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index ea63f83a509b..015760284969 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -245,14 +245,13 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* program the position buffer */
 	if (bus->use_posbuf && bus->posbuf.addr) {
-		snd_hdac_chip_writel(bus, DPLBASE, (u32)bus->posbuf.addr);
-		snd_hdac_chip_writel(bus, DPUBASE,
-				     upper_32_bits(bus->posbuf.addr));
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_ADSP_DPLBASE,
+				  (u32)bus->posbuf.addr);
+		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_ADSP_DPUBASE,
+				  upper_32_bits(bus->posbuf.addr));
 	}
-#endif
 
 	bus->chip_init = true;
 
-- 
2.20.1
