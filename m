Return-Path: <SRS0=iYEd=XX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A8C388F3
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Sep 2019 08:18:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4790220830
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Sep 2019 08:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZrFLSxxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4790220830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D19EE15F2;
	Sat, 28 Sep 2019 10:17:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D19EE15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569658689;
	bh=HQfSm3BLyKyESqoX2sLwKCT9+cGxqv/5/vzVFo7t+RQ=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZrFLSxxK1TgxeAdNhER0kPCjbGwAWAuUYQgLCs+fuj7fyxQ3eiSbZNU/0ld+4zUyb
	 xw0Hak9Emr+z7a3zp4C+oi1/Yw4tyneH6B0CjK37voyi3kOMcSljw5lSAUQfDwGQz/
	 I5OEdaywB/x+2p8EujGxwS00vpJlAUswI/sc1ZZY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E39FF80306;
	Sat, 28 Sep 2019 10:17:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1359F803F4; Sat, 28 Sep 2019 10:17:14 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29581F80140
 for <alsa-devel@alsa-project.org>; Sat, 28 Sep 2019 10:17:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29581F80140
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5E62930C0D2E4C2D86C5;
 Sat, 28 Sep 2019 16:17:08 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 16:17:02 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <codrin.ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <mirq-linux@rere.qmqm.pl>
Date: Sat, 28 Sep 2019 16:16:41 +0800
Message-ID: <20190928081641.44232-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH -next] ASoC: atmel: Fix build error
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

when do randbuilding, I got this error:

sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
(.text+0x12f6): undefined reference to `atmel_pcm_pdc_platform_register'

This is because SND_ATMEL_SOC_SSC_DMA=y, SND_ATMEL_SOC_SSC=y,
but SND_ATMEL_SOC_SSC_PDC=m. Fix it bt reintroducing the default Kconfig.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/atmel/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index f118c22..79e45f2 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -12,10 +12,14 @@ if SND_ATMEL_SOC
 config SND_ATMEL_SOC_PDC
 	tristate
 	depends on HAS_DMA
+	default m if SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=m
+	default y if SND_ATMEL_SOC_SSC_PDC=y || (SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=y)
 
 config SND_ATMEL_SOC_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	default m if SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=m
+	default y if SND_ATMEL_SOC_SSC_DMA=y || (SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=y)
 
 config SND_ATMEL_SOC_SSC
 	tristate
-- 
2.7.4


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
