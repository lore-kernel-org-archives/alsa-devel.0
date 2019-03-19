From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 07/12] ASoC: wm_adsp: Refactor firmware status
	reading
Date: Tue, 19 Mar 2019 11:52:10 +0000
Message-ID: <20190319115215.22960-8-ckeepax@opensource.cirrus.com>
References: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D982F8968D
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 12:52:18 +0100 (CET)
In-Reply-To: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

In preparation for further additions refactor the reading of the
firmware status.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 8800ffcc4f8c0..fb252762f23ce 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -788,49 +788,42 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 	}
 }
 
-static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
+static void wm_adsp_read_fw_status(struct wm_adsp *dsp,
+				   int noffs, unsigned int *offs)
 {
-	unsigned int scratch[4];
-	unsigned int addr = dsp->base + ADSP2_SCRATCH0;
 	unsigned int i;
 	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(scratch); ++i) {
-		ret = regmap_read(dsp->regmap, addr + i, &scratch[i]);
+	for (i = 0; i < noffs; ++i) {
+		ret = regmap_read(dsp->regmap, dsp->base + offs[i], &offs[i]);
 		if (ret) {
 			adsp_err(dsp, "Failed to read SCRATCH%u: %d\n", i, ret);
 			return;
 		}
 	}
+}
+
+static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
+{
+	unsigned int offs[] = {
+		ADSP2_SCRATCH0, ADSP2_SCRATCH1, ADSP2_SCRATCH2, ADSP2_SCRATCH3,
+	};
+
+	wm_adsp_read_fw_status(dsp, ARRAY_SIZE(offs), offs);
 
 	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
-		 scratch[0], scratch[1], scratch[2], scratch[3]);
+		 offs[0], offs[1], offs[2], offs[3]);
 }
 
 static void wm_adsp2v2_show_fw_status(struct wm_adsp *dsp)
 {
-	unsigned int scratch[2];
-	int ret;
+	unsigned int offs[] = { ADSP2V2_SCRATCH0_1, ADSP2V2_SCRATCH2_3 };
 
-	ret = regmap_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH0_1,
-			  &scratch[0]);
-	if (ret) {
-		adsp_err(dsp, "Failed to read SCRATCH0_1: %d\n", ret);
-		return;
-	}
-
-	ret = regmap_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH2_3,
-			  &scratch[1]);
-	if (ret) {
-		adsp_err(dsp, "Failed to read SCRATCH2_3: %d\n", ret);
-		return;
-	}
+	wm_adsp_read_fw_status(dsp, ARRAY_SIZE(offs), offs);
 
 	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
-		 scratch[0] & 0xFFFF,
-		 scratch[0] >> 16,
-		 scratch[1] & 0xFFFF,
-		 scratch[1] >> 16);
+		 offs[0] & 0xFFFF, offs[0] >> 16,
+		 offs[1] & 0xFFFF, offs[1] >> 16);
 }
 
 static inline struct wm_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
-- 
2.11.0
