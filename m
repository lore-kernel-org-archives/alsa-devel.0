Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE2CFA372C
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:59:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0773821848
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vEI4CMeR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z62xCmmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0773821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB9B8166F;
	Thu,  7 Nov 2019 02:58:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB9B8166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573091968;
	bh=cAuZA35nsNxropvw5x8ChvxndVbnoX6z4qHVDzH8QmE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vEI4CMeRTtiCgZ0LRTup5ZSdugym9u2g5X+lZDbNNPlvc0mMPQEoRn6pwwQvH1PTo
	 uNWotttx0fI8+qtni/3uWk9M5mxP/PXOU6Q0xjoK/HmSk/fPJy5pRgCroW4ZHRFUZh
	 b+HPkZoW+XbUvvQUHy0IdNHnFl9OS1nGxKREN0B4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16338F8015B;
	Thu,  7 Nov 2019 02:58:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E93A8F8045F; Thu,  7 Nov 2019 02:58:35 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 958BDF8015B
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 02:58:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 958BDF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="Z62xCmmY"
Received: by mail-pg1-x543.google.com with SMTP id 29so721045pgm.6
 for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2019 17:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BFz5SUfQeFQR2d+nQP7mPvaYeGS1RbBlT4qO/Qhk3Jo=;
 b=Z62xCmmY0K2ZFvMsihi+nPkR0EG6EK4nvAFMgOc1MMWBeGRr9zTZWLH+tyGQcol8sc
 FxyLHfJKU9Y+5vuFcT7uqSQP25+G3xG9s8v3ISW80Df2azxG3B/AgjSr4mjDdCzSMHmM
 v1Efo5tSFaqPzw8/q+oXhuVNeHQOqwoU3p97A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BFz5SUfQeFQR2d+nQP7mPvaYeGS1RbBlT4qO/Qhk3Jo=;
 b=RBoOIEh4dtRZFOf0yq2XKxuJ/nvbjeRHtCgLib1bsw401jb+rpV2XIkL9WV5+Ic4wW
 7CR/dGOusWwFfqVIIEu0jvcLRT4/KPCTR8ep/k/sFNkfPdgp8+DF+yRKYM/ggZ/GMKae
 Pj6s+8lXxMJ3nlQaItFnfrE0OJPUSkpNffwO/wzzfV3ff4qNCSpmWcLMyZMuGaAKu5ZN
 CJRF2Ek+w5Dzpxaxj+zxs6xTdvL6KBP9pnPA1h+aQZOFhYAuCWZ4LSPhUhpE4XZSoxcQ
 KsyLIezPe/r67WO2789srZMYa4hrf9pxt5XP2sieee58smYIP1eQYJFnZ89a45bNxqYS
 k2vg==
X-Gm-Message-State: APjAAAWWjQ1L3kAS/R9BPeAq/E7mM6D3G5ZeJeMUJ2Hm/OcB/GAHSsqD
 MHCgDCttyiqAPa9Tfg0b+cewmmqyMBS5
X-Google-Smtp-Source: APXvYqwWsrd/HvlTDq1k8hp5meHDXVuBBOgjcdxOMZkR2Uw3T7AHmT0C2laSacffCqT3JQkhlLfeLg==
X-Received: by 2002:aa7:9488:: with SMTP id z8mr611935pfk.213.1573091909934;
 Wed, 06 Nov 2019 17:58:29 -0800 (PST)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id n3sm290568pff.102.2019.11.06.17.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 17:58:29 -0800 (PST)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 17:57:58 -0800
Message-Id: <20191107015808.26844-1-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Cc: Curtis Malainey <cujomalainey@chromium.org>, broonie@kernel.org
Subject: [alsa-devel] [PATCH 01/11] ucm: docs: Add JackName value
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

This field represents the input device name for a jack detection line

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 include/use-case.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index 5cb4f31c..2051bd40 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -320,6 +320,8 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *        trick upper software layers to e.g. automatically mute speakers when
  *        headphones are plugged in, but that's application policy
  *        configuration that doesn't belong to UCM configuration files.
+ *   - JackName
+ *      - Input name is the input device name for the jack
  */
 int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                      const char *identifier,
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
