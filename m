Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675F6C17440
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:20:20 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385AF2196E
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XuDQR0gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385AF2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EA90820;
	Tue, 12 Nov 2019 20:03:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EA90820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573585435;
	bh=Zr2Y1Edv6phssY2vsYI4Rgcjw4FYvRXLtGMDcFCM8hg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XuDQR0grZ60BAaB/PqxPMh+uH53n1YfOjOfPvvt+iegy2waCYf2uLRyAGD7lkGvR6
	 1SQoGzCyWLMKg267u0mjPBB5yb4WRjIWo/IkKeXeuSOW5sCMN7HaDeTbP4nEH9/wH7
	 5IEkMLATFWP6zEQE5FiA2M0VXJ0D26ptcwhAnocQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B2B7F80275;
	Tue, 12 Nov 2019 20:03:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33E87F8048F; Tue, 12 Nov 2019 20:03:03 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78CC3F80275
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 20:02:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78CC3F80275
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1iUbQh-0001Z1-4J; Tue, 12 Nov 2019 19:02:19 +0000
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Date: Tue, 12 Nov 2019 19:02:18 +0000
Message-Id: <20191112190218.282337-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH][next] ASoC: tas2770: clean up an indentation
	issue
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Colin Ian King <colin.king@canonical.com>

There is a block that is indented too deeply, remove
the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/tas2770.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index ad76f22fcfac..54c8135fe43c 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -761,12 +761,12 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
 							  "reset-gpio",
 						      GPIOD_OUT_HIGH);
-		if (IS_ERR(tas2770->reset_gpio)) {
-			if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
-				tas2770->reset_gpio = NULL;
-				return -EPROBE_DEFER;
-			}
+	if (IS_ERR(tas2770->reset_gpio)) {
+		if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
+			tas2770->reset_gpio = NULL;
+			return -EPROBE_DEFER;
 		}
+	}
 
 	tas2770->channel_size = 0;
 	tas2770->slot_width = 0;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
