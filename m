From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup rsnd_ssi_master_clk_start()
	user count check" to the asoc tree
Date: Wed,  6 Feb 2019 18:17:34 +0000 (GMT)
Message-ID: <20190206181734.097F61127EA3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 231CC267917
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 19:17:35 +0100 (CET)
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
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count check

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d9111d36024de07784f2e1ba2ccf70b16035f378 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 5 Feb 2019 09:46:43 +0900
Subject: [PATCH] ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count
 check

commit 4d230d1271064 ("ASoC: rsnd: fixup not to call clk_get/set
under non-atomic") added new rsnd_ssi_prepare() and moved
rsnd_ssi_master_clk_start() to .prepare.
But, ssi user count (= ssi->usrcnt) is incremented at .init
(= rsnd_ssi_init()).
Because of these timing exchange, ssi->usrcnt check at
rsnd_ssi_master_clk_start() should be adjusted.
Otherwise, 2nd master clock setup will be no check.
This patch fixup this issue.

Fixes: commit 4d230d1271064 ("ASoC: rsnd: fixup not to call clk_get/set under non-atomic")
Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Reported-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 45ef295743ec..f5afab631abb 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -286,7 +286,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
-	if (ssi->usrcnt > 1) {
+	if (ssi->usrcnt > 0) {
 		if (ssi->rate != rate) {
 			dev_err(dev, "SSI parent/child should use same rate\n");
 			return -EINVAL;
-- 
2.20.1
