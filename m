From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-evm: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:47 +0100 (BST)
Message-ID: <20190606212647.5730B440046@finisterre.sirena.org.uk>
References: <878sufjrgh.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B000F8974B
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:48 +0200 (CEST)
In-Reply-To: <878sufjrgh.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ti: davinci-evm: use modern dai_link style

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

>From de3582fec0aacdca484d68ca693e255f2617d8ec Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:12:57 +0900
Subject: [PATCH] ASoC: ti: davinci-evm: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-evm.c | 105 +++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 38 deletions(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index 4869d6311510..bd822bc8040f 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -143,103 +143,127 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 }
 
 /* davinci-evm digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEFS(dm6446,
+	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcbsp")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-001b",
+				      "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcbsp")));
+
 static struct snd_soc_dai_link dm6446_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai_name = "davinci-mcbsp",
-	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.1-001b",
-	.platform_name = "davinci-mcbsp",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
 		   SND_SOC_DAIFMT_IB_NF,
+	SND_SOC_DAILINK_REG(dm6446),
 };
 
+SND_SOC_DAILINK_DEFS(dm355,
+	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcbsp.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-001b",
+				      "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcbsp.1")));
+
 static struct snd_soc_dai_link dm355_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai_name = "davinci-mcbsp.1",
-	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.1-001b",
-	.platform_name = "davinci-mcbsp.1",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
 		   SND_SOC_DAIFMT_IB_NF,
+	SND_SOC_DAILINK_REG(dm355),
 };
 
+#ifdef CONFIG_SND_SOC_DM365_AIC3X_CODEC
+SND_SOC_DAILINK_DEFS(dm365,
+	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcbsp")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-0018",
+				      "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcbsp")));
+#elif defined(CONFIG_SND_SOC_DM365_VOICE_CODEC)
+SND_SOC_DAILINK_DEFS(dm365,
+	DAILINK_COMP_ARRAY(COMP_CPU("davinci-vcif")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("cq93vc-codec", "cq93vc-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-vcif")));
+#endif
+
 static struct snd_soc_dai_link dm365_evm_dai = {
 #ifdef CONFIG_SND_SOC_DM365_AIC3X_CODEC
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai_name = "davinci-mcbsp",
-	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.1-0018",
-	.platform_name = "davinci-mcbsp",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
 		   SND_SOC_DAIFMT_IB_NF,
+	SND_SOC_DAILINK_REG(dm365),
 #elif defined(CONFIG_SND_SOC_DM365_VOICE_CODEC)
 	.name = "Voice Codec - CQ93VC",
 	.stream_name = "CQ93",
-	.cpu_dai_name = "davinci-vcif",
-	.codec_dai_name = "cq93vc-hifi",
-	.codec_name = "cq93vc-codec",
-	.platform_name = "davinci-vcif",
+	SND_SOC_DAILINK_REG(dm365),
 #endif
 };
 
+SND_SOC_DAILINK_DEFS(dm6467_aic3x,
+	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcasp.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.0-001a",
+				      "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcasp.0")));
+
+SND_SOC_DAILINK_DEFS(dm6467_spdif,
+	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcasp.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("spdif_dit", "dit-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcasp.1")));
+
 static struct snd_soc_dai_link dm6467_evm_dai[] = {
 	{
 		.name = "TLV320AIC3X",
 		.stream_name = "AIC3X",
-		.cpu_dai_name= "davinci-mcasp.0",
-		.codec_dai_name = "tlv320aic3x-hifi",
-		.platform_name = "davinci-mcasp.0",
-		.codec_name = "tlv320aic3x-codec.0-001a",
 		.init = evm_aic3x_init,
 		.ops = &evm_ops,
 		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
 			   SND_SOC_DAIFMT_IB_NF,
+		SND_SOC_DAILINK_REG(dm6467_aic3x),
 	},
 	{
 		.name = "McASP",
 		.stream_name = "spdif",
-		.cpu_dai_name= "davinci-mcasp.1",
-		.codec_dai_name = "dit-hifi",
-		.codec_name = "spdif_dit",
-		.platform_name = "davinci-mcasp.1",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
 			   SND_SOC_DAIFMT_IB_NF,
+		SND_SOC_DAILINK_REG(dm6467_spdif),
 	},
 };
 
+SND_SOC_DAILINK_DEFS(da830,
+	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcasp.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-0018",
+				      "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcasp.1")));
+
 static struct snd_soc_dai_link da830_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai_name = "davinci-mcasp.1",
-	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.1-0018",
-	.platform_name = "davinci-mcasp.1",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
 		   SND_SOC_DAIFMT_IB_NF,
+	SND_SOC_DAILINK_REG(da830),
 };
 
+SND_SOC_DAILINK_DEFS(da850,
+	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcasp.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-0018",
+				      "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcasp.0")));
+
 static struct snd_soc_dai_link da850_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai_name= "davinci-mcasp.0",
-	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.1-0018",
-	.platform_name = "davinci-mcasp.0",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
 		   SND_SOC_DAIFMT_IB_NF,
+	SND_SOC_DAILINK_REG(da850),
 };
 
 /* davinci dm6446 evm audio machine driver */
@@ -330,14 +354,19 @@ static struct snd_soc_card da850_snd_soc_card = {
  * The struct is used as place holder. It will be completely
  * filled with data from dt node.
  */
+SND_SOC_DAILINK_DEFS(evm,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link evm_dai_tlv320aic3x = {
 	.name		= "TLV320AIC3X",
 	.stream_name	= "AIC3X",
-	.codec_dai_name	= "tlv320aic3x-hifi",
 	.ops            = &evm_ops,
 	.init           = evm_aic3x_init,
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
 		   SND_SOC_DAIFMT_IB_NF,
+	SND_SOC_DAILINK_REG(evm),
 };
 
 static const struct of_device_id davinci_evm_dt_ids[] = {
@@ -374,15 +403,15 @@ static int davinci_evm_probe(struct platform_device *pdev)
 
 	evm_soc_card.dai_link = dai;
 
-	dai->codec_of_node = of_parse_phandle(np, "ti,audio-codec", 0);
-	if (!dai->codec_of_node)
+	dai->codecs->of_node = of_parse_phandle(np, "ti,audio-codec", 0);
+	if (!dai->codecs->of_node)
 		return -EINVAL;
 
-	dai->cpu_of_node = of_parse_phandle(np, "ti,mcasp-controller", 0);
-	if (!dai->cpu_of_node)
+	dai->cpus->of_node = of_parse_phandle(np, "ti,mcasp-controller", 0);
+	if (!dai->cpus->of_node)
 		return -EINVAL;
 
-	dai->platform_of_node = dai->cpu_of_node;
+	dai->platforms->of_node = dai->cpus->of_node;
 
 	evm_soc_card.dev = &pdev->dev;
 	ret = snd_soc_of_parse_card_name(&evm_soc_card, "ti,model");
-- 
2.20.1
