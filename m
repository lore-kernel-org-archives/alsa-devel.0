From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup 6ch settings to 8ch" to the
	asoc tree
Date: Thu, 25 Apr 2019 20:26:30 +0100 (BST)
Message-ID: <20190425192630.54F26441D57@finisterre.ee.mobilebroadband>
References: <877ebi1v1e.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA04BF8976A
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 21:26:34 +0200 (CEST)
In-Reply-To: <877ebi1v1e.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup 6ch settings to 8ch

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From 66287def435315d9d8de740da4c543e37630b897 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Apr 2019 15:16:58 +0900
Subject: [PATCH] ASoC: rsnd: fixup 6ch settings to 8ch

rsnd need to use 8ch clock settings for 6ch for TDM.
Otherwise, it can't work correctly.
This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 18 +++++++++++++-----
 sound/soc/sh/rcar/rsnd.h |  1 +
 sound/soc/sh/rcar/ssi.c  |  2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 4fe83e611c01..37cb61553d5f 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -300,6 +300,18 @@ int rsnd_runtime_channel_after_ctu_with_params(struct rsnd_dai_stream *io,
 	return chan;
 }
 
+int rsnd_channel_normalization(int chan)
+{
+	if ((chan > 8) || (chan < 0))
+		return 0;
+
+	/* TDM Extend Mode needs 8ch */
+	if (chan == 6)
+		chan = 8;
+
+	return chan;
+}
+
 int rsnd_runtime_channel_for_ssi_with_params(struct rsnd_dai_stream *io,
 					     struct snd_pcm_hw_params *params)
 {
@@ -312,11 +324,7 @@ int rsnd_runtime_channel_for_ssi_with_params(struct rsnd_dai_stream *io,
 	if (rsnd_runtime_is_multi_ssi(io))
 		chan /= rsnd_rdai_ssi_lane_get(rdai);
 
-	/* TDM Extend Mode needs 8ch */
-	if (chan == 6)
-		chan = 8;
-
-	return chan;
+	return rsnd_channel_normalization(chan);
 }
 
 int rsnd_runtime_is_multi_ssi(struct rsnd_dai_stream *io)
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 0e6ef4e18400..7727add3eb1a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -446,6 +446,7 @@ void rsnd_parse_connect_common(struct rsnd_dai *rdai,
 		struct device_node *playback,
 		struct device_node *capture);
 
+int rsnd_channel_normalization(int chan);
 #define rsnd_runtime_channel_original(io) \
 	rsnd_runtime_channel_original_with_params(io, NULL)
 int rsnd_runtime_channel_original_with_params(struct rsnd_dai_stream *io,
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f5afab631abb..44bda210256e 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -303,6 +303,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_runtime_is_tdm_split(io))
 		chan = rsnd_io_converted_chan(io);
 
+	chan = rsnd_channel_normalization(chan);
+
 	main_rate = rsnd_ssi_clk_query(rdai, rate, chan, &idx);
 	if (!main_rate) {
 		dev_err(dev, "unsupported clock rate\n");
-- 
2.20.1
