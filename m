From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: use defined
	io_playback/io_capture" to the asoc tree
Date: Tue,  6 Nov 2018 17:53:11 +0000 (GMT)
Message-ID: <20181106175311.0B750112266B@debutante.sirena.org.uk>
References: <87bm72x02z.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 08ABE267AAB
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:53:11 +0100 (CET)
In-Reply-To: <87bm72x02z.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: use defined io_playback/io_capture

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

>From 9328882e9dc6b3ae6d11eaf6dbdeb45dfbb2d38f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 05:19:33 +0000
Subject: [PATCH] ASoC: rsnd: use defined io_playback/io_capture

rdai->playback/rdai->capture are defined as io_playback/io_capture
on __rsnd_dai_probe(). Let's use it instead of original one.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index cbe846e4438f..cb592191bc86 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1091,24 +1091,24 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	drv->name	= rdai->name;
 	drv->ops	= &rsnd_soc_dai_ops;
 
-	snprintf(rdai->playback.name, RSND_DAI_NAME_SIZE,
+	snprintf(io_playback->name, RSND_DAI_NAME_SIZE,
 		 "DAI%d Playback", dai_i);
 	drv->playback.rates		= RSND_RATES;
 	drv->playback.formats		= RSND_FMTS;
 	drv->playback.channels_min	= 2;
 	drv->playback.channels_max	= 8;
-	drv->playback.stream_name	= rdai->playback.name;
+	drv->playback.stream_name	= io_playback->name;
 
-	snprintf(rdai->capture.name, RSND_DAI_NAME_SIZE,
+	snprintf(io_capture->name, RSND_DAI_NAME_SIZE,
 		 "DAI%d Capture", dai_i);
 	drv->capture.rates		= RSND_RATES;
 	drv->capture.formats		= RSND_FMTS;
 	drv->capture.channels_min	= 2;
 	drv->capture.channels_max	= 8;
-	drv->capture.stream_name	= rdai->capture.name;
+	drv->capture.stream_name	= io_capture->name;
 
-	rdai->playback.rdai		= rdai;
-	rdai->capture.rdai		= rdai;
+	io_playback->rdai		= rdai;
+	io_capture->rdai		= rdai;
 	rsnd_rdai_channels_set(rdai, 2); /* default 2ch */
 	rsnd_rdai_ssi_lane_set(rdai, 1); /* default 1lane */
 	rsnd_rdai_width_set(rdai, 32);   /* default 32bit width */
-- 
2.19.0.rc2
