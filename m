From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: more clear rsnd_get_dalign() for
	DALIGN" to the asoc tree
Date: Fri, 08 Dec 2017 18:54:49 +0000
Message-ID: <E1eNNnN-00049U-Uh@debutante>
References: <87k1xxiw68.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 25754267255
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 19:54:55 +0100 (CET)
In-Reply-To: <87k1xxiw68.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: more clear rsnd_get_dalign() for DALIGN

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

>From a914e44693d41ba43604afa8c435c98a6d2c7cb1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 8 Dec 2017 06:23:11 +0000
Subject: [PATCH] ASoC: rsnd: more clear rsnd_get_dalign() for DALIGN

On Renesas sound device, DALIGN which exchanges channel position
is needed because SW and HW are using defferent data order if
16bit data. It is not needed when 24bit data.
rsnd_get_dalign() returns necessary value, but it was confusable
code. This patch makes it more simple.

Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index d76ad46a6fd9..8e50b284230d 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -294,11 +294,12 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	struct rsnd_mod *ssiu = rsnd_io_to_mod_ssiu(io);
 	struct rsnd_mod *target;
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	u32 val = 0x76543210;
-	u32 mask = ~0;
 
 	/*
-	 * *Hardware* L/R and *Software* L/R are inverted.
+	 * *Hardware* L/R and *Software* L/R are inverted for 16bit data.
+	 *	    31..16 15...0
+	 *	HW: [L ch] [R ch]
+	 *	SW: [R ch] [L ch]
 	 * We need to care about inversion timing to control
 	 * Playback/Capture correctly.
 	 * The point is [DVC] needs *Hardware* L/R, [MEM] needs *Software* L/R
@@ -325,27 +326,13 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 		target = cmd ? cmd : ssiu;
 	}
 
-	mask <<= runtime->channels * 4;
-	val = val & mask;
-
-	switch (runtime->sample_bits) {
-	case 16:
-		val |= 0x67452301 & ~mask;
-		break;
-	case 32:
-		val |= 0x76543210 & ~mask;
-		break;
-	}
-
-	/*
-	 * exchange channeles on SRC if possible,
-	 * otherwise, R/L volume settings on DVC
-	 * changes inverted channels
-	 */
-	if (mod == target)
-		return val;
-	else
+	/* Non target mod or 24bit data needs normal DALIGN */
+	if ((runtime->sample_bits != 16) ||
+	    (mod != target))
 		return 0x76543210;
+	/* Target mod needs inverted DALIGN when 16bit */
+	else
+		return 0x67452301;
 }
 
 u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod)
-- 
2.15.1
