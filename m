From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fix sound route path when using
	SRC6/SRC9" to the asoc tree
Date: Mon, 13 Mar 2017 16:59:18 +0000
Message-ID: <E1cnTJW-0005GE-Dm@debutante>
References: <87r32hmzdp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 20154266E43
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:59:27 +0100 (CET)
In-Reply-To: <87r32hmzdp.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Cc: Simon <horms@verge.net.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fix sound route path when using SRC6/SRC9

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

>From a1c2ff53726907aff5feb37e4cfd45c1ff626431 Mon Sep 17 00:00:00 2001
From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Date: Wed, 1 Mar 2017 03:51:00 +0000
Subject: [PATCH] ASoC: rsnd: fix sound route path when using SRC6/SRC9

This patch fixes the problem that the missing value of the route path
setting table and incorrect values are set in the CMD_ROUTE_SELECT
register.

Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
[Kuninori: shared data on MIX and non-MIX case]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index abb5eaac854a..7d92a24b7cfa 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -31,23 +31,24 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 	struct rsnd_mod *mix = rsnd_io_to_mod_mix(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	u32 data;
+	u32 path[] = {
+		[1] = 1 << 0,
+		[5] = 1 << 8,
+		[6] = 1 << 12,
+		[9] = 1 << 15,
+	};
 
 	if (!mix && !dvc)
 		return 0;
 
+	if (ARRAY_SIZE(path) < rsnd_mod_id(mod) + 1)
+		return -ENXIO;
+
 	if (mix) {
 		struct rsnd_dai *rdai;
 		struct rsnd_mod *src;
 		struct rsnd_dai_stream *tio;
 		int i;
-		u32 path[] = {
-			[0] = 0,
-			[1] = 1 << 0,
-			[2] = 0,
-			[3] = 0,
-			[4] = 0,
-			[5] = 1 << 8
-		};
 
 		/*
 		 * it is assuming that integrater is well understanding about
@@ -70,16 +71,19 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 	} else {
 		struct rsnd_mod *src = rsnd_io_to_mod_src(io);
 
-		u32 path[] = {
-			[0] = 0x30000,
-			[1] = 0x30001,
-			[2] = 0x40000,
-			[3] = 0x10000,
-			[4] = 0x20000,
-			[5] = 0x40100
+		u8 cmd_case[] = {
+			[0] = 0x3,
+			[1] = 0x3,
+			[2] = 0x4,
+			[3] = 0x1,
+			[4] = 0x2,
+			[5] = 0x4,
+			[6] = 0x1,
+			[9] = 0x2,
 		};
 
-		data = path[rsnd_mod_id(src)];
+		data = path[rsnd_mod_id(src)] |
+			cmd_case[rsnd_mod_id(src)] << 16;
 	}
 
 	dev_dbg(dev, "ctu/mix path = 0x%08x", data);
-- 
2.11.0
