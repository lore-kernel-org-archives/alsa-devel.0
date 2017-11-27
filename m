From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use codec hw_write on max98927"
	to the asoc tree
Date: Mon, 27 Nov 2017 18:52:02 +0000
Message-ID: <E1eJOVe-0006qY-D3@debutante>
References: <878thzm0zb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E8976267551
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:05 +0100 (CET)
In-Reply-To: <878thzm0zb.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: don't use codec hw_write on max98927

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

>From 68fea7cd3f3722cf3d3b7f30e9b5667133446936 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 9 Nov 2017 01:05:11 +0000
Subject: [PATCH] ASoC: don't use codec hw_write on max98927

max98927 driver is using codec hw_write/control_data,
but it is redundant code. This patch cleanup these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index a1d39353719d..f701fdc81175 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -682,7 +682,6 @@ static int max98927_probe(struct snd_soc_codec *codec)
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 
 	max98927->codec = codec;
-	codec->control_data = max98927->regmap;
 
 	/* Software Reset */
 	regmap_write(max98927->regmap,
-- 
2.15.0
