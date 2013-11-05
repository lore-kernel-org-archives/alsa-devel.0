From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/31] ASoC: wm_adsp: Fix BUG_ON() and
	WARN_ON() usages
Date: Tue,  5 Nov 2013 18:40:00 +0100
Message-ID: <1383673218-18405-14-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FAA22651FC
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Also, the driver triggers BUG_ON() in the caller side, which can be
reduced easily by putting an assert in the callee side.

This patch does:
- Move the sanity check with WARN_ON() in wm_adsp_region_to_reg() and
  remove the checks in the callers,
- Fix wrong WARN_ON() usages, replaced with WARN(),
- Fix unreachable or wrong BUG_ON() usages and replace with WARN_ON().

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm_adsp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 53b6033658a6..83c255815a2f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -341,6 +341,8 @@ static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
 static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *region,
 					  unsigned int offset)
 {
+	if (WARN_ON(!region))
+		return offset;
 	switch (region->type) {
 	case WMFW_ADSP1_PM:
 		return region->base + (offset * 3);
@@ -353,7 +355,7 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *region,
 	case WMFW_ADSP1_ZM:
 		return region->base + (offset * 2);
 	default:
-		WARN_ON(NULL != "Unknown memory region type");
+		WARN(1, "Unknown memory region type");
 		return offset;
 	}
 }
@@ -605,7 +607,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		break;
 
 	default:
-		BUG_ON(NULL == "Unknown DSP type");
+		WARN(1, "Unknown DSP type");
 		goto out_fw;
 	}
 
@@ -645,27 +647,22 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 			reg = offset;
 			break;
 		case WMFW_ADSP1_PM:
-			BUG_ON(!mem);
 			region_name = "PM";
 			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		case WMFW_ADSP1_DM:
-			BUG_ON(!mem);
 			region_name = "DM";
 			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		case WMFW_ADSP2_XM:
-			BUG_ON(!mem);
 			region_name = "XM";
 			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		case WMFW_ADSP2_YM:
-			BUG_ON(!mem);
 			region_name = "YM";
 			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		case WMFW_ADSP1_ZM:
-			BUG_ON(!mem);
 			region_name = "ZM";
 			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
@@ -905,10 +902,8 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 		break;
 	}
 
-	if (mem == NULL) {
-		BUG_ON(mem != NULL);
+	if (WARN_ON(!mem))
 		return -EINVAL;
-	}
 
 	switch (dsp->type) {
 	case WMFW_ADSP1:
@@ -1002,7 +997,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 		break;
 
 	default:
-		BUG_ON(NULL == "Unknown DSP type");
+		WARN(1, "Unknown DSP type");
 		return -EINVAL;
 	}
 
-- 
1.8.4.2
