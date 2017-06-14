From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: reduce confusable macro parameter magic" to the asoc tree
Date: Wed, 14 Jun 2017 11:12:50 +0100
Message-ID: <E1dL5IA-0007ec-IW@debutante>
References: <87h8zj81hl.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h8zj81hl.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: reduce confusable macro parameter magic

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

>From f30b4ca4447095f6923b59ffaa25ca6a54daffac Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Jun 2017 07:41:43 +0000
Subject: [PATCH] ASoC: rsnd: reduce confusable macro parameter magic

rsnd_dai_call() macro is using "priv" inside.
Thus, if caller function doesn't have "priv" related operation, strange
phenomenon occur which code is using "priv", but compiler indicates
"unused variable 'priv'".

>From code point of view, it is not problem, but it is very confusable.
This patch removes "priv" from rsnd_dai_call() macro, and adds "priv"
on caller function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 0bb99aa70e29..1b536d140e49 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -488,8 +488,7 @@ static int rsnd_status_update(u32 *status,
 
 #define rsnd_dai_call(fn, io, param...)					\
 ({									\
-	struct rsnd_priv *priv = rsnd_io_to_priv(io);			\
-	struct device *dev = rsnd_priv_to_dev(priv);			\
+	struct device *dev = rsnd_priv_to_dev(rsnd_io_to_priv(io));	\
 	struct rsnd_mod *mod;						\
 	int is_play = rsnd_io_is_play(io);				\
 	int ret = 0, i;							\
@@ -741,6 +740,7 @@ static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
 	int ret;
 
@@ -758,6 +758,7 @@ static void rsnd_soc_dai_shutdown(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
 
 	/*
-- 
2.11.0
