From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup clock start checker" to the
	asoc tree
Date: Wed, 31 Oct 2018 10:34:50 +0000 (GMT)
Message-ID: <20181031103450.A0ADE440078@finisterre.ee.mobilebroadband>
References: <87ftwn0x15.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C2DB2675B8
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2018 11:34:51 +0100 (CET)
In-Reply-To: <87ftwn0x15.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, RYO KATAOKA <ryo.kataoka.wt@renesas.com>, TAKAMITSU HONDA <takamitsu.honda.pv@renesas.com>, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, TAKESHI KIHARA <takeshi.kihara.df@renesas.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Mark Brown <broonie@kernel.org>, HIROYUKI YOKOYAMA <hiroyuki.yokoyama.vx@renesas.com>, YOSHIYUKI ITO <yoshiyuki.ito.ub@renesas.com>, YUTA WAKASAWA <yuta.wakasawa.pv@renesas.com>, Masao Nomura <masao.nomura.ra@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup clock start checker

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

>From 3ee9a76a8c5a10e1bfb04b81db767c6d562ddaf3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 31 Oct 2018 00:48:12 +0000
Subject: [PATCH] ASoC: rsnd: fixup clock start checker

commit 4d230d12710646 ("ASoC: rsnd: fixup not to call clk_get/set under
non-atomic") fixuped clock start timing. But it exchanged clock start
checker from ssi->usrcnt to ssi->rate.

Current rsnd_ssi_master_clk_start() is called from .prepare,
but some player (for example GStreamer) might calls it many times.
In such case, the checker might returns error even though it was not
error. It should check ssi->usrcnt instead of ssi->rate.
This patch fixup it. Without this patch, GStreamer can't switch
48kHz / 44.1kHz.

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index fcb4df23248c..6ec78f3096dd 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -306,7 +306,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
-	if (ssi->rate) {
+	if (ssi->usrcnt > 1) {
 		if (ssi->rate != rate) {
 			dev_err(dev, "SSI parent/child should use same rate\n");
 			return -EINVAL;
-- 
2.19.0
