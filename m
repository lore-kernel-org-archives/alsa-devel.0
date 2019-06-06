From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: pcm030-audio-fabric: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:29 +0100 (BST)
Message-ID: <20190606212629.63B4D440049@finisterre.sirena.org.uk>
References: <87y32fgy64.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AD53F8978C
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:30 +0200 (CEST)
In-Reply-To: <87y32fgy64.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: pcm030-audio-fabric: use modern dai_link style

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

>From 61c29313cb812a6de3dc7bfd7baa3d20cf7e3e83 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:16:14 +0900
Subject: [PATCH] ASoC: fsl: pcm030-audio-fabric: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/pcm030-audio-fabric.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index a7fe4ad25c52..af3c3b90c0ac 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -23,20 +23,26 @@ struct pcm030_audio_data {
 	struct platform_device *codec_device;
 };
 
+SND_SOC_DAILINK_DEFS(analog,
+	DAILINK_COMP_ARRAY(COMP_CPU("mpc5200-psc-ac97.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9712-codec", "wm9712-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(iec958,
+	DAILINK_COMP_ARRAY(COMP_CPU("mpc5200-psc-ac97.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9712-codec", "wm9712-aux")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 {
 	.name = "AC97.0",
 	.stream_name = "AC97 Analog",
-	.codec_dai_name = "wm9712-hifi",
-	.cpu_dai_name = "mpc5200-psc-ac97.0",
-	.codec_name = "wm9712-codec",
+	SND_SOC_DAILINK_REG(analog),
 },
 {
 	.name = "AC97.1",
 	.stream_name = "AC97 IEC958",
-	.codec_dai_name = "wm9712-aux",
-	.cpu_dai_name = "mpc5200-psc-ac97.1",
-	.codec_name = "wm9712-codec",
+	SND_SOC_DAILINK_REG(iec958),
 },
 };
 
@@ -76,7 +82,7 @@ static int pcm030_fabric_probe(struct platform_device *op)
 	}
 
 	for_each_card_prelinks(card, i, dai_link)
-		dai_link->platform_of_node = platform_np;
+		dai_link->platforms->of_node = platform_np;
 
 	ret = request_module("snd-soc-wm9712");
 	if (ret)
-- 
2.20.1
