From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: tse850-pcm5142: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:40 +0100 (BST)
Message-ID: <20190606212640.9E293440049@finisterre.sirena.org.uk>
References: <87r287icuj.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F230F897AA
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:41 +0200 (CEST)
In-Reply-To: <87r287icuj.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: atmel: tse850-pcm5142: use modern dai_link style

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

>From 1199dd99ddf699dd81c764016b8b6a9fd599d0d4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:13:51 +0900
Subject: [PATCH] ASoC: atmel: tse850-pcm5142: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/tse850-pcm5142.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index ae445184614a..59e2edb22b3a 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -294,13 +294,18 @@ static const struct snd_soc_dapm_route tse850_intercon[] = {
 	{ "DAC", NULL, "OUTL" },
 };
 
+SND_SOC_DAILINK_DEFS(pcm,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "pcm512x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link tse850_dailink = {
 	.name = "TSE-850",
 	.stream_name = "TSE-850-PCM",
-	.codec_dai_name = "pcm512x-hifi",
 	.dai_fmt = SND_SOC_DAIFMT_I2S
 		 | SND_SOC_DAIFMT_NB_NF
 		 | SND_SOC_DAIFMT_CBM_CFS,
+	SND_SOC_DAILINK_REG(pcm),
 };
 
 static struct snd_soc_card tse850_card = {
@@ -331,8 +336,8 @@ static int tse850_dt_init(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get cpu dai\n");
 		return -EINVAL;
 	}
-	dailink->cpu_of_node = cpu_np;
-	dailink->platform_of_node = cpu_np;
+	dailink->cpus->of_node = cpu_np;
+	dailink->platforms->of_node = cpu_np;
 	of_node_put(cpu_np);
 
 	codec_np = of_parse_phandle(np, "axentia,audio-codec", 0);
@@ -340,7 +345,7 @@ static int tse850_dt_init(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get codec info\n");
 		return -EINVAL;
 	}
-	dailink->codec_of_node = codec_np;
+	dailink->codecs->of_node = codec_np;
 	of_node_put(codec_np);
 
 	return 0;
-- 
2.20.1
