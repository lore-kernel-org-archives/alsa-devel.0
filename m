From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Fix missing of_node_put()
	at simple_dai_link_of()" to the asoc tree
Date: Wed, 20 Feb 2019 12:13:16 +0000 (GMT)
Message-ID: <20190220121316.29D3D11274ED@debutante.sirena.org.uk>
References: <20190219154652.13644-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6A60F807A7
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 13:13:17 +0100 (CET)
In-Reply-To: <20190219154652.13644-3-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Fix missing of_node_put() at simple_dai_link_of()

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

>From 44662f90cda7ce0b65e77a7f1eefe45fb9053a4e Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 19 Feb 2019 16:46:48 +0100
Subject: [PATCH] ASoC: simple-card: Fix missing of_node_put() at
 simple_dai_link_of()

We forgot to unreference the platform node object obtained from
of_get_child_by_name().  This leads to the unbalance of node
refcount.

Fixes: e0ae225b7e96 ("ASoC: simple-card: support platform in dts parse")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index dc18c4492955..092963e90e1e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -421,6 +421,7 @@ static int simple_dai_link_of(struct simple_priv *priv,
 	asoc_simple_card_canonicalize_platform(dai_link);
 
 dai_link_of_err:
+	of_node_put(plat);
 	of_node_put(node);
 
 	return ret;
-- 
2.20.1
