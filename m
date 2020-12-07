Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14005C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 12:55:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440D723407
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 12:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440D723407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C8451755;
	Mon,  7 Dec 2020 13:54:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C8451755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607345735;
	bh=ZfFmXiUV2hzTQ91OQ/B5qZ8uvdRAuDnwEbZIGgTmHJM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R/sCnFkIFD8zqjos1mHWotba33e3Bh8TLDZXSPmEw7Y/U4RPTgOrk+Wcjpi0K076h
	 2ciVk1lweMrD2uyV6PMOdO+VBpQ7gkuboMhSmJ1VvXhQICkDAKH2MYjz7k38WXMIQD
	 48eSv0ieog22iPIonkEpJrlST3OgdzAcdMtLdYds=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7B2CF8020D;
	Mon,  7 Dec 2020 13:54:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D87DAF8021D; Mon,  7 Dec 2020 13:54:00 +0100 (CET)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5BADF8020D
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2020 13:53:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5BADF8020D
From: Paul Cercueil <paul@crapouillou.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/5] ASoC: codecs/jz4770: Reset interrupt flags in bias PREPARE
Date: Mon,  7 Dec 2020 12:53:34 +0000
Message-Id: <20201207125338.119397-2-paul@crapouillou.net>
In-Reply-To: <20201207125338.119397-1-paul@crapouillou.net>
References: <20201207125338.119397-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org,
 od@zcrc.me, Christophe Branchereau <cbranchereau@gmail.com>,
 linux-kernel@vger.kernel.org
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

From: Christophe Branchereau <cbranchereau@gmail.com>

In case a poll for RUP times out, we might be left with some IRQ flags
that should be cleared before the next power on.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4770.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index c6b2043f31a9..002f2300e750 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -190,6 +190,9 @@ static int jz4770_codec_set_bias_level(struct snd_soc_component *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
+		/* Reset all interrupt flags. */
+		regmap_write(regmap, JZ4770_CODEC_REG_IFR, REG_IFR_ALL_MASK);
+
 		regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
 				  REG_CR_VIC_SB);
 		msleep(250);
@@ -642,9 +645,6 @@ static void jz4770_codec_codec_init_regs(struct snd_soc_component *codec)
 	/* Send collected updates. */
 	regcache_cache_only(regmap, false);
 	regcache_sync(regmap);
-
-	/* Reset all interrupt flags. */
-	regmap_write(regmap, JZ4770_CODEC_REG_IFR, REG_IFR_ALL_MASK);
 }
 
 static int jz4770_codec_codec_probe(struct snd_soc_component *codec)
-- 
2.29.2

