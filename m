From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: acp-rt5645: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:42 +0100 (BST)
Message-ID: <20190606212642.D2B06440049@finisterre.sirena.org.uk>
References: <87wohzicv1.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E8AFF897AF
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:43 +0200 (CEST)
In-Reply-To: <87wohzicv1.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: amd: acp-rt5645: use modern dai_link style

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

>From 19913c163e219376e543e8138ca4f05670ee9f4a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:13:33 +0900
Subject: [PATCH] ASoC: amd: acp-rt5645: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-rt5645.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-rt5645.c b/sound/soc/amd/acp-rt5645.c
index b79b922b08a0..91abeb92b648 100644
--- a/sound/soc/amd/acp-rt5645.c
+++ b/sound/soc/amd/acp-rt5645.c
@@ -95,29 +95,34 @@ static struct snd_soc_ops cz_aif1_ops = {
 	.hw_params = cz_aif1_hw_params,
 };
 
+SND_SOC_DAILINK_DEF(designware1,
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1.auto")));
+SND_SOC_DAILINK_DEF(designware2,
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+
+SND_SOC_DAILINK_DEF(codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5650:00", "rt5645-aif1")));
+
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0.auto")));
+
 static struct snd_soc_dai_link cz_dai_rt5650[] = {
 	{
 		.name = "amd-rt5645-play",
 		.stream_name = "RT5645_AIF1",
-		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.1.auto",
-		.codec_dai_name = "rt5645-aif1",
-		.codec_name = "i2c-10EC5650:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_init,
 		.ops = &cz_aif1_ops,
+		SND_SOC_DAILINK_REG(designware1, codec, platform),
 	},
 	{
 		.name = "amd-rt5645-cap",
 		.stream_name = "RT5645_AIF1",
-		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.2.auto",
-		.codec_dai_name = "rt5645-aif1",
-		.codec_name = "i2c-10EC5650:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.ops = &cz_aif1_ops,
+		SND_SOC_DAILINK_REG(designware2, codec, platform),
 	},
 };
 
-- 
2.20.1
