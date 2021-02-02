Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA5DC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 15:10:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646AE64DE1
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 15:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646AE64DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 006DA176B;
	Tue,  2 Feb 2021 16:09:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 006DA176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612278605;
	bh=T1G47C+170L7aGR3/Jpru6PX8ZjymhBt7Devr9ptUGs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KEzb2H0HzDTVNdYaSCK5dKLN/Ilcg15Xluo272bWXuy4YJyhst6eoNQfsttomisAY
	 EroqHSyTuFFha2R4fsl4ETmR7GFMV567LIEolcsrJWatGbbGUySh6FNip09o6FR8m6
	 bzSLnWK8Mg8vrNMCWejkczP7LSOIH6I5ewJchHwE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26DD6F8032D;
	Tue,  2 Feb 2021 16:07:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20F63F80423; Tue,  2 Feb 2021 16:07:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0005DF802C9
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 16:07:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0005DF802C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JruYYX4H"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9107564F82;
 Tue,  2 Feb 2021 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612278420;
 bh=T1G47C+170L7aGR3/Jpru6PX8ZjymhBt7Devr9ptUGs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JruYYX4H+4u8OKJe6K89fQB/9K25/DCiOJTAs7Q/CWMzzl3jI8vMgqIlr1gzn/1w7
 o7XhECaItVS637yNHQSDxkrwDm5BlaF3w4bjOLbET7x5NZzijfEHpTmqhfWH5iN34Y
 TSX2ZocU/brrEqbI2IFWp5+1QY1kuAAsH4poeJ36jzx4HkZTwVmzChZK9LdqB0ccet
 dtsMtZKr47e8EdantOxGAOfOnTrhdWvgSnpNHr6aAS9RRH2tt2316wOzN9Bm4kNvFp
 cEvgzdR4/xsSD7SCS61J+rujBVT1FNMsuNDLXAiPKkaB2P61vlupdqlDx25rU57raZ
 VShZlW/tXQgqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/17] ASoC: ak4458: correct reset polarity
Date: Tue,  2 Feb 2021 10:06:41 -0500
Message-Id: <20210202150651.1864426-7-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202150651.1864426-1-sashal@kernel.org>
References: <20210202150651.1864426-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
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

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

[ Upstream commit e953daeb68b1abd8a7d44902786349fdeef5c297 ]

Reset (aka power off) happens when the reset gpio is made active.
Change function name to ak4458_reset to match devicetree property "reset-gpios"

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/ce650f47-4ff6-e486-7846-cc3d033f3601@blennerhassett.gen.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/ak4458.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 71562154c0b1e..217e8ce9a4ba4 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -523,18 +523,10 @@ static struct snd_soc_dai_driver ak4497_dai = {
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
@@ -548,7 +540,7 @@ static int ak4458_init(struct snd_soc_component *component)
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 
-	ak4458_power_on(ak4458);
+	ak4458_reset(ak4458, false);
 
 	ret = snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
 			    0x80, 0x80);   /* ACKS bit = 1; 10000000 */
@@ -571,7 +563,7 @@ static void ak4458_remove(struct snd_soc_component *component)
 {
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 
-	ak4458_power_off(ak4458);
+	ak4458_reset(ak4458, true);
 }
 
 #ifdef CONFIG_PM
@@ -581,7 +573,7 @@ static int __maybe_unused ak4458_runtime_suspend(struct device *dev)
 
 	regcache_cache_only(ak4458->regmap, true);
 
-	ak4458_power_off(ak4458);
+	ak4458_reset(ak4458, true);
 
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
@@ -596,8 +588,8 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 
-	ak4458_power_off(ak4458);
-	ak4458_power_on(ak4458);
+	ak4458_reset(ak4458, true);
+	ak4458_reset(ak4458, false);
 
 	regcache_cache_only(ak4458->regmap, false);
 	regcache_mark_dirty(ak4458->regmap);
-- 
2.27.0

