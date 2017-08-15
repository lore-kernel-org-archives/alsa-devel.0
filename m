From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: spear: constify snd_soc_dai_ops structures" to the asoc tree
Date: Tue, 15 Aug 2017 18:15:14 +0100
Message-ID: <E1dhfQw-0003aM-TQ@debutante>
References: <20170713055710.GA21105@embeddedgus>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170713055710.GA21105@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: spear: constify snd_soc_dai_ops structures

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

>From a1150d40b219af1344f7bcc9b365dc5ec7bfbb65 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Tue, 15 Aug 2017 17:10:12 +0200
Subject: [PATCH] ASoC: spear: constify snd_soc_dai_ops structures

These snd_soc_dai_ops structures are only stored in the ops field of
a snd_soc_dai_driver structure, which is const.  Thus, the
snd_soc_dai_ops structures can be const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/spear/spdif_in.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 01b28e59b4c0..78a6a360b4a6 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -151,7 +151,7 @@ static int spdif_in_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static struct snd_soc_dai_ops spdif_in_dai_ops = {
+static const struct snd_soc_dai_ops spdif_in_dai_ops = {
 	.shutdown	= spdif_in_shutdown,
 	.trigger	= spdif_in_trigger,
 	.hw_params	= spdif_in_hw_params,
-- 
2.13.3
