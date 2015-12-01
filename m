From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add TDM Extend Mode support" to
	the asoc tree
Date: Tue, 01 Dec 2015 22:59:50 +0000
Message-ID: <E1a3ttm-0006fo-K7@debutante>
References: <87si3nswdn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B656D266469
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:55 +0100 (CET)
In-Reply-To: <87si3nswdn.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add TDM Extend Mode support

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

>From 186fadc132f0d634c7b43202a240fbd3654b6623 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:54:03 +0000
Subject: [PATCH] ASoC: rsnd: add TDM Extend Mode support

Renesas R-Car can out TDM by
1) 6ch x 1 DAI as TDM Extend Mode
2) 2ch x 4 x 1 DAI as TDM split Mode
3) 2ch x 3 DAI or
   2ch x 4 DAI as TDM Multichannel Mode

This patch adds 1) TDM Extend Mode. Because of HW design,
this 6ch data will be outputed via 8ch data width.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 30 ++++++++++++++++++++++++++----
 sound/soc/sh/rcar/gen.c  |  1 +
 sound/soc/sh/rcar/rsnd.h |  1 +
 sound/soc/sh/rcar/ssi.c  | 18 +++++++++++++++++-
 sound/soc/sh/rcar/ssiu.c |  9 +++++++++
 5 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 7d364d7505a1..b187a8927e29 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -247,9 +247,9 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 u32 rsnd_get_adinr_chan(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	u32 chan = runtime->channels;
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+	u32 chan = rsnd_get_slot_rdai(rdai);
 
 	switch (chan) {
 	case 1:
@@ -569,9 +569,31 @@ static int rsnd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
+				     u32 tx_mask, u32 rx_mask,
+				     int slots, int slot_width)
+{
+	struct rsnd_priv *priv = rsnd_dai_to_priv(dai);
+	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	struct device *dev = rsnd_priv_to_dev(priv);
+
+	switch (slots) {
+	case 6:
+		/* TDM Extend Mode */
+		rdai->slots = slots;
+		break;
+	default:
+		dev_err(dev, "unsupported TDM slots (%d)\n", slots);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	.trigger	= rsnd_soc_dai_trigger,
 	.set_fmt	= rsnd_soc_dai_set_fmt,
+	.set_tdm_slot	= rsnd_soc_set_dai_tdm_slot,
 };
 
 static int rsnd_dai_probe(struct rsnd_priv *priv)
@@ -626,7 +648,7 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 		drv->playback.rates		= RSND_RATES;
 		drv->playback.formats		= RSND_FMTS;
 		drv->playback.channels_min	= 2;
-		drv->playback.channels_max	= 2;
+		drv->playback.channels_max	= 6;
 		drv->playback.stream_name	= rdai->playback.name;
 
 		snprintf(rdai->capture.name, RSND_DAI_NAME_SIZE,
@@ -634,7 +656,7 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 		drv->capture.rates		= RSND_RATES;
 		drv->capture.formats		= RSND_FMTS;
 		drv->capture.channels_min	= 2;
-		drv->capture.channels_max	= 2;
+		drv->capture.channels_max	= 6;
 		drv->capture.stream_name	= rdai->capture.name;
 
 		rdai->playback.rdai		= rdai;
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 2151aa5e161b..50fc73042b7e 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -230,6 +230,7 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SSI_BUSIF_MODE,	0x0,	0x80),
 		RSND_GEN_M_REG(SSI_BUSIF_ADINR,	0x4,	0x80),
 		RSND_GEN_M_REG(SSI_BUSIF_DALIGN,0x8,	0x80),
+		RSND_GEN_M_REG(SSI_MODE,	0xc,	0x80),
 		RSND_GEN_M_REG(SSI_CTRL,	0x10,	0x80),
 		RSND_GEN_M_REG(SSI_INT_ENABLE,	0x18,	0x80),
 	};
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 2111bf32e789..970e1301f7c6 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -44,6 +44,7 @@
  */
 enum rsnd_reg {
 	/* SCU (SRC/SSIU/MIX/CTU/DVC) */
+	RSND_REG_SSI_MODE,		/* Gen2 only */
 	RSND_REG_SSI_MODE0,
 	RSND_REG_SSI_MODE1,
 	RSND_REG_SSI_CTRL,		/* Gen2 only */
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 44e914132b02..628739f13f99 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -24,7 +24,9 @@
 #define	OIEN		(1 << 26)	/* Overflow Interrupt Enable */
 #define	IIEN		(1 << 25)	/* Idle Mode Interrupt Enable */
 #define	DIEN		(1 << 24)	/* Data Interrupt Enable */
-
+#define	CHNL_4		(1 << 22)	/* Channels */
+#define	CHNL_6		(2 << 22)	/* Channels */
+#define	CHNL_8		(3 << 22)	/* Channels */
 #define	DWL_8		(0 << 19)	/* Data Word Length */
 #define	DWL_16		(1 << 19)	/* Data Word Length */
 #define	DWL_18		(2 << 19)	/* Data Word Length */
@@ -57,6 +59,7 @@
  * SSIWSR
  */
 #define CONT		(1 << 8)	/* WS Continue Function */
+#define WS_MODE		(1 << 0)	/* WS Mode */
 
 #define SSI_NAME "ssi"
 
@@ -261,6 +264,7 @@ static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	u32 cr_own;
 	u32 cr_mode;
+	u32 wsr;
 
 	/*
 	 * always use 32bit system word.
@@ -297,8 +301,20 @@ static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
 		cr_mode = DIEN;		/* PIO : enable Data interrupt */
 	}
 
+	/*
+	 * TDM Extend Mode
+	 * see
+	 *	rsnd_ssiu_init_gen2()
+	 */
+	wsr = ssi->wsr;
+	if (rsnd_get_slot_runtime(io) >= 6) {
+		wsr	|= WS_MODE;
+		cr_own	|= CHNL_8;
+	}
+
 	ssi->cr_own	= cr_own;
 	ssi->cr_mode	= cr_mode;
+	ssi->wsr	= wsr;
 
 	return 0;
 }
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 6120b0a66958..326550114299 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -78,6 +78,15 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
+	if (rsnd_get_slot_runtime(io) >= 6) {
+		/*
+		 * TDM Extend Mode
+		 * see
+		 *	rsnd_ssi_config_init()
+		 */
+		rsnd_mod_write(mod, SSI_MODE, 0x1);
+	}
+
 	if (rsnd_ssi_use_busif(io)) {
 		u32 val = rsnd_get_dalign(mod, io);
 
-- 
2.6.2
