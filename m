From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: smdk_wm8994: don't select
	unnecessary Platform" to the asoc tree
Date: Wed, 19 Jun 2019 13:12:01 +0100 (BST)
Message-ID: <20190619121201.90DA844004C@finisterre.sirena.org.uk>
References: <875zp2v0hc.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DCB4F8973D
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:03 +0200 (CEST)
In-Reply-To: <875zp2v0hc.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: smdk_wm8994: don't select unnecessary Platform

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

>From d815e0f08fdd6259c9fff9eb4dc1834454526e98 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:18:09 +0900
Subject: [PATCH] ASoC: samsung: smdk_wm8994: don't select unnecessary Platform

ALSA SoC is now supporting "no Platform". Sound card doesn't need to
select "CPU component" as "Platform" anymore if it doesn't need
special Platform.
This patch removes such settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/smdk_wm8994.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 28f8be000aa1..99aa1620a17d 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -102,13 +102,11 @@ static int smdk_wm8994_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 
 SND_SOC_DAILINK_DEFS(aif1,
 	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("wm8994-codec", "wm8994-aif1")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8994-codec", "wm8994-aif1")));
 
 SND_SOC_DAILINK_DEFS(fifo_tx,
 	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s-sec")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("wm8994-codec", "wm8994-aif1")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s-sec")));
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8994-codec", "wm8994-aif1")));
 
 static struct snd_soc_dai_link smdk_dai[] = {
 	{ /* Primary DAI i/f */
@@ -165,9 +163,6 @@ static int smdk_audio_probe(struct platform_device *pdev)
 			   "Property 'samsung,i2s-controller' missing or invalid\n");
 			ret = -EINVAL;
 		}
-
-		smdk_dai[0].platforms->name = NULL;
-		smdk_dai[0].platforms->of_node = smdk_dai[0].cpus->of_node;
 	}
 
 	id = of_match_device(of_match_ptr(samsung_wm8994_of_match), &pdev->dev);
-- 
2.20.1
