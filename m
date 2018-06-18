From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: SSI parent cares SWSP bit" to the
	asoc tree
Date: Mon, 18 Jun 2018 13:00:28 +0100
Message-ID: <E1fUspg-0000IK-Nw@debutante>
References: <874li8sghe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FC3226771F
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:31 +0200 (CEST)
In-Reply-To: <874li8sghe.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: SSI parent cares SWSP bit

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

>From 203cdf51f28820bee7893b4be392847418e6f4ec Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:52:17 +0000
Subject: [PATCH] ASoC: rsnd: SSI parent cares SWSP bit

SSICR has SWSP bit (= Serial WS Polarity) which decides WS pin 1st
channel polarity (low or hi). This bit shouldn't exchange after running.

Current SSI "parent" doesn't care SSICR, just controls clock only.
Because of this behavior, if platform uses SSI0 as playback,
SSI1 as capture, and if user starts capture -> playback order,
SSI0 SSICR::SWSP bit exchanged 0 -> 1 during captureing, and it makes
capture noise.
This patch cares SSICR on SSI parent, too.
Special thanks to Yokoyama-san

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 4e605648918b..98dd120d830a 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -37,6 +37,7 @@
 #define	CHNL_4		(1 << 22)	/* Channels */
 #define	CHNL_6		(2 << 22)	/* Channels */
 #define	CHNL_8		(3 << 22)	/* Channels */
+#define DWL_MASK	(7 << 19)	/* Data Word Length mask */
 #define	DWL_8		(0 << 19)	/* Data Word Length */
 #define	DWL_16		(1 << 19)	/* Data Word Length */
 #define	DWL_18		(2 << 19)	/* Data Word Length */
@@ -353,21 +354,18 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	u32 cr_own;
-	u32 cr_mode;
-	u32 wsr;
+	u32 cr_own	= ssi->cr_own;
+	u32 cr_mode	= ssi->cr_mode;
+	u32 wsr		= ssi->wsr;
 	int is_tdm;
 
-	if (rsnd_ssi_is_parent(mod, io))
-		return;
-
 	is_tdm = rsnd_runtime_is_ssi_tdm(io);
 
 	/*
 	 * always use 32bit system word.
 	 * see also rsnd_ssi_master_clk_enable()
 	 */
-	cr_own = FORCE | SWL_32;
+	cr_own |= FORCE | SWL_32;
 
 	if (rdai->bit_clk_inv)
 		cr_own |= SCKP;
@@ -377,9 +375,18 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 		cr_own |= SDTA;
 	if (rdai->sys_delay)
 		cr_own |= DEL;
+
+	/*
+	 * We shouldn't exchange SWSP after running.
+	 * This means, parent needs to care it.
+	 */
+	if (rsnd_ssi_is_parent(mod, io))
+		goto init_end;
+
 	if (rsnd_io_is_play(io))
 		cr_own |= TRMD;
 
+	cr_own &= ~DWL_MASK;
 	switch (snd_pcm_format_width(runtime->format)) {
 	case 16:
 		cr_own |= DWL_16;
@@ -406,7 +413,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 		wsr	|= WS_MODE;
 		cr_own	|= CHNL_8;
 	}
-
+init_end:
 	ssi->cr_own	= cr_own;
 	ssi->cr_mode	= cr_mode;
 	ssi->wsr	= wsr;
@@ -470,15 +477,18 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 		return -EIO;
 	}
 
-	if (!rsnd_ssi_is_parent(mod, io))
-		ssi->cr_own	= 0;
-
 	rsnd_ssi_master_clk_stop(mod, io);
 
 	rsnd_mod_power_off(mod);
 
 	ssi->usrcnt--;
 
+	if (!ssi->usrcnt) {
+		ssi->cr_own	= 0;
+		ssi->cr_mode	= 0;
+		ssi->wsr	= 0;
+	}
+
 	return 0;
 }
 
-- 
2.17.1
