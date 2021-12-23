Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1CFC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Dec 2021 08:17:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFEA01775;
	Thu, 23 Dec 2021 09:16:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFEA01775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640247441;
	bh=a3om0L9UiaN9iXolNLF1bnEw0hxqbPAR9OWSDdenHv8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X4ZcbdPZeSPd+1K6qh3IgiSrkA6Z8MBLP6/sXpDoJ7sdWgoE9OTtOFIPDV1RtvKxr
	 HzMQuiwX2FyuoG9IPl18V5GgJm38PlmsJoFn5u7aEElWlO2RsqLOHMq/CgikPpmElM
	 XCjSuilLHxDWpRluCWS26SW4wtmk2OpWnAfmpv3E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8950AF80104;
	Thu, 23 Dec 2021 09:16:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 993F7F80105; Thu, 23 Dec 2021 09:16:29 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7962BF80084
 for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2021 09:16:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7962BF80084
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JKNH62kzXzZdYt;
 Thu, 23 Dec 2021 16:13:06 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 16:16:16 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 23 Dec
 2021 16:16:15 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH -next] ASoC: codec: tlv320adc3xxx: Fix missing
 clk_disable_unprepare() on error in adc3xxx_i2c_probe()
Date: Thu, 23 Dec 2021 16:22:12 +0800
Message-ID: <20211223082212.3342184-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: ricardw@axis.com, broonie@kernel.org
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

Fix the missing clk_disable_unprepare() before return
from adc3xxx_i2c_probe() in the error handling case.

Fixes: e9a3b57efd28 ("ASoC: codec: tlv320adc3xxx: New codec driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/codecs/tlv320adc3xxx.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index a683bda7eb36..4baf3d881633 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -1232,21 +1232,21 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c,
 
 	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmdin-gpio1", &adc3xxx->gpio_cfg[0]);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_mclk;
 	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmclk-gpio2", &adc3xxx->gpio_cfg[1]);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_mclk;
 	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias1-vg", &adc3xxx->micbias_vg[0]);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_mclk;
 	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias2-vg", &adc3xxx->micbias_vg[1]);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_mclk;
 
 	adc3xxx->regmap = devm_regmap_init_i2c(i2c, &adc3xxx_regmap);
 	if (IS_ERR(adc3xxx->regmap)) {
 		ret = PTR_ERR(adc3xxx->regmap);
-		return ret;
+		goto err_unprepare_mclk;
 	}
 
 	i2c_set_clientdata(i2c, adc3xxx);
@@ -1263,9 +1263,15 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_component(dev,
 			&soc_component_dev_adc3xxx, &adc3xxx_dai, 1);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "Failed to register codec: %d\n", ret);
+		goto err_unprepare_mclk;
+	}
+
+	return 0;
 
+err_unprepare_mclk:
+	clk_disable_unprepare(adc3xxx->mclk);
 	return ret;
 }
 
-- 
2.25.1

