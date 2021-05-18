Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138FBC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:03:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797F6610A2
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797F6610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1045316C2;
	Tue, 18 May 2021 10:02:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1045316C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621325012;
	bh=sbl6KepxrzR2xVnSxcqXJMr3XarDaKcbcsqysh9moXA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fDV712wOLcIFyqS74bTjcsMs3oD2Kf2C2xPHUKbpAGRrtSCGZdz4zjwgxn5t9UY6d
	 py/rAuI/gKadKhJU/kkgmF540PROjL+TAOMWFSZiBJotpDrFRzYuXB6Lo3p/elSbHl
	 NPtHA6+gI+z8Dtd2sX39426oMZVqeAFvsf9x7vvs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06BC4F804B0;
	Tue, 18 May 2021 10:00:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0B6CF80217; Tue, 18 May 2021 06:43:13 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91877F80139
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 06:43:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91877F80139
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fkjvj2rp3zQpH8;
 Tue, 18 May 2021 12:39:29 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 12:42:58 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 12:42:57 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH -next] ASoC: hisilicon: fix missing clk_disable_unprepare() on
 error in hi6210_i2s_startup()
Date: Tue, 18 May 2021 12:45:14 +0800
Message-ID: <20210518044514.607010-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 18 May 2021 10:00:15 +0200
Cc: broonie@kernel.org
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

After calling clk_prepare_enable(), clk_disable_unprepare() need
be called when calling clk_set_rate() failed.

Fixes: 0bf750f4cbe1 ("ASoC: hisilicon: Add hi6210 i2s audio driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/hisilicon/hi6210-i2s.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 907f5f1f7b44..ff05b9779e4b 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -102,18 +102,15 @@ static int hi6210_i2s_startup(struct snd_pcm_substream *substream,
 
 	for (n = 0; n < i2s->clocks; n++) {
 		ret = clk_prepare_enable(i2s->clk[n]);
-		if (ret) {
-			while (n--)
-				clk_disable_unprepare(i2s->clk[n]);
-			return ret;
-		}
+		if (ret)
+			goto err_unprepare_clk;
 	}
 
 	ret = clk_set_rate(i2s->clk[CLK_I2S_BASE], 49152000);
 	if (ret) {
 		dev_err(i2s->dev, "%s: setting 49.152MHz base rate failed %d\n",
 			__func__, ret);
-		return ret;
+		goto err_unprepare_clk;
 	}
 
 	/* enable clock before frequency division */
@@ -165,6 +162,11 @@ static int hi6210_i2s_startup(struct snd_pcm_substream *substream,
 	hi6210_write_reg(i2s, HII2S_SW_RST_N, val);
 
 	return 0;
+
+err_unprepare_clk:
+	while (n--)
+		clk_disable_unprepare(i2s->clk[n]);
+	return ret;
 }
 
 static void hi6210_i2s_shutdown(struct snd_pcm_substream *substream,
-- 
2.25.1

