From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Disable DMAs before clearing
	the transfer length
Date: Wed, 22 Jun 2016 15:31:03 +0100
Message-ID: <1466605863-812-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CC80267106
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 16:30:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, simont@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Simon Trimmer <simont@opensource.wolfsonmicro.com>

This patch reorders the clearing of the DMA masks to avoid potential
artefacts being introduced.

Signed-off-by: Simon Trimmer <simont@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 430bb8b..21fbe7d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2368,13 +2368,15 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		dsp->running = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				   ADSP2_SYS_ENA | ADSP2_CORE_ENA |
-				   ADSP2_START, 0);
+				   ADSP2_CORE_ENA | ADSP2_START, 0);
 
 		/* Make sure DMAs are quiesced */
+		regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
 		regmap_write(dsp->regmap, dsp->base + ADSP2_WDMA_CONFIG_1, 0);
 		regmap_write(dsp->regmap, dsp->base + ADSP2_WDMA_CONFIG_2, 0);
-		regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
+
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				   ADSP2_SYS_ENA, 0);
 
 		list_for_each_entry(ctl, &dsp->ctl_list, list)
 			ctl->enabled = 0;
-- 
2.1.4
