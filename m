From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: src: add rsnd_src_halt()" to the
	asoc tree
Date: Tue, 01 Dec 2015 22:59:57 +0000
Message-ID: <E1a3ttt-0006ys-Th@debutante>
References: <8737vnub29.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 770582661B5
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 00:00:02 +0100 (CET)
In-Reply-To: <8737vnub29.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: src: add rsnd_src_halt()

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

>From 475a361a6f2c7c690fd59a8f5224615e781cc3bd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:51:35 +0000
Subject: [PATCH] ASoC: rsnd: src: add rsnd_src_halt()

Based on datasheet process

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 5239c3d7a3d0..b438538a0a69 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -76,6 +76,12 @@ static void rsnd_src_activation(struct rsnd_mod *mod)
 	rsnd_mod_write(mod, SRC_SWRSR, 1);
 }
 
+static void rsnd_src_halt(struct rsnd_mod *mod)
+{
+	rsnd_mod_write(mod, SRC_SRCIR, 1);
+	rsnd_mod_write(mod, SRC_SWRSR, 0);
+}
+
 static struct dma_chan *rsnd_src_dma_req(struct rsnd_dai_stream *io,
 					 struct rsnd_mod *mod)
 {
@@ -406,6 +412,8 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 	/* stop both out/in */
 	rsnd_mod_write(mod, SRC_CTRL, 0);
 
+	rsnd_src_halt(mod);
+
 	rsnd_mod_power_off(mod);
 
 	if (src->err)
-- 
2.6.2
