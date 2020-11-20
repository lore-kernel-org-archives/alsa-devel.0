Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494E6C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:19:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E328F24124
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lUPkIDz4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeX5Yzr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E328F24124
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB4961701;
	Fri, 20 Nov 2020 17:18:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB4961701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889171;
	bh=eUNQeZbUHRAtKX1EIalnF5m65XCO6D2xUekfrik1QEk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lUPkIDz4rR89UieFd+vEflaygpXN6PUv32FwsDeUOgHy/iG5p5EPR0uisU6CBv5jl
	 gQ5cKPUpok3BVS1ybuWGVnfNFac99RX9YOb1pPF6jByoIUrWQYtjngVa+zlh/YEDzA
	 ZXt2uugSYHoFK70K6Gi6YcK7M28g44p412F6xx1U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D2E4F8016E;
	Fri, 20 Nov 2020 17:17:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBCBBF80258; Fri, 20 Nov 2020 17:17:55 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8ED43F80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:17:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ED43F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HeX5Yzr5"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4424D223BE;
 Fri, 20 Nov 2020 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889071;
 bh=eUNQeZbUHRAtKX1EIalnF5m65XCO6D2xUekfrik1QEk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HeX5Yzr5VnPSNdN1g5g/Bg+Jcfa/RWEDO34fkIYbI4CW8Kn/lnJSuY63bK5BVsZr+
 4rkfFp3A1uVqJPzzSXoBRfYmMdQDk6aHQuGY5jbgviUWAxT0ZN+eQ+WaJfoIsnmG1J
 YHmx90ogcu0UEhJl6J7Ko3QJcYLJYTgPhQAgqu08=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 02/38] ASoC: gtm601: drop of_match_ptr from of_device_id table
Date: Fri, 20 Nov 2020 17:16:16 +0100
Message-Id: <20201120161653.445521-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Angus Ainslie \(Purism\)" <angus@akkea.ca>, Arnd Bergmann <arnd@arndb.de>,
 Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
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

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  sound/soc/codecs/gtm601.c:90:34: warning: ‘gtm601_codec_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/gtm601.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index ae9e1c70ca57..5dfd26e1fe9a 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -97,7 +97,7 @@ MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
 		.name = "gtm601",
-		.of_match_table = of_match_ptr(gtm601_codec_of_match),
+		.of_match_table = gtm601_codec_of_match,
 	},
 	.probe = gtm601_platform_probe,
 };
-- 
2.25.1

