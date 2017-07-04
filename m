From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 5/9] clk: at91: clk-generated: create function to find best_diff
Date: Tue,  4 Jul 2017 13:59:23 +0200
Message-ID: <20170704115927.32662-6-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170704115927.32662-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The way to find the best_diff and do the appropriate process afterwards
can be re-used.

This patch prepares the driver for an upcoming patch that will allow
clk_generated to determine the rate of the audio_pll.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/clk/at91/clk-generated.c | 41 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index dab7002937e6..6530a2e7e84d 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -99,15 +99,36 @@ clk_generated_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST(parent_rate, gck->gckdiv + 1);
 }
 
+static void clk_generated_best_diff(struct clk_rate_request *req,
+				    struct clk_hw *parent,
+				    unsigned long parent_rate, u32 div,
+				    int *best_diff, long *best_rate)
+{
+	unsigned long tmp_rate;
+	int tmp_diff;
+
+	if (!div)
+		tmp_rate = parent_rate;
+	else
+		tmp_rate = parent_rate / div;
+	tmp_diff = abs(req->rate - tmp_rate);
+
+	if (*best_diff < 0 || *best_diff > tmp_diff) {
+		*best_rate = tmp_rate;
+		*best_diff = tmp_diff;
+		req->best_parent_rate = parent_rate;
+		req->best_parent_hw = parent;
+	}
+}
+
 static int clk_generated_determine_rate(struct clk_hw *hw,
 					struct clk_rate_request *req)
 {
 	struct clk_generated *gck = to_clk_generated(hw);
 	struct clk_hw *parent = NULL;
 	long best_rate = -EINVAL;
-	unsigned long tmp_rate, min_rate;
+	unsigned long min_rate;
 	int best_diff = -1;
-	int tmp_diff;
 	int i;
 
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
@@ -125,18 +146,10 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 			continue;
 
 		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
-		if (!div)
-			tmp_rate = parent_rate;
-		else
-			tmp_rate = parent_rate / div;
-		tmp_diff = abs(req->rate - tmp_rate);
-
-		if (best_diff < 0 || best_diff > tmp_diff) {
-			best_rate = tmp_rate;
-			best_diff = tmp_diff;
-			req->best_parent_rate = parent_rate;
-			req->best_parent_hw = parent;
-		}
+
+		clk_generated_best_diff(req, parent, parent_rate, div,
+					&best_diff, &best_rate);
+
 
 		if (!best_diff)
 			break;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
