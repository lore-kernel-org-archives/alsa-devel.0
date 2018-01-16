From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uda1380: fix regression by adding back
	.read/.write" to the asoc tree
Date: Tue, 16 Jan 2018 13:56:37 +0000
Message-ID: <E1ebRjB-00059a-Cv@debutante>
References: <87y3ky8sz2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D625C26770A
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:56:43 +0100 (CET)
In-Reply-To: <87y3ky8sz2.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uda1380: fix regression by adding back .read/.write

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

>From 7604d8068e6253c143b27ce7e164ee8e7a9da5b9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Jan 2018 01:59:53 +0000
Subject: [PATCH] ASoC: uda1380: fix regression by adding back .read/.write

commit c001bf633a9 ("ASoC: use internal reg_cache on uda1380")
removed .read/.write from driver, but it might breaks non-regmap
driver, because ALSA SoC framework might call it.

To fix this regression, this patch back .read/.write

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/uda1380.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 46a495b4da8d..c73e6a192224 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -726,6 +726,8 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 
 static const struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.probe =	uda1380_probe,
+	.read =		uda1380_read_reg_cache,
+	.write =	uda1380_write,
 	.set_bias_level = uda1380_set_bias_level,
 	.suspend_bias_off = true,
 
-- 
2.15.1
