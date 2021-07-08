Return-Path: <SRS0=3BcS=MA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CBDC07E96
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 09:13:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739BE6146E
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 09:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739BE6146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F0E085D;
	Thu,  8 Jul 2021 11:12:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F0E085D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625735611;
	bh=NWNPYEJ/BZAE4tON4Ez1jHn7pUhu6R8XBldJ5dvcX+Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VI8e4aG2um7Q7RKADJ6LvcUG5BZ+v6VyD2V6T0D6ew2mns0SWUvA5wEB+73dTZIDy
	 jBz/LtEurEq1g55Q3N0bW6yfqg+Zv9zBxXo1kEeFNm/KwtN1TWP1etWRIgwi5nP3Ea
	 N+ew22J4i1OmzzcbP/zuurKKiQP8nRw0juhBRTXM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E747F80246;
	Thu,  8 Jul 2021 11:12:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07519F8012A; Thu,  8 Jul 2021 11:12:40 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0B7EF8012A
 for <alsa-devel@alsa-project.org>; Thu,  8 Jul 2021 11:12:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0B7EF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="YKMXUfU6"
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C0EDD80661;
 Thu,  8 Jul 2021 11:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1625735552;
 bh=IDbXSfA9WgWUl324OfUj5IXalKW4jFt20fRBLf6DOuA=;
 h=From:To:Cc:Subject:Date:From;
 b=YKMXUfU6Q6ZpVMfxoQL/0c71vRzGdJpTS9KGXCzHobK/7p5eA0HMaMs4XsSC+D6xe
 cigCEJmu/0MmnsNmZ0C5jl1L6JH7rVQTGgSEdnkLotlPYeBNbnG2wQxOato/69alGE
 WjRKnu0/pwxXyJWXdgwBknuxfLhJDMjlLd2Jnbenr7B/7nGKsQqi0WPABU/R/d2kOw
 6ST0wsjUk3TdsmU3pk6WtXVfk2L6kXAgZcaPjmnPF7VVArTEhHWOHAfEkeldANq4SO
 17P5EHnfUuprjUX+KenRwnSmVm2jmC5DxrxvsI0Hy/tKMW6DTkJ2L8EKXKhueEJTuR
 2KVOrtOdOPeEw==
From: Marek Vasut <marex@denx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: tlv320aic32x4: Fix TAS2505/TAS2521 channel count
Date: Thu,  8 Jul 2021 11:12:29 +0200
Message-Id: <20210708091229.56443-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Cc: Marek Vasut <marex@denx.de>, Mark Brown <broonie@kernel.org>, ch@denx.de
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

The TAS2505/TAS2521 does support up to two channels, LEFT and RIGHT,
which are being alternated on the audio data bus by Word Clock, WCLK.
This is documented in TI slau472 2.7.1 Digital Audio Interface. Note
that both the LEFT and RIGHT channels are only used for audio INPUT,
while only the LEFT channel is used for audio OUTPUT.

Fixes: b4525b6196cd7 ("ASoC: tlv320aic32x4: add support for TAS2505")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Claudius Heine <ch@denx.de>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index c63b717040ed2..8af739284fbec 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1113,7 +1113,7 @@ static struct snd_soc_dai_driver aic32x4_tas2505_dai = {
 	.playback = {
 			 .stream_name = "Playback",
 			 .channels_min = 1,
-			 .channels_max = 1,
+			 .channels_max = 2,
 			 .rates = SNDRV_PCM_RATE_8000_96000,
 			 .formats = AIC32X4_FORMATS,},
 	.ops = &aic32x4_ops,
-- 
2.30.2

