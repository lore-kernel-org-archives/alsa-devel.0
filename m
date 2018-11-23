From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: tidyup "prefix"
	parsing" to the asoc tree
Date: Fri, 23 Nov 2018 14:12:41 +0000 (GMT)
Message-ID: <20181123141241.3AF1D440078@finisterre.ee.mobilebroadband>
References: <87wop6lz1a.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 20A65267929
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:12:43 +0100 (CET)
In-Reply-To: <87wop6lz1a.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-scu-card: tidyup "prefix" parsing

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

>From ca8d95c709378d0792c9dbacdab176a75e521ffb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Nov 2018 00:55:40 +0000
Subject: [PATCH] ASoC: simple-scu-card: tidyup "prefix" parsing

simple-scu-card.c is supporting "prefix" which is used to avoid
DAI naming conflict when CPU/Codec matching.
But, sound card might have multi sub-devices, and each codec might need
each prefix.

Now, ASoC is supporting snd_soc_of_parse_node_prefix(), let's support
it on audio-graph-scu-card, too. It is keeping existing DT style.

It can't support each codec's prefix if sound card had multi sub-devices
without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index e650143eb532..7ae1901b2f85 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -157,10 +157,17 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
+		/* check "prefix" from top node */
 		snd_soc_of_parse_audio_prefix(card,
 					      &priv->codec_conf,
 					      dai_link->codecs->of_node,
 					      PREFIX "prefix");
+		/* check "prefix" from each node if top doesn't have */
+		if (!priv->codec_conf.of_node)
+			snd_soc_of_parse_node_prefix(np,
+						     &priv->codec_conf,
+						     dai_link->codecs->of_node,
+						     "prefix");
 	}
 
 	ret = asoc_simple_card_of_parse_tdm(np, &dai_props->dai);
-- 
2.19.1
