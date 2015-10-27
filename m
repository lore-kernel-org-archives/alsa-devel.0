From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup rsnd_dma_of_path method for
	mod base common method" to the asoc tree
Date: Tue, 27 Oct 2015 13:48:51 +0900
Message-ID: <E1ZqwBn-0004rU-79@finisterre>
References: <87si4y3u4d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 711542651AC
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:00 +0100 (CET)
In-Reply-To: <87si4y3u4d.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup rsnd_dma_of_path method for mod base common method

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

>From 144e80f562dd1f53948696c871552752b2055430 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:40:19 +0000
Subject: [PATCH] ASoC: rsnd: fixup rsnd_dma_of_path method for mod base common
 method

Renesas sound needs many devices
(SSI/SSIU/SRC/CTU/MIX/DVC/CMD/AudioDMAC/AudioDMACpp).
SSI/SRC/CTU/MIX/DVC are implemented as module.
SSI parent, SSIU are implemented as part of SSI
CMD is implemented as part of CTU/MIX/DVC
AudioDMAC/AudioDMACpp are implemented as part of SSI/SRC
It is nice sense that these all devices are implemented as mod.

Current rsnd_dma_of_path is assuming that all mods are related to DMA.
But it will be wrong. This patch tidyup this wrong assumption

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 705e524b..697f882 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -533,7 +533,7 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 	struct rsnd_mod *mod_start, *mod_end;
 	struct rsnd_priv *priv = rsnd_mod_to_priv(this);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	int nr, i;
+	int nr, i, idx;
 
 	if (!ssi)
 		return;
@@ -562,23 +562,24 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 	mod_start	= (is_play) ? NULL : ssi;
 	mod_end		= (is_play) ? ssi  : NULL;
 
-	mod[0] = mod_start;
+	idx = 0;
+	mod[idx++] = mod_start;
 	for (i = 1; i < nr; i++) {
 		if (src) {
-			mod[i] = src;
+			mod[idx++] = src;
 			src = NULL;
 		} else if (ctu) {
-			mod[i] = ctu;
+			mod[idx++] = ctu;
 			ctu = NULL;
 		} else if (mix) {
-			mod[i] = mix;
+			mod[idx++] = mix;
 			mix = NULL;
 		} else if (dvc) {
-			mod[i] = dvc;
+			mod[idx++] = dvc;
 			dvc = NULL;
 		}
 	}
-	mod[i] = mod_end;
+	mod[idx] = mod_end;
 
 	/*
 	 *		| SSI | SRC |
@@ -587,8 +588,8 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 	 * !is_play	|  *  |  o  |
 	 */
 	if ((this == ssi) == (is_play)) {
-		*mod_from	= mod[nr - 1];
-		*mod_to		= mod[nr];
+		*mod_from	= mod[idx - 1];
+		*mod_to		= mod[idx];
 	} else {
 		*mod_from	= mod[0];
 		*mod_to		= mod[1];
@@ -596,7 +597,7 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 
 	dev_dbg(dev, "module connection (this is %s[%d])\n",
 		rsnd_mod_name(this), rsnd_mod_id(this));
-	for (i = 0; i <= nr; i++) {
+	for (i = 0; i <= idx; i++) {
 		dev_dbg(dev, "  %s[%d]%s\n",
 		       rsnd_mod_name(mod[i]), rsnd_mod_id(mod[i]),
 		       (mod[i] == *mod_from) ? " from" :
-- 
2.6.1
