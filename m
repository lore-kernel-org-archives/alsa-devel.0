From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: src: make sure SRC soft reset" to
	the asoc tree
Date: Thu, 16 Jul 2015 22:30:08 +0100
Message-ID: <E1ZFqjI-0004mX-17@finisterre>
References: <87si8pvqvx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE2A32666C0
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:30:13 +0200 (CEST)
In-Reply-To: <87si8pvqvx.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: src: make sure SRC soft reset

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

>From 379febfd2e30ec8db5baccd9f9403bf650c6afa1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:12:18 +0000
Subject: [PATCH] ASoC: rsnd: src: make sure SRC soft reset

Renesas SCU (Sampling Rate Convert Unit) includes SRC/CTU/MIX/DVC,
and these have similar register. xxxRSR (Software reset Register) is one
of them. These xxxRSR need be set to 1 to 0 when software reset.
Current rsnd driver has src.c / dvc.c, and we will have mix.c.
It is readable if these have same named function.
This patch adds rsnd_src_soft_reset() and make sure it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 0b06ac8..74ab644 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -118,6 +118,12 @@ struct rsnd_src {
 /*
  *		Gen1/Gen2 common functions
  */
+static void rsnd_src_soft_reset(struct rsnd_mod *mod)
+{
+	rsnd_mod_write(mod, SRC_SWRSR, 0);
+	rsnd_mod_write(mod, SRC_SWRSR, 1);
+}
+
 static struct dma_chan *rsnd_src_dma_req(struct rsnd_dai_stream *io,
 					 struct rsnd_mod *mod)
 {
@@ -294,10 +300,6 @@ static int rsnd_src_set_convert_rate(struct rsnd_mod *mod,
 	if (convert_rate)
 		fsrate = 0x0400000 / convert_rate * runtime->rate;
 
-	/* set/clear soft reset */
-	rsnd_mod_write(mod, SRC_SWRSR, 0);
-	rsnd_mod_write(mod, SRC_SWRSR, 1);
-
 	/* Set channel number and output bit length */
 	rsnd_mod_write(mod, SRC_ADINR, rsnd_get_adinr(mod, io));
 
@@ -358,6 +360,8 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 
 	rsnd_mod_hw_start(mod);
 
+	rsnd_src_soft_reset(mod);
+
 	src->err = 0;
 
 	/* reset sync convert_rate */
-- 
2.1.4
