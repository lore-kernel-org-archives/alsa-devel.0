From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Fix dma-unsafe read of
	scratch registers
Date: Mon, 12 Nov 2018 13:36:38 +0000
Message-ID: <20181112133639.13444-1-rf@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A69DF267A8F
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 14:36:43 +0100 (CET)
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Stack memory isn't DMA-safe so it isn't safe to use either
regmap_raw_read or regmap_bulk_read to read into stack memory.

The two functions to read the scratch registers were using
stack memory and regmap_raw_read. It's not worth allocating
memory just for this trivial read, and it isn't time-critical.
A simple regmap_read for each register is sufficient.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a53dc174bbf0..66501b8dc46f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -765,38 +765,41 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 
 static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
 {
-	u16 scratch[4];
+	unsigned int scratch[4];
+	unsigned int addr = dsp->base + ADSP2_SCRATCH0;
+	unsigned int i;
 	int ret;
 
-	ret = regmap_raw_read(dsp->regmap, dsp->base + ADSP2_SCRATCH0,
-				scratch, sizeof(scratch));
-	if (ret) {
-		adsp_err(dsp, "Failed to read SCRATCH regs: %d\n", ret);
-		return;
+	for (i = 0; i < ARRAY_SIZE(scratch); ++i) {
+		ret = regmap_read(dsp->regmap, addr + i, &scratch[i]);
+		if (ret) {
+			adsp_err(dsp, "Failed to read SCRATCH%u: %d\n", i, ret);
+			return;
+		}
 	}
 
 	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
-		 be16_to_cpu(scratch[0]),
-		 be16_to_cpu(scratch[1]),
-		 be16_to_cpu(scratch[2]),
-		 be16_to_cpu(scratch[3]));
+		 scratch[0], scratch[1], scratch[2], scratch[3]);
 }
 
 static void wm_adsp2v2_show_fw_status(struct wm_adsp *dsp)
 {
-	u32 scratch[2];
+	unsigned int scratch[2];
 	int ret;
 
-	ret = regmap_raw_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH0_1,
-			      scratch, sizeof(scratch));
-
+	ret = regmap_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH0_1,
+			  &scratch[0]);
 	if (ret) {
-		adsp_err(dsp, "Failed to read SCRATCH regs: %d\n", ret);
+		adsp_err(dsp, "Failed to read SCRATCH0_1: %d\n", ret);
 		return;
 	}
 
-	scratch[0] = be32_to_cpu(scratch[0]);
-	scratch[1] = be32_to_cpu(scratch[1]);
+	ret = regmap_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH2_3,
+			  &scratch[1]);
+	if (ret) {
+		adsp_err(dsp, "Failed to read SCRATCH2_3: %d\n", ret);
+		return;
+	}
 
 	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
 		 scratch[0] & 0xFFFF,
-- 
2.11.0
