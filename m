From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: update BSDSR/BSDISR handling" to
	the asoc tree
Date: Mon,  7 Jan 2019 18:57:38 +0000 (GMT)
Message-ID: <20190107185738.ED5BA1127491@debutante.sirena.org.uk>
References: <871s66tdc8.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 981392669BD
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:57:40 +0100 (CET)
In-Reply-To: <871s66tdc8.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, chaoliang qin <chaoliang.qin.jg@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: update BSDSR/BSDISR handling

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

>From 7674bec4fc09e85803a8f2bd26a013d0076a80a9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Dec 2018 14:05:28 +0900
Subject: [PATCH] ASoC: rsnd: update BSDSR/BSDISR handling

Current BSDSR/BSDISR are using temporary/generic settings, but it can't
handle all SRCx/SoC. It needs to handle correctry.
Otherwise, sampling rate converted sound channel will be broken if it
was TDM. One note is that it needs to overwrite settings on E3 case.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: chaoliang qin <chaoliang.qin.jg@renesas.com>
Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 125 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 50348a2c9203..db81e066b92e 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -14,6 +14,7 @@
  */
 
 #include "rsnd.h"
+#include <linux/sys_soc.h>
 
 #define SRC_NAME "src"
 
@@ -134,20 +135,83 @@ unsigned int rsnd_src_get_rate(struct rsnd_priv *priv,
 	return rate;
 }
 
+const static u32 bsdsr_table_pattern1[] = {
+	0x01800000, /* 6 - 1/6 */
+	0x01000000, /* 6 - 1/4 */
+	0x00c00000, /* 6 - 1/3 */
+	0x00800000, /* 6 - 1/2 */
+	0x00600000, /* 6 - 2/3 */
+	0x00400000, /* 6 - 1   */
+};
+
+const static u32 bsdsr_table_pattern2[] = {
+	0x02400000, /* 6 - 1/6 */
+	0x01800000, /* 6 - 1/4 */
+	0x01200000, /* 6 - 1/3 */
+	0x00c00000, /* 6 - 1/2 */
+	0x00900000, /* 6 - 2/3 */
+	0x00600000, /* 6 - 1   */
+};
+
+const static u32 bsisr_table[] = {
+	0x00100060, /* 6 - 1/6 */
+	0x00100040, /* 6 - 1/4 */
+	0x00100030, /* 6 - 1/3 */
+	0x00100020, /* 6 - 1/2 */
+	0x00100020, /* 6 - 2/3 */
+	0x00100020, /* 6 - 1   */
+};
+
+const static u32 chan288888[] = {
+	0x00000006, /* 1 to 2 */
+	0x000001fe, /* 1 to 8 */
+	0x000001fe, /* 1 to 8 */
+	0x000001fe, /* 1 to 8 */
+	0x000001fe, /* 1 to 8 */
+	0x000001fe, /* 1 to 8 */
+};
+
+const static u32 chan244888[] = {
+	0x00000006, /* 1 to 2 */
+	0x0000001e, /* 1 to 4 */
+	0x0000001e, /* 1 to 4 */
+	0x000001fe, /* 1 to 8 */
+	0x000001fe, /* 1 to 8 */
+	0x000001fe, /* 1 to 8 */
+};
+
+const static u32 chan222222[] = {
+	0x00000006, /* 1 to 2 */
+	0x00000006, /* 1 to 2 */
+	0x00000006, /* 1 to 2 */
+	0x00000006, /* 1 to 2 */
+	0x00000006, /* 1 to 2 */
+	0x00000006, /* 1 to 2 */
+};
+
+static const struct soc_device_attribute ov_soc[] = {
+	{ .soc_id = "r8a77990" }, /* E3 */
+	{ /* sentinel */ }
+};
+
 static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 				      struct rsnd_mod *mod)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	const struct soc_device_attribute *soc = soc_device_match(ov_soc);
 	int is_play = rsnd_io_is_play(io);
 	int use_src = 0;
 	u32 fin, fout;
 	u32 ifscr, fsrate, adinr;
 	u32 cr, route;
