From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add support for 8 bit S8 format"
	to the asoc tree
Date: Mon,  3 Sep 2018 14:46:14 +0100 (BST)
Message-ID: <20180903134614.9960411227AE@debutante.sirena.org.uk>
References: <877ek3f4md.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 44DFC2678CD
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:46:15 +0200 (CEST)
In-Reply-To: <877ek3f4md.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jiada Wang <jiada_wang@mentor.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add support for 8 bit S8 format

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

>From ba5d553b7bd71e63d639863e2cb09e0c9543b8b7 Mon Sep 17 00:00:00 2001
From: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Date: Mon, 3 Sep 2018 07:06:29 +0000
Subject: [PATCH] ASoC: rsnd: add support for 8 bit S8 format

This patch adds support for SNDRV_PCM_FMTBIT_S8 format.

Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[Kuninori: tidyup for upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 10 +++++++---
 sound/soc/sh/rcar/ssi.c  |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 8a417768b7ef..cd0ff1eef463 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -102,7 +102,9 @@
 #include "rsnd.h"
 
 #define RSND_RATES SNDRV_PCM_RATE_8000_192000
-#define RSND_FMTS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
+#define RSND_FMTS (SNDRV_PCM_FMTBIT_S8 |\
+		   SNDRV_PCM_FMTBIT_S16_LE |\
+		   SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct of_device_id rsnd_of_match[] = {
 	{ .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
@@ -280,6 +282,8 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	struct device *dev = rsnd_priv_to_dev(priv);
 
 	switch (snd_pcm_format_width(runtime->format)) {
+	case 8:
+		return 16 << 16;
 	case 16:
 		return 8 << 16;
 	case 24:
@@ -331,7 +335,7 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 		target = cmd ? cmd : ssiu;
 	}
 
-	/* Non target mod or 24bit data needs normal DALIGN */
+	/* Non target mod or non 16bit needs normal DALIGN */
 	if ((snd_pcm_format_width(runtime->format) != 16) ||
 	    (mod != target))
 		return 0x76543210;
@@ -367,7 +371,7 @@ u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod)
 	 * HW    24bit data is located as 0x******00
 	 *
 	 */
-	if (snd_pcm_format_width(runtime->format) == 16)
+	if (snd_pcm_format_width(runtime->format) != 24)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(playback_mods); i++) {
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f707f53748bd..765ecc06c7c9 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -400,6 +400,9 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 
 	cr_own &= ~DWL_MASK;
 	switch (snd_pcm_format_width(runtime->format)) {
+	case 8:
+		cr_own |= DWL_8;
+		break;
 	case 16:
 		cr_own |= DWL_16;
 		break;
-- 
2.19.0.rc1
