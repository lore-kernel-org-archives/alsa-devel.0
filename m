Return-Path: <SRS0=GfuB=4T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3AEC3F2CD
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:39:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28962166E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A7cpt+zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28962166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27B481690;
	Mon,  2 Mar 2020 15:38:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27B481690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583159983;
	bh=J6yFcYaIyDQrcndk5c6IfzHpFuwW8HHEeMP+7HBq2xM=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=A7cpt+zRJTIfNMTEa8o7bJzP3ITv0mV7DX+cM6ls6MKNm2lsTLjpzlABkk1kCflTN
	 KQshVewMMX/HzIWAV3iNlxycD/HM7d6OgKW2eJgLgdYHrmQ2UGMCPylwtT8jHsuNrW
	 8Y6FmkQcM8e8H6ZE1WUtMGeq5wm/hYUT0F9ok4iw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E7B7F801EC;
	Mon,  2 Mar 2020 15:37:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D7E2F80232; Mon,  2 Mar 2020 15:37:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 63631F801EC
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2020 15:37:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63631F801EC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA5CC101E;
 Mon,  2 Mar 2020 06:37:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E05A3F534;
 Mon,  2 Mar 2020 06:37:05 -0800 (PST)
Date: Mon, 02 Mar 2020 14:37:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Applied "ASoc: amd: Add DMIC switch capability to machine driver" to
 the asoc tree
In-Reply-To: <20200302082443.51587-1-akshu.agrawal@amd.com>
Message-Id: <applied-20200302082443.51587-1-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Cc: , "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 open list <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, akshu.agrawal@amd.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoc: amd: Add DMIC switch capability to machine driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 72c3b2b09fcdaa6a63e17e9a715e2a8236af529a Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 2 Mar 2020 13:54:36 +0530
Subject: [PATCH] ASoc: amd: Add DMIC switch capability to machine driver

Switch between DMIC0 and DMIC1 based on recording device selected.
This is done by toggling the dmic select gpio.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Link: https://lore.kernel.org/r/20200302082443.51587-1-akshu.agrawal@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 53 ++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 96fbcd29e3ed..511b8b1722aa 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -12,6 +12,7 @@
 #include <sound/jack.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -27,6 +28,7 @@
 static struct snd_soc_jack pco_jack;
 static struct clk *rt5682_dai_wclk;
 static struct clk *rt5682_dai_bclk;
+static struct gpio_desc *dmic_sel;
 
 static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -176,7 +178,7 @@ static int acp3x_max_startup(struct snd_pcm_substream *substream)
 	return rt5682_clk_enable(substream);
 }
 
-static int acp3x_ec_startup(struct snd_pcm_substream *substream)
+static int acp3x_ec_dmic0_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
@@ -185,6 +187,23 @@ static int acp3x_ec_startup(struct snd_pcm_substream *substream)
 
 	machine->cap_i2s_instance = I2S_BT_INSTANCE;
 	snd_soc_dai_set_bclk_ratio(codec_dai, 64);
+	if (dmic_sel)
+		gpiod_set_value(dmic_sel, 0);
+
+	return rt5682_clk_enable(substream);
+}
+
+static int acp3x_ec_dmic1_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct acp3x_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->cap_i2s_instance = I2S_BT_INSTANCE;
+	snd_soc_dai_set_bclk_ratio(codec_dai, 64);
+	if (dmic_sel)
+		gpiod_set_value(dmic_sel, 1);
 
 	return rt5682_clk_enable(substream);
 }
@@ -204,8 +223,13 @@ static const struct snd_soc_ops acp3x_max_play_ops = {
 	.shutdown = rt5682_shutdown,
 };
 
-static const struct snd_soc_ops acp3x_ec_cap_ops = {
-	.startup = acp3x_ec_startup,
+static const struct snd_soc_ops acp3x_ec_cap0_ops = {
+	.startup = acp3x_ec_dmic0_startup,
+	.shutdown = rt5682_shutdown,
+};
+
+static const struct snd_soc_ops acp3x_ec_cap1_ops = {
+	.startup = acp3x_ec_dmic1_startup,
 	.shutdown = rt5682_shutdown,
 };
 
@@ -246,12 +270,21 @@ static struct snd_soc_dai_link acp3x_dai_5682_98357[] = {
 		SND_SOC_DAILINK_REG(acp3x_bt, max, platform),
 	},
 	{
-		.name = "acp3x-ec-capture",
-		.stream_name = "Capture",
+		.name = "acp3x-ec-dmic0-capture",
+		.stream_name = "Capture DMIC0",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBS_CFS,
+		.dpcm_capture = 1,
+		.ops = &acp3x_ec_cap0_ops,
+		SND_SOC_DAILINK_REG(acp3x_bt, cros_ec, platform),
+	},
+	{
+		.name = "acp3x-ec-dmic1-capture",
+		.stream_name = "Capture DMIC1",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBS_CFS,
 		.dpcm_capture = 1,
-		.ops = &acp3x_ec_cap_ops,
+		.ops = &acp3x_ec_cap1_ops,
 		SND_SOC_DAILINK_REG(acp3x_bt, cros_ec, platform),
 	},
 };
@@ -302,6 +335,14 @@ static int acp3x_probe(struct platform_device *pdev)
 	acp3x_card.dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
+
+	dmic_sel = devm_gpiod_get(&pdev->dev, "dmic", GPIOD_OUT_LOW);
+	if (IS_ERR(dmic_sel)) {
+		dev_err(&pdev->dev, "DMIC gpio failed err=%d\n",
+			PTR_ERR(dmic_sel));
+		return PTR_ERR(dmic_sel);
+	}
+
 	ret = devm_snd_soc_register_card(&pdev->dev, &acp3x_card);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.20.1

