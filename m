Return-Path: <SRS0=tEYa=KV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F9AC47088
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 14:34:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A842C613E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 14:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A842C613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57BBC1737;
	Wed, 26 May 2021 16:33:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57BBC1737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622039637;
	bh=h2b2O5YS9rXHW8nPneCksqCazi5ASQyPtvRQnplwSa0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cHUac3hnEqZV2os07xztF2ZxV78OKDkP6pW5Mzm+t4TRa7Xb/BFKZI7irGu5R22kM
	 aVOn4BJPvEBivYuqZh2rYeK6gZhjxE6iz3sOpCXINij/ZK6sVfw2HuhdeNoN/ZHESR
	 N+VIdg2iXauJNoAdKxs1wZ5n+nlP1Jbikd8vQr7k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C114F8024E;
	Wed, 26 May 2021 16:33:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53E80F8025C; Wed, 26 May 2021 16:33:04 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2917AF8011B
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 16:32:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2917AF8011B
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FqtdK0lHNzmV6V;
 Wed, 26 May 2021 22:29:57 +0800 (CST)
Received: from dggeml759-chm.china.huawei.com (10.1.199.138) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 22:32:48 +0800
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 26 May 2021 22:32:48 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: <weiyongjun1@huawei.com>, Simon Shields <simon@lineageos.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@canonical.com>, Sylwester Nawrocki
 <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>
Subject: [PATCH -next] ASoC: samsung: midas_wm1811: Fix build error when
 CONFIG_GPIOLIB is not set
Date: Wed, 26 May 2021 14:43:39 +0000
Message-ID: <20210526144339.2392592-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
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

Fix build error when CONFIG_GPIOLIB is not set:

sound/soc/samsung/midas_wm1811.c: In function 'midas_fm_set':
sound/soc/samsung/midas_wm1811.c:205:3: error:
 implicit declaration of function 'gpiod_set_value_cansleep';
 did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
  205 |   gpiod_set_value_cansleep(priv->gpio_fm_sel, 1);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~
      |   gpio_set_value_cansleep
sound/soc/samsung/midas_wm1811.c: In function 'midas_probe':
sound/soc/samsung/midas_wm1811.c:445:22: error:
 implicit declaration of function 'devm_gpiod_get_optional';
 did you mean 'devm_clk_get_optional'? [-Werror=implicit-function-declaration]
  445 |  priv->gpio_fm_sel = devm_gpiod_get_optional(dev, "fm-sel", GPIOD_OUT_HIGH);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~
      |                      devm_clk_get_optional
sound/soc/samsung/midas_wm1811.c:445:61:
 error: 'GPIOD_OUT_HIGH' undeclared (first use in this function);
 did you mean 'GPIOF_INIT_HIGH'?
  445 |  priv->gpio_fm_sel = devm_gpiod_get_optional(dev, "fm-sel", GPIOD_OUT_HIGH);
      |                                                             ^~~~~~~~~~~~~~
      |                                                             GPIOF_INIT_HIGH

Fixes: fd0ea9cd9698 ("ASoC: samsung: Add sound support for Midas boards")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index a2221ebb1b6a..22be597b1dd9 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -228,6 +228,7 @@ config SND_SOC_SAMSUNG_ARIES_WM8994
 config SND_SOC_SAMSUNG_MIDAS_WM1811
 	tristate "SoC I2S Audio support for Midas boards"
 	depends on SND_SOC_SAMSUNG
+	depends on GPIOLIB
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8994
 	help

