From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: tm2_wm5110: don't select
	unnecessary Platform" to the asoc tree
Date: Wed, 19 Jun 2019 13:12:01 +0100 (BST)
Message-ID: <20190619121201.56CF944004A@finisterre.sirena.org.uk>
References: <8736k6v0h3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DCEFF896DF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:07 +0200 (CEST)
In-Reply-To: <8736k6v0h3.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: tm2_wm5110: don't select unnecessary Platform

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

>From ae7cbcc43b8c275b9f9b2491144110d260cd6b18 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:18:17 +0900
Subject: [PATCH] ASoC: samsung: tm2_wm5110: don't select unnecessary Platform

ALSA SoC is now supporting "no Platform". Sound card doesn't need to
select "CPU component" as "Platform" anymore if it doesn't need
special Platform.
This patch removes such settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/tm2_wm5110.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index c091033d17ad..a80781031f62 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -429,21 +429,17 @@ static struct snd_soc_dai_driver tm2_ext_dai[] = {
 
 SND_SOC_DAILINK_DEFS(aif1,
 	DAILINK_COMP_ARRAY(COMP_CPU(SAMSUNG_I2S_DAI)),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif1")),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif1")));
 
 SND_SOC_DAILINK_DEFS(voice,
 	DAILINK_COMP_ARRAY(COMP_CPU(SAMSUNG_I2S_DAI)),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif2")),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif2")));
 
 SND_SOC_DAILINK_DEFS(bt,
 	DAILINK_COMP_ARRAY(COMP_CPU(SAMSUNG_I2S_DAI)),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif3")),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif3")));
 
 SND_SOC_DAILINK_DEFS(hdmi,
-	DAILINK_COMP_ARRAY(COMP_EMPTY()),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
@@ -576,14 +572,12 @@ static int tm2_probe(struct platform_device *pdev)
 		unsigned int dai_index = 0; /* WM5110 */
 
 		dai_link->cpus->name = NULL;
-		dai_link->platforms->name = NULL;
 
 		if (num_codecs > 1 && i == card->num_links - 1)
 			dai_index = 1; /* HDMI */
 
 		dai_link->codecs->of_node = codec_dai_node[dai_index];
 		dai_link->cpus->of_node = cpu_dai_node[dai_index];
-		dai_link->platforms->of_node = cpu_dai_node[dai_index];
 	}
 
 	if (num_codecs > 1) {
-- 
2.20.1
