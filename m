From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: need to call nolock_stop if nolock_start was failed" to the asoc tree
Date: Wed, 17 May 2017 10:52:06 +0100
Message-ID: <E1dAvck-0006le-36@debutante>
References: <878tlv535x.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <878tlv535x.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: need to call nolock_stop if nolock_start was failed

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

>From 2adcea7e22d382e2becf5671e92296f79672b957 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 May 2017 07:59:20 +0000
Subject: [PATCH] ASoC: rsnd: need to call nolock_stop if nolock_start was
 failed

rsnd_dai_call() is counting the called number of start/stop functions.
nolock_stop should be called if nolock_start was failed.
Otherwise, nolock_start doesn't called in 2nd play.
This patch solved this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1744015408c3..3c47af1990cb 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -715,11 +715,16 @@ static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
 {
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
 	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
+	int ret;
 
 	/*
 	 * call rsnd_dai_call without spinlock
 	 */
-	return rsnd_dai_call(nolock_start, io, priv);
+	ret = rsnd_dai_call(nolock_start, io, priv);
+	if (ret < 0)
+		rsnd_dai_call(nolock_stop, io, priv);
+
+	return ret;
 }
 
 static void rsnd_soc_dai_shutdown(struct snd_pcm_substream *substream,
-- 
2.11.0
