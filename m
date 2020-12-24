Return-Path: <SRS0=BPvr=F4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC7C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Dec 2020 10:08:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C552168B
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Dec 2020 10:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C552168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A103117F9;
	Thu, 24 Dec 2020 11:07:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A103117F9
Authentication-Results: alsa0.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="t+z39E2b"
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3758EF80234;
	Thu, 24 Dec 2020 11:06:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D940BF80264; Thu, 24 Dec 2020 11:06:25 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 213F4F80232
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 11:06:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 213F4F80232
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="t+z39E2b"
Received: by mail-yb1-xb49.google.com with SMTP id b131so2722617ybc.3
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=ZYYrAWwbkxeayAzkRubBQLJLquwO6POPrmwFlXil8ko=;
 b=t+z39E2b76LHvZE37y4WSBn4SH8RT9Tq7+7TEQFmcafgvV0eKKMyxl/Qw2Geu9ytB5
 EcDAj8MvCVDe0c9l4BvyUV4QjfVrM+v1eUOsX4LzlfckQKEDyyOT9+xl32Fz28unJj0F
 5gNJTDnVxamE5fxQST2M8Z4xYTRL6Bi/qQ2ou3I6tqfn+YS4YrkTMZLb/jimjz0riruw
 Kif5qaA9U1QDlwEO5PxKqDaYZ28QeUu6g1NJEWxVE3KpcBSOBNM/i6x5mo4AspSoNfjv
 yVBjVcZIv+fcTZ858OrosW+mxAK/W3ZOaLlkdN/74QlpEZzrJeQFQ/Cd6YxS9yWB4q8E
 Axpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ZYYrAWwbkxeayAzkRubBQLJLquwO6POPrmwFlXil8ko=;
 b=LVJVt1n0tBRqiaJfH2QvhdrsGZ4AqhQVYYjT/M7swJwDwuZsd6EwJJeNMos5zqLMWk
 AVUHZRObbKVrExI8bOOGjAwkOaVDHj0NZiVIIA2IYKi10J6YLQWknuo4uNKDI3No8vvx
 ZIWxrlW2dZdOCR9LmypWi80e4VvfmwSebDfB7MUMkweTaYQuoqtF8YPQvmWLGa9BDDIY
 WxCOgFH0LGx2CCya77AkW1BiZs7uhuUYjwnmJyV8lmCxXuKOtMVZFKwGCq3dF0dAUcT6
 Yo57T6I1Fvp1SA/oMz4lk6gop4Nnhi1Lerr9xo4dRAsBAgNSmH34sieSDpRYyQRUbAh1
 VQaQ==
X-Gm-Message-State: AOAM532hioUBfAi9zabQRuYpW18wRBFBriqQ2uvqjTek2/wqD/SaAgK2
 vxhMLevdFTu0UTibJMjzdG/oY5VfsBgQ
X-Google-Smtp-Source: ABdhPJzNixU+e7flFbrBEQcjPzaC8HJ/IeljfCk1TpQJq1X5EHw+l3eRDkbnV40xaFqSwcBSlnw+nNfdr3ra
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a25:df8b:: with SMTP id
 w133mr44028414ybg.491.1608804376913; Thu, 24 Dec 2020 02:06:16 -0800 (PST)
Date: Thu, 24 Dec 2020 18:06:03 +0800
In-Reply-To: <20201224100607.3006171-1-tzungbi@google.com>
Message-Id: <20201224100607.3006171-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20201224100607.3006171-1-tzungbi@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 1/5] ASoC: rt1015: sort header inclusions
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

Sorts header inclusions.  ASCII value of 'r' is less than 's'.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/rt1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 32e6bcf763d1..1a29d3d5263e 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -24,10 +24,10 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/rt1015.h>
 #include <sound/soc-dapm.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
-#include <sound/rt1015.h>
 
 #include "rl6231.h"
 #include "rt1015.h"
-- 
2.29.2.729.g45daf8777d-goog

