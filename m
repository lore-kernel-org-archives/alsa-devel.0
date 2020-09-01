Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F07DC433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:09:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA632067C
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AeOlCsT5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="A1XJapEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA632067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F409178C;
	Tue,  1 Sep 2020 15:09:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F409178C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598965797;
	bh=IRQPmiAp7Vbu72qt56AlBFeE8Mjc2IEdiAvM/ihm14U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AeOlCsT56F0NJKlX6Z9yPnGJCl/Q0SZT6RZs+GCYyKYIJ9228+IhfRy/C8m1qN8IC
	 nnxh7CnBbioloizFtpIVqpwO7mRJ+zzDunx3czazIyKPVGEglPK/uuFNw7dDS6s0TG
	 MT4TqffA+dh16VQE9xwT69mdliOE54pEVTXHvCQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C66BF8021D;
	Tue,  1 Sep 2020 15:08:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFA35F80278; Tue,  1 Sep 2020 15:08:16 +0200 (CEST)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABF2BF8020D
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 15:08:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABF2BF8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="A1XJapEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=1083; q=dns/txt; s=axis-central1;
 t=1598965692; x=1630501692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XM/YiO1AN+GvGSxUyxQbpOxOSqb3rPJ2qUV4jnebMHM=;
 b=A1XJapEFzx5UNTumGMM+Lsg40lcTQQQvtjqnDuD6vGiGR3M5nDCxOWvq
 Mea0qMcUQz3VUaOqv1sv4FI176EG1OGftURK/JTf2hSS3ofXY6+epkO+i
 iOt15o99OGg1SQmMNziQWQaRIyLrrAkZ0Zp/KplSA3glGj6UPW3Sp/Idy
 asDznILQfjW48leGjz0I7pqWwx5oSn/1mfBRxuQj3mrRQifkxiGHKkn5j
 hsYXdNWq4hH8ds+LXmm2G27rzNrWkQpG2+x+eSbO2UPo3t9FOq+d1MFH9
 L4zIpnbOOF21KFWY7+7q/C8BlaUN1ir7vDrY2gyT185eOEoCeZHGjfc9G A==;
IronPort-SDR: JSWorGGGlbfcZbzI5fleFnnnHVRJWrr9awe3/ZTkPFcjNndKis4aT3mf4kLCBRg7CLgBsNQsP/
 VmhwplkhScCG1ZsWDV/6cO89BonM6vV9ZUtnMj8DXa2IRWh9XgyAoP76bgaEYFl7MaENAci8vF
 ZU7yzW/TQ5fJhjJhuvzhic6Aylqj3I8DXEzh3jvoMS5VhSKPIB8purSKuRkWRW/QQoSE4pPFkP
 VJOf7CF6q1h2rrGIQW8M8YLths3IIjNRtqgSFY3sExQDZG+XZSAdbfx8+fODezYDqcer8jq4/Z
 mEg=
X-IronPort-AV: E=Sophos;i="5.76,379,1592863200"; d="scan'208";a="12435719"
From: Camel Guo <camel.guo@axis.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <dmurphy@ti.com>
Subject: [PATCH] ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
Date: Tue, 1 Sep 2020 15:07:53 +0200
Message-ID: <20200901130753.27670-2-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901130753.27670-1-camel.guo@axis.com>
References: <20200901130753.27670-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: Camel Guo <camel.guo@axis.com>, alsa-devel@alsa-project.org,
 kernel@axis.com, linux-kernel@vger.kernel.org, Camel Guo <camelg@axis.com>
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

From: Camel Guo <camelg@axis.com>

In adcx140_i2c_probe, adcx140->dev is accessed before its
initialization. This commit fixes this bug.

Fixes: 689c7655b50c ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
Signed-off-by: Camel Guo <camel.guo@axis.com>
---
 sound/soc/codecs/tlv320adcx140.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 5cd50d841177..7ae6ec374be3 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -980,6 +980,8 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 	if (!adcx140)
 		return -ENOMEM;
 
+	adcx140->dev = &i2c->dev;
+
 	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
 						      "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(adcx140->gpio_reset))
@@ -1007,7 +1009,7 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 			ret);
 		return ret;
 	}
-	adcx140->dev = &i2c->dev;
+
 	i2c_set_clientdata(i2c, adcx140);
 
 	return devm_snd_soc_register_component(&i2c->dev,
-- 
2.20.1

