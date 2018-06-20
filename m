From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Simplify handling of alg
	offset and length
Date: Wed, 20 Jun 2018 11:56:21 +0100
Message-ID: <20180620105621.2660-2-ckeepax@opensource.cirrus.com>
References: <20180620105621.2660-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DC32676BC
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 12:56:24 +0200 (CEST)
In-Reply-To: <20180620105621.2660-1-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The current code that reads the algorithm list from the DSP is
somewhat unclear, it converts directly from bytes to registers using
a hard coded divide by 2. Most offsets are usually handled in DSP
words within the driver and there is a function specifically for
converting from words to register addresses. So update the handling
to use these. This also removes the assumption that the registers
are 16-bit word addressed, which will no longer be true on some of
our newer parts.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 2fcdd84021a5..07c17acc8a4f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1871,9 +1871,11 @@ static void wm_adsp_ctl_fixup_base(struct wm_adsp *dsp,
 }
 
 static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
+			       const struct wm_adsp_region *mem,
 			       unsigned int pos, unsigned int len)
 {
 	void *alg;
+	unsigned int reg;
 	int ret;
 	__be32 val;
 
@@ -1888,7 +1890,9 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	}
 
 	/* Read the terminator first to validate the length */
-	ret = regmap_raw_read(dsp->regmap, pos + len, &val, sizeof(val));
+	reg = wm_adsp_region_to_reg(mem, pos + len);
+
+	ret = regmap_raw_read(dsp->regmap, reg, &val, sizeof(val));
 	if (ret != 0) {
 		adsp_err(dsp, "Failed to read algorithm list end: %d\n",
 			ret);
@@ -1897,13 +1901,18 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 
 	if (be32_to_cpu(val) != 0xbedead)
 		adsp_warn(dsp, "Algorithm list end %x 0x%x != 0xbedead\n",
-			  pos + len, be32_to_cpu(val));
+			  reg, be32_to_cpu(val));
+
+	/* Convert length from DSP words to bytes */
+	len *= sizeof(u32);
 
 	alg = kcalloc(len, 2, GFP_KERNEL | GFP_DMA);
 	if (!alg)
 		return ERR_PTR(-ENOMEM);
 
-	ret = regmap_raw_read(dsp->regmap, pos, alg, len * 2);
+	reg = wm_adsp_region_to_reg(mem, pos);
+
+	ret = regmap_raw_read(dsp->regmap, reg, alg, len);
 	if (ret != 0) {
 		adsp_err(dsp, "Failed to read algorithm list: %d\n", ret);
 		kfree(alg);
@@ -2002,10 +2011,11 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 	if (IS_ERR(alg_region))
 		return PTR_ERR(alg_region);
 
-	pos = sizeof(adsp1_id) / 2;
-	len = (sizeof(*adsp1_alg) * n_algs) / 2;
+	/* Calculate offset and length in DSP words */
+	pos = sizeof(adsp1_id) / sizeof(u32);
+	len = (sizeof(*adsp1_alg) * n_algs) / sizeof(u32);
 
-	adsp1_alg = wm_adsp_read_algs(dsp, n_algs, mem->base + pos, len);
+	adsp1_alg = wm_adsp_read_algs(dsp, n_algs, mem, pos, len);
 	if (IS_ERR(adsp1_alg))
 		return PTR_ERR(adsp1_alg);
 
@@ -2113,10 +2123,11 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 	if (IS_ERR(alg_region))
 		return PTR_ERR(alg_region);
 
-	pos = sizeof(adsp2_id) / 2;
-	len = (sizeof(*adsp2_alg) * n_algs) / 2;
+	/* Calculate offset and length in DSP words */
+	pos = sizeof(adsp2_id) / sizeof(u32);
+	len = (sizeof(*adsp2_alg) * n_algs) / sizeof(u32);
 
-	adsp2_alg = wm_adsp_read_algs(dsp, n_algs, mem->base + pos, len);
+	adsp2_alg = wm_adsp_read_algs(dsp, n_algs, mem, pos, len);
 	if (IS_ERR(adsp2_alg))
 		return PTR_ERR(adsp2_alg);
 
-- 
2.11.0
