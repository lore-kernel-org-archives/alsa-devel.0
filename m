Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49DFC56201
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:23:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D16E22269
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NZVOD29S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWlhuIwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D16E22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5176A170B;
	Fri, 20 Nov 2020 17:22:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5176A170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889379;
	bh=LoZ8MEoTv7rDCX6hpawQGW8JCdHOH0nJLp45COZaV1Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NZVOD29SvC9SP076fEztEE9zJyhmTxUHdrKSjETGQWBZAQU0/HFTQUBXa4ObPonlV
	 cV1OsV/8ai76GdGr2B1losiezo73wxRhkwMVXxoNSZwSDPZsuvlin7Xd5p7fog2EcX
	 s28rS74cLtfOe4RB2C6qJmnpTH2h2QikgUl1WcvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77DC0F80519;
	Fri, 20 Nov 2020 17:18:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11C9DF80506; Fri, 20 Nov 2020 17:18:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D6C6F804FB
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:18:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D6C6F804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QWlhuIwX"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D9E422D0A;
 Fri, 20 Nov 2020 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889101;
 bh=LoZ8MEoTv7rDCX6hpawQGW8JCdHOH0nJLp45COZaV1Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QWlhuIwXxRhcctfQnjYTxO9qFyRJc3VE2ARu3z0o6qM1eS4eFsj4WMsV+2D2z5dKF
 FqLb05GDhwJW15B4bhFfiN6+sLMvmMno5Ja7sc1gbwM947Xybi/YhFYIUGSo1sxYwE
 0lWaldhFAqc5qbomVbk53FcF2A71ZExWNd6p5+DE=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 11/38] ASoC: ti: davinci: drop of_match_ptr from of_device_id
 table
Date: Fri, 20 Nov 2020 17:16:25 +0100
Message-Id: <20201120161653.445521-11-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
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

  sound/soc/ti/davinci-i2s.c:750:34: warning: ‘davinci_i2s_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/ti/davinci-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index dd34504c09ba..0039b689745a 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -758,7 +758,7 @@ static struct platform_driver davinci_mcbsp_driver = {
 	.remove		= davinci_i2s_remove,
 	.driver		= {
 		.name	= "davinci-mcbsp",
-		.of_match_table = of_match_ptr(davinci_i2s_match),
+		.of_match_table = davinci_i2s_match,
 	},
 };
 
-- 
2.25.1

