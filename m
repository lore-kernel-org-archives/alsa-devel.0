From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: simple-card: Support for selecting
	system clocks by ID
Date: Mon, 15 Feb 2016 16:11:35 +0200
Message-ID: <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 48203265091
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 15:11:51 +0100 (CET)
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

Most CPU and codec drivers can select their system clock from different
sources. They rely on snd_soc_dai_set_sysclk(x, sysclk_id, x, x) to do so.
Add support for selecting which clock need to be selected along with the
rate.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 2 ++
 include/sound/simple_card.h                             | 1 +
 sound/soc/generic/simple-card.c                         | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 1f2cf76d701a..bc8f9e4a17cc 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -85,6 +85,8 @@ Optional CPU/CODEC subnodes properties:
 					  clk_disable_unprepare() in dai
 					  shutdown().
 - system-clock-direction		: "in" or "out", default "in"
+- system-clock-id			: Numberic ID of the system clock to
+					  select within the dai, default is 0.
 
 Example 1 - single DAI link:
 
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 783bc5499794..f930ad3763ff 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -18,6 +18,7 @@ struct asoc_simple_dai {
 	const char *name;
 	unsigned int sysclk;
 	int sysclk_dir;
+	int sysclk_id;
 	int slots;
 	int slot_width;
 	unsigned int tx_slot_mask;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index f0d89e6f28a6..c6111e7a6d93 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -142,7 +142,7 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 	int ret;
 
 	if (set->sysclk) {
-		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk,
+		ret = snd_soc_dai_set_sysclk(dai, set->sysclk_id, set->sysclk,
 					     set->sysclk_dir);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_sysclk error\n");
@@ -284,6 +284,9 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			dai->sysclk = clk_get_rate(clk);
 	}
 
+	if (!of_property_read_u32(np, "system-clock-id", &val))
+		dai->sysclk_id = val;
+
 	return 0;
 }
 
-- 
2.7.1
