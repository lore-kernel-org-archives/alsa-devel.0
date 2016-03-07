From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: SRC sync mode is not related to
	clock master mode" to the asoc tree
Date: Mon, 07 Mar 2016 14:42:54 +0700
Message-ID: <E1acpoc-00073m-Ke@finisterre>
References: <87io0yyj74.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4F5B2617BB
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:42:57 +0100 (CET)
In-Reply-To: <87io0yyj74.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: SRC sync mode is not related to clock master mode

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

>From b5ebbb3a16c631c776f6619dff8ee86da21cca6f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Mar 2016 05:06:46 +0000
Subject: [PATCH] ASoC: rsnd: SRC sync mode is not related to clock master mode

SRC sync mode needs to control its clock (= for in/out). 1st but codec
side clock

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 541a478cf157..ab974afe79eb 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -474,7 +474,6 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			    struct rsnd_dai_stream *io,
 			    struct snd_soc_pcm_runtime *rtd)
 {
-	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	int ret;
 
@@ -483,12 +482,6 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 	 */
 
 	/*
-	 * SRC sync convert needs clock master
-	 */
-	if (!rsnd_rdai_is_clk_master(rdai))
-		return 0;
-
-	/*
 	 * It can't use SRC Synchronous convert
 	 * when Capture if it uses CMD
 	 */
-- 
2.7.0
