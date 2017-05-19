From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: fix spelling mistake: "missmatch" -> "mismatch"" to the asoc tree
Date: Fri, 19 May 2017 18:04:05 +0100
Message-ID: <E1dBlJt-0003gi-Pn@debutante>
References: <20170518074815.10755-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518074815.10755-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: fix spelling mistake: "missmatch" -> "mismatch"

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

>From a619f049f23be98510aa0cae774cdc553c54e0e9 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 18 May 2017 08:48:15 +0100
Subject: [PATCH] ASoC: audio-graph-card: fix spelling mistake: "missmatch" ->
 "mismatch"

Trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index f41b0393ffca..93c167a91d2d 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -107,7 +107,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	int ret;
 
 	if (rcpu_ep != cpu_ep) {
-		dev_err(dev, "remote-endpoint missmatch (%s/%s/%s)\n",
+		dev_err(dev, "remote-endpoint mismatch (%s/%s/%s)\n",
 			cpu_ep->name, codec_ep->name, rcpu_ep->name);
 		ret = -EINVAL;
 		goto dai_link_of_err;
-- 
2.11.0
