From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove struct rcar_snd_info" to
	the asoc tree
Date: Wed, 18 Nov 2015 18:09:33 +0000
Message-ID: <E1Zz7Aj-0000EX-Ok@debutante>
References: <87r3jyjvan.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C538265A69
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:41 +0100 (CET)
In-Reply-To: <87r3jyjvan.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove struct rcar_snd_info

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

>From 2ea2cc86db7c73dc4e3a9fc3232cb04fe1b1ab91 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 05:13:53 +0000
Subject: [PATCH] ASoC: rsnd: remove struct rcar_snd_info

No board is using Renesas sound driver via platform boot now.
This means all user is using DT boot. Platform boot support is
no longer needed. But, it strongly depends on platform boot style.
Now, platform boot style was removed from driver.
This is cleanup patch, and remove pointless struct rcar_snd_info

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c     |  21 --------
 sound/soc/sh/rcar/rcar_snd.h | 115 -------------------------------------------
 sound/soc/sh/rcar/rsnd.h     |  16 ++++--
 3 files changed, 13 insertions(+), 139 deletions(-)
 delete mode 100644 sound/soc/sh/rcar/rcar_snd.h

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 8b9d721acb41..8af166809629 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -108,13 +108,6 @@ static const struct of_device_id rsnd_of_match[] = {
 MODULE_DEVICE_TABLE(of, rsnd_of_match);
 
 /*
- *	rsnd_platform functions
- */
-#define rsnd_platform_call(priv, dai, func, param...)	\
-	(!(priv->info->func) ? 0 :		\
-	 priv->info->func(param))
-
-/*
  *	rsnd_mod functions
  */
 void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type)
@@ -457,7 +450,6 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct rsnd_priv *priv = rsnd_dai_to_priv(dai);
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
 	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
-	int ssi_id = rsnd_mod_id(rsnd_io_to_mod_ssi(io));
 	int ret;
 	unsigned long flags;
 
@@ -467,10 +459,6 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 		rsnd_dai_stream_init(io, substream);
 
-		ret = rsnd_platform_call(priv, dai, start, ssi_id);
-		if (ret < 0)
-			goto dai_trigger_end;
-
 		ret = rsnd_dai_call(init, io, priv);
 		if (ret < 0)
 			goto dai_trigger_end;
@@ -484,8 +472,6 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		ret |= rsnd_dai_call(quit, io, priv);
 
-		ret |= rsnd_platform_call(priv, dai, stop, ssi_id);
-
 		rsnd_dai_stream_quit(io);
 		break;
 	default:
