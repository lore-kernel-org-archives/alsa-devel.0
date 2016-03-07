From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: CMD TIMSEL support for Capture"
	to the asoc tree
Date: Mon, 07 Mar 2016 14:42:46 +0700
Message-ID: <E1acpoU-00071G-6E@finisterre>
References: <87bn6qyj2f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C02F2607F7
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:42:52 +0100 (CET)
In-Reply-To: <87bn6qyj2f.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: CMD TIMSEL support for Capture

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

>From 09e59075496517206351cc28226ad7263a1a5c4f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Mar 2016 05:09:34 +0000
Subject: [PATCH] ASoC: rsnd: CMD TIMSEL support for Capture

CMD.out should use same as SRC.out for TIMSEL settings,
but it cares Playback case only. This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index f7e164c89f33..606399de684d 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -202,7 +202,10 @@ int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *cmd_mod,
 	int shift = (id % 2) ? 16 : 0;
 	u32 mask, val;
 
-	val = rsnd_adg_ssi_ws_timing_gen2(io);
+	rsnd_adg_get_timesel_ratio(priv, io,
+				   rsnd_src_get_in_rate(priv, io),
+				   rsnd_src_get_out_rate(priv, io),
+				   NULL, &val, NULL);
 
 	val  = val	<< shift;
 	mask = 0xffff	<< shift;
-- 
2.7.0
