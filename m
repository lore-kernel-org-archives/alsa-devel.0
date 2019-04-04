From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: don't select DPCM via
	audio-graph-card" to the asoc tree
Date: Thu,  4 Apr 2019 15:17:09 +0700 (+07)
Message-ID: <20190404081709.30ECB441D3D@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 776A6F89756
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 10:17:14 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: don't select DPCM via audio-graph-card

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

>From c2c616021d64d952dc9d37793924ce57833d7754 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 4 Apr 2019 09:52:15 +0900
Subject: [PATCH] ASoC: audio-graph-card: don't select DPCM via
 audio-graph-card

commit ae3cb5790906b ("ASoC: audio-graph-card: merge
audio-graph-scu-card") merged audio-graph-scu-card which can
handle DPCM into audio-graph-card.

By this patch, the judgement to select "normal sound card" or
"DPCM sound card" is based on its OF-graph endpoint connection.
But, because of it, existing "audio-graph-card" user who is
assuming "normal sound card" might select DPCM unintentionally.

To solve this issue, this patch allows "audio-graph-card" user
can select "normal sound card", and "audio-graph-scu-card" user
can select both "normal sound card" and "DPCM sound card".
This keeps compatibility collectry.

Fixes: ae3cb5790906b ("ASoC: audio-graph-card: merge audio-graph-scu-card")
Reported-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index bb12351330e8..69bc4848d787 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -20,6 +20,8 @@
 #include <linux/string.h>
 #include <sound/simple_card_utils.h>
 
+#define DPCM_SELECTABLE 1
+
 struct graph_priv {
 	struct snd_soc_card snd_card;
 	struct graph_dai_props {
@@ -440,6 +442,7 @@ static int graph_for_each_link(struct graph_priv *priv,
 	struct device_node *codec_port;
 	struct device_node *codec_port_old = NULL;
 	struct asoc_simple_card_data adata;
+	uintptr_t dpcm_selectable = (uintptr_t)of_device_get_match_data(dev);
 	int rc, ret;
 
 	/* loop for all listed CPU port */
@@ -470,8 +473,9 @@ static int graph_for_each_link(struct graph_priv *priv,
 			 * if Codec port has many endpoints,
 			 * or has convert-xxx property
 			 */
-			if ((of_get_child_count(codec_port) > 1) ||
-			    adata.convert_rate || adata.convert_channels)
+			if (dpcm_selectable &&
+			    ((of_get_child_count(codec_port) > 1) ||
+			     adata.convert_rate || adata.convert_channels))
 				ret = func_dpcm(priv, cpu_ep, codec_ep, li,
 						(codec_port_old == codec_port));
 			/* else normal sound */
@@ -732,7 +736,8 @@ static int graph_remove(struct platform_device *pdev)
 
 static const struct of_device_id graph_of_match[] = {
 	{ .compatible = "audio-graph-card", },
-	{ .compatible = "audio-graph-scu-card", },
+	{ .compatible = "audio-graph-scu-card",
+	  .data = (void *)DPCM_SELECTABLE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, graph_of_match);
-- 
2.20.1
