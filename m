From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't enable SRC Sync mode when
	Capture with CMD" to the asoc tree
Date: Mon, 07 Mar 2016 14:42:56 +0700
Message-ID: <E1acpoe-00074H-A2@finisterre>
References: <87k2leyj7u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 525582619BE
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:42:59 +0100 (CET)
In-Reply-To: <87k2leyj7u.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: don't enable SRC Sync mode when Capture with CMD

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

>From 61a219fe192412bca6c26657a4b0c99c67a3e7fc Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Mar 2016 05:06:17 +0000
Subject: [PATCH] ASoC: rsnd: don't enable SRC Sync mode when Capture with CMD

It can't use SRC Synchronous convert when Capture if it uses CMD,
because no one provide out side clocks.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 8e1177aea6b1..541a478cf157 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -475,7 +475,6 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			    struct snd_soc_pcm_runtime *rtd)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	int ret;
 
@@ -490,9 +489,10 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 		return 0;
 
 	/*
-	 * SRC In doesn't work if DVC was enabled
+	 * It can't use SRC Synchronous convert
+	 * when Capture if it uses CMD
 	 */
-	if (dvc && !rsnd_io_is_play(io))
+	if (rsnd_io_to_mod_cmd(io) && !rsnd_io_is_play(io))
 		return 0;
 
 	/*
-- 
2.7.0
