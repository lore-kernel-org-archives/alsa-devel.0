Return-Path: <SRS0=5dB9=7Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C35C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:45:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D2A2078D
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZO+OEHrb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4Yx9htZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D2A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5C281688;
	Thu, 11 Jun 2020 14:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5C281688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591879506;
	bh=J2MJ/duH2bS5U1Y0T+/jkmjX+XL5hlBX5Sdwc59rfgg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZO+OEHrbBpVsAFQjgVfGf+13L4/QbDKBGfu2YSo4nCc+loxqaAt1f4RaYmMg5WKFn
	 Y6s7LbLbb5hrRdW5MionkTJP6KDZBUcgTuytbiERhsYbTGk9gjeNRAVnRUGWHfy8Ml
	 VG5gT8kG810nKZY1S8+HIUvouoohISme8lqkFEjA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C718EF8028D;
	Thu, 11 Jun 2020 14:42:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38A97F802C2; Thu, 11 Jun 2020 14:42:16 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71FBCF80292
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 14:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71FBCF80292
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="L4Yx9htZ"
Received: by mail-wr1-x442.google.com with SMTP id l11so6025504wru.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=89ssfiDaoOJSnjV248d4sDefUT+7TO0HxUeigRg/Xi8=;
 b=L4Yx9htZSgsTyGH9/nBWmXvvG7pSc20Jy88SyQfOe1gfupZBVpYa1iRsAhT6DE1x+T
 iJL4j5tDVV53t5lrkAGU4pxi+6l1wyC1l7yW+Y+MmVNKPBTG36Cv9DoBeJEAYSfNu+ym
 LsWcOh66+ThBt872nbMRSHlCwUp4XrIfrcpHrlMAdihSQ8xesNaGtk74fjiFDlCku8Sr
 zraTcuSRY4BWGd8bf2kBpWhkExwzfHAcfkMT7k5YgPHZfNw/I0Y7r3ZneZ+haejBSWXH
 AvCUzgQmW9hdccTSc1vrbfrdxOfruBq/CwZSIHBH8dMsbHJczW7ouqt2sWba7k/h64Mm
 UPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=89ssfiDaoOJSnjV248d4sDefUT+7TO0HxUeigRg/Xi8=;
 b=q2+MExvV4hCMdBBIJjTeZ4pLIkOgkK5ok1FbdYxgjqUTnv31DiN6CNOwaqJWZqtBAf
 xOPSqNWYIRwCaNHObwbMZ1jtR5htJ7g6P5PVyTVsS5ojhAYSlw5QINUIZ0v9BQZm3Y4P
 9ZRYQWa9si9CEZ93o0q5Aw05kxU2frW92stHYjYLbWDzMANmdr1VEmRkoTyvTLFBzqSK
 tyBFb3tWbDhXl10DCyKST3S4NvC6T0qTFcmCpGnARQ3jbO+9pwo1C66Bg6hKkUXCPiDA
 q6IBQLR60pGSwx9MXZK1HWLbY2NFaYb+tCHxC8p2oMJE+yXjw2ljA7+r1xD2GSO2sq9q
 Mxbw==
X-Gm-Message-State: AOAM531xb126+YQeOh+LTOrXofWCdNqlsSI2ccdstycjljidfb41m35r
 FBBBRUzgyiH99u8/9LeMFsSd4A==
X-Google-Smtp-Source: ABdhPJyErYeOzDKPbvAE9DmcVdq0rdmLobsuWCwfpgj8VuPZq7x6FcvEpRgs8yytZ/OEKGkn1EpUzg==
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr9541801wrx.5.1591879328901; 
 Thu, 11 Jun 2020 05:42:08 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 05:42:08 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 5/8] ASoC: q6asm: use flags directly from asm-dai
Date: Thu, 11 Jun 2020 13:41:56 +0100
Message-Id: <20200611124159.20742-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
References: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
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

use flags set by asm-dais directly!

This will be useful gapless case where write needs a special flag to indicate
that last buffer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index f5d1f3c2c1ec..d6728304ce6a 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1546,10 +1546,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 	write->mem_map_handle =
 	    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
 
-	if (wflags == NO_TIMESTAMP)
-		write->flags = (wflags & 0x800000FF);
-	else
-		write->flags = (0x80000000 | wflags);
+	write->flags = wflags;
 
 	port->dsp_buf++;
 
-- 
2.21.0

