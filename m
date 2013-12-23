From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: Add device's module clock selection.
Date: Mon, 23 Dec 2013 15:25:38 +0800
Message-ID: <1387783538-5318-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: kuninori.morimoto.gx@renesas.com, Li.Xiubo@freescale.com, fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Try to get the device's module clock if the dt has no clocks and
system-clock-frequency properties.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 a.out                           |  0
 sound/soc/generic/simple-card.c | 21 ++++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 a.out

diff --git a/a.out b/a.out
new file mode 100644
index 0000000..e69de29
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6ce9745..c0d92813 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -90,14 +90,29 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	 * dai->sysclk come from
 	 *  "clocks = <&xxx>" (if system has common clock)
 	 *  or "system-clock-frequency = <xxx>"
+	 *  or device's module clock.
 	 */
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk))
+	if (of_property_read_bool(np, "clocks")) {
+		clk = of_clk_get(np, 0);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto parse_error;
+		}
+
+		dai->sysclk = clk_get_rate(clk);
+	} else if (of_property_read_bool(np, "system-clock-frequency")) {
 		of_property_read_u32(np,
 				     "system-clock-frequency",
 				     &dai->sysclk);
-	else
+	} else {
+		clk = of_clk_get(*node, 0);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto parse_error;
+		}
+
 		dai->sysclk = clk_get_rate(clk);
+	}
 
 	ret = 0;
 
-- 
1.8.4
