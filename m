From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: make sure SRC In Rate feature
	enablement" to the asoc tree
Date: Tue, 10 Nov 2015 19:06:27 +0000
Message-ID: <E1ZwEFP-0002hm-Ia@debutante>
References: <87lha6jokb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E51C626053D
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 20:06:34 +0100 (CET)
In-Reply-To: <87lha6jokb.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: make sure SRC In Rate feature enablement

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

>From 7115cb913d9e2d68583cf76578b32568bc8ea83f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 07:39:17 +0000
Subject: [PATCH] ASoC: rsnd: make sure SRC In Rate feature enablement

SRC In Rate convert feature cannot be used if data path is using DVC.
This patch judges it, and not allowed to use it in such case.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 261b50217c48..68b439ed22d7 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -923,6 +923,7 @@ static int rsnd_src_pcm_new_gen2(struct rsnd_mod *mod,
 			    struct snd_soc_pcm_runtime *rtd)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	int ret;
 
@@ -937,6 +938,12 @@ static int rsnd_src_pcm_new_gen2(struct rsnd_mod *mod,
 		return 0;
 
 	/*
+	 * SRC In doesn't work if DVC was enabled
+	 */
+	if (dvc && !rsnd_io_is_play(io))
+		return 0;
+
+	/*
 	 * enable sync convert
 	 */
 	ret = rsnd_kctrl_new_s(mod, io, rtd,
-- 
2.6.2
