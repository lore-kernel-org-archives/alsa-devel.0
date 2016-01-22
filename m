From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: select each SRC correctly for CMD
	data path" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:44 +0000
Message-ID: <E1aMgQ0-000489-Ud@debutante>
References: <87fuxr4s06.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66B4026067F
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:49 +0100 (CET)
In-Reply-To: <87fuxr4s06.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: select each SRC correctly for CMD data path

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

>From 72154e50728e8a08940332db20884b63dfa6590d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:57:37 +0000
Subject: [PATCH] ASoC: rsnd: select each SRC correctly for CMD data path

To select CMD data patch, it should use correct SRC from each stream
in MUX case. But current code is selecting SRC from fixed stream.
This patch solves this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index e77e4935b4ea..4b2d50d9a686 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -29,7 +29,6 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 {
 	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
 	struct rsnd_mod *mix = rsnd_io_to_mod_mix(io);
-	struct rsnd_mod *src = rsnd_io_to_mod_src(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	u32 data;
 
@@ -38,6 +37,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 
 	if (mix) {
 		struct rsnd_dai *rdai;
+		struct rsnd_mod *src;
 		struct rsnd_dai_stream *tio;
 		int i;
 		u32 path[] = {
@@ -57,15 +57,19 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 		data = 0;
 		for_each_rsnd_dai(rdai, priv, i) {
 			tio = &rdai->playback;
+			src = rsnd_io_to_mod_src(tio);
 			if (mix == rsnd_io_to_mod_mix(tio))
 				data |= path[rsnd_mod_id(src)];
 
 			tio = &rdai->capture;
+			src = rsnd_io_to_mod_src(tio);
 			if (mix == rsnd_io_to_mod_mix(tio))
 				data |= path[rsnd_mod_id(src)];
 		}
 
 	} else {
+		struct rsnd_mod *src = rsnd_io_to_mod_src(io);
+
 		u32 path[] = {
 			[0] = 0x30000,
 			[1] = 0x30001,
-- 
2.7.0.rc3
