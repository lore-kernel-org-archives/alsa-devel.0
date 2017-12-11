From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't use runtime->sample_bits"
	to the asoc tree
Date: Mon, 11 Dec 2017 12:13:37 +0000
Message-ID: <E1eOMxl-0004bT-GZ@debutante>
References: <87mv2qui1k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CDB33267583
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 13:13:42 +0100 (CET)
In-Reply-To: <87mv2qui1k.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: don't use runtime->sample_bits

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

>From 41acc8ec04f32abb16e035ca1c9fe4d52819601e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Dec 2017 02:24:23 +0000
Subject: [PATCH] ASoC: rsnd: don't use runtime->sample_bits

Current rsnd driver is judging 16bit/24bit data by using
runtime->sample_bits, but it is indicating physical size,
not format size. This is confusable code.
This patch uses snd_pcm_format_width() to be more correct code.

Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 12 ++++--------
 sound/soc/sh/rcar/ssi.c  |  9 +++------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 8e50b284230d..a96ebebd96de 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -274,10 +274,10 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
-	switch (runtime->sample_bits) {
+	switch (snd_pcm_format_width(runtime->format)) {
 	case 16:
 		return 8 << 16;
-	case 32:
+	case 24:
 		return 0 << 16;
 	}
 
@@ -327,7 +327,7 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	}
 
 	/* Non target mod or 24bit data needs normal DALIGN */
-	if ((runtime->sample_bits != 16) ||
+	if ((snd_pcm_format_width(runtime->format) != 16) ||
 	    (mod != target))
 		return 0x76543210;
 	/* Target mod needs inverted DALIGN when 16bit */
@@ -362,12 +362,8 @@ u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod)
 	 * HW    24bit data is located as 0x******00
 	 *
 	 */
-	switch (runtime->sample_bits) {
-	case 16:
+	if (snd_pcm_format_width(runtime->format) == 16)
 		return 0;
-	case 32:
-		break;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(playback_mods); i++) {
 		tmod = rsnd_io_to_mod(io, mods[i]);
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f21202429000..5a70fdc3c680 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -370,11 +370,11 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	if (rsnd_io_is_play(io))
 		cr_own |= TRMD;
 
-	switch (runtime->sample_bits) {
+	switch (snd_pcm_format_width(runtime->format)) {
 	case 16:
 		cr_own |= DWL_16;
 		break;
-	case 32:
+	case 24:
 		cr_own |= DWL_24;
 		break;
 	}
@@ -677,11 +677,8 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 				   rsnd_ssi_pointer_offset(mod, io, 0));
 		int shift = 0;
 
-		switch (runtime->sample_bits) {
-		case 32:
+		if (snd_pcm_format_width(runtime->format) == 24)
 			shift = 8;
-			break;
-		}
 
 		/*
 		 * 8/16/32 data can be assesse to TDR/RDR register
-- 
2.15.1
