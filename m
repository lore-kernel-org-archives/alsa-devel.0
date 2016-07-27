From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Fixup SRCm_IFSVR calculate method" to the asoc tree
Date: Wed, 27 Jul 2016 20:09:41 +0100
Message-ID: <E1bSUD7-0003qv-0l@debutante>
References: <87h9bewkwu.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h9bewkwu.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, tomoharu.fukawa.eb@renesas.com, Linux-ALSA <alsa-devel@alsa-project.org>, naoya.shiiba.nx@renesas.com, mitsuhiro.kimura.kc@renesas.com, hideya.tanaka.nx@renesas.com, tomohiro.komagata.aj@renesas.com, khiem.nguyen.xt@rvc.renesas.com, hien.dang.eb@renesas.com, ryo.kodama.vz@renesas.com, takeshi.kihara.df@renesas.com, ryo.kataoka.wt@renesas.com, takamitsu.honda.pv@renesas.com, hiroyuki.yokoyama.vx@renesas.com, Chris.Paterson2@renesas.com, kouei.abe.cp@renesas.com, ren.imaoka.vj@renesas.com, Simon <horms@verge.net.au>, takahiko.gomi.yn@renesas.com, yuta.wakasawa.pv@renesas.com, yoshifumi.hosoya.wj@renesas.com, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, harunobu.kurokawa.dn@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Fixup SRCm_IFSVR calculate method

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

>From 24e06559a8f52889b3dd581d2ddd572421a73ae0 Mon Sep 17 00:00:00 2001
From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Date: Mon, 25 Jul 2016 01:52:43 +0000
Subject: [PATCH] ASoC: rsnd: Fixup SRCm_IFSVR calculate method

This patch fixes the calculation accuracy degradation of SRCm_IFSVR
register value.

Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index e39f916d0f2f..969a5169de25 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -226,8 +226,12 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	ifscr = 0;
 	fsrate = 0;
 	if (fin != fout) {
+		u64 n;
+
 		ifscr = 1;
-		fsrate = 0x0400000 / fout * fin;
+		n = (u64)0x0400000 * fin;
+		do_div(n, fout);
+		fsrate = n;
 	}
 
 	/*
-- 
2.8.1
