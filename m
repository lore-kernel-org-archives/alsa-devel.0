From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v5 4/7] clk: at91: clk-generated: create function to find
 best_diff
Date: Thu, 10 Aug 2017 08:34:04 +0200
Message-ID: <4dde07bb3345d569778e7b1b5a8679bded095041.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, cyrille.pitchen@wedev4u.fr, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The way to find the best_diff and do the appropriate process afterwards
can be re-used.

This patch prepares the driver for an upcoming patch that will allow
clk_generated to determine the rate of the audio_pll.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/clk-generated.c | 41 +++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index ef4b4e0..7260e49 100644
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
git-series 0.9.1
