From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add detail explanation of L/R conversion timing" to the asoc tree
Date: Tue, 13 Jun 2017 22:08:18 +0100
Message-ID: <E1dKt2w-0000Om-4z@debutante>
References: <87d1aeovg9.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1aeovg9.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add detail explanation of L/R conversion timing

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

>From 8cce431aa26ef24a4d4b820301ac73bf55df7a5e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 9 Jun 2017 00:34:09 +0000
Subject: [PATCH] ASoC: rsnd: add detail explanation of L/R conversion timing

Renesas Sound device *Hardware* L/R and Linux *Software* L/R are
inverted. Because of this background, it needs to convert L/R.
Then, DVC needs *Hardware* L/R, and Linux needs *Software* L/R.
Because Playback/Capture needs different timing, and there is no
explanation about it on source code / git log, this patch adds it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 7c68f9d4a0ed..1bf261d677b7 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -310,6 +310,24 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	u32 val = 0x76543210;
 	u32 mask = ~0;
 
+	/*
+	 * *Hardware* L/R and *Software* L/R are inverted.
+	 * We need to care about inversion timing to control
+	 * Playback/Capture correctly.
+	 * The point is [DVC] needs *Hardware* L/R, [MEM] needs *Software* L/R
+	 *
+	 * sL/R : software L/R
+	 * hL/R : hardware L/R
+	 * (*)  : conversion timing
+	 *
+	 * Playback
+	 *	     sL/R (*) hL/R     hL/R     hL/R      hL/R     hL/R
+	 *	[MEM] -> [SRC] -> [DVC] -> [CMD] -> [SSIU] -> [SSI] -> codec
+	 *
+	 * Capture
+	 *	     hL/R     hL/R      hL/R     hL/R     hL/R (*) sL/R
+	 *	codec -> [SSI] -> [SSIU] -> [SRC] -> [DVC] -> [CMD] -> [MEM]
+	 */
 	if (rsnd_io_is_play(io)) {
 		struct rsnd_mod *src = rsnd_io_to_mod_src(io);
 
-- 
2.11.0
