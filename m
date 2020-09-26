Return-Path: <SRS0=yvFc=DD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A841FC2D0A8
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:19:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BF120789
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ql4PuTfP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akFarIoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BF120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E3AB1A9C;
	Sat, 26 Sep 2020 19:19:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E3AB1A9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601140792;
	bh=FaV1Ehi95Xc7XGiF1Y8+kmCPu3pU8TYR0cJLO6M5zU4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ql4PuTfPFk3iWHk5ly6Ln7eHxnZted7gvrwwocCr1Z8tMJ+ZZFjgRS8kz7lMMwpqu
	 iyU/XGtzrNGQprcI7Qp78dtaP2ReEOjjTCYZXz30057CEstbcJyKGjgGuxfSCc5tyS
	 WR9HJh/Gfow94DvSZs17NHs0QzjZ4/fgPM7YXupc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA20AF80229;
	Sat, 26 Sep 2020 19:19:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F54EF80232; Sat, 26 Sep 2020 19:19:00 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31B14F8010E
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2020 19:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31B14F8010E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="akFarIoK"
Received: by mail-wm1-x343.google.com with SMTP id b79so2505994wmb.4
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2020 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TWPF/+E31jT/SF9e9pWIeVEZ0ZzV1h+W9xrpsy2lYE8=;
 b=akFarIoKZv689do8big5BzIFfx9bb8mXj52ZZlFSMAIYjETXUfxzYf4HXB3HZ9KL12
 LTzQqJpLX7bNS2Sq/1P3YLaJZZ1u/lILiKdbW7hi9F0FTMN8vOaAGFHP9M1I0fr4twPp
 SyG6EjIQ51iuTKkTqAaIzClKVrDiSzBcjuhns8IPwpNAkLaYuCljrtb8o/yueaam5SPO
 1X7sW7057Rs+Bg5QYBXV21XB7AcTrXoPXTqW7t7jDaX/XHJKc1XLb4J2Llpg+78lzMqu
 TdDl+oPGSfRjRZ6Lmz3RZlun48Bi9bBvDpw3lPYJIS/t5sTc/Ud+TYrRW1GRSFup0T8t
 rtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TWPF/+E31jT/SF9e9pWIeVEZ0ZzV1h+W9xrpsy2lYE8=;
 b=jHeddj+eZEx74AhqH2b47Ny+2MRy3nxUMNu4KACgmMMBdtapwmJJ8eL1RtLYdFkm+c
 CfjsyESQpirm23pHqjpzLd5exsfvfbRrVis977v1ij1l8xcJhyM8Sbqy2uHVrLo4n46Z
 NKDNLPz8faKpmsyOFTR+niUcLgHuCD8VmFxnE4RRb9UyQXQVeDl3G82m+fxZTjHQZL16
 9B2arIfHwQ1tkP8enWIerNyXMUpsU2fIhPng2vFbrgiO12jm6PbuLcro0fWR5TCZI/kR
 /j6E6L0VXMnF4P89s8pUTzubpgjyJMzUE/rJSfNsHPNOq2iQsDHjjphaTCtH89il9547
 F/LA==
X-Gm-Message-State: AOAM531v4kJGlIssaZ88SNdTqxOP0/l3AvEO6fQvNdEz9jjwrGAj20NY
 TmtiJTCmmDdbZze6sejzFhwmzQ==
X-Google-Smtp-Source: ABdhPJwZgoso8BLc4MzoELCecqgt5fmmxg2WHb+/fPwZgYYPKmer2gbdf2KDTq7B6JcOnIr1zR/PGQ==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr3320680wme.179.1601140733451; 
 Sat, 26 Sep 2020 10:18:53 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id 70sm3368176wme.15.2020.09.26.10.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 10:18:52 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH] ASoC: q6afe-clocks: Fix typo in SPDX Licence
Date: Sat, 26 Sep 2020 18:18:44 +0100
Message-Id: <20200926171844.7792-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lukas.bulwahn@gmail.com
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

Looks like there was a major typo in SPDX Licence version,
Not sure how it was missed.
This patch is to fix it.

Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index 25b409597d51..2efc2eaa0424 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0
+// SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020, Linaro Limited
 
 #include <linux/err.h>
-- 
2.21.0

