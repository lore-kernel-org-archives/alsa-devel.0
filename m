From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: use snd_soc_update_bits() to avoid Reserve bit on I/O CTRL" to the asoc tree
Date: Wed, 19 Apr 2017 17:33:22 +0100
Message-ID: <E1d0sXi-0001RK-WB@debutante>
References: <877f2hkzcp.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <877f2hkzcp.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: use snd_soc_update_bits() to avoid Reserve bit on I/O CTRL

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

>From 4898b61e40d62ca1652af40935dbbb5d2e5fd93d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Apr 2017 00:40:38 +0000
Subject: [PATCH] ASoC: ak4613: use snd_soc_update_bits() to avoid Reserve bit
 on I/O CTRL

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index e819dd8c82fd..b2dfddead227 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -75,6 +75,12 @@
 #define DFS_DOUBLE_SPEED	(1 << 2)
 #define DFS_QUAD_SPEED		(2 << 2)
 
+/* ICTRL */
+#define ICTRL_MASK	(0x3)
+
+/* OCTRL */
+#define OCTRL_MASK	(0x3F)
+
 struct ak4613_formats {
 	unsigned int width;
 	unsigned int fmt;
@@ -365,8 +371,8 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_update_bits(codec, CTRL1, FMT_MASK, fmt_ctrl);
 	snd_soc_update_bits(codec, CTRL2, DFS_MASK, ctrl2);
 
-	snd_soc_write(codec, ICTRL, priv->ic);
-	snd_soc_write(codec, OCTRL, priv->oc);
+	snd_soc_update_bits(codec, ICTRL, ICTRL_MASK, priv->ic);
+	snd_soc_update_bits(codec, OCTRL, OCTRL_MASK, priv->oc);
 
 hw_params_end:
 	if (ret < 0)
-- 
2.11.0
