From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove 16ch support for now" to the asoc tree
Date: Wed, 09 Aug 2017 17:56:40 +0100
Message-ID: <E1dfUHg-0005Kt-QQ@debutante>
References: <87wp6decyf.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wp6decyf.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.orgNguyen Viet Dung <dung.nguyen.aj@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove 16ch support for now

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

>From 29d03ff5c752e02918e8319fdcc86faa374d36ec Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 9 Aug 2017 01:46:23 +0000
Subject: [PATCH] ASoC: rsnd: remove 16ch support for now

R-Car Gen3 sound device can use TDM 16ch, but its usage is very
limited. It is not yet supported.
Let's remove unexpected/unsupported channel settings for now.
This patch makes xx_ADINR register settings sanity without
runtime check.

R-Car Gen3 datasheet

40.4.7 Note on Usage of the SSIU Module
When an SSIU module is used in "TDM-16ch mode",
only the transfer with the external memory is available.

Reported-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 3f2ced26ed37..7fa40fcad59e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -726,7 +726,6 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	case 2:
 	case 6:
 	case 8:
-	case 16:
 		/* TDM Extend Mode */
 		rsnd_rdai_channels_set(rdai, slots);
 		rsnd_rdai_ssi_lane_set(rdai, 1);
@@ -740,7 +739,7 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 }
 
 static unsigned int rsnd_soc_hw_channels_list[] = {
-	2, 6, 8, 16,
+	2, 6, 8,
 };
 
 static unsigned int rsnd_soc_hw_rate_list[] = {
@@ -1017,7 +1016,7 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	drv->playback.rates		= RSND_RATES;
 	drv->playback.formats		= RSND_FMTS;
 	drv->playback.channels_min	= 2;
-	drv->playback.channels_max	= 16;
+	drv->playback.channels_max	= 8;
 	drv->playback.stream_name	= rdai->playback.name;
 
 	snprintf(rdai->capture.name, RSND_DAI_NAME_SIZE,
@@ -1025,7 +1024,7 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	drv->capture.rates		= RSND_RATES;
 	drv->capture.formats		= RSND_FMTS;
 	drv->capture.channels_min	= 2;
-	drv->capture.channels_max	= 16;
+	drv->capture.channels_max	= 8;
 	drv->capture.stream_name	= rdai->capture.name;
 
 	rdai->playback.rdai		= rdai;
-- 
2.13.3
