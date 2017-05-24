From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: SSI PIO adjust to 24bit mode" to the asoc tree
Date: Wed, 24 May 2017 18:42:07 +0100
Message-ID: <E1dDaIR-0002tb-Hw@debutante>
References: <87k257oy6t.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87k257oy6t.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: SSI PIO adjust to 24bit mode

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

>From 7819a942de7b993771bd9377babc80485fe7606b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 May 2017 01:17:10 +0000
Subject: [PATCH] ASoC: rsnd: SSI PIO adjust to 24bit mode

commit 90431eb49bff ("ASoC: rsnd: don't use PDTA bit for 24bit on SSI")
fixups 24bit mode data alignment, but PIO was not cared.
This patch fixes PIO mode 24bit data alignment

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index c224695c1484..91e5c07911b4 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -550,6 +550,13 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 		u32 *buf = (u32 *)(runtime->dma_area +
 				   rsnd_dai_pointer_offset(io, 0));
+		int shift = 0;
+
+		switch (runtime->sample_bits) {
+		case 32:
+			shift = 8;
+			break;
+		}
 
 		/*
 		 * 8/16/32 data can be assesse to TDR/RDR register
@@ -557,9 +564,9 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 		 * see rsnd_ssi_init()
 		 */
 		if (rsnd_io_is_play(io))
-			rsnd_mod_write(mod, SSITDR, *buf);
+			rsnd_mod_write(mod, SSITDR, (*buf) << shift);
 		else
-			*buf = rsnd_mod_read(mod, SSIRDR);
+			*buf = (rsnd_mod_read(mod, SSIRDR) >> shift);
 
 		elapsed = rsnd_dai_pointer_update(io, sizeof(*buf));
 	}
-- 
2.11.0
