From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: test memory
	allocation" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:33 +0000 (GMT)
Message-ID: <20190321150633.3EDAA11288EC@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C7B8F80791
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:35 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: test memory allocation

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

>From 008fe4e5382293e2da96a4dc75b95782a5f95be8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:57:02 +0900
Subject: [PATCH] ASoC: simple-card-utils: test memory allocation

li->conf will be 0 if it was not DPCM case.
Then, 1) we shouldn't call devm_kcalloc() with size 0,
2) we need NULL pointer check if li->conf was not 0.
This patch fixed above issues.
Special thanks to Pierre-Louis Bossart

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index a794f767ff7f..4ed68348f939 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -495,16 +495,21 @@ int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 	struct snd_soc_dai_link *dai_link;
 	struct simple_dai_props *dai_props;
 	struct asoc_simple_dai *dais;
-	struct snd_soc_codec_conf *cconf;
+	struct snd_soc_codec_conf *cconf = NULL;
 	int i;
 
 	dai_props = devm_kcalloc(dev, li->link, sizeof(*dai_props), GFP_KERNEL);
 	dai_link  = devm_kcalloc(dev, li->link, sizeof(*dai_link),  GFP_KERNEL);
 	dais      = devm_kcalloc(dev, li->dais, sizeof(*dais),      GFP_KERNEL);
-	cconf     = devm_kcalloc(dev, li->conf, sizeof(*cconf),     GFP_KERNEL);
 	if (!dai_props || !dai_link || !dais)
 		return -ENOMEM;
 
+	if (li->conf) {
+		cconf = devm_kcalloc(dev, li->conf, sizeof(*cconf), GFP_KERNEL);
+		if (!cconf)
+			return -ENOMEM;
+	}
+
 	/*
 	 * Use snd_soc_dai_link_component instead of legacy style
 	 * It is codec only. but cpu/platform will be supported in the future.
-- 
2.20.1
