From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: avoid SSI_MODEx settings for
	SSI8" to the asoc tree
Date: Mon, 06 Mar 2017 11:46:55 +0100
Message-ID: <E1ckqAJ-0002Wp-N6@finisterre>
References: <8760jrf0rh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FAE5266DAA
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:47:08 +0100 (CET)
In-Reply-To: <8760jrf0rh.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: avoid SSI_MODEx settings for SSI8

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

>From 4b30eebfc35c67771b5f58d9274d3e321b72d7a8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 3 Mar 2017 04:25:09 +0000
Subject: [PATCH] ASoC: rcar: avoid SSI_MODEx settings for SSI8

SSI8 is is sharing pin with SSI7, and nothing to do for SSI_MODEx.
It is special pin and it needs special settings whole system,
but we can't confirm it, because we never have SSI8 available board.

This patch fixup SSI_MODEx settings error for SSI8 on connection test,
but should be confirmed behavior on real board in the future.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 4e817c8a18c0..14fafdaf1395 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -64,7 +64,11 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 	mask1 = (1 << 4) | (1 << 20);	/* mask sync bit */
 	mask2 = (1 << 4);		/* mask sync bit */
 	val1  = val2  = 0;
-	if (rsnd_ssi_is_pin_sharing(io)) {
+	if (id == 8) {
+		/*
+		 * SSI8 pin is sharing with SSI7, nothing to do.
+		 */
+	} else if (rsnd_ssi_is_pin_sharing(io)) {
 		int shift = -1;
 
 		switch (id) {
-- 
2.11.0
