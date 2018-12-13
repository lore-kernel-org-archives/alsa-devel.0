From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Dereference pointer for
	memcpy sizeof in asoc_simple_card_probe" to the asoc tree
Date: Thu, 13 Dec 2018 12:08:47 +0000 (GMT)
Message-ID: <20181213120847.3393A11254D1@debutante.sirena.org.uk>
References: <87wooe10f7.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DCAA267BA5
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 13:08:48 +0100 (CET)
In-Reply-To: <87wooe10f7.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Dereference pointer for memcpy sizeof in asoc_simple_card_probe

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

>From 869858f84a65b646052eff1ec75c1f49e638b62b Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 13 Dec 2018 14:15:20 +0900
Subject: [PATCH] ASoC: simple-card: Dereference pointer for memcpy sizeof in
 asoc_simple_card_probe

Commit 4fb7f4df49d3 ("ASoC: simple-card: use cpu/codec pointer on
simple_dai_props") updated {cpu,codec}_dai to be pointers in struct
simple_dai_props but didn't update these locations to dereference the
pointers.
This patch fixup it for non DT simple-card use case.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 766123485d7c..93d68161f953 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -429,6 +429,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		struct asoc_simple_card_info *cinfo;
 		struct snd_soc_dai_link_component *codecs;
 		struct snd_soc_dai_link_component *platform;
+		int dai_idx = 0;
 
 		cinfo = dev->platform_data;
 		if (!cinfo) {
@@ -445,6 +446,9 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
+		dai_props->cpu_dai	= &priv->dais[dai_idx++];
+		dai_props->codec_dai	= &priv->dais[dai_idx++];
+
 		codecs			= dai_link->codecs;
 		codecs->name		= cinfo->codec;
 		codecs->dai_name	= cinfo->codec_dai.name;
@@ -458,10 +462,10 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		dai_link->cpu_dai_name	= cinfo->cpu_dai.name;
 		dai_link->dai_fmt	= cinfo->daifmt;
 		dai_link->init		= asoc_simple_card_dai_init;
-		memcpy(&priv->dai_props->cpu_dai, &cinfo->cpu_dai,
-					sizeof(priv->dai_props->cpu_dai));
-		memcpy(&priv->dai_props->codec_dai, &cinfo->codec_dai,
-					sizeof(priv->dai_props->codec_dai));
+		memcpy(priv->dai_props->cpu_dai, &cinfo->cpu_dai,
+					sizeof(*priv->dai_props->cpu_dai));
+		memcpy(priv->dai_props->codec_dai, &cinfo->codec_dai,
+					sizeof(*priv->dai_props->codec_dai));
 	}
 
 	snd_soc_card_set_drvdata(card, priv);
-- 
2.19.0.rc2
