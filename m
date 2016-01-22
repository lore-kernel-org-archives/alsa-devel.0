From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't overwrite io on
	rsnd_cmd_init()" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:45 +0000
Message-ID: <E1aMgQ1-00048d-SA@debutante>
References: <87h9i74s0p.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 456A5260701
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:50 +0100 (CET)
In-Reply-To: <87h9i74s0p.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: don't overwrite io on rsnd_cmd_init()

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

>From 654a12b86305b1fd78279616f876b8d21d146a5e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:57:17 +0000
Subject: [PATCH] ASoC: rsnd: don't overwrite io on rsnd_cmd_init()

Current rsnd_cmd_init() overwrites "io" which will be used end of this
function. This patch solved this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index cd1f064e63c4..e77e4935b4ea 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -38,6 +38,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 
 	if (mix) {
 		struct rsnd_dai *rdai;
+		struct rsnd_dai_stream *tio;
 		int i;
 		u32 path[] = {
 			[0] = 0,
@@ -55,12 +56,12 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 		 */
 		data = 0;
 		for_each_rsnd_dai(rdai, priv, i) {
-			io = &rdai->playback;
-			if (mix == rsnd_io_to_mod_mix(io))
+			tio = &rdai->playback;
+			if (mix == rsnd_io_to_mod_mix(tio))
 				data |= path[rsnd_mod_id(src)];
 
-			io = &rdai->capture;
-			if (mix == rsnd_io_to_mod_mix(io))
+			tio = &rdai->capture;
+			if (mix == rsnd_io_to_mod_mix(tio))
 				data |= path[rsnd_mod_id(src)];
 		}
 
-- 
2.7.0.rc3
