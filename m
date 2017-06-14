From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_of_parse_tdm()" to the asoc tree
Date: Wed, 14 Jun 2017 11:12:35 +0100
Message-ID: <E1dL5Hv-0007cD-8b@debutante>
References: <87d1a79ztz.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1a79ztz.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_of_parse_tdm()

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

>From e68ba207444354ddf295de2e7fbcc97c06cccc8b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Jun 2017 00:34:35 +0000
Subject: [PATCH] ASoC: simple-card-utils: add asoc_simple_card_of_parse_tdm()

Current simple card drivers are using asoc_simple_dai's tx_slot_mask,
rx_slot_mask, slots, slot_width directly to parse TDM.
Encapsulation is one of simple card util's purpose.
Let's add asoc_simple_card_of_parse_tdm for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 840d624148df..2679312228b3 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -75,6 +75,12 @@ int asoc_simple_card_parse_graph_dai(struct device_node *ep,
 				     struct device_node **endpoint_np,
 				     const char **dai_name);
 
+#define asoc_simple_card_of_parse_tdm(np, dai)			\
+	snd_soc_of_parse_tdm_slot(np,	&(dai)->tx_slot_mask,	\
+					&(dai)->rx_slot_mask,	\
+					&(dai)->slots,		\
+					&(dai)->slot_width);
+
 int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 			      struct asoc_simple_dai *simple_dai);
 
-- 
2.11.0
