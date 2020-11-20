Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A62EC56201
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:32:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FFF2240B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YXErp/zX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn06UuLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FFF2240B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 280AD17E0;
	Fri, 20 Nov 2020 17:31:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 280AD17E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889948;
	bh=NX1sCI8zxlv2qyzfAYPwh+TfyVm3JU5OnLvy2TqvW/I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YXErp/zXbx9L8BJAh/Ujcg0bCdczznlHKLtm/hQWjlbOm2Nd6i7BpTX8z/qoWEGdj
	 CZmQRRYifAGmNdDPiwwCNTf3c5pgq7kKFXzcmRpW/TVmmHAKLkOdd3SfZnxWIijFaO
	 ilI7/hwckCYG3Vn12LXitBluz8pIiK2kwIWYjDnk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1433EF805E9;
	Fri, 20 Nov 2020 17:20:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A159F805E4; Fri, 20 Nov 2020 17:19:59 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3648F805E1
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:19:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3648F805E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cn06UuLo"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 05B40238E6;
 Fri, 20 Nov 2020 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889195;
 bh=NX1sCI8zxlv2qyzfAYPwh+TfyVm3JU5OnLvy2TqvW/I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cn06UuLocBhrxPqSQ722nyAWCLcnqH4qY1JOmm0B+106mEU1hPpN5P3T/N4ElgBPT
 xyCR9Mye//OtU4n9SZYgzJIpHwWOQ4kDq06pg63YCKfzUcPLa4gUyKJEP0FCNNcDnU
 AQofqxC08raZp1/0XoBECrltoU4ulvq5W7ZTiD4A=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 35/38] ASoC: max98371: drop driver pm=NULL assignment
Date: Fri, 20 Nov 2020 17:16:49 +0100
Message-Id: <20201120161653.445521-35-krzk@kernel.org>
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
 sound/soc/codecs/max98371.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 0b438303e1d5..e424779db02b 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -419,7 +419,6 @@ MODULE_DEVICE_TABLE(of, max98371_of_match);
 static struct i2c_driver max98371_i2c_driver = {
 	.driver = {
 		.name = "max98371",
-		.pm = NULL,
 		.of_match_table = of_match_ptr(max98371_of_match),
 	},
 	.probe  = max98371_i2c_probe,
-- 
2.25.1

