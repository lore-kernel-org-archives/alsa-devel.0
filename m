From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: byt-max98090: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:09 +0100 (BST)
Message-ID: <20190606212609.73D63440046@finisterre.sirena.org.uk>
References: <87imtjfjf0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49162F89747
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:10 +0200 (CEST)
In-Reply-To: <87imtjfjf0.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: Intel: byt-max98090: use modern dai_link style

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

>From 0034172031aa695911cc2c2db2a3cd76ebff6cf4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:20:15 +0900
Subject: [PATCH] ASoC: Intel: byt-max98090: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/byt-max98090.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
index f1283634b22b..589499fcd36d 100644
--- a/sound/soc/intel/boards/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -117,17 +117,19 @@ static int byt_max98090_init(struct snd_soc_pcm_runtime *runtime)
 				       hs_jack_gpios);
 }
 
+SND_SOC_DAILINK_DEFS(baytrail,
+	DAILINK_COMP_ARRAY(COMP_CPU("baytrail-pcm-audio")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-193C9890:00", "HiFi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("baytrail-pcm-audio")));
+
 static struct snd_soc_dai_link byt_max98090_dais[] = {
 	{
 		.name = "Baytrail Audio",
 		.stream_name = "Audio",
-		.cpu_dai_name = "baytrail-pcm-audio",
-		.codec_dai_name = "HiFi",
-		.codec_name = "i2c-193C9890:00",
-		.platform_name = "baytrail-pcm-audio",
 		.init = byt_max98090_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(baytrail),
 	},
 };
 
-- 
2.20.1
