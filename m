From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: s3c24xx_simtec_hermes: use
	modern dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:03 +0100 (BST)
Message-ID: <20190606212703.74C41440049@finisterre.sirena.org.uk>
References: <87ef47l65e.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AA23F897EA
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:04 +0200 (CEST)
In-Reply-To: <87ef47l65e.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: s3c24xx_simtec_hermes: use modern dai_link style

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

>From 1c0f3edbcabd014b70473937199467af3e1339c5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:10:16 +0900
Subject: [PATCH] ASoC: samsung: s3c24xx_simtec_hermes: use modern dai_link
 style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c24xx_simtec_hermes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index e3528e74a338..ed0d1b8fa2d4 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -63,14 +63,17 @@ static int simtec_hermes_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+SND_SOC_DAILINK_DEFS(tlv320aic33,
+	DAILINK_COMP_ARRAY(COMP_CPU("s3c24xx-iis")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.0-001a",
+				      "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("s3c24xx-iis")));
+
 static struct snd_soc_dai_link simtec_dai_aic33 = {
 	.name		= "tlv320aic33",
 	.stream_name	= "TLV320AIC33",
-	.codec_name	= "tlv320aic3x-codec.0-001a",
-	.cpu_dai_name	= "s3c24xx-iis",
-	.codec_dai_name = "tlv320aic3x-hifi",
-	.platform_name	= "s3c24xx-iis",
 	.init		= simtec_hermes_init,
+	SND_SOC_DAILINK_REG(tlv320aic33),
 };
 
 /* simtec audio machine driver */
-- 
2.20.1
