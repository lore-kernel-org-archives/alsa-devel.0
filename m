Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BAAC3524E
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:01:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A594124672
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NimUnIQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A594124672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC93616BB;
	Wed, 19 Feb 2020 22:00:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC93616BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582146069;
	bh=ZLeSRaZ+bs57DBKQbEWc3gflC62avjUK1mfd1oFxx8o=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=NimUnIQoEx9KmM3+UEju6T9YAyb2r5gDDzoM8PeYo43Q/FBXHWbEskkrVQLYa4yqN
	 5Fni/49q0bwW+ckH5qa/kSjbLaaIyXsbCBbBPY848We5XhDH8BSsCqgn60qjSW3p5s
	 w4Ixo4Np/j5Z3n+zfV+RaZif+vT9Nq9g4mHamSO0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B776AF8029B;
	Wed, 19 Feb 2020 21:57:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 098BCF802A9; Wed, 19 Feb 2020 21:57:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 58E30F8029B
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 21:57:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58E30F8029B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F106FEC;
 Wed, 19 Feb 2020 12:57:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A63AE3F68F;
 Wed, 19 Feb 2020 12:57:09 -0800 (PST)
Date: Wed, 19 Feb 2020 20:57:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Applied "ASoC: rockchip: Make RK3328 GPIO_MUTE control explicit" to
 the asoc tree
In-Reply-To: <5bc383ed1832f0f5d1dcb3c97ad92fd68e5217e3.1581376744.git.robin.murphy@arm.com>
Message-Id: <applied-5bc383ed1832f0f5d1dcb3c97ad92fd68e5217e3.1581376744.git.robin.murphy@arm.com>
X-Patchwork-Hint: ignore
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de,
 lgirdwood@gmail.com, linux-rockchip@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, pgwipeout@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

   ASoC: rockchip: Make RK3328 GPIO_MUTE control explicit

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

From 87d12d5545fa72d67d99d797cdb464c0c7efb9c9 Mon Sep 17 00:00:00 2001
From: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 18 Feb 2020 21:31:59 +0000
Subject: [PATCH] ASoC: rockchip: Make RK3328 GPIO_MUTE control explicit

The RK3328 reference design uses an external line driver IC as a buffer
on the analog codec output, enabled by the GPIO_MUTE pin, and such a
configuration is currently assumed in the codec driver's direct poking
of GRF_SOC_CON10 to control the GPIO_MUTE output value. However, some
boards wire up analog audio yet use that pin for some other purpose, so
that assumption doesn't always hold. Update this functionality to rely
on an explicit GPIO descriptor, such that it can be managed at the
board level.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/5bc383ed1832f0f5d1dcb3c97ad92fd68e5217e3.1581376744.git.robin.murphy@arm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 287c962ba00d..115706a55577 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -7,6 +7,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -31,7 +32,7 @@
 
 struct rk3328_codec_priv {
 	struct regmap *regmap;
-	struct regmap *grf;
+	struct gpio_desc *mute;
 	struct clk *mclk;
 	struct clk *pclk;
 	unsigned int sclk;
@@ -106,16 +107,6 @@ static int rk3328_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static void rk3328_analog_output(struct rk3328_codec_priv *rk3328, int mute)
-{
-	unsigned int val = BIT(17);
-
-	if (mute)
-		val |= BIT(1);
-
-	regmap_write(rk3328->grf, RK3328_GRF_SOC_CON10, val);
-}
-
 static int rk3328_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct rk3328_codec_priv *rk3328 =
@@ -205,7 +196,7 @@ static int rk3328_codec_open_playback(struct rk3328_codec_priv *rk3328)
 	}
 
 	msleep(rk3328->spk_depop_time);
-	rk3328_analog_output(rk3328, 1);
+	gpiod_set_value(rk3328->mute, 0);
 
 	regmap_update_bits(rk3328->regmap, HPOUTL_GAIN_CTRL,
 			   HPOUTL_GAIN_MASK, OUT_VOLUME);
@@ -246,7 +237,7 @@ static int rk3328_codec_close_playback(struct rk3328_codec_priv *rk3328)
 {
 	size_t i;
 
-	rk3328_analog_output(rk3328, 0);
+	gpiod_set_value(rk3328->mute, 1);
 
 	regmap_update_bits(rk3328->regmap, HPOUTL_GAIN_CTRL,
 			   HPOUTL_GAIN_MASK, 0);
@@ -446,7 +437,6 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "missing 'rockchip,grf'\n");
 		return PTR_ERR(grf);
 	}
-	rk3328->grf = grf;
 	/* enable i2s_acodec_en */
 	regmap_write(grf, RK3328_GRF_SOC_CON2,
 		     (BIT(14) << 16 | BIT(14)));
@@ -458,7 +448,18 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 		rk3328->spk_depop_time = 200;
 	}
 
-	rk3328_analog_output(rk3328, 0);
+	rk3328->mute = gpiod_get_optional(&pdev->dev, "mute", GPIOD_OUT_HIGH);
+	if (IS_ERR(rk3328->mute))
+		return PTR_ERR(rk3328->mute);
+	/*
+	 * Rock64 is the only supported platform to have widely relied on
+	 * this; if we do happen to come across an old DTB, just leave the
+	 * external mute forced off.
+	 */
+	if (!rk3328->mute && of_machine_is_compatible("pine64,rock64")) {
+		dev_warn(&pdev->dev, "assuming implicit control of GPIO_MUTE; update devicetree if possible\n");
+		regmap_write(grf, RK3328_GRF_SOC_CON10, BIT(17) | BIT(1));
+	}
 
 	rk3328->mclk = devm_clk_get(&pdev->dev, "mclk");
 	if (IS_ERR(rk3328->mclk))
-- 
2.20.1

