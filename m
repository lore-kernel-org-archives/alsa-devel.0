From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: rx1950_uda1380: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:02 +0100 (BST)
Message-ID: <20190606212702.E1A24440046@finisterre.sirena.org.uk>
References: <87d0jrl659.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA65FF89735
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:03 +0200 (CEST)
In-Reply-To: <87d0jrl659.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: rx1950_uda1380: use modern dai_link style

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

>From 400127a12ae36fe61e2740a96c7bad4755c43d65 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:10:21 +0900
Subject: [PATCH] ASoC: samsung: rx1950_uda1380: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/rx1950_uda1380.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 1dcc1b252ad1..4b247e91ae5b 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -72,18 +72,21 @@ static struct snd_soc_ops rx1950_ops = {
 };
 
 /* s3c24xx digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEFS(uda1380,
+	DAILINK_COMP_ARRAY(COMP_CPU("s3c24xx-iis")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("uda1380-codec.0-001a",
+				      "uda1380-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("s3c24xx-iis")));
+
 static struct snd_soc_dai_link rx1950_uda1380_dai[] = {
 	{
 		.name		= "uda1380",
 		.stream_name	= "UDA1380 Duplex",
-		.cpu_dai_name	= "s3c24xx-iis",
-		.codec_dai_name	= "uda1380-hifi",
 		.init		= rx1950_uda1380_init,
-		.platform_name	= "s3c24xx-iis",
-		.codec_name	= "uda1380-codec.0-001a",
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBS_CFS,
 		.ops		= &rx1950_ops,
+		SND_SOC_DAILINK_REG(uda1380),
 	},
 };
 
-- 
2.20.1
