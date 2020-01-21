Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECC6C2D0CE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:40:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD7D22522
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="px9Mii0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD7D22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD8D616AB;
	Tue, 21 Jan 2020 18:39:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD8D616AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579628434;
	bh=0/vSMycIIyanuxuTrQFHMLpdixgk+gHBXdVZA2jg7TA=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=px9Mii0ux0HNac3UrHZnNV6SGvrEtGc24CZz6WG+SHmJt/rIGr2W7raSbn1idtvxU
	 x1lLlqlLEXfvh0sncDwCTCa1hKIUcyZXiYemzoix2s8sLPaMIHGwr6VMHuyAaobC50
	 2bR4FGVlOOO5yWMuzMo+CY0an8aUWBmvkNMlDRMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30991F8034E;
	Tue, 21 Jan 2020 18:29:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7EFEF80334; Tue, 21 Jan 2020 18:28:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 881B9F8032A
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 18:28:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 881B9F8032A
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF07E328;
 Tue, 21 Jan 2020 09:28:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EE413F6C4;
 Tue, 21 Jan 2020 09:28:48 -0800 (PST)
Date: Tue, 21 Jan 2020 17:28:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878sm3ym4j.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-878sm3ym4j.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: jz4740: jz4740-i2s: move
	.suspend/.resume to component" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: jz4740: jz4740-i2s: move .suspend/.resume to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From aa3c4765b3e8931e2e3c70894b717a993f96fff5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Jan 2020 10:03:56 +0900
Subject: [PATCH] ASoC: jz4740: jz4740-i2s: move .suspend/.resume to component

There is no big difference at implementation for .suspend/.resume
between DAI driver and Component driver.
But because some driver is using DAI version, thus ALSA SoC needs
to keep supporting it, hence, framework becoming verbose.
If we can switch all DAI driver .suspend/.resume to Component driver,
we can remove verbose code from ALSA SoC.

Driver is getting its private data via dai->dev.
But dai->dev and component->dev are same dev, thus, we can convert
these. For same reason, we can convert dai->active to
component->active if necessary.

This patch moves DAI driver .suspend/.resume to Component driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/878sm3ym4j.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 38d48d101783..9d5405881209 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -324,12 +324,12 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return ret;
 }
 
-static int jz4740_i2s_suspend(struct snd_soc_dai *dai)
+static int jz4740_i2s_suspend(struct snd_soc_component *component)
 {
-	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
 	uint32_t conf;
 
-	if (dai->active) {
+	if (component->active) {
 		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
 		conf &= ~JZ_AIC_CONF_ENABLE;
 		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
@@ -342,9 +342,9 @@ static int jz4740_i2s_suspend(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static int jz4740_i2s_resume(struct snd_soc_dai *dai)
+static int jz4740_i2s_resume(struct snd_soc_component *component)
 {
-	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
 	uint32_t conf;
 	int ret;
 
@@ -352,7 +352,7 @@ static int jz4740_i2s_resume(struct snd_soc_dai *dai)
 	if (ret)
 		return ret;
 
-	if (dai->active) {
+	if (component->active) {
 		ret = clk_prepare_enable(i2s->clk_i2s);
 		if (ret) {
 			clk_disable_unprepare(i2s->clk_aic);
@@ -455,8 +455,6 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	},
 	.symmetric_rates = 1,
 	.ops = &jz4740_i2s_dai_ops,
-	.suspend = jz4740_i2s_suspend,
-	.resume = jz4740_i2s_resume,
 };
 
 static struct snd_soc_dai_driver jz4780_i2s_dai = {
@@ -475,12 +473,12 @@ static struct snd_soc_dai_driver jz4780_i2s_dai = {
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.ops = &jz4740_i2s_dai_ops,
-	.suspend = jz4740_i2s_suspend,
-	.resume = jz4740_i2s_resume,
 };
 
 static const struct snd_soc_component_driver jz4740_i2s_component = {
 	.name		= "jz4740-i2s",
+	.suspend	= jz4740_i2s_suspend,
+	.resume		= jz4740_i2s_resume,
 };
 
 #ifdef CONFIG_OF
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
