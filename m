From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: wm2200: Add names for ranges
Date: Fri,  5 Oct 2012 19:55:36 +0100
Message-ID: <1349463336-10871-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7FE862650CA
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 20:55:43 +0200 (CEST)
In-Reply-To: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm2200.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 06d4e61..b63391a 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -109,48 +109,42 @@ struct wm2200_priv {
 #define WM2200_DSP2_ZM_BASE (WM2200_DSP_RANGE_BASE + (5 * WM2200_DSP_SPACING))
 
 static const struct regmap_range_cfg wm2200_ranges[] = {
-	/* DSP1 DM */
-	{ .range_min = WM2200_DSP1_DM_BASE,
+	{ .name = "DSP1DM", .range_min = WM2200_DSP1_DM_BASE,
 	  .range_max = WM2200_DSP1_DM_BASE + 12287,
 	  .selector_reg = WM2200_DSP1_CONTROL_3,
 	  .selector_mask = WM2200_DSP1_PAGE_BASE_DM_0_MASK,
 	  .selector_shift = WM2200_DSP1_PAGE_BASE_DM_0_SHIFT,
 	  .window_start = WM2200_DSP1_DM_0, .window_len = 2048, },
 
-	/* DSP1 PM */
-	{ .range_min = WM2200_DSP1_PM_BASE,
+	{ .name = "DSP1PM", .range_min = WM2200_DSP1_PM_BASE,
 	  .range_max = WM2200_DSP1_PM_BASE + 12287,
 	  .selector_reg = WM2200_DSP1_CONTROL_2,
 	  .selector_mask = WM2200_DSP1_PAGE_BASE_PM_0_MASK,
 	  .selector_shift = WM2200_DSP1_PAGE_BASE_PM_0_SHIFT,
 	  .window_start = WM2200_DSP1_PM_0, .window_len = 768, },
 
-	/* DSP1 ZM */
-	{ .range_min = WM2200_DSP1_ZM_BASE,
+	{ .name = "DSP1ZM", .range_min = WM2200_DSP1_ZM_BASE,
 	  .range_max = WM2200_DSP1_ZM_BASE + 2047,
 	  .selector_reg = WM2200_DSP1_CONTROL_4,
 	  .selector_mask = WM2200_DSP1_PAGE_BASE_ZM_0_MASK,
 	  .selector_shift = WM2200_DSP1_PAGE_BASE_ZM_0_SHIFT,
 	  .window_start = WM2200_DSP1_ZM_0, .window_len = 1024, },
 
-	/* DSP2 DM */
-	{ .range_min = WM2200_DSP2_DM_BASE,
+	{ .name = "DSP2DM", .range_min = WM2200_DSP2_DM_BASE,
 	  .range_max = WM2200_DSP2_DM_BASE + 4095,
 	  .selector_reg = WM2200_DSP2_CONTROL_3,
 	  .selector_mask = WM2200_DSP2_PAGE_BASE_DM_0_MASK,
 	  .selector_shift = WM2200_DSP2_PAGE_BASE_DM_0_SHIFT,
 	  .window_start = WM2200_DSP2_DM_0, .window_len = 2048, },
 
-	/* DSP2 PM */
-	{ .range_min = WM2200_DSP2_PM_BASE,
+	{ .name = "DSP2PM", .range_min = WM2200_DSP2_PM_BASE,
 	  .range_max = WM2200_DSP2_PM_BASE + 11287,
 	  .selector_reg = WM2200_DSP2_CONTROL_2,
 	  .selector_mask = WM2200_DSP2_PAGE_BASE_PM_0_MASK,
 	  .selector_shift = WM2200_DSP2_PAGE_BASE_PM_0_SHIFT,
 	  .window_start = WM2200_DSP2_PM_0, .window_len = 768, },
 
-	/* DSP2 ZM */
-	{ .range_min = WM2200_DSP2_ZM_BASE,
+	{ .name = "DSP2ZM", .range_min = WM2200_DSP2_ZM_BASE,
 	  .range_max = WM2200_DSP2_ZM_BASE + 2047,
 	  .selector_reg = WM2200_DSP2_CONTROL_4,
 	  .selector_mask = WM2200_DSP2_PAGE_BASE_ZM_0_MASK,
-- 
1.7.10.4
