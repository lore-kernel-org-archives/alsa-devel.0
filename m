From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_ssi_run_mods() needs to care
	ssi_parent_mod" to the asoc tree
Date: Wed, 01 Nov 2017 10:07:05 +0000
Message-ID: <E1e9pvN-0004Ek-AJ@debutante>
References: <871slizdap.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D1913267141
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 11:07:08 +0100 (CET)
In-Reply-To: <871slizdap.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rsnd_ssi_run_mods() needs to care ssi_parent_mod

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

>From 21781e87881f9c420871b1d1f3f29d4cd7bffb10 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 1 Nov 2017 07:16:58 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_ssi_run_mods() needs to care ssi_parent_mod

SSI parent mod might be NULL. ssi_parent_mod() needs to care
about it. Otherwise, it uses negative shift.
This patch fixes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 58e3420a1f05..43c31d153ea6 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -195,10 +195,15 @@ static u32 rsnd_ssi_run_mods(struct rsnd_dai_stream *io)
 {
 	struct rsnd_mod *ssi_mod = rsnd_io_to_mod_ssi(io);
 	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
+	u32 mods;
 
-	return rsnd_ssi_multi_slaves_runtime(io) |
-		1 << rsnd_mod_id(ssi_mod) |
-		1 << rsnd_mod_id(ssi_parent_mod);
+	mods = rsnd_ssi_multi_slaves_runtime(io) |
+		1 << rsnd_mod_id(ssi_mod);
+
+	if (ssi_parent_mod)
+		mods |= 1 << rsnd_mod_id(ssi_parent_mod);
+
+	return mods;
 }
 
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io)
-- 
2.15.0.rc2
