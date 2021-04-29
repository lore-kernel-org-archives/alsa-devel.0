Return-Path: <SRS0=hTuJ=J6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AADC433B4
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 11:41:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AF7611CB
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 11:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AF7611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9173C852;
	Mon,  3 May 2021 13:40:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9173C852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620042078;
	bh=zTD5XNpQcNgkJT83Q2al0FE7LUgrZGM1S6a2eWeWBEc=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m/eg5sQbslf9xHYuqs6P+1O72YeGbLbnRC8w4zVdXvEyWdyw9Ac5a9UBq2HupT7II
	 ECLxT4/Omd8ycHJ7S1I8SyjE1ZecZaYaVlVMf1L4sx7wNnoiJoTNbHqvXLxXDtQ/fd
	 Gfydfkb9Ug6bP9OPQlKX4zJIc+rQTzLlN/Xb8Swc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71924F80257;
	Mon,  3 May 2021 13:40:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2907F801EC; Thu, 29 Apr 2021 11:25:23 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B602AF800E4
 for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2021 11:25:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B602AF800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="doJSUANF"
Received: by mail-pj1-x102b.google.com with SMTP id
 gc22-20020a17090b3116b02901558435aec1so6911891pjb.4
 for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2021 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=Hc7qwEWt0TQypk1NpxmfhrdUGD/9xTC+FVNkE0PCDPk=;
 b=doJSUANF+Dq7ZsjoPCEistPnbGK/JuTWTDxUpl1X+jLEN/iAxF5HyqYv47fIS8EOS1
 aWfgcvdUjOOc8RR2wDvrI3QcPgsdvmboE79Z0PA2eD8SkZl71zB0EAAwXwDwtyWQhZw0
 r+NGGlnKMwxXpqTwDm8mUGnZ+i1wG8cp4D74H5GWBn0EZbLo1mzgMrrRxGa2DoUednKH
 yx7v8WMtcPTGL50QaTzmqbWMFJ8wmse8Q9Z+59ciTX4R/qvCItQQdENBJFB3Ge35+jc1
 BPGhK03Xb/kJIyEBxz5ktnfq88PZjZKboFIfAwGVisicojSU6fcr9V25WyassBo1XYk2
 wR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=Hc7qwEWt0TQypk1NpxmfhrdUGD/9xTC+FVNkE0PCDPk=;
 b=n1l4s7Bc9hMz8yUIX384LIPpE1o86pZ4vYw+X/FcAeKxqSB7X+rhQjC52xnFy6VeAr
 56788pKp4BoNFhMSy2a4QwrH3qhtOvAL7HOc17Aj6QMV8pXExF2EWIoKzhgxn8SXwC6C
 k383BNq/Qx4mx1FLX1VnFQFf6mYLDJdPV5tE4FfHOiVnPUBN/MFfRB6GOaDPYEORdnE4
 DgrcXAj5+cCxIk7l0Z7geWD90t5UJTCwDPxmuLIsQwXZJEzArBa98b4IaKSi0l3586Si
 yU+irQPErZY8BR0cccGFRZeuI20cXtGF32w1EBFhab9nlmFB6JpRGBVcRov4Yz4hNYCK
 63Ag==
X-Gm-Message-State: AOAM531PtwG97xBxYWwpHCMccIWuFimMi2ThovqTayDovUSw5Th+tSqr
 /JTGYS6tTM6BFoHuY72Jy2M=
X-Google-Smtp-Source: ABdhPJwIKMM5WeakUgaxHGL5V94vdsm/Y7DRjAdrvfr1VxbJ6AY43JpMQGSBU46hdFmarfcpO1NiEA==
X-Received: by 2002:a17:90b:370a:: with SMTP id
 mg10mr6303916pjb.219.1619688313938; 
 Thu, 29 Apr 2021 02:25:13 -0700 (PDT)
Received: from localhost ([157.45.42.16])
 by smtp.gmail.com with ESMTPSA id j23sm2069548pfh.179.2021.04.29.02.25.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Apr 2021 02:25:13 -0700 (PDT)
Date: Thu, 29 Apr 2021 14:55:05 +0530
From: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To: agross@kernel.org
Subject: [PATCH] drivers: slimbus: qcom-ngd-ctrl.c: Added space after comma
Message-ID: <20210429092505.lamh5km4inoynjar@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-Mailman-Approved-At: Mon, 03 May 2021 13:40:20 +0200
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 sanjanasrinidhi1810@gmail.com
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

A space has been give after the ','.
This is done to maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index c054e83ab636..cb9612a5c30c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1348,7 +1348,7 @@ static const struct of_device_id qcom_slim_ngd_dt_match[] = {
 	{
 		.compatible = "qcom,slim-ngd-v1.5.0",
 		.data = &ngd_v1_5_offset_info,
-	},{
+	}, {
 		.compatible = "qcom,slim-ngd-v2.1.0",
 		.data = &ngd_v1_5_offset_info,
 	},
-- 
2.17.1

