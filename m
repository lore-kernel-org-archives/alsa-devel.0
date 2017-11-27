From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use codec hw_write on max98926"
	to the asoc tree
Date: Mon, 27 Nov 2017 18:52:05 +0000
Message-ID: <E1eJOVh-0006rl-Ew@debutante>
References: <87a82fm0zs.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 10B67267567
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:08 +0100 (CET)
In-Reply-To: <87a82fm0zs.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: don't use codec hw_write on max98926

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

>From 866b9c81ad8450eb1e2a0132b4bd9fd909afd647 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 9 Nov 2017 01:04:54 +0000
Subject: [PATCH] ASoC: don't use codec hw_write on max98926

max98926 driver is using codec hw_write/control_data,
but it is redundant code. This patch cleanup these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98926.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 03d07bf4d942..7b1d1b0fa879 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -490,7 +490,7 @@ static int max98926_probe(struct snd_soc_codec *codec)
 	struct max98926_priv *max98926 = snd_soc_codec_get_drvdata(codec);
 
 	max98926->codec = codec;
-	codec->control_data = max98926->regmap;
+
 	/* Hi-Z all the slots */
 	regmap_write(max98926->regmap, MAX98926_DOUT_HIZ_CFG4, 0xF0);
 	return 0;
-- 
2.15.0