-	u32 bsdsr, bsisr;
 	u32 i_busif, o_busif, tmp;
+	const u32 *bsdsr_table;
+	const u32 *chptn;
 	uint ratio;
+	int chan;
+	int idx;
 
 	if (!runtime)
 		return;
@@ -155,6 +219,8 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	fin  = rsnd_src_get_in_rate(priv, io);
 	fout = rsnd_src_get_out_rate(priv, io);
 
+	chan = rsnd_runtime_channel_original(io);
+
 	/* 6 - 1/6 are very enough ratio for SRC_BSDSR */
 	if (fin == fout)
 		ratio = 0;
@@ -173,8 +239,7 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	/*
 	 * SRC_ADINR
 	 */
-	adinr = rsnd_get_adinr_bit(mod, io) |
-		rsnd_runtime_channel_original(io);
+	adinr = rsnd_get_adinr_bit(mod, io) | chan;
 
 	/*
 	 * SRC_IFSCR / SRC_IFSVR
@@ -207,21 +272,56 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 
 	/*
 	 * SRC_BSDSR / SRC_BSISR
+	 *
+	 * see
+	 *	Combination of Register Setting Related to
+	 *	FSO/FSI Ratio and Channel, Latency
 	 */
 	switch (rsnd_mod_id(mod)) {
+	case 0:
+		chptn		= chan288888;
+		bsdsr_table	= bsdsr_table_pattern1;
+		break;
+	case 1:
+	case 3:
+	case 4:
+		chptn		= chan244888;
+		bsdsr_table	= bsdsr_table_pattern1;
+		break;
+	case 2:
+	case 9:
+		chptn		= chan222222;
+		bsdsr_table	= bsdsr_table_pattern1;
+		break;
 	case 5:
 	case 6:
 	case 7:
 	case 8:
-		bsdsr = 0x02400000; /* 6 - 1/6 */
-		bsisr = 0x00100060; /* 6 - 1/6 */
+		chptn		= chan222222;
+		bsdsr_table	= bsdsr_table_pattern2;
 		break;
 	default:
-		bsdsr = 0x01800000; /* 6 - 1/6 */
-		bsisr = 0x00100060 ;/* 6 - 1/6 */
-		break;
+		goto convert_rate_err;
 	}
 
+	/*
+	 * E3 need to overwrite
+	 */
+	if (soc)
+		switch (rsnd_mod_id(mod)) {
+		case 0:
+		case 4:
+			chptn	= chan222222;
+		}
+
+	for (idx = 0; idx < ARRAY_SIZE(chan222222); idx++)
+		if (chptn[idx] & (1 << chan))
+			break;
+
+	if (chan > 8 ||
+	    idx >= ARRAY_SIZE(chan222222))
+		goto convert_rate_err;
+
 	/* BUSIF_MODE */
 	tmp = rsnd_get_busif_shift(io, mod);
 	i_busif = ( is_play ? tmp : 0) | 1;
@@ -234,8 +334,8 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, SRC_IFSCR, ifscr);
 	rsnd_mod_write(mod, SRC_IFSVR, fsrate);
 	rsnd_mod_write(mod, SRC_SRCCR, cr);
-	rsnd_mod_write(mod, SRC_BSDSR, bsdsr);
-	rsnd_mod_write(mod, SRC_BSISR, bsisr);
+	rsnd_mod_write(mod, SRC_BSDSR, bsdsr_table[idx]);
+	rsnd_mod_write(mod, SRC_BSISR, bsisr_table[idx]);
 	rsnd_mod_write(mod, SRC_SRCIR, 0);	/* cancel initialize */
 
 	rsnd_mod_write(mod, SRC_I_BUSIF_MODE, i_busif);
@@ -244,6 +344,11 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, SRC_BUSIF_DALIGN, rsnd_get_dalign(mod, io));
 
 	rsnd_adg_set_src_timesel_gen2(mod, io, fin, fout);
+
+	return;
+
+convert_rate_err:
+	dev_err(dev, "unknown BSDSR/BSDIR settings\n");
 }
 
 static int rsnd_src_irq(struct rsnd_mod *mod,
-- 
2.20.1
