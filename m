Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAEAC33CB1
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:37:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C27D214AF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eUaae2xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C27D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3383617AE;
	Wed, 15 Jan 2020 15:36:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3383617AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579099024;
	bh=RT1IWWVQoDqgHQmF4+5WDU511COQPuvrRltHH8rFmEs=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eUaae2xAvI4J+pC0YBuHJ4mkz70MyFGqeSFYPLKZvEN5xs6ykRrG3GHmfYwygV7Lt
	 +bJ7iKAdCr7edQN9dagH1l+xkdu5JPfemwaKP+j1m8kUhxtM/lHmVEsbb3dYCpkjL3
	 eAJdJYj9SKBlh8zEjZtQo+vmpvcySmZWdb9xJQSY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F4219F8020D;
	Wed, 15 Jan 2020 15:35:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92A60F800CC; Wed, 15 Jan 2020 15:35:19 +0100 (CET)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05852F800CC
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 15:35:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05852F800CC
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A77F31C8A80F63C28F5B;
 Wed, 15 Jan 2020 22:35:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 22:35:02 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shuming Fan
 <shumingf@realtek.com>
Date: Wed, 15 Jan 2020 14:30:34 +0000
Message-ID: <20200115143034.94492-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH -next] ASoC: rt711: fix return value check in
	rt711_sdw_probe()
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

In case of error, the function devm_regmap_init() returns ERR_PTR() and
never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR().

Fixes: 320b8b0d13b8 ("ASoC: rt711: add rt711 codec driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/rt711-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index e28dc84ede5b..85e62e1059cd 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -460,8 +460,8 @@ static int rt711_sdw_probe(struct sdw_slave *slave,
 
 	regmap = devm_regmap_init(&slave->dev, NULL,
 		&slave->dev, &rt711_regmap);
-	if (!regmap)
-		return -EINVAL;
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	rt711_init(&slave->dev, sdw_regmap, regmap, slave);



_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
