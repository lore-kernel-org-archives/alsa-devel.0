From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup src->convert_rate reset timing" to the asoc tree
Date: Thu, 06 Apr 2017 11:48:56 +0100
Message-ID: <E1cw4yG-0004QS-2a@debutante>
References: <87vaqi3stx.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87vaqi3stx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup src->convert_rate reset timing

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

>From fc99d23f6d3ec6b17772915114018444393e0ad1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Apr 2017 07:24:36 +0000
Subject: [PATCH] ASoC: rsnd: tidyup src->convert_rate reset timing

Current src->convert_rate will be set on .hw_param, and
be reset on .quit timing.
But, .hw_param will not be called again if user did Ctrl-Z + fg.
It should be reset on initial of .hw_param to keep its value.
Here, ctu.c already do this.
This patch solves this issue, other wise, MIXed sound will be
strange if user did like below.

	> aplay -D plughw:0,0 sound_44100.wav &
	> aplay -D plughw:0,1 sound_96000.wav
	> Ctrl-Z
	> fg # 96kHz will be played as 44.1kHz

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 42db48db09ba..20b5b2ec625e 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -167,6 +167,7 @@ static int rsnd_src_hw_params(struct rsnd_mod *mod,
 	 *	dpcm_fe_dai_hw_params()
 	 *	dpcm_be_dai_hw_params()
 	 */
+	src->convert_rate = 0;
 	if (fe->dai_link->dynamic) {
 		int stream = substream->stream;
 		struct snd_soc_dpcm *dpcm;
@@ -414,8 +415,6 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 
 	rsnd_mod_power_off(mod);
 
-	src->convert_rate = 0;
-
 	/* reset sync convert_rate */
 	src->sync.val = 0;
 
-- 
2.11.0
