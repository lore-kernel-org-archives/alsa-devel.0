From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: odroid: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:02 +0100 (BST)
Message-ID: <20190606212702.61E76440049@finisterre.sirena.org.uk>
References: <87blzbl654.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26367F89761
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:03 +0200 (CEST)
In-Reply-To: <87blzbl654.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: odroid: use modern dai_link style

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

>From 3cddda10c25f4627a43f3db9314a9c79c5a60ce1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:10:26 +0900
Subject: [PATCH] ASoC: samsung: odroid: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index e688169ff12a..dfb6e460e7eb 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -151,39 +151,48 @@ static const struct snd_soc_dapm_route odroid_dapm_routes[] = {
 	{ "HiFi Playback", NULL, "Mixer DAI TX" },
 };
 
+SND_SOC_DAILINK_DEFS(primary,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("3830000.i2s")));
+
+SND_SOC_DAILINK_DEFS(mixer,
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()));
+
+SND_SOC_DAILINK_DEFS(secondary,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("3830000.i2s-sec")));
+
 static struct snd_soc_dai_link odroid_card_dais[] = {
 	{
 		/* Primary FE <-> BE link */
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.ops = &odroid_card_fe_ops,
 		.name = "Primary",
 		.stream_name = "Primary",
-		.platform_name = "3830000.i2s",
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(primary),
 	}, {
 		/* BE <-> CODECs link */
 		.name = "I2S Mixer",
-		.cpu_name = "snd-soc-dummy",
-		.cpu_dai_name = "snd-soc-dummy-dai",
-		.platform_name = "snd-soc-dummy",
 		.ops = &odroid_card_be_ops,
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(mixer),
 	}, {
 		/* Secondary FE <-> BE link */
 		.playback_only = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.ops = &odroid_card_fe_ops,
 		.name = "Secondary",
 		.stream_name = "Secondary",
-		.platform_name = "3830000.i2s-sec",
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(secondary),
 	}
 };
 
@@ -262,7 +271,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 			break;
 		}
 
-		ret = snd_soc_get_dai_name(&args, &link->cpu_dai_name);
+		ret = snd_soc_get_dai_name(&args, &link->cpus->dai_name);
 		of_node_put(args.np);
 
 		if (ret < 0)
-- 
2.20.1
