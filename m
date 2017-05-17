From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove un-used OUF_SRCO/I macro" to the asoc tree
Date: Wed, 17 May 2017 10:52:25 +0100
Message-ID: <E1dAvd3-0006rs-Kl@debutante>
References: <87vap2j385.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87vap2j385.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove un-used OUF_SRCO/I macro

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

>From a9b10dddd6d86e6004a9f310c68888229f75e041 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 May 2017 01:57:27 +0000
Subject: [PATCH] ASoC: rsnd: remove un-used OUF_SRCO/I macro

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 20b5b2ec625e..a8ab26d70a8b 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -12,10 +12,6 @@
 
 #define SRC_NAME "src"
 
-/* SRCx_STATUS */
-#define OUF_SRCO	((1 << 12) | (1 << 13))
-#define OUF_SRCI	((1 <<  9) | (1 <<  8))
-
 /* SCU_SYSTEM_STATUS0/1 */
 #define OUF_SRC(id)	((1 << (id + 16)) | (1 << id))
 
-- 
2.11.0
