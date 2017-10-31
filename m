From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Don't check SSISR::DIRQ when
	Capture" to the asoc tree
Date: Tue, 31 Oct 2017 11:21:17 +0000
Message-ID: <E1e9Ubd-0002nC-RG@debutante>
References: <87she0xim3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FEDF26728A
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 12:21:23 +0100 (CET)
In-Reply-To: <87she0xim3.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: Don't check SSISR::DIRQ when Capture

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

>From ce548931207c0d0059bd90171e2c458f897354d7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 Oct 2017 00:40:32 +0000
Subject: [PATCH] ASoC: rsnd: Don't check SSISR::DIRQ when Capture

When stop case, it was Playback, it need to check all data were
completely sent. But in Capture case, it might not receive data
anymore. SSISR::DIRQ check is not need for Capture case.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 61b4ce20ee2b..58e3420a1f05 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -598,15 +598,18 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
-	/*
-	 * disable all IRQ,
-	 * and, wait all data was sent
-	 */
 	cr  =	ssi->cr_own	|
 		ssi->cr_clk;
 
-	rsnd_mod_write(mod, SSICR, cr | EN);
-	rsnd_ssi_status_check(mod, DIRQ);
+	/*
+	 * disable all IRQ,
+	 * Playback: Wait all data was sent
+	 * Capture:  It might not receave data. Do nothing
+	 */
+	if (rsnd_io_is_play(io)) {
+		rsnd_mod_write(mod, SSICR, cr | EN);
+		rsnd_ssi_status_check(mod, DIRQ);
+	}
 
 	/*
 	 * disable SSI,
-- 
2.15.0.rc2
