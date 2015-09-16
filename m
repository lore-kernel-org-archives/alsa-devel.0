From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup clkout_name[] index error
	for single AUDIO_CLKOUT SoC" to the asoc tree
Date: Wed, 16 Sep 2015 21:01:43 +0100
Message-ID: <E1ZcItj-0007qy-AZ@finisterre>
References: <874miw4d7s.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 82F272616EF
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:01:48 +0200 (CEST)
In-Reply-To: <874miw4d7s.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup clkout_name[] index error for single AUDIO_CLKOUT SoC

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

>From 462c30bc8b3457e2904c45babf4cb06c3b38ed4e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Sep 2015 02:44:37 +0000
Subject: [PATCH] ASoC: rsnd: fixup clkout_name[] index error for single
 AUDIO_CLKOUT SoC

2a46db4a3("ASoC: rsnd: add AUDIO_CLKOUT support") added AUDIO_CLKOUT
support for ADG. But single AUDIO_CLKOUT needs clkout_name[CLKOUT],
not clkout_name[i]. Kernel will have NULL pointer access without this
patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 3fecb87..c4ebbb7 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -532,7 +532,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	 * for clkout
 	 */
 	if (!count) {
-		clk = clk_register_fixed_rate(dev, clkout_name[i],
+		clk = clk_register_fixed_rate(dev, clkout_name[CLKOUT],
 					      parent_clk_name,
 					      (parent_clk_name) ?
 					      0 : CLK_IS_ROOT, req_rate);
-- 
2.5.0
