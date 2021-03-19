Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8704C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 09:35:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CAF64F68
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 09:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CAF64F68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C264A1696;
	Fri, 19 Mar 2021 10:34:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C264A1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616146516;
	bh=sIf8ctCId5ytpE0A22d9bUF9agHe+yRxDcqNBuLExQc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KxpiFdHfpcDvEF5g7WYDiZ2E9xQIHzUho7kC6hp0EdlvFVZznwvwWNuhOHmXzNMz1
	 d2fa0XvfDtrhWb8jBknq5YNpl1CEsPxniPVxQuqORrRoylvZ6tCOWuwgY++QOm7Azq
	 VrOyUei75qwsd8SWmr7tmQXvKpv2bKK0kAgasvGY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F23A1F8021C;
	Fri, 19 Mar 2021 10:32:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFD5FF8023C; Fri, 19 Mar 2021 10:32:50 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED403F800E0
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 10:32:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED403F800E0
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1zCP3c0tz19Gf8;
 Fri, 19 Mar 2021 17:30:41 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 17:32:30 +0800
From: 'w00385741 <weiyongjun1@huawei.com>
To: <weiyongjun1@huawei.com>, Oder Chiou <oder_chiou@realtek.com>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jack Yu
 <jack.yu@realtek.com>
Subject: [PATCH -next] ASoC: rt1019: make symbol 'rt1019_i2c_driver' static
Date: Fri, 19 Mar 2021 09:41:02 +0000
Message-ID: <20210319094102.4185096-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Cc: Hulk Robot <hulkci@huawei.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

sound/soc/codecs/rt1019.c:927:19: warning:
 symbol 'rt1019_i2c_driver' was not declared. Should it be static?

This symbol is not used outside of rt1019.c, so this
commit marks it static.

Fixes: 7ec79d3850d0 ("ASoC: rt1019: add rt1019 amplifier driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/rt1019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1019.c b/sound/soc/codecs/rt1019.c
index fb275686a00f..5138f028d9f2 100644
--- a/sound/soc/codecs/rt1019.c
+++ b/sound/soc/codecs/rt1019.c
@@ -924,7 +924,7 @@ static int rt1019_i2c_probe(struct i2c_client *i2c,
 		&soc_component_dev_rt1019, rt1019_dai, ARRAY_SIZE(rt1019_dai));
 }
 
-struct i2c_driver rt1019_i2c_driver = {
+static struct i2c_driver rt1019_i2c_driver = {
 	.driver = {
 		.name = "rt1019",
 		.of_match_table = of_match_ptr(rt1019_of_match),

