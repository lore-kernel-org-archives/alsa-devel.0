From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Fix possible NULL pointer
	dereference" to the asoc tree
Date: Fri, 21 Apr 2017 18:28:39 +0100
Message-ID: <E1d1cMJ-0001yt-DS@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6511A267283
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 19:28:46 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Fix possible NULL pointer dereference

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

>From e8dffe6c2004278c588b3bb441a3dbe998a3f2e4 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut+renesas@gmail.com>
Date: Fri, 21 Apr 2017 00:41:20 +0000
Subject: [PATCH] ASoC: rsnd: Fix possible NULL pointer dereference

25165f79adc76b812bfb4d8f2ab120aafb28d0e6
("ASoC: rsnd: enable clock-frequency for both 44.1kHz/48kHz")
supports both 44.1kHz/48kHz clock-frequency settings for ADG
which will be used for AUDIO_OLKOUTn.
But some board doesn't need it, thus, it is not mandatory.

But, above patch didn't care about the case of "clock-frequency" DT
property was not present.
This patch ignores ADG settings if AUDIO_OLKOUTn was not used.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
[Kuninori: tidyup not to break non AUDIO_OLKOUTn case]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index faa1a4f09766..66203d107a11 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -453,13 +453,18 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 		[CLKI] = 0x2,
 	};
 
-	of_property_read_u32(np, "#clock-cells", &count);
+	ckr = 0;
+	rbga = 2; /* default 1/6 */
+	rbgb = 2; /* default 1/6 */
 
 	/*
 	 * ADG supports BRRA/BRRB output only
 	 * this means all clkout0/1/2/3 will be same rate
 	 */
 	prop = of_find_property(np, "clock-frequency", NULL);
+	if (!prop)
+		goto rsnd_adg_get_clkout_end;
+
 	req_size = prop->length / sizeof(u32);
 
 	of_property_read_u32_array(np, "clock-frequency", req_rate, req_size);
@@ -472,6 +477,9 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 			req_48kHz_rate = req_rate[i];
 	}
 
+	if (req_rate[0] % 48000 == 0)
+		adg->flags = AUDIO_OUT_48;
+
 	/*
 	 * This driver is assuming that AUDIO_CLKA/AUDIO_CLKB/AUDIO_CLKC
 	 * have 44.1kHz or 48kHz base clocks for now.
@@ -481,9 +489,6 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	 *	rsnd_adg_ssi_clk_try_start()
 	 *	rsnd_ssi_master_clk_start()
 	 */
-	ckr = 0;
-	rbga = 2; /* default 1/6 */
-	rbgb = 2; /* default 1/6 */
 	adg->rbga_rate_for_441khz	= 0;
 	adg->rbgb_rate_for_48khz	= 0;
 	for_each_rsnd_clk(clk, adg, i) {
@@ -528,6 +533,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	 * this means all clkout0/1/2/3 will be * same rate
 	 */
 
+	of_property_read_u32(np, "#clock-cells", &count);
 	/*
 	 * for clkout
 	 */
@@ -557,13 +563,11 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 				    &adg->onecell);
 	}
 
+rsnd_adg_get_clkout_end:
 	adg->ckr = ckr;
 	adg->rbga = rbga;
 	adg->rbgb = rbgb;
 
-	if (req_rate[0] % 48000 == 0)
-		adg->flags = AUDIO_OUT_48;
-
 	for_each_rsnd_clkout(clk, adg, i)
 		dev_dbg(dev, "clkout %d : %p : %ld\n", i, clk, clk_get_rate(clk));
 	dev_dbg(dev, "BRGCKR = 0x%08x, BRRA/BRRB = 0x%x/0x%x\n",
-- 
2.11.0
