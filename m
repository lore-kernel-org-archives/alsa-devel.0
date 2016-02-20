From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: setup SRC_ROUTE_MODE0 before
	SRC_SRCIR" to the asoc tree
Date: Sun, 21 Feb 2016 02:16:19 +0900
Message-ID: <E1aXB8l-0008SM-A4@finisterre>
References: <87povutp6u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E2E265162
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:25 +0100 (CET)
In-Reply-To: <87povutp6u.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: setup SRC_ROUTE_MODE0 before SRC_SRCIR

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

>From 0fbab951db17085fbb521b3a50550990b763bdf4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:13:45 +0000
Subject: [PATCH] ASoC: rsnd: setup SRC_ROUTE_MODE0 before SRC_SRCIR

SRC_ROUTE_MODE0 determines whether to use SRC.
Thus, it should be setup before SRC_SRCIR.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index ab5f131..dab0954 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -249,6 +249,8 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 		break;
 	}
 
+	rsnd_mod_write(mod, SRC_ROUTE_MODE0, route);
+
 	rsnd_mod_write(mod, SRC_SRCIR, 1);	/* initialize */
 	rsnd_mod_write(mod, SRC_ADINR, adinr);
 	rsnd_mod_write(mod, SRC_IFSCR, ifscr);
@@ -258,7 +260,6 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, SRC_BSISR, bsisr);
 	rsnd_mod_write(mod, SRC_SRCIR, 0);	/* cancel initialize */
 
-	rsnd_mod_write(mod, SRC_ROUTE_MODE0, route);
 	rsnd_mod_write(mod, SRC_I_BUSIF_MODE, 1);
 	rsnd_mod_write(mod, SRC_O_BUSIF_MODE, 1);
 	rsnd_mod_write(mod, SRC_BUSIF_DALIGN, rsnd_get_dalign(mod, io));
-- 
2.7.0
