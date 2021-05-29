Return-Path: <SRS0=AoxM=KY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793ABC4708E
	for <alsa-devel@archiver.kernel.org>; Sat, 29 May 2021 09:03:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0A5613B4
	for <alsa-devel@archiver.kernel.org>; Sat, 29 May 2021 09:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0A5613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 865A216AB;
	Sat, 29 May 2021 11:02:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 865A216AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622279005;
	bh=iOsJZs4S9KmxcKCP6/+Edog/SU1W2KOQ8mlXtoTgFEY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=neBav0Zof3s62t51suyHMBOAIGWqrP5JQPTQknZn+XtjlUdsz1SYunepYIfNJkiF/
	 QDYotgsQU6Ihtf43FpMVU6uKev3FKayF0s5WGqhIfZS7Fi1qvHSL0yIKfyKuHyO01y
	 8t8gBYGPunE/762D2sGWbrsylUXgnEw+E8llRW4k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17536F8014B;
	Sat, 29 May 2021 11:02:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB215F80169; Sat, 29 May 2021 11:02:32 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B271F8013A
 for <alsa-devel@alsa-project.org>; Sat, 29 May 2021 11:02:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B271F8013A
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fsb8q031gzYr26;
 Sat, 29 May 2021 16:59:39 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:02:16 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:02:16 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: usb-audio: Remove the repeated declaration
Date: Sat, 29 May 2021 17:02:06 +0800
Message-ID: <1622278926-63857-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Takashi Iwai <tiwai@suse.com>
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

Function 'snd_usb_endpoint_suspend' is declared twice, so remove the
repeated declaration.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 sound/usb/endpoint.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index eea4ca49876d..a668f675b52b 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -19,7 +19,6 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 			    struct snd_usb_endpoint *ep);
 int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 			       struct snd_usb_endpoint *ep);
-void snd_usb_endpoint_suspend(struct snd_usb_endpoint *ep);
 
 bool snd_usb_endpoint_compatible(struct snd_usb_audio *chip,
 				 struct snd_usb_endpoint *ep,
-- 
2.7.4

