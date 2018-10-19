From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: enable TDM settings for SSI
	parent" to the asoc tree
Date: Fri, 19 Oct 2018 13:34:39 +0100 (BST)
Message-ID: <20181019123439.7C76B1122548@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EB8C6267950
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:34:39 +0200 (CEST)
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: enable TDM settings for SSI parent

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

>From 6817d7593f3e3c8a9c11e7a07cb5646c70371f0a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Oct 2018 01:55:37 +0000
Subject: [PATCH] ASoC: rsnd: enable TDM settings for SSI parent

Some SSIs are sharing each pins (= WS/CLK pin for playback/capture).
Then, SSI parent needs control WS/CLK setting for SSI slave.
In such case, SSI parent needs TDM settings if SSI slave is working as
TDM mode. But it is not cared in current driver.
It can't capture TDM sound without this patch if SSIs were pin sharing.
This patch is tested on R-Car H3 ulcb-kf board, SSI3/4 with TDM sound.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3adcc4f778f7..b42a0e0feab7 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -399,6 +399,17 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	if (rdai->sys_delay)
 		cr_own |= DEL;
 
+	/*
+	 * TDM Mode
+	 * see
+	 *	rsnd_ssiu_init_gen2()
+	 */
+	wsr = ssi->wsr;
+	if (is_tdm) {
+		wsr	|= WS_MODE;
+		cr_own	|= CHNL_8;
+	}
+
 	/*
 	 * We shouldn't exchange SWSP after running.
 	 * This means, parent needs to care it.
@@ -429,16 +440,6 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 		cr_mode = DIEN;		/* PIO : enable Data interrupt */
 	}
 
-	/*
-	 * TDM Extend Mode
-	 * see
-	 *	rsnd_ssiu_init_gen2()
-	 */
-	wsr = ssi->wsr;
-	if (is_tdm) {
-		wsr	|= WS_MODE;
-		cr_own	|= CHNL_8;
-	}
 init_end:
 	ssi->cr_own	= cr_own;
 	ssi->cr_mode	= cr_mode;
-- 
2.19.0.rc2
