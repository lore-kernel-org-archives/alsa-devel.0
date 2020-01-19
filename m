Return-Path: <SRS0=BOfx=3I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB97C33CB1
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jan 2020 07:20:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DA120684
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jan 2020 07:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U6QXT2dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DA120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 825A616AC;
	Sun, 19 Jan 2020 08:19:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 825A616AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579418417;
	bh=OIn7w66u2TeEoHy64YiN6hZTZHAw6Vp4ugqAm7/SyJg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U6QXT2dKX+KBmT8PmLXZTrGFYipmR3I1U5g3Y0lvT4qh+WmYdaGPryH2vf4jJDBIJ
	 T2Cq6p2Y5vcaJ9S7bxt5B5HVw2Vd31QWnHjwEz060T5Uf4blF7pP17g5pIM17NTSKZ
	 TDE3axFyjJDTS13yz7eTSI9aDjiCuJWfbCpNWsa4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03824F802A7;
	Sun, 19 Jan 2020 08:14:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BA62F80126; Sun, 19 Jan 2020 03:05:00 +0100 (CET)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A68DF80126
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2020 03:04:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A68DF80126
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5000E5E974F6F5BF8FB1;
 Sun, 19 Jan 2020 10:04:45 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 10:04:38 +0800
From: y00444492 <yebin10@huawei.com>
To: <broonie@opensource.wolfsonmicro.com>, <codrin.ciubotariu@microchip.com>
Date: Sun, 19 Jan 2020 10:03:20 +0800
Message-ID: <20200119020320.27075-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sun, 19 Jan 2020 08:13:53 +0100
Cc: alsa-devel@alsa-project.org, Ye Bin <yebin10@huawei.com>,
 linux-sound@vger.kernel.org
Subject: [alsa-devel] [PATCH] ASoC: atmel-pcm: Fix build error
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

From: Ye Bin <yebin10@huawei.com>

If SND_ATMEL_SOC_SSC is y and SND_ATMEL_SOC_PDC is m, building fails:
sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
(.text+0x6f6): undefined reference to `atmel_pcm_pdc_platform_register'

Select SND_ATMEL_SOC_PDC to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 92dfa6198623 ("ASoC: atmel-pcm: split into two file")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 sound/soc/atmel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index f118c229ed82..78e7d40c3c24 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -19,11 +19,11 @@ config SND_ATMEL_SOC_DMA
 
 config SND_ATMEL_SOC_SSC
 	tristate
+	select SND_ATMEL_SOC_PDC
 
 config SND_ATMEL_SOC_SSC_PDC
 	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
 	depends on ATMEL_SSC
-	select SND_ATMEL_SOC_PDC
 	select SND_ATMEL_SOC_SSC
 	help
 	  Say Y or M if you want to add support for Atmel SSC interface
-- 
2.17.2

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
