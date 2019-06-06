From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cirrus: snappercl15: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:36 +0100 (BST)
Message-ID: <20190606212636.2078B440046@finisterre.sirena.org.uk>
References: <87ftonictj.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5B9CF897A2
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:36 +0200 (CEST)
In-Reply-To: <87ftonictj.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: cirrus: snappercl15: use modern dai_link style

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

>From 40989980bf4b9483ad2fb99c58324123a8c74c92 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:14:28 +0900
Subject: [PATCH] ASoC: cirrus: snappercl15: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/cirrus/snappercl15.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index dea4909154c8..0b4efcc51232 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -65,16 +65,19 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MICIN", NULL, "Mic Jack"},
 };
 
+SND_SOC_DAILINK_DEFS(aic23,
+	DAILINK_COMP_ARRAY(COMP_CPU("ep93xx-i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic23-codec.0-001a",
+				      "tlv320aic23-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("ep93xx-i2s")));
+
 static struct snd_soc_dai_link snappercl15_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "AIC23",
-	.cpu_dai_name	= "ep93xx-i2s",
-	.codec_dai_name	= "tlv320aic23-hifi",
-	.codec_name	= "tlv320aic23-codec.0-001a",
-	.platform_name	= "ep93xx-i2s",
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &snappercl15_ops,
+	SND_SOC_DAILINK_REG(aic23),
 };
 
 static struct snd_soc_card snd_soc_snappercl15 = {
-- 
2.20.1
