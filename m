From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sirf: sirf-audio: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:22 +0100 (BST)
Message-ID: <20190606212622.12A75440049@finisterre.sirena.org.uk>
References: <87ef47gy30.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3F1EF89732
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:22 +0200 (CEST)
In-Reply-To: <87ef47gy30.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: sirf: sirf-audio: use modern dai_link style

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

>From a39bb1b740c95d8f0029b280266744897453e8ee Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:18:06 +0900
Subject: [PATCH] ASoC: sirf: sirf-audio: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sirf/sirf-audio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sirf/sirf-audio.c b/sound/soc/sirf/sirf-audio.c
index f2bc50790f76..ba85ccf1fe19 100644
--- a/sound/soc/sirf/sirf-audio.c
+++ b/sound/soc/sirf/sirf-audio.c
@@ -61,11 +61,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 };
 
 /* Digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEFS(sirf,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "sirf-audio-codec")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link sirf_audio_dai_link[] = {
 	{
 		.name = "SiRF audio card",
 		.stream_name = "SiRF audio HiFi",
-		.codec_dai_name = "sirf-audio-codec",
+		SND_SOC_DAILINK_REG(sirf),
 	},
 };
 
@@ -92,11 +97,11 @@ static int sirf_audio_probe(struct platform_device *pdev)
 	if (sirf_audio_card == NULL)
 		return -ENOMEM;
 
-	sirf_audio_dai_link[0].cpu_of_node =
+	sirf_audio_dai_link[0].cpus->of_node =
 		of_parse_phandle(pdev->dev.of_node, "sirf,audio-platform", 0);
-	sirf_audio_dai_link[0].platform_of_node =
+	sirf_audio_dai_link[0].platforms->of_node =
 		of_parse_phandle(pdev->dev.of_node, "sirf,audio-platform", 0);
-	sirf_audio_dai_link[0].codec_of_node =
+	sirf_audio_dai_link[0].codecs->of_node =
 		of_parse_phandle(pdev->dev.of_node, "sirf,audio-codec", 0);
 	sirf_audio_card->gpio_spk_pa = of_get_named_gpio(pdev->dev.of_node,
 			"spk-pa-gpios", 0);
-- 
2.20.1
