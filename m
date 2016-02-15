From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ASoC: simple-card: Add
	system-clock-direction DT parameter to dai nodes
Date: Mon, 15 Feb 2016 16:11:34 +0200
Message-ID: <1455545495-20292-4-git-send-email-peter.ujfalusi@ti.com>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 24829264FBB
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 15:11:48 +0100 (CET)
In-Reply-To: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Jyri Sarha <jsarha@ti.com>

Select dir parameters for set_sysclk calls in the card init phase.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt |  1 +
 include/sound/simple_card.h                             |  1 +
 sound/soc/generic/simple-card.c                         | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index cf3979eb3578..1f2cf76d701a 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -84,6 +84,7 @@ Optional CPU/CODEC subnodes properties:
 					  in dai startup() and disabled with
 					  clk_disable_unprepare() in dai
 					  shutdown().
+- system-clock-direction		: "in" or "out", default "in"
 
 Example 1 - single DAI link:
 
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 0399352f3a62..783bc5499794 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -17,6 +17,7 @@
 struct asoc_simple_dai {
 	const char *name;
 	unsigned int sysclk;
+	int sysclk_dir;
 	int slots;
 	int slot_width;
 	unsigned int tx_slot_mask;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2389ab47e25f..f0d89e6f28a6 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -142,7 +142,8 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 	int ret;
 
 	if (set->sysclk) {
-		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
+		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk,
+					     set->sysclk_dir);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_sysclk error\n");
 			goto err;
@@ -220,6 +221,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 {
 	struct of_phandle_args args;
 	struct clk *clk;
+	const char *str;
 	u32 val;
 	int ret;
 
@@ -249,6 +251,16 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	if (ret)
 		return ret;
 
+	ret = of_property_read_string(np, "system-clock-direction", &str);
+	if (ret == 0) {
+		if (!strcmp(str, "out"))
+			dai->sysclk_dir = SND_SOC_CLOCK_OUT;
+		else if (!strcmp(str, "in"))
+			dai->sysclk_dir = SND_SOC_CLOCK_IN;
+		else
+			return -EINVAL;
+	}
+
 	/*
 	 * Parse dai->sysclk come from "clocks = <&xxx>"
 	 * (if system has common clock)
-- 
2.7.1
