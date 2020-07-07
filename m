Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD0C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:44:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16DC2073E
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FhSBdaEr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3utOKUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16DC2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 386DE112;
	Tue,  7 Jul 2020 16:44:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 386DE112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594133097;
	bh=H/tdZ8ilfYBgwOZ3cM2RmrdmhVzeUghpK04gZ6y3CJM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FhSBdaErbEw8dGgK37otyXIjit+nMHTzEGNEHuBJ9rf5Lb9VXoPOVsai1klPzj8ZY
	 bWZ4Xt3yeSpHZNawIm1yDIINVYcWGkH5Nfnr0LdhOw34rmpRRB1xu76k+MAe6868uj
	 Qv3HyLXyXRSs0K8pdVKsd4K8a+JMuDNakY0wrpPU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD441F802EC;
	Tue,  7 Jul 2020 16:38:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8474CF802FB; Tue,  7 Jul 2020 16:38:11 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBEDCF80216
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 16:38:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBEDCF80216
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="a3utOKUU"
Received: by mail-wm1-x341.google.com with SMTP id f139so46803343wmf.5
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ceIee8YBFX9kzqJWoK/1iqOS7aaLJ7GoK8i5sFpusg4=;
 b=a3utOKUUtmKkFumgYHWsrcA1cg/wCdSJzx/eQgQLrrlD+gKnImbCleOaOXKOhYAKbQ
 wFtcCg0Zo07kbM7/6b2WCbMEHtqRx0z5z8x45mkeHdE3bvPHfdCb/TUOyMt7XXoEq+KQ
 o8/c8hFiFt4TI3ZC+VsiuM7fi3SZ8WfEOadMim+lOC72FVkmNDmll/pBDzmpXzouNgZF
 mUbq2kGI6/L1hRYrnhevYOeHjGlQmRVZAAtBN2SQ6pF+rb9isxab6LqIUpDrOsAI0MhP
 DQwJZds52dUHxrq1ypA88jHKSu/zyLTc4WUK+bTAjzBhJXhdv7fX8pvOqDcGdewSDIZG
 aGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ceIee8YBFX9kzqJWoK/1iqOS7aaLJ7GoK8i5sFpusg4=;
 b=Cn1mNCwPs8Y8rTL5yXFNtZ1vnARKbm0L4KT4622rqAMQalEr+pOiKypAQ/7bXzncCm
 Sn/7ZXWaJdAfHzlbod5CDqznXYzY9ifOfeAfAoJXpe09OTJ0xeNbD+Ad2Lpak6zeM1cD
 ryBfEbOvoh9G3Cm4jE9YHDujo32vs7ywKQdtqzRdz8SnMEANZHB4tHMXnkP/D6+E5+6g
 z8BAGbYVgyuwmjjEMLHLwwp7Px3HYQ0f8SmiEAA5Rp8BHoGH7Soa/bRIsLFBiPsrxr5n
 Vxe/khz1dcwLkUuvufghdUg1jcVXxkfASIMHYjyJz8mR6bkLoQHzFU+FmyVTDCXaj/ge
 nhOA==
X-Gm-Message-State: AOAM532B8Nsn2i2ejAHmsXHRw2IYHq/fj3n4EWRWWoHoKHncvxY3SXDB
 ygSe2Afw4/XP+YxgF9GLhYFjwg==
X-Google-Smtp-Source: ABdhPJwBhFtwMc09q5I1X/u5knzfYzz3vq0gulrDOAYoVOgPpYR9Udx/EMDFNfeERzWsGHW0kriQDg==
X-Received: by 2002:a1c:b409:: with SMTP id d9mr4245606wmf.99.1594132682705;
 Tue, 07 Jul 2020 07:38:02 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 07:38:02 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2 10/28] ASoC: fsl: fsl_esai: Add descriptions for 'tx_mask'
 and 'rx_mask' to 'fsl_esai'
Date: Tue,  7 Jul 2020 15:37:24 +0100
Message-Id: <20200707143742.2959960-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
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

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_esai.c:86: warning: Function parameter or member 'tx_mask' not described in 'fsl_esai'
 sound/soc/fsl/fsl_esai.c:86: warning: Function parameter or member 'rx_mask' not described in 'fsl_esai'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_esai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index bb3c405df623c..3f67f4a465780 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -49,6 +49,8 @@ struct fsl_esai_soc_data {
  * @fifo_depth: depth of tx/rx FIFO
  * @slot_width: width of each DAI slot
  * @slots: number of slots
+ * @tx_mask: tx register mask
+ * @rx_mask: rx register mask
  * @channels: channel num for tx or rx
  * @hck_rate: clock rate of desired HCKx clock
  * @sck_rate: clock rate of desired SCKx clock
-- 
2.25.1

