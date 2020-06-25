Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B8C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92800207E8
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nKW8VaZw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="F5rLCh58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92800207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F2801910;
	Thu, 25 Jun 2020 17:37:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F2801910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593099510;
	bh=5fDD8NmEW9QkobIY6oHmA1VE9pr6WZBgTjYo2fUKWMQ=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nKW8VaZwPIchFJrucrery+78qj57/Vwren2pHQK+cWDhIlaVyHqvF2LK/lERJn6EX
	 E//IwXhH4ODTk2RrYN2tvwPucHlbFzTPlgL8jLP1tUGYsycqi00x7TeJeIWEJFb8Uv
	 S4H532Cezfmm+17JvwtHuUtzScTsYr4m45gQSiaA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAD00F802A1;
	Thu, 25 Jun 2020 17:36:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A309AF802A1; Thu, 25 Jun 2020 17:36:06 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E70EF8025E
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 17:36:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E70EF8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="F5rLCh58"
Received: by mail-yb1-xb49.google.com with SMTP id l9so5565472ybm.20
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=VXKiWv6DTV1TrKdYwUuMhghuxgm18ckN/7p6PszOuRE=;
 b=F5rLCh58RdVQQgE9xgJsRGLi63Ct3V4A7EroMli62T/ytob3QLnhVf+a4nxCAR8pu0
 +Op3zbLg9E1ysSbKrIvcZDV7+KO/1kTEQuJZC76D9zz9yQRyYzCA4YldrrPMxt+D7Znb
 jUNxGIpWy9W5nmanSJcHEJYyE940ISM2zZ1V4rTqVDQ2ZQznW2DQPy/iCH6i+97Uz0vR
 7r6QUF+L6gN3PRKYxYDgpr8/SpNe+mKHFxfhgokEROr6bm1/hcKeE6qI0Rpwf9GT/hAa
 ao/54jfYbm5VfLRyUSYZz4NG2BEDnYsd4R/1mVarUmEy++f/LbKDKc5c+rwplRIqBMtt
 YWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=VXKiWv6DTV1TrKdYwUuMhghuxgm18ckN/7p6PszOuRE=;
 b=TrgjOdXixJ9IVxgE68iHYfdJ3JCAgzP30wHbh/u1XA1kwEpGAPb8W21Nd8/W2vpMN/
 5qzh/lvAAWy7tyXPFAsYdNiHUxA6NvF5MGGrYjkMh3glh9O3vs6D7vrrfZ2sIXl/L3rc
 ziyTt1Oh/sKqgSYBN0xlKdYSnaN5fI4NJgU9GzwgYbLDex3et+HOIS6bJ0hhNCHhrDkD
 Xd0vZPXSGqaOP3e852nRW3jZWFS4WBNcNaqD5jBQAs0bFYYR/7FlgVneEzJhp/GrMYEp
 b9mrQSTO1F0Do8L09yxhm9EDBN96b6omvuw55AxtRr+V9w82sgVxYszWXJOquzPa6LUJ
 /Q8g==
X-Gm-Message-State: AOAM533qdkZqUliRChTfCtmMAekBH6zx9o57NrbeBEMBRfgJJ1jrapOr
 KbsT3Rzy5GBk33e2a4YwW0KTqtbD+4+M
X-Google-Smtp-Source: ABdhPJy5PZyhdFaR4SpFVtZms0KvvXK3BCjXrGrhkRySd63KDoleRAWNmxBbloZMg+d8FvN2n2qdZc28h6V0
X-Received: by 2002:a25:b51:: with SMTP id 78mr54320051ybl.186.1593099361606; 
 Thu, 25 Jun 2020 08:36:01 -0700 (PDT)
Date: Thu, 25 Jun 2020 23:35:42 +0800
In-Reply-To: <20200625153543.85039-1-tzungbi@google.com>
Message-Id: <20200625153543.85039-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20200625153543.85039-1-tzungbi@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 2/3] ASoC: dapm: declare missing structure prototypes
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

To fix compilation warnings:

- struct 'snd_soc_pcm_runtime' declared inside parameter list will not
  be visible outside of this definition or declaration
- struct 'soc_enum' declared inside parameter list will not be visible
  outside of this definition or declaration

Declares the missing structure prototypes.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 include/sound/soc-dapm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 75467f2ed405..c3039e97929a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -16,6 +16,8 @@
 #include <sound/asoc.h>
 
 struct device;
+struct snd_soc_pcm_runtime;
+struct soc_enum;
 
 /* widget has no PM register bit */
 #define SND_SOC_NOPM	-1
-- 
2.27.0.212.ge8ba1cc988-goog

