Return-Path: <SRS0=5dB9=7Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82A1C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:43:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32237207C3
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jXNJsLuc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcEC6fng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32237207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9812F167F;
	Thu, 11 Jun 2020 14:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9812F167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591879379;
	bh=qbRLAvulckFxE1TGw643ah6T5PAOER996gpqcHRciW0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jXNJsLucp0Bq4ihwgC7C78Ij2D8hxEO7gQn480Nr2ajwY4Q6BexdQYwZc4mG9xT/S
	 bkPMjrYFyLntvWTwKeSXFIZ9TjNR3swoMQnmKP8iQRnp1Z1p6nJLIYAOY3vNG2lttk
	 HgopwKC7CLjjdlzZfafXqsXlVfqvPFk44aeo2ZK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB611F800CC;
	Thu, 11 Jun 2020 14:42:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D51CAF80290; Thu, 11 Jun 2020 14:42:07 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E678FF800CC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 14:42:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E678FF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="HcEC6fng"
Received: by mail-wm1-x344.google.com with SMTP id l17so4862307wmj.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=laaD8UzobffiSB7u/5lmFKPGdNh3SaNEg044mEgCOBI=;
 b=HcEC6fngLw1IZqkT0ZIy+oG6vVaoYiMCjA8WXTD6kOmX6PYqcXlqNDWF+erPuhsaMR
 DcFWuqFYRudvJ9ovOg1TZOlCy8A/3/7NoBBY6gspp4Orn4ouFiZ0Gqb4fzGI6L+HHqNo
 H0XOKf/lRwl63UBjf3l+xpzxFV8pKefuNDEfmkTTujeTMTgQTdqH/4QvG5yun5hS2Imf
 7U3S/kw5CpvBWo/mK8nLXp8og7BuQ5hTLCY2XQ4RdX6lKyUT0lcj7avg3MxIqdM45HZm
 sw5iYvwxKdnO358y8foLqVakrDznBYfMmrz7GZ1OsUOMt/P4fMUsOW/8agLupo63yHxy
 Jd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=laaD8UzobffiSB7u/5lmFKPGdNh3SaNEg044mEgCOBI=;
 b=QmhMMCErEk8b4i3lrgA8HmVeaK3NrREC2b3QgQMoUd57RhjsK9gO/44c7qi5p9uywp
 sqoCaCqP0JKAHTemdT9NnXk9594n7y/PRu5HMnGxUZyJ4p87ldEgLkrwtelXi7twYdJd
 TE0yPRadaavbX6Yq/FxlxFl/HWk4Q845GmRSUAzqB5VsToicEKvOchq5VlW5zaQQj/s/
 JDhzotioSdGdRe7rdhViOfwazcmaekCEst7A/anc/f9s5e5mkGaF06bRWaLXcG5Omvcc
 8g0gA6Ii97vjaHHzVGlKWYFg2La5ZbWj6xroO84WOuYPap71qwQxLBLlaQQ6prJhMzC9
 +BDg==
X-Gm-Message-State: AOAM532lKeSXr8Cl2+OHG05C+o79E2nypRulbmdnlc4FeA+AX/8HUU+r
 y+7oCgvtl5OVWcWLxMzzWZCPh7GXX9U=
X-Google-Smtp-Source: ABdhPJzvBtbsGiyEJ2M2wwSnsUCNIIAH/NTq4ytV5PjJtR+k7rhHBIsvR0HqZbvh+Gzl+RqDvytt2A==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr7603110wmc.113.1591879322750; 
 Thu, 11 Jun 2020 05:42:02 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 05:42:01 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 0/8] ASoC: qcom: q6asm: few fixes and enhancements.
Date: Thu, 11 Jun 2020 13:41:51 +0100
Message-Id: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, vkoul@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

While trying out gapless playback, I found few issues with the existing code
This patchset has few fixes and some enhancement to the code to handle
multiple streams per asm session and also handle buffers that are not aligned
to period sizes.

I will send Gapless support patches once compressed gapless state machine is fixed.

Thanks,
srini

Srinivas Kandagatla (8):
  ASoC: q6asm: add command opcode to timeout error report
  ASoC: q6asm: handle EOS correctly
  ASoC: q6asm: rename misleading session id variable
  ASoC: q6asm: make commands specific to streams
  ASoC: q6asm: use flags directly from asm-dai
  ASoC: q6asm: add length to write command token
  ASoC: q6asm-dai: check available buffer size before sending
  ASoC: q6asm: allow to specify buffer offset in q6asm_write

 sound/soc/qcom/qdsp6/q6asm-dai.c | 100 ++++++++++++++--------
 sound/soc/qcom/qdsp6/q6asm.c     | 138 ++++++++++++++++++-------------
 sound/soc/qcom/qdsp6/q6asm.h     |  42 ++++++----
 3 files changed, 172 insertions(+), 108 deletions(-)

-- 
2.21.0

