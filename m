Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65573C4361B
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 12:55:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCA123432
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 12:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCA123432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D25BF1768;
	Mon,  7 Dec 2020 13:54:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D25BF1768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607345740;
	bh=Jljt51kij+VIcX4wBu6jRB2GPJfxUJVLhbv99gb00dQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qUqrHlsA0VIoKlCVR6Z7R5yir74OajfSPGHhehpsH03YiQUnUh5WVzF6oXbNPXgvM
	 rQJjZXuzRYADS1hzr29zQ3ngBVEl0/WJXCck2ZYWQ0UZXwecXj5neKo5r00zE8shzY
	 e88+/hPupg/EpoKN+5gZSD4t5k0i6sZ1VclozJIk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A1E9F8027C;
	Mon,  7 Dec 2020 13:54:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6847AF8027C; Mon,  7 Dec 2020 13:54:03 +0100 (CET)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D655CF8021D
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2020 13:54:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D655CF8021D
From: Paul Cercueil <paul@crapouillou.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 3/5] ASoC: codecs/jz4770: Adjust timeouts for cap-coupled
 outputs
Date: Mon,  7 Dec 2020 12:53:35 +0000
Message-Id: <20201207125338.119397-3-paul@crapouillou.net>
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

When using cap-coupled outputs, the RUP/RDO can take much longer than
the 100ms timeout we used to have. Increase that timeout to one second.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4770.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 002f2300e750..0da966785aee 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -287,7 +287,7 @@ static int jz4770_codec_mute_stream(struct snd_soc_dai *dai, int mute, int direc
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
 					       val, val & gain_bit,
-					       1000, 100 * USEC_PER_MSEC);
+					       1000, 1 * USEC_PER_SEC);
 		if (err) {
 			dev_err(jz_codec->dev,
 				"Timeout while setting digital mute: %d", err);
@@ -381,7 +381,7 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
 					       val, val & REG_IFR_RUP,
-					       1000, 100 * USEC_PER_MSEC);
+					       1000, 1 * USEC_PER_SEC);
 		if (err) {
 			dev_err(jz_codec->dev, "RUP timeout: %d", err);
 			return err;
@@ -401,7 +401,7 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
 					       val, val & REG_IFR_RDO,
-					       1000, 100 * USEC_PER_MSEC);
+					       1000, 1 * USEC_PER_SEC);
 		if (err) {
 			dev_err(jz_codec->dev, "RDO timeout: %d", err);
 			return err;
@@ -803,7 +803,7 @@ static int jz4770_codec_io_wait(struct jz_codec *codec)
 
 	return readl_poll_timeout(codec->base + ICDC_RGADW_OFFSET, reg,
 				  !(reg & ICDC_RGADW_RGWR),
-				  1000, 10 * USEC_PER_MSEC);
+				  1000, 1 * USEC_PER_SEC);
 }
 
 static int jz4770_codec_reg_read(void *context, unsigned int reg,
-- 
2.29.2

