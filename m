From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 1/9] clk: at91: clk-generated: remove
	useless divisor loop
Date: Thu, 13 Jul 2017 09:49:19 +0200
Message-ID: <20170713074927.10882-2-quentin.schulz@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 23DFF2671D3
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 09:49:40 +0200 (CEST)
In-Reply-To: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, cyrille.pitchen@wedev4u.fr, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The driver requests the current clk rate of each of its parent clocks to
decide whether a clock rate is suitable or not. It does not request
determine_rate from a parent clock which could request a rate change in
parent clock (i.e. there is no parent rate propagation).

We know the rate we want (passed along req argument of the function) and
the parent clock rate, thus we know the closest rounded divisor, we
don't need to iterate over the available divisors to find the best one
for a given clock.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/at91/clk-generated.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index f0b7ae904ce2..ef4b4e03de04 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -124,19 +124,18 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 		    (gck->range.max && min_rate > gck->range.max))
 			continue;
 
-		for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
-			tmp_rate = DIV_ROUND_CLOSEST(parent_rate, div);
-			tmp_diff = abs(req->rate - tmp_rate);
-
-			if (best_diff < 0 || best_diff > tmp_diff) {
-				best_rate = tmp_rate;
-				best_diff = tmp_diff;
-				req->best_parent_rate = parent_rate;
-				req->best_parent_hw = parent;
-			}
-
-			if (!best_diff || tmp_rate < req->rate)
-				break;
+		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
+		if (!div)
+			tmp_rate = parent_rate;
+		else
+			tmp_rate = parent_rate / div;
+		tmp_diff = abs(req->rate - tmp_rate);
+
+		if (best_diff < 0 || best_diff > tmp_diff) {
+			best_rate = tmp_rate;
+			best_diff = tmp_diff;
+			req->best_parent_rate = parent_rate;
+			req->best_parent_hw = parent;
 		}
 
 		if (!best_diff)
-- 
2.11.0
