Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A46BFA372C
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 02:05:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9A2217D7
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 02:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U4At0hPb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHi0sazA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9A2217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B5A0169C;
	Thu,  7 Nov 2019 03:05:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B5A0169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573092350;
	bh=UGLPjQWXDyMeEI7XZAGUqcC2R7LN6dN2UXmF5I+2hdY=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U4At0hPbkWPvLpVcKK8uLDj8IlLMeCeGb7X+3SVMmglqzGHN3mBB7YIEWPMipzOWQ
	 /TGU6ADPfSrrHFalqcRHcbLT9kBQr6e400pPUgj6btmOww6xaUpWZkZ0VCBKWj5aQZ
	 02RY0rHJ0J61RD2ZVN8h7gzm2NrhPxEGsoLmt+aA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F168F806EF;
	Thu,  7 Nov 2019 02:58:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3651F8063C; Thu,  7 Nov 2019 02:58:45 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCEDDF80636
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 02:58:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCEDDF80636
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="ZHi0sazA"
Received: by mail-pf1-x444.google.com with SMTP id 3so1051304pfb.10
 for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2019 17:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2wXWJaSCd2JmRB8D3fuZ5gEYXpLPJzLqFKUZZRyerrI=;
 b=ZHi0sazA+WoxL8NnNi1psqkdF1RNggult7lzei8x7KVuBXA8DVPqrpaUu5jHFNJ+7w
 0CKGh+fcG2XU5IW1KvdxkDRJLlXlak1xddUyaMPwBz5kKR/ZyobVuRE/PxkN8nsmj9x1
 Czro2xpp35zGixwMbRZ3sj5wPVqEAqQQ5wMv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2wXWJaSCd2JmRB8D3fuZ5gEYXpLPJzLqFKUZZRyerrI=;
 b=FHvwR8PEnuGWXbKppumeXLfXG7qfPf+OeQ9BH8mCBn5zLRcndOoD//eP93yaBlEzVx
 3o7YL63OJvNfsc9BBshuAEsq+xdkDtYUXr28zkZZ/qz4MdPO6T3/Xfoqu3cgpRQupUVa
 vEhJfz/NC7F/2KhkjUAKWbNR2QEeMXaMq1zuduumVsclEyBVeiwwX3jkunI1pkbmShfG
 apP9ZS2xuTJNona791mM6UttY16YmaYdpmRff1xlqfGbpZvPxSfSUewR9+PSsyGLUyjW
 3ZWnEfKlkay+2tm13v4D1sUOhg2SwIjc3guLYPmY/NRJ5uos3kDNyCrWmEHTdbTfWGpr
 IAtA==
X-Gm-Message-State: APjAAAXj3wroJNSi+Hi0gxgOBUBd85Twq5QdUw2fGfg88oPMX1QcSbH8
 SVLsDzyQ5C/x8ZfAYabpL6N1mP/uxIPM
X-Google-Smtp-Source: APXvYqxGuDbiCkfdq7Tp3thFdRbbOEnazAiL8GVXfeLkNFy7YPy8UELqdRBiDLIMuUj0M33xOd/VKA==
X-Received: by 2002:a62:1d8d:: with SMTP id d135mr653053pfd.172.1573091920815; 
 Wed, 06 Nov 2019 17:58:40 -0800 (PST)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id h66sm292435pfg.23.2019.11.06.17.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 17:58:40 -0800 (PST)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 17:58:07 -0800
Message-Id: <20191107015808.26844-10-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191107015808.26844-1-cujomalainey@chromium.org>
References: <20191107015808.26844-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Cc: Curtis Malainey <cujomalainey@chromium.org>, broonie@kernel.org
Subject: [alsa-devel] [PATCH 10/11] ucm: docs: Add SoftwareGain
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

Add software gain ucm definition.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 include/use-case.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index e84f3f8f..ee6ee5e0 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -344,6 +344,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *      - This is used on platform where reported buffer level is not accurate.
  *        E.g. "512", which holds 512 samples in device buffer. Note: this will
  *        increase latency.
+ *   - SoftwareGain
+ *      - Specify the software gain in 0.01dB. E.g. "20" means there will be
+ *        0.2 dB software gain on this node.
  *   - DisableSoftwareVolume
  *      - Set to "1" to force userspace to use hardware volume controls
  */
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
