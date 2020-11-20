Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C31C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:33:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3163A223B0
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Pp7xu0qg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2pO1V35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3163A223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87F2017C0;
	Fri, 20 Nov 2020 17:32:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87F2017C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889989;
	bh=1fhDXmO08NfkJQ4t+guUAX1qFIWAvOwnwGfYMJfpCc4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pp7xu0qgwUFOwpICL/5eSm2PDpKfUyCFu3bLwSip30pMQ+HM+B+OuPBlDonE4Xizp
	 2X06y7cMTVT8s1uxyO0zkYrFwt97cuwwz5INnWU3Mj+Zm8IPpwiyT1mp75dUFfyl7y
	 WbnA7mxuGQNIzOeMXru456Vg0teWepLGDtWvtNEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0C57F805F0;
	Fri, 20 Nov 2020 17:20:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16267F805EF; Fri, 20 Nov 2020 17:20:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1CBFF805EE
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:20:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1CBFF805EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="L2pO1V35"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EEB8F2245F;
 Fri, 20 Nov 2020 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889202;
 bh=1fhDXmO08NfkJQ4t+guUAX1qFIWAvOwnwGfYMJfpCc4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L2pO1V354Zxdr4iFbSU2fOGABNdvr1YyszwUycC9eisUVZBOCLvTqI7GNfZ5su1Wg
 BcPGHxK1Yj7mBFMK4lbq4otbnmHe7Ms2obNc2VCIGrZqbjIFXFXalTM7cT93U7c6ZW
 m3DiUdzgngllEeMLBrhcAJ1ALy9z6VSsKm0v/RnI=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 37/38] ASoC: max98926: drop driver pm=NULL assignment
Date: Fri, 20 Nov 2020 17:16:51 +0100
Message-Id: <20201120161653.445521-37-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
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

There is no point to explicitly set driver .pm field to NULL.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98926.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 0977e541326d..f286e572263e 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -583,7 +583,6 @@ static struct i2c_driver max98926_i2c_driver = {
 	.driver = {
 		.name = "max98926",
 		.of_match_table = of_match_ptr(max98926_of_match),
-		.pm = NULL,
 	},
 	.probe	= max98926_i2c_probe,
 	.id_table = max98926_i2c_id,
-- 
2.25.1