@@ -985,7 +971,6 @@ static int rsnd_rdai_continuance_probe(struct rsnd_priv *priv,
  */
 static int rsnd_probe(struct platform_device *pdev)
 {
-	struct rcar_snd_info *info;
 	struct rsnd_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct rsnd_dai *rdai;
@@ -1006,11 +991,6 @@ static int rsnd_probe(struct platform_device *pdev)
 	};
 	int ret, i;
 
-	info = devm_kzalloc(&pdev->dev, sizeof(struct rcar_snd_info),
-			    GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
 	/*
 	 *	init priv data
 	 */
@@ -1021,7 +1001,6 @@ static int rsnd_probe(struct platform_device *pdev)
 	}
 
 	priv->pdev	= pdev;
-	priv->info	= info;
 	priv->flags	= (u32)of_id->data;
 	spin_lock_init(&priv->lock);
 
diff --git a/sound/soc/sh/rcar/rcar_snd.h b/sound/soc/sh/rcar/rcar_snd.h
deleted file mode 100644
index 18b27e6aecbc..000000000000
--- a/sound/soc/sh/rcar/rcar_snd.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * Renesas R-Car SRU/SCU/SSIU/SSI support
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef RCAR_SND_H
-#define RCAR_SND_H
-
-
-#define RSND_GEN1_SRU	0
-#define RSND_GEN1_ADG	1
-#define RSND_GEN1_SSI	2
-
-#define RSND_GEN2_SCU	0
-#define RSND_GEN2_ADG	1
-#define RSND_GEN2_SSIU	2
-#define RSND_GEN2_SSI	3
-
-#define RSND_BASE_MAX	4
-
-/*
- * flags
- *
- * 0xAB000000
- *
- * A : clock sharing settings
- * B : SSI direction
- */
-
-#define RSND_SSI(_dma_id, _irq, _flags)		\
-{ .dma_id = _dma_id, .irq = _irq, .flags = _flags }
-#define RSND_SSI_UNUSED \
-{ .dma_id = -1, .irq = -1, .flags = 0 }
-
-struct rsnd_ssi_platform_info {
-	int dma_id;
-	int irq;
-	u32 flags;
-};
-
-#define RSND_SRC(rate, _dma_id)						\
-{ .convert_rate = rate, .dma_id = _dma_id, }
-#define RSND_SRC_UNUSED				\
-{ .convert_rate = 0, .dma_id = -1, }
-
-struct rsnd_src_platform_info {
-	u32 convert_rate; /* sampling rate convert */
-	int dma_id; /* for Gen2 SCU */
-	int irq;
-};
-
-/*
- * flags
- */
-struct rsnd_ctu_platform_info {
-	u32 flags;
-};
-
-struct rsnd_mix_platform_info {
-	u32 flags;
-};
-
-struct rsnd_dvc_platform_info {
-	u32 flags;
-};
-
-struct rsnd_dai_path_info {
-	struct rsnd_ssi_platform_info *ssi;
-	struct rsnd_src_platform_info *src;
-	struct rsnd_ctu_platform_info *ctu;
-	struct rsnd_mix_platform_info *mix;
-	struct rsnd_dvc_platform_info *dvc;
-};
-
-struct rsnd_dai_platform_info {
-	struct rsnd_dai_path_info playback;
-	struct rsnd_dai_path_info capture;
-};
-
-/*
- * flags
- *
- * 0x0000000A
- *
- * A : generation
- */
-#define RSND_GEN_MASK	(0xF << 0)
-#define RSND_GEN1	(1 << 0) /* fixme */
-#define RSND_GEN2	(2 << 0) /* fixme */
-
-struct rcar_snd_info {
-	u32 flags;
-	struct rsnd_ssi_platform_info *ssi_info;
-	int ssi_info_nr;
-	struct rsnd_src_platform_info *src_info;
-	int src_info_nr;
-	struct rsnd_ctu_platform_info *ctu_info;
-	int ctu_info_nr;
-	struct rsnd_mix_platform_info *mix_info;
-	int mix_info_nr;
-	struct rsnd_dvc_platform_info *dvc_info;
-	int dvc_info_nr;
-	struct rsnd_dai_platform_info *dai_info;
-	int dai_info_nr;
-	int (*start)(int id);
-	int (*stop)(int id);
-};
-
-#endif
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 0ad3d0d20a81..e6efac29113d 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -24,7 +24,16 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include "rcar_snd.h"
+#define RSND_GEN1_SRU	0
+#define RSND_GEN1_ADG	1
+#define RSND_GEN1_SSI	2
+
+#define RSND_GEN2_SCU	0
+#define RSND_GEN2_ADG	1
+#define RSND_GEN2_SSIU	2
+#define RSND_GEN2_SSI	3
+
+#define RSND_BASE_MAX	4
 
 /*
  *	pseudo register
@@ -373,9 +382,11 @@ int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *mod,
 struct rsnd_priv {
 
 	struct platform_device *pdev;
-	struct rcar_snd_info *info;
 	spinlock_t lock;
 	u32 flags;
+#define RSND_GEN_MASK	(0xF << 0)
+#define RSND_GEN1	(1 << 0)
+#define RSND_GEN2	(2 << 0)
 
 	/*
 	 * below value will be filled on rsnd_gen_probe()
@@ -444,7 +455,6 @@ struct rsnd_priv {
 
 #define rsnd_priv_to_pdev(priv)	((priv)->pdev)
 #define rsnd_priv_to_dev(priv)	(&(rsnd_priv_to_pdev(priv)->dev))
-#define rsnd_priv_to_info(priv)	((priv)->info)
 
 #define rsnd_is_gen1(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN1)
 #define rsnd_is_gen2(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN2)
-- 
2.6.2
