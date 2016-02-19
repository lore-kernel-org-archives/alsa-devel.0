From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm_adsp:
	wm_coeff_{read|write}_control should use passed length
Date: Fri, 19 Feb 2016 14:44:44 +0000
Message-ID: <1455893084-4556-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1455893084-4556-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A9578266A9A
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 15:44:44 +0100 (CET)
In-Reply-To: <1455893084-4556-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

wm_coeff_{read|write}_control were using the control length rather than
the length parameter passed to them. This is not causing any issues as
the two values are currently always the same, but this needs fixed to
allow future improvements.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1c6d5fb..6d9552a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -741,19 +741,19 @@ static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 	reg = ctl->alg_region.base + ctl->offset;
 	reg = wm_adsp_region_to_reg(mem, reg);
 
-	scratch = kmemdup(buf, ctl->len, GFP_KERNEL | GFP_DMA);
+	scratch = kmemdup(buf, len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
 		return -ENOMEM;
 
 	ret = regmap_raw_write(dsp->regmap, reg, scratch,
-			       ctl->len);
+			       len);
 	if (ret) {
 		adsp_err(dsp, "Failed to write %zu bytes to %x: %d\n",
-			 ctl->len, reg, ret);
+			 len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
-	adsp_dbg(dsp, "Wrote %zu bytes to %x\n", ctl->len, reg);
+	adsp_dbg(dsp, "Wrote %zu bytes to %x\n", len, reg);
 
 	kfree(scratch);
 
@@ -800,20 +800,20 @@ static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 	reg = ctl->alg_region.base + ctl->offset;
 	reg = wm_adsp_region_to_reg(mem, reg);
 
-	scratch = kmalloc(ctl->len, GFP_KERNEL | GFP_DMA);
+	scratch = kmalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
 		return -ENOMEM;
 
-	ret = regmap_raw_read(dsp->regmap, reg, scratch, ctl->len);
+	ret = regmap_raw_read(dsp->regmap, reg, scratch, len);
 	if (ret) {
 		adsp_err(dsp, "Failed to read %zu bytes from %x: %d\n",
 			 ctl->len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
-	adsp_dbg(dsp, "Read %zu bytes from %x\n", ctl->len, reg);
+	adsp_dbg(dsp, "Read %zu bytes from %x\n", len, reg);
 
-	memcpy(buf, scratch, ctl->len);
+	memcpy(buf, scratch, len);
 	kfree(scratch);
 
 	return 0;
-- 
2.1.4
