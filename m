Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C0C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 08:28:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8D3236F9
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 08:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8D3236F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blennerhassett.gen.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BE1F1AB0;
	Fri, 22 Jan 2021 09:27:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BE1F1AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611304097;
	bh=SuTpL6HOX4xqG5ds5yc9fFelsZy6CbKFigq5L0eYoEI=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ADLUzsow/t4bnQ6QdyUpA4okHmqzdZ11esy+TO+1j6ugo81QEbvmeIVVOMj68hwk5
	 fjIYuEBq2vVAF/zHhue3e3Zu1r3hgrpyLeczrxSIUTmtbVDA4DM5BP9Q0RS7K+YVee
	 2fWAI5gvkBPfUcp2HlIja+QuWDa8Cj/gzeSZXMNc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04002F80166;
	Fri, 22 Jan 2021 09:27:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64B44F8016E; Fri, 22 Jan 2021 09:27:24 +0100 (CET)
Received: from omr2.mail.isx.net.nz (omr2.mail.isx.net.nz [111.65.230.131])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C897BF8015B
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 09:27:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C897BF8015B
Received: from [10.36.0.146] (unknown [203.173.181.15])
 (Authenticated sender: eliot@blennerhassett.gen.nz)
 by omr2.mail.isx.net.nz (Postfix) with ESMTPA id 870FF937FCF;
 Fri, 22 Jan 2021 21:27:08 +1300 (NZDT)
Subject: [PATCH] ASoC: ak4458: correct reset polarity
From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
To: Mark Brown <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <935820c1-0c96-6c85-26e7-ce0b741737dc@blennerhassett.gen.nz>
 <20210120190759.GH6794@sirena.org.uk>
 <84e36db4-b78d-de1b-3575-62b19035ea43@blennerhassett.gen.nz>
Message-ID: <ce650f47-4ff6-e486-7846-cc3d033f3601@blennerhassett.gen.nz>
Date: Fri, 22 Jan 2021 21:27:08 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <84e36db4-b78d-de1b-3575-62b19035ea43@blennerhassett.gen.nz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Cc: daniel.baluta@nxp.com, kuninori.morimoto.gx@renesas.com,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>
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

Reset (aka power off) happens when the reset gpio is made active.
Change function name to ak4458_reset to match devicetree property "reset-gpios"

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/soc/codecs/ak4458.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 1010c9ee2e8..472caad1701 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -595,18 +595,10 @@ static struct snd_soc_dai_driver ak4497_dai = {
 	.ops = &ak4458_dai_ops,
 };
 
-static void ak4458_power_off(struct ak4458_priv *ak4458)
+static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
 {
 	if (ak4458->reset_gpiod) {
-		gpiod_set_value_cansleep(ak4458->reset_gpiod, 0);
-		usleep_range(1000, 2000);
-	}
-}
-
-static void ak4458_power_on(struct ak4458_priv *ak4458)
-{
-	if (ak4458->reset_gpiod) {
-		gpiod_set_value_cansleep(ak4458->reset_gpiod, 1);
+		gpiod_set_value_cansleep(ak4458->reset_gpiod, active);
 		usleep_range(1000, 2000);
 	}
 }
@@ -620,7 +612,7 @@ static int ak4458_init(struct snd_soc_component *component)
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 
-	ak4458_power_on(ak4458);
+	ak4458_reset(ak4458, false);
 
 	ret = snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
 			    0x80, 0x80);   /* ACKS bit = 1; 10000000 */
@@ -650,7 +642,7 @@ static void ak4458_remove(struct snd_soc_component *component)
 {
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 
-	ak4458_power_off(ak4458);
+	ak4458_reset(ak4458, true);
 }
 
 #ifdef CONFIG_PM
@@ -660,7 +652,7 @@ static int __maybe_unused ak4458_runtime_suspend(struct device *dev)
 
 	regcache_cache_only(ak4458->regmap, true);
 
-	ak4458_power_off(ak4458);
+	ak4458_reset(ak4458, true);
 
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
@@ -685,8 +677,8 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 
-	ak4458_power_off(ak4458);
-	ak4458_power_on(ak4458);
+	ak4458_reset(ak4458, true);
+	ak4458_reset(ak4458, false);
 
 	regcache_cache_only(ak4458->regmap, false);
 	regcache_mark_dirty(ak4458->regmap);

