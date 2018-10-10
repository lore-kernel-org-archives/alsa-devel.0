From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: enable mclk-fs on
	codec node" to the asoc tree
Date: Wed, 10 Oct 2018 15:35:00 +0100 (BST)
Message-ID: <20181010143500.D28A71122395@debutante.sirena.org.uk>
References: <878t361rb1.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E3FE2678F3
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 16:35:02 +0200 (CEST)
In-Reply-To: <878t361rb1.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: enable mclk-fs on codec node

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 8036dbc490d16dc3d998246e14c9507ec8272ae2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Oct 2018 02:22:29 +0000
Subject: [PATCH] ASoC: audio-graph-card: enable mclk-fs on codec node

Current audio-graph-card is supporting mclk-fs on CPU node
side only. But having Codec node also is good idea.
It will be just ignored if not defined.

"rcpu_ep" is same as "cpu_ep", This patch tidyup it, too.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index fb6635f8d5d7..25c819e402e1 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -182,7 +182,8 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	of_property_read_u32(rcpu_ep, "mclk-fs", &dai_props->mclk_fs);
+	of_property_read_u32(cpu_ep,   "mclk-fs", &dai_props->mclk_fs);
+	of_property_read_u32(codec_ep, "mclk-fs", &dai_props->mclk_fs);
 
 	ret = asoc_simple_card_parse_graph_cpu(cpu_ep, dai_link);
 	if (ret < 0)
-- 
2.19.0.rc2
