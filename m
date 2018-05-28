From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/3] ASoC: simple-card: make sysclk index
	configurable
Date: Mon, 28 May 2018 21:35:02 +0200
Message-ID: <20180528193503.18905-3-daniel@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id D19702673F2
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 21:35:11 +0200 (CEST)
In-Reply-To: <20180528193503.18905-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, kuninori.morimoto.gx@renesas.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The simple-card driver currently hard-codes the clk_id parameter in
snd_soc_dai_set_sysclk() to 0. Make this configrable for both CPU and
codec dai sub-nodes.

This still has the limitation that only one clk_id can be configured, but it
should help some more platforms to use simple-card in favor to a more
specific machine driver.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/sound/simple-card.txt |  3 +++
 include/sound/simple_card_utils.h                       |  1 +
 sound/soc/generic/simple-card-utils.c                   |  3 +++
 sound/soc/generic/simple-card.c                         | 10 ++++++----
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index a4c72d09cd45..c8d268285a9e 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -94,6 +94,9 @@ Optional CPU/CODEC subnodes properties:
 - system-clock-direction-out		: specifies clock direction as 'out' on
 					  initialization. It is useful for some aCPUs with
 					  fixed clocks.
+- system-clock-index			: index of the system clock to use when
+					  the mclk frequency is on the CPU/CODEC
+					  DAI. Defaults to 0.
 
 Example 1 - single DAI link:
 
diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 7e25afce6566..ebdf52c9884f 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -21,6 +21,7 @@ struct asoc_simple_dai {
 	unsigned int tx_slot_mask;
 	unsigned int rx_slot_mask;
 	struct clk *clk;
+	int sysclk_id;
 };
 
 struct asoc_simple_card_data {
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 3751a07de6aa..493c9b1f057e 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -199,6 +199,9 @@ int asoc_simple_card_parse_clk(struct device *dev,
 	if (of_property_read_bool(node, "system-clock-direction-out"))
 		simple_dai->clk_direction = SND_SOC_CLOCK_OUT;
 
+	if (!of_property_read_u32(node, "system-clock-index", &val))
+		simple_dai->sysclk_id = val;
+
 	dev_dbg(dev, "%s : sysclk = %d, direction %d\n", name,
 		simple_dai->sysclk, simple_dai->clk_direction);
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index ca529a6cab06..5b4afa624395 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -158,13 +158,15 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 		if (dai_props->cpu_dai.clk)
 			clk_set_rate(dai_props->cpu_dai.clk, mclk);
 
-		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
-					     SND_SOC_CLOCK_IN);
+		ret = snd_soc_dai_set_sysclk(codec_dai,
+					     dai_props->codec_dai.sysclk_id,
+					     mclk, SND_SOC_CLOCK_IN);
 		if (ret && ret != -ENOTSUPP)
 			goto err;
 
-		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
-					     SND_SOC_CLOCK_OUT);
+		ret = snd_soc_dai_set_sysclk(cpu_dai,
+					     dai_props->cpu_dai.sysclk_id,
+					     mclk, SND_SOC_CLOCK_OUT);
 		if (ret && ret != -ENOTSUPP)
 			goto err;
 	}
-- 
2.14.3
