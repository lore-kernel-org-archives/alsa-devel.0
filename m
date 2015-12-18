From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: enable to use tdm_slot on
	DT" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:43 +0000
Message-ID: <E1a9twl-0006E3-IX@debutante>
References: <87io3xiyid.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51B082665C2
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:48 +0100 (CET)
In-Reply-To: <87io3xiyid.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: enable to use tdm_slot on DT

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6dad9758a5e3e75de91871a636572d64806b240f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:48:23 +0000
Subject: [PATCH] ASoC: rsrc-card: enable to use tdm_slot on DT

Renesas sound driver will use tdm slot on TDM Multi Mode support.
This patch enables tdm slot on rsrc card driver on DT.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index a3ec13f6271e..3c308e2d696e 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -50,6 +50,10 @@ MODULE_DEVICE_TABLE(of, rsrc_card_of_match);
 struct rsrc_card_dai {
 	unsigned int fmt;
 	unsigned int sysclk;
+	unsigned int tx_slot_mask;
+	unsigned int rx_slot_mask;
+	int slots;
+	int slot_width;
 	struct clk *clk;
 	char dai_name[DAI_NAME_NUM];
 };
@@ -126,6 +130,18 @@ static int rsrc_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 		}
 	}
 
+	if (dai_props->slots) {
+		ret = snd_soc_dai_set_tdm_slot(dai,
+					       dai_props->tx_slot_mask,
+					       dai_props->rx_slot_mask,
+					       dai_props->slots,
+					       dai_props->slot_width);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "set_tdm_slot error\n");
+			goto err;
+		}
+	}
+
 	ret = 0;
 
 err:
@@ -198,6 +214,15 @@ static int rsrc_card_parse_links(struct device_node *np,
 	if (ret)
 		return ret;
 
+	/* Parse TDM slot */
+	ret = snd_soc_of_parse_tdm_slot(np,
+					&dai_props->tx_slot_mask,
+					&dai_props->rx_slot_mask,
+					&dai_props->slots,
+					&dai_props->slot_width);
+	if (ret)
+		return ret;
+
 	if (is_fe) {
 		/* BE is dummy */
 		dai_link->codec_of_node		= NULL;
-- 
2.6.2
