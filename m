From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fix ADG flags" to the asoc tree
Date: Wed, 13 Sep 2017 17:49:27 +0100 (BST)
Message-ID: <20170913164927.C26E944000B@finisterre.ee.mobilebroadband>
References: <87zia1lvtt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A48FD266DD5
 for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2017 19:07:22 +0200 (CEST)
In-Reply-To: <87zia1lvtt.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fix ADG flags

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

>From b7165d26bf730567ab081bb9383aff82cd43d9ea Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Sep 2017 04:17:26 +0000
Subject: [PATCH] ASoC: rsnd: fix ADG flags

Current ADG driver is over-writing flags. This patch fixes it.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 938baff86ef2..e11ce5036bcf 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -479,10 +479,10 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	}
 
 	if (req_rate[0] % 48000 == 0)
-		adg->flags = AUDIO_OUT_48;
+		adg->flags |= AUDIO_OUT_48;
 
 	if (of_get_property(np, "clkout-lr-asynchronous", NULL))
-		adg->flags = LRCLK_ASYNC;
+		adg->flags |= LRCLK_ASYNC;
 
 	/*
 	 * This driver is assuming that AUDIO_CLKA/AUDIO_CLKB/AUDIO_CLKC
-- 
2.13.2
