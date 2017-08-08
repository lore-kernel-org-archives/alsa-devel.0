From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: move rsnd_ssi_config_init() execute condition into it." to the asoc tree
Date: Tue, 08 Aug 2017 12:06:14 +0100
Message-ID: <E1df2L0-0004wX-4H@finisterre>
References: <873792n94e.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <873792n94e.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: move rsnd_ssi_config_init() execute condition into it.

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

>From bf23c6a3813aac96e0af01565aba012b25c8bae5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 Aug 2017 01:32:08 +0000
Subject: [PATCH] ASoC: rsnd: move rsnd_ssi_config_init() execute condition
 into it.

Make it the same style as other functions

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 49cdc5e007b3..3ee7b2de7dea 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -335,6 +335,9 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	u32 wsr;
 	int is_tdm;
 
+	if (rsnd_ssi_is_parent(mod, io))
+		return;
+
 	is_tdm = rsnd_runtime_is_ssi_tdm(io);
 
 	/*
@@ -472,8 +475,7 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	if (!rsnd_ssi_is_parent(mod, io))
-		rsnd_ssi_config_init(mod, io);
+	rsnd_ssi_config_init(mod, io);
 
 	rsnd_ssi_register_setup(mod);
 
-- 
2.13.2
