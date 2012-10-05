From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: wm2200: Map DSPs into regmap
Date: Fri,  5 Oct 2012 19:55:32 +0100
Message-ID: <1349463336-10871-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C37A72650CF
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 20:55:42 +0200 (CEST)
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

Use the regmap ranges support to add the WM2200 DSP core memory pages
into the "register map" beyond the end of the real register map. We
don't extend beyond 16 bits since the regmap API will iterate over
every register doing diagnostics.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |   85 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 367d1e5..1eafaae 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -64,6 +64,66 @@ struct wm2200_priv {
 	int sysclk;
 };
 
+#define WM2200_DSP_RANGE_BASE (WM2200_MAX_REGISTER + 1)
+#define WM2200_DSP_SPACING 12288
+
+#define WM2200_DSP1_DM_BASE (WM2200_DSP_RANGE_BASE + (0 * WM2200_DSP_SPACING))
+#define WM2200_DSP1_PM_BASE (WM2200_DSP_RANGE_BASE + (1 * WM2200_DSP_SPACING))
+#define WM2200_DSP1_ZM_BASE (WM2200_DSP_RANGE_BASE + (2 * WM2200_DSP_SPACING))
+#define WM2200_DSP2_DM_BASE (WM2200_DSP_RANGE_BASE + (3 * WM2200_DSP_SPACING))
+#define WM2200_DSP2_PM_BASE (WM2200_DSP_RANGE_BASE + (4 * WM2200_DSP_SPACING))
+#define WM2200_DSP2_ZM_BASE (WM2200_DSP_RANGE_BASE + (5 * WM2200_DSP_SPACING))
+
+static const struct regmap_range_cfg wm2200_ranges[] = {
+	/* DSP1 DM */
+	{ .range_min = WM2200_DSP1_DM_BASE,
+	  .range_max = WM2200_DSP1_DM_BASE + 12287,
+	  .selector_reg = WM2200_DSP1_CONTROL_3,
+	  .selector_mask = WM2200_DSP1_PAGE_BASE_DM_0_MASK,
+	  .selector_shift = WM2200_DSP1_PAGE_BASE_DM_0_SHIFT,
+	  .window_start = WM2200_DSP1_DM_0, .window_len = 2048, },
+
+	/* DSP1 PM */
+	{ .range_min = WM2200_DSP1_PM_BASE,
+	  .range_max = WM2200_DSP1_PM_BASE + 12287,
+	  .selector_reg = WM2200_DSP1_CONTROL_2,
+	  .selector_mask = WM2200_DSP1_PAGE_BASE_PM_0_MASK,
+	  .selector_shift = WM2200_DSP1_PAGE_BASE_PM_0_SHIFT,
+	  .window_start = WM2200_DSP1_PM_0, .window_len = 768, },
+
+	/* DSP1 ZM */
+	{ .range_min = WM2200_DSP1_ZM_BASE,
+	  .range_max = WM2200_DSP1_ZM_BASE + 2047,
+	  .selector_reg = WM2200_DSP1_CONTROL_4,
+	  .selector_mask = WM2200_DSP1_PAGE_BASE_ZM_0_MASK,
+	  .selector_shift = WM2200_DSP1_PAGE_BASE_ZM_0_SHIFT,
+	  .window_start = WM2200_DSP1_ZM_0, .window_len = 1024, },
+
+	/* DSP2 DM */
+	{ .range_min = WM2200_DSP2_DM_BASE,
+	  .range_max = WM2200_DSP2_DM_BASE + 4095,
+	  .selector_reg = WM2200_DSP2_CONTROL_3,
+	  .selector_mask = WM2200_DSP2_PAGE_BASE_DM_0_MASK,
+	  .selector_shift = WM2200_DSP2_PAGE_BASE_DM_0_SHIFT,
+	  .window_start = WM2200_DSP2_DM_0, .window_len = 2048, },
+
+	/* DSP2 PM */
+	{ .range_min = WM2200_DSP2_PM_BASE,
+	  .range_max = WM2200_DSP2_PM_BASE + 11287,
+	  .selector_reg = WM2200_DSP2_CONTROL_2,
+	  .selector_mask = WM2200_DSP2_PAGE_BASE_PM_0_MASK,
+	  .selector_shift = WM2200_DSP2_PAGE_BASE_PM_0_SHIFT,
+	  .window_start = WM2200_DSP2_PM_0, .window_len = 768, },
+
+	/* DSP2 ZM */
+	{ .range_min = WM2200_DSP2_ZM_BASE,
+	  .range_max = WM2200_DSP2_ZM_BASE + 2047,
+	  .selector_reg = WM2200_DSP2_CONTROL_4,
+	  .selector_mask = WM2200_DSP2_PAGE_BASE_ZM_0_MASK,
+	  .selector_shift = WM2200_DSP2_PAGE_BASE_ZM_0_SHIFT,
+	  .window_start = WM2200_DSP2_ZM_0, .window_len = 1024, },
+};
+
 static struct reg_default wm2200_reg_defaults[] = {
 	{ 0x000B, 0x0000 },   /* R11    - Tone Generator 1 */
 	{ 0x0102, 0x0000 },   /* R258   - Clocking 3 */
@@ -407,6 +467,16 @@ static struct reg_default wm2200_reg_defaults[] = {
 
 static bool wm2200_volatile_register(struct device *dev, unsigned int reg)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wm2200_ranges); i++)
+		if ((reg >= wm2200_ranges[i].window_start &&
+		     reg <= wm2200_ranges[i].window_start +
+		     wm2200_ranges[i].window_len) ||
+		    (reg >= wm2200_ranges[i].range_min &&
+		     reg <= wm2200_ranges[i].range_max))
+			return true;
+
 	switch (reg) {
 	case WM2200_SOFTWARE_RESET:
 	case WM2200_DEVICE_REVISION:
@@ -423,6 +493,16 @@ static bool wm2200_volatile_register(struct device *dev, unsigned int reg)
 
 static bool wm2200_readable_register(struct device *dev, unsigned int reg)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wm2200_ranges); i++)
+		if ((reg >= wm2200_ranges[i].window_start &&
+		     reg <= wm2200_ranges[i].window_start +
+		     wm2200_ranges[i].window_len) ||
+		    (reg >= wm2200_ranges[i].range_min &&
+		     reg <= wm2200_ranges[i].range_max))
+			return true;
+
 	switch (reg) {
 	case WM2200_SOFTWARE_RESET:
 	case WM2200_DEVICE_REVISION:
@@ -1991,12 +2071,15 @@ static const struct regmap_config wm2200_regmap = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
-	.max_register = WM2200_MAX_REGISTER,
+	.max_register = WM2200_MAX_REGISTER + (ARRAY_SIZE(wm2200_ranges) *
+					       WM2200_DSP_SPACING),
 	.reg_defaults = wm2200_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm2200_reg_defaults),
 	.volatile_reg = wm2200_volatile_register,
 	.readable_reg = wm2200_readable_register,
 	.cache_type = REGCACHE_RBTREE,
+	.ranges = wm2200_ranges,
+	.num_ranges = ARRAY_SIZE(wm2200_ranges),
 };
 
 static const unsigned int wm2200_dig_vu[] = {
-- 
1.7.10.4
