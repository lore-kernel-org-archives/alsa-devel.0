From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: care SWSP bit for TDM/non-TDM" to
	the asoc tree
Date: Wed, 02 Dec 2015 20:10:46 +0000
Message-ID: <E1a4Dji-0008Mp-L8@debutante>
References: <87r3j5jogm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E359E2650F2
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 21:10:52 +0100 (CET)
In-Reply-To: <87r3j5jogm.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: care SWSP bit for TDM/non-TDM

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

>From f98ed119a7c5feacb1fc1c8d7f6c68934cd27384 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 2 Dec 2015 07:34:28 +0000
Subject: [PATCH] ASoC: rsnd: care SWSP bit for TDM/non-TDM

SSICR::SWSP bit controls WS signal low/high, but in case of TDM
it is inverted. This patch solves this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 628739f13f99..79c3211a1e7f 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -265,6 +265,9 @@ static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
 	u32 cr_own;
 	u32 cr_mode;
 	u32 wsr;
+	int is_tdm;
+
+	is_tdm = (rsnd_get_slot_runtime(io) >= 6) ? 1 : 0;
 
 	/*
 	 * always use 32bit system word.
@@ -274,7 +277,7 @@ static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
 
 	if (rdai->bit_clk_inv)
 		cr_own |= SCKP;
-	if (rdai->frm_clk_inv)
+	if (rdai->frm_clk_inv ^ is_tdm)
 		cr_own |= SWSP;
 	if (rdai->data_alignment)
 		cr_own |= SDTA;
@@ -307,7 +310,7 @@ static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
 	 *	rsnd_ssiu_init_gen2()
 	 */
 	wsr = ssi->wsr;
-	if (rsnd_get_slot_runtime(io) >= 6) {
+	if (is_tdm) {
 		wsr	|= WS_MODE;
 		cr_own	|= CHNL_8;
 	}
-- 
2.6.2
