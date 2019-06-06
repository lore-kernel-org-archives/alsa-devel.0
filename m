From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mxs: mxs-sgtl5000: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:27 +0100 (BST)
Message-ID: <20190606212627.3BB80440046@finisterre.sirena.org.uk>
References: <87sgsngy5h.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4A3DF89780
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:27 +0200 (CEST)
In-Reply-To: <87sgsngy5h.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: mxs: mxs-sgtl5000: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 49cb448846f57227a9758dc71a19ce1e24ddbbdd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:16:37 +0900
Subject: [PATCH] ASoC: mxs: mxs-sgtl5000: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mxs/mxs-sgtl5000.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 2b3f2408301a..459fced603b0 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -75,21 +75,32 @@ static const struct snd_soc_ops mxs_sgtl5000_hifi_ops = {
 #define MXS_SGTL5000_DAI_FMT (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | \
 	SND_SOC_DAIFMT_CBS_CFS)
 
+
+SND_SOC_DAILINK_DEFS(hifi_tx,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "sgtl5000")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(hifi_rx,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "sgtl5000")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
 	{
 		.name		= "HiFi Tx",
 		.stream_name	= "HiFi Playback",
-		.codec_dai_name	= "sgtl5000",
 		.dai_fmt	= MXS_SGTL5000_DAI_FMT,
 		.ops		= &mxs_sgtl5000_hifi_ops,
 		.playback_only	= true,
+		SND_SOC_DAILINK_REG(hifi_tx),
 	}, {
 		.name		= "HiFi Rx",
 		.stream_name	= "HiFi Capture",
-		.codec_dai_name	= "sgtl5000",
 		.dai_fmt	= MXS_SGTL5000_DAI_FMT,
 		.ops		= &mxs_sgtl5000_hifi_ops,
 		.capture_only	= true,
+		SND_SOC_DAILINK_REG(hifi_rx),
 	},
 };
 
@@ -124,12 +135,12 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < 2; i++) {
-		mxs_sgtl5000_dai[i].codec_name = NULL;
-		mxs_sgtl5000_dai[i].codec_of_node = codec_np;
-		mxs_sgtl5000_dai[i].cpu_dai_name = NULL;
-		mxs_sgtl5000_dai[i].cpu_of_node = saif_np[i];
-		mxs_sgtl5000_dai[i].platform_name = NULL;
-		mxs_sgtl5000_dai[i].platform_of_node = saif_np[i];
+		mxs_sgtl5000_dai[i].codecs->name = NULL;
+		mxs_sgtl5000_dai[i].codecs->of_node = codec_np;
+		mxs_sgtl5000_dai[i].cpus->dai_name = NULL;
+		mxs_sgtl5000_dai[i].cpus->of_node = saif_np[i];
+		mxs_sgtl5000_dai[i].platforms->name = NULL;
+		mxs_sgtl5000_dai[i].platforms->of_node = saif_np[i];
 	}
 
 	of_node_put(codec_np);
-- 
2.20.1
