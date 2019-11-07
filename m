Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2226FC6194
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 02:00:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267E22178F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 02:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qRx+LYld";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L6Bs2QkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267E22178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC9091682;
	Thu,  7 Nov 2019 02:59:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC9091682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573092024;
	bh=CFq15I51naap8bXAYlNozpBzba09e4Py2cdelEJL8Gs=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qRx+LYlda1AIwsYN9iI+hpu1sDwRX2PxyxAZvt1SMux2ksdOeCaGyShMSrk/iWHmT
	 dPwRRD63uxjcA7MSpW8dpU9P+KmPsyd552NzrZ+N9FNMGUtrcDVQRVwBQrrLQkTENv
	 wn9PFwU5a1uanHwaPlfiKc7hG7cmUeD0vMSAc1w8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D30DEF804FD;
	Thu,  7 Nov 2019 02:58:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EC56F803F4; Thu,  7 Nov 2019 02:58:36 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73405F800F3
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 02:58:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73405F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="L6Bs2QkF"
Received: by mail-pl1-x642.google.com with SMTP id k7so357742pll.1
 for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2019 17:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UfsJvY2cdOU1Cw7G8RBBsya/f9ah4pZopwRcM1t6e3c=;
 b=L6Bs2QkFYqmTA246qxJZbO4OodYFA4TEf+JWgftyAVo835tqYIupkFDGrAbwvFHVEt
 66Y3ciNn3dhgPzU5mPTz+3vTFNv6J2rmgYVmh0XNV/hTAq9O+BUIPXWWfOTJoYyYWH+8
 aOl0zruQa8LVwNLsWg0DnOXpyixRDfB7ciUhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UfsJvY2cdOU1Cw7G8RBBsya/f9ah4pZopwRcM1t6e3c=;
 b=DFy6lc8ieEo8TEUWmMEurTk5UpeEuQrpR2tgl+MdveapezJ/uMTCe6v7e8bUh35Aor
 CYMN47KYq9CNoslIFSS0D4wXUvr6LdN18KUAylyzT9Pl8GDkqmwarxJCvy1wWWpSeYdg
 obGdKp7L9wVKGc+VSgmqeoi35GLeyTo/IJONOvCDZexPiOVWCgc9uZNRzzjyUYBDEoIo
 MmHULX0rufuNATGKAFJeu2Mqe4Fefd3PXo0ELbmhgVojOSt+kNTImV1IU5BaejPAfRpV
 ejuoNlQQbcDFPm+hNQxYGoFiPm/wD1a75JCyphJAcA3zXarwdGLKhrgPEXhJ5XE7mz7D
 +H9g==
X-Gm-Message-State: APjAAAXgF1LEHcyG7qnMbGGaBUNV1xMPuBJkNlKhxACKDV3bVMmPE5Tt
 0EtRpUU0OcOzU3AtrVdosHOFdoxOXdKn
X-Google-Smtp-Source: APXvYqw/Jm4llLEBuk9K2NDXVcUWkD6n4tKYqJ2olPeQhx2ftmuI7wlBqYNK1tIIFI40eQE24kiaAA==
X-Received: by 2002:a17:902:6903:: with SMTP id
 j3mr832231plk.231.1573091911074; 
 Wed, 06 Nov 2019 17:58:31 -0800 (PST)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id fz12sm224217pjb.15.2019.11.06.17.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 17:58:30 -0800 (PST)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 17:57:59 -0800
Message-Id: <20191107015808.26844-2-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191107015808.26844-1-cujomalainey@chromium.org>
References: <20191107015808.26844-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Cc: Curtis Malainey <cujomalainey@chromium.org>, broonie@kernel.org
Subject: [alsa-devel] [PATCH 02/11] ucm: docs: Add JackType value
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

Identifies the type of jack and how it should be accessed

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 include/use-case.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index 2051bd40..3208cc30 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -322,6 +322,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *        configuration that doesn't belong to UCM configuration files.
  *   - JackName
  *      - Input name is the input device name for the jack
+ *   - JackType
+ *      - Specifies whether the jack is accessed via hctl or gpio and therefore
+ *        only carries the possible values of "gpio" or "hctl"
  */
 int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                      const char *identifier,
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
