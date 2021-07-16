Return-Path: <SRS0=MRBS=MI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493B0C12002
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 10:24:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B5E613F6
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 10:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5E613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC085167E;
	Fri, 16 Jul 2021 12:23:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC085167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626431061;
	bh=yM3a8dQxSPHCAFE6FjkNkxyi3MxoRGJVXEcHD22Fnj0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AsjI5/LNKFn5wyqvTAbnpJ50dvh7XYxnwBTLlGD8MkzhnWf1kV251Gn3GHo7QB2bT
	 fv+CEUa6i/qaB3OPfdRYL/N5Awd6wBGZ8YTbBUh6a9JQDWCcRANn3dWN9oPAtgzVRo
	 S0Fye0wg4yKEsTIIfCZ9ruUtwJLh4rOVVDGRtXZI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 272C7F8025B;
	Fri, 16 Jul 2021 12:22:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9CDD1F80424; Fri, 16 Jul 2021 12:22:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FF89F800FB
 for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2021 12:22:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FF89F800FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="MOrqkMTR"
Received: by mail-wm1-x32c.google.com with SMTP id
 l18-20020a1ced120000b029014c1adff1edso7860645wmh.4
 for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2021 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+agN8Y7YKzZWGYmosJCMKjDZQDR4OYf00Q82/uMWOlg=;
 b=MOrqkMTRaghA4zePX8fRMewT5cG3NtLKJzS7iORpeQbcGZqwTYyZCtkxuk2rmNk0Ud
 djO3kn4BW1OIclMYeYfeHmGGbHvAV3vxxRIQFWFGQI3+6qfgDH/6vzD8WIn2ZgPZ2YGG
 7VCJ/kdpZhu1Fs9zeX1ssJZEYGjYnz04CfnR2KJDmNiSL02A5ncCqCaeFAPYAK4Vj8r5
 0EHWwTzmSJT/LXy096e6SydUisLTV6va0I8EBMhJoszJKXvhTDpagssqecy9J/QWpZiZ
 t9hi8nEZDokN4SbyG1sbLgskvyuzQCoXUcEr0qgmPoIaAUfuWmfLQM0GZTEhy4XB/UJM
 Fcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+agN8Y7YKzZWGYmosJCMKjDZQDR4OYf00Q82/uMWOlg=;
 b=ZHdLeB2B8JpNUs9UAX263x4Nr5DCloaUL03OpmY0bCDWU4kaNoIteAURrx1g2mYUxX
 8q+G9tJvs6jvDI9R6uxX/Zz1BhUShnyIJwPgz0fGHOLKAxvxAY+pYxcXfq6mrACKk+5o
 upLLjRMLWqmCmP30c5ihsYhkIfMyPqG4aXSuF3ImKdoWWxvx4HnqtdfRuI55okldgm7r
 6ADT//bbrLo7twmkYiQ5Af3dcyoToW+KuXA7IAYuzneL36QxNDhm3sqTfpMtTXzaJtEU
 Bdysvq9onSCdlcrlv5kd4XBTpdFtW6bAVCysm4v+GrM81VIKbNQsQsd9I7xCj4P+Gdr7
 O8+g==
X-Gm-Message-State: AOAM530HgLw9ctxQWd9Iwv3qqMIAn6Jx7YEdsVMz0jtOG1x/NCXUCeJW
 wpp+zxVJ4rk3ilaM0aY6oTs/7g==
X-Google-Smtp-Source: ABdhPJwNc+AyvJtfQ9kkcmoxhYtdC+xXLCIe0+rEhwDGj7Jiug7pX6oKrAKZ8OzjWmM5DCK45wh0CQ==
X-Received: by 2002:a7b:c1cd:: with SMTP id a13mr15467463wmj.75.1626430956488; 
 Fri, 16 Jul 2021 03:22:36 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id g15sm7421796wmh.44.2021.07.16.03.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jul 2021 03:22:36 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: srini@kernel.org
Subject: [PATCH 1/4] slimbus: messaging: start transaction ids from 1 instead
 of zero
Date: Fri, 16 Jul 2021 11:21:20 +0100
Message-Id: <20210716102123.26861-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
References: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

As tid is unsigned its hard to figure out if the tid is valid or
invalid. So Start the transaction ids from 1 instead of zero
so that we could differentiate between a valid tid and invalid tids

This is useful in cases where controller would add a tid for controller
specific transfers.

Fixes: d3062a210930 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index f2b5d347d227..6097ddc43a35 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -66,7 +66,7 @@ int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	int ret = 0;
 
 	spin_lock_irqsave(&ctrl->txn_lock, flags);
-	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 0,
+	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 1,
 				SLIM_MAX_TIDS, GFP_ATOMIC);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-- 
2.21.0

