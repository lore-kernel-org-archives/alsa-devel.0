From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Factor out calculation of
	memory base addresses
Date: Tue,  8 Jan 2013 16:59:22 +0000
Message-ID: <1357664363-16094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8AE6A26165E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 18:07:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6bff303..ed9a6c4 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -156,6 +156,26 @@ static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
 	return NULL;
 }
 
+static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *region,
+					  unsigned int offset)
+{
+	switch (region->type) {
+	case WMFW_ADSP1_PM:
+		return region->base + (offset * 3);
+	case WMFW_ADSP1_DM:
+		return region->base + (offset * 2);
+	case WMFW_ADSP2_XM:
+		return region->base + (offset * 2);
+	case WMFW_ADSP2_YM:
+		return region->base + (offset * 2);
+	case WMFW_ADSP1_ZM:
+		return region->base + (offset * 2);
+	default:
+		WARN_ON(NULL != "Unknown memory region type");
+		return offset;
+	}
+}
+
 static int wm_adsp_load(struct wm_adsp *dsp)
 {
 	const struct firmware *firmware;
@@ -283,27 +303,27 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		case WMFW_ADSP1_PM:
 			BUG_ON(!mem);
 			region_name = "PM";
-			reg = mem->base + (offset * 3);
+			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		case WMFW_ADSP1_DM:
 			BUG_ON(!mem);
 			region_name = "DM";
-			reg = mem->base + (offset * 2);
+			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		case WMFW_ADSP2_XM:
 			BUG_ON(!mem);
 			region_name = "XM";
-			reg = mem->base + (offset * 2);
+			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		case WMFW_ADSP2_YM:
 			BUG_ON(!mem);
 			region_name = "YM";
-			reg = mem->base + (offset * 2);
+			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		case WMFW_ADSP1_ZM:
 			BUG_ON(!mem);
 			region_name = "ZM";
-			reg = mem->base + (offset * 2);
+			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		default:
 			adsp_warn(dsp,
-- 
1.7.10.4
