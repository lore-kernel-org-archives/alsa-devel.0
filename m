From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 1/1] ASoC: sti: select player for I2S/TDM TX bus
Date: Thu, 14 Apr 2016 15:29:35 +0200
Message-ID: <1460640575-27011-2-git-send-email-moise.gergaud@st.com>
References: <1460640575-27011-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 5E08526167A
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 15:29:47 +0200 (CEST)
In-Reply-To: <1460640575-27011-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

By default, player#0 is connected to I2S/TDM TX bus.
This patch connects player#1 to I2S/TDM TX bus.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif.h        |  1 +
 sound/soc/sti/uniperif_player.c | 42 +++++++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index d0e2446..eb9933c 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1302,6 +1302,7 @@ struct uniperif {
 	struct device *dev;
 	int ver; /* IP version, used by register access macros */
 	struct regmap_field *clk_sel;
+	struct regmap_field *valid_sel;
 
 	/* capabilities */
 	const struct snd_pcm_hardware *hw;
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index ff2d735..ee1c7c2 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -21,7 +21,6 @@
 
 /* sys config registers definitions */
 #define SYS_CFG_AUDIO_GLUE 0xA4
-#define SYS_CFG_AUDI0_GLUE_PCM_CLKX 8
 
 /*
  * Driver specific types.
@@ -29,6 +28,7 @@
 
 #define UNIPERIF_PLAYER_CLK_ADJ_MIN  -999999
 #define UNIPERIF_PLAYER_CLK_ADJ_MAX  1000000
+#define UNIPERIF_PLAYER_I2S_OUT 1 /* player id connected to I2S/TDM TX bus */
 
 /*
  * Note: snd_pcm_hardware is linked to DMA controller but is declared here to
@@ -1013,27 +1013,30 @@ static void uni_player_shutdown(struct snd_pcm_substream *substream,
 	player->substream = NULL;
 }
 
-static int uni_player_parse_dt_clk_glue(struct platform_device *pdev,
-					struct uniperif *player)
+static int uni_player_parse_dt_audio_glue(struct platform_device *pdev,
+					  struct uniperif *player)
 {
-	int bit_offset;
 	struct device_node *node = pdev->dev.of_node;
 	struct regmap *regmap;
-
-	bit_offset = SYS_CFG_AUDI0_GLUE_PCM_CLKX + player->info->id;
+	struct reg_field regfield[2] = {
+		/* PCM_CLK_SEL */
+		REG_FIELD(SYS_CFG_AUDIO_GLUE,
+			  8 + player->info->id,
+			  8 + player->info->id),
+		/* PCMP_VALID_SEL */
+		REG_FIELD(SYS_CFG_AUDIO_GLUE, 0, 1)
+	};
 
 	regmap = syscon_regmap_lookup_by_phandle(node, "st,syscfg");
 
-	if (regmap) {
-		struct reg_field regfield =
-			REG_FIELD(SYS_CFG_AUDIO_GLUE, bit_offset, bit_offset);
-
-		player->clk_sel = regmap_field_alloc(regmap, regfield);
-	} else {
+	if (!regmap) {
 		dev_err(&pdev->dev, "sti-audio-clk-glue syscf not found\n");
 		return -EINVAL;
 	}
 
+	player->clk_sel = regmap_field_alloc(regmap, regfield[0]);
+	player->valid_sel = regmap_field_alloc(regmap, regfield[1]);
+
 	return 0;
 }
 
@@ -1084,8 +1087,8 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	/* Save the info structure */
 	player->info = info;
 
-	/* Get the PCM_CLK_SEL bit from audio-glue-ctrl SoC register */
-	if (uni_player_parse_dt_clk_glue(pdev, player))
+	/* Get PCM_CLK_SEL & PCMP_VALID_SEL from audio-glue-ctrl SoC reg */
+	if (uni_player_parse_dt_audio_glue(pdev, player))
 		return -EINVAL;
 
 	return 0;
@@ -1139,6 +1142,17 @@ int uni_player_init(struct platform_device *pdev,
 		}
 	}
 
+	/* connect to I2S/TDM TX bus */
+	if (player->valid_sel &&
+	    (player->info->id == UNIPERIF_PLAYER_I2S_OUT)) {
+		ret = regmap_field_write(player->valid_sel, player->info->id);
+		if (ret) {
+			dev_err(player->dev,
+				"%s: unable to connect to tdm bus", __func__);
+			return ret;
+		}
+	}
+
 	ret = devm_request_irq(&pdev->dev, player->irq,
 			       uni_player_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), player);
-- 
1.9.1
