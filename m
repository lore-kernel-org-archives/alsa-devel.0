From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: enable SRC sync even FIN = FOUT"
	to the asoc tree
Date: Thu, 27 Oct 2016 17:47:26 +0100
Message-ID: <E1bznpu-0007fM-VF@debutante>
References: <87h97yfw51.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A1C33266820
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 18:47:36 +0200 (CEST)
In-Reply-To: <87h97yfw51.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: tomoharu.fukawa.eb@renesas.com, Linux-ALSA <alsa-devel@alsa-project.org>, tomohiro.komagata.aj@renesas.com, mitsuhiro.kimura.kc@renesas.com, triet.huynh.jy@renesas.com, hideya.tanaka.nx@renesas.com, naoya.shiiba.nx@renesas.com, hien.dang.eb@renesas.com, ryo.kodama.vz@renesas.com, takeshi.kihara.df@renesas.com, ryo.kataoka.wt@renesas.com, hiroshige.abe.zc@renesas.com, hiroyuki.yokoyama.vx@renesas.com, yuichi.takagi.uh@renesas.com, Chris.Paterson2@renesas.com, kouei.abe.cp@renesas.com, ren.imaoka.vj@renesas.com, Simon <horms@verge.net.au>, takahiko.gomi.yn@renesas.com, satoshi.okada.wz@renesas.com, yoshifumi.hosoya.wj@renesas.com, takamitsu.honda.pv@renesas.com, khiem.nguyen.xt@renesas.com, yuta.wakasawa.pv@renesas.com, Mark Brown <broonie@kernel.org>, naohiro.nishikawa.uj@renesas.com, harunobu.kurokawa.dn@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: enable SRC sync even FIN = FOUT

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

>From 67923f779b8d9d210c5ec98ffb68d9fe5a68df18 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 27 Oct 2016 01:05:21 +0000
Subject: [PATCH] ASoC: rsnd: enable SRC sync even FIN = FOUT

Current SRC (= Sampling Rate Converter) is supporting
SYNC mode and ASYNC mode. Current src.c cares SRC if FIN != FOUT.
Here, SYNC mode will be used for tweak, so it will be used
even FIN = FOUT. This patch enables SRC sync in such situation

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Tested-by: Yuichi Takagi <yuichi.takagi.uh@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index aa24258b9b14..3a8f65bd1bf9 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -189,6 +189,7 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	int use_src = 0;
 	u32 fin, fout;
 	u32 ifscr, fsrate, adinr;
 	u32 cr, route;
@@ -214,6 +215,8 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 		return;
 	}
 
+	use_src = (fin != fout) | rsnd_src_sync_is_enabled(mod);
+
 	/*
 	 *	SRC_ADINR
 	 */
@@ -225,7 +228,7 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	 */
 	ifscr = 0;
 	fsrate = 0;
-	if (fin != fout) {
+	if (use_src) {
 		u64 n;
 
 		ifscr = 1;
@@ -239,7 +242,7 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	 */
 	cr	= 0x00011110;
 	route	= 0x0;
-	if (fin != fout) {
+	if (use_src) {
 		route	= 0x1;
 
 		if (rsnd_src_sync_is_enabled(mod)) {
-- 
2.8.1
