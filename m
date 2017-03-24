From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: enable PCM RATE untile 192000" to the asoc tree
Date: Fri, 24 Mar 2017 19:16:28 +0000
Message-ID: <E1crUhI-00064v-6J@debutante>
References: <87shm5oonl.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shm5oonl.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: enable PCM RATE untile 192000

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

>From dc2721564f6da549f6eb29ac5bca28d65beadcb7 Mon Sep 17 00:00:00 2001
From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Date: Wed, 22 Mar 2017 05:43:35 +0000
Subject: [PATCH] ASoC: rcar: enable PCM RATE untile 192000

R-Car sound can handle untile 192000 rate.

Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 72966bdd3daa..3e852e00b277 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -96,7 +96,7 @@
 #include <linux/pm_runtime.h>
 #include "rsnd.h"
 
-#define RSND_RATES SNDRV_PCM_RATE_8000_96000
+#define RSND_RATES SNDRV_PCM_RATE_8000_192000
 #define RSND_FMTS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
 
 static const struct of_device_id rsnd_of_match[] = {
-- 
2.11.0
