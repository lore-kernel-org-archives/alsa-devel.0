From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_ssi_config_init()" to
	the asoc tree
Date: Tue, 01 Dec 2015 22:59:54 +0000
Message-ID: <E1a3ttq-0006oW-RN@debutante>
References: <87y4dfswg0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 72B412661AE
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:59 +0100 (CET)
In-Reply-To: <87y4dfswg0.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add rsnd_ssi_config_init()

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

>From 840ada3b04275d47a24f35a8c559bc584962f315 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:52:38 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_ssi_config_init()

In order to enhance code readability, this patch adds
rsnd_ssi_config_init() and moves SSICR register settings to it.
This is prepare patch for TDM support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 98 ++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 46 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 40d5b587cbe9..31e26bd481cf 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -253,6 +253,55 @@ static void rsnd_ssi_master_clk_stop(struct rsnd_ssi *ssi,
 	rsnd_adg_ssi_clk_stop(mod);
 }
 
+static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
+				struct rsnd_dai_stream *io)
+{
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	u32 cr_own;
+	u32 cr_mode;
+
+	/*
+	 * always use 32bit system word.
+	 * see also rsnd_ssi_master_clk_enable()
+	 */
+	cr_own = FORCE | SWL_32 | PDTA;
+
+	if (rdai->bit_clk_inv)
+		cr_own |= SCKP;
+	if (rdai->frm_clk_inv)
+		cr_own |= SWSP;
+	if (rdai->data_alignment)
+		cr_own |= SDTA;
+	if (rdai->sys_delay)
+		cr_own |= DEL;
+	if (rsnd_io_is_play(io))
+		cr_own |= TRMD;
+
+	switch (runtime->sample_bits) {
+	case 16:
+		cr_own |= DWL_16;
+		break;
+	case 32:
+		cr_own |= DWL_24;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (rsnd_ssi_is_dma_mode(rsnd_mod_get(ssi))) {
+		cr_mode = UIEN | OIEN |	/* over/under run */
+			  DMEN;		/* DMA : enable DMA */
+	} else {
+		cr_mode = DIEN;		/* PIO : enable Data interrupt */
+	}
+
+	ssi->cr_own	= cr_own;
+	ssi->cr_mode	= cr_mode;
+
+	return 0;
+}
+
 /*
  *	SSI mod common functions
  */
@@ -261,9 +310,6 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 			 struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	u32 cr;
 	int ret;
 
 	ssi->usrcnt++;
@@ -277,49 +323,9 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
-	cr = FORCE | PDTA;
-
-	/*
-	 * always use 32bit system word for easy clock calculation.
-	 * see also rsnd_ssi_master_clk_enable()
-	 */
-	cr |= SWL_32;
-
-	/*
-	 * init clock settings for SSICR
-	 */
-	switch (runtime->sample_bits) {
-	case 16:
-		cr |= DWL_16;
-		break;
-	case 32:
-		cr |= DWL_24;
-		break;
-	default:
-		return -EIO;
-	}
-
-	if (rdai->bit_clk_inv)
-		cr |= SCKP;
-	if (rdai->frm_clk_inv)
-		cr |= SWSP;
-	if (rdai->data_alignment)
-		cr |= SDTA;
-	if (rdai->sys_delay)
-		cr |= DEL;
-	if (rsnd_io_is_play(io))
-		cr |= TRMD;
-
-	ssi->cr_own	= cr;
-
-	if (rsnd_ssi_is_dma_mode(mod)) {
-		cr =	UIEN | OIEN |	/* over/under run */
-			DMEN;		/* DMA : enable DMA */
-	} else {
-		cr =	DIEN;		/* PIO : enable Data interrupt */
-	}
-
-	ssi->cr_mode	= cr;
+	ret = rsnd_ssi_config_init(ssi, io);
+	if (ret < 0)
+		return ret;
 
 	ssi->err	= -1; /* ignore 1st error */
 
-- 
2.6.2
