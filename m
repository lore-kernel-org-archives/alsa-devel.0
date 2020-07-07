Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276DFC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:45:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A838A206DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EaiDLn7x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTcBBZsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A838A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 475DE1670;
	Tue,  7 Jul 2020 16:44:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 475DE1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594133133;
	bh=hQ3D2xyepyWmGLcKAIv2tyIEaznOFFCmVF1LlIRGzsw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EaiDLn7xSPc3AfAeVB0ftJjQ+OoFHj8LcUQuwmR8MXh+4PgCD/7JPaPILZtJqPiJJ
	 EVqKQ5KMQppyRDBbtv+d6ERiFqWFlNyfnljbcs91I7us0akEEB1pwQtj6BtAxa6QxN
	 YRPZlvCScunKcELbj61LXRmhGUYHrF0AVIMOklHw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AED25F8033E;
	Tue,  7 Jul 2020 16:38:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92BF3F80315; Tue,  7 Jul 2020 16:38:14 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C8B6F802E9
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 16:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C8B6F802E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="FTcBBZsq"
Received: by mail-wm1-x341.google.com with SMTP id j18so43527476wmi.3
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j306gyjagAnal9NO9hxv+ks7W0GYhjttqc5twDw7Zos=;
 b=FTcBBZsqkkNyUiAEpUDu2DT5/rR3PslRgh6m1YKkzbz2J2rpneHY37t/nxabjcduOr
 gFpeKCRREntWYiNYwmQ+uKkEMazFirg1ZNU/cmmI4C7jpYoSc1olPXZ1sizl7lkRsLkf
 /4So5bw/2TFBGWv1+MLgv5qn3xjO3RoztYcGXwbzdet0CQ9Ead2vkTjRE7fg1lw+do7F
 nxEQ7I2WCsPjvvyLDEBdAIfdMqXKXTnSfGeD72rM+AN1NSxPq5h9ciIEl8AC3BkYQwk6
 iQBz5laqp3uH0sKSuBXp7ZESiTIl7iXRSU399b8zxklirEQXK/G4bzEyRxmSetYgIgyp
 3sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j306gyjagAnal9NO9hxv+ks7W0GYhjttqc5twDw7Zos=;
 b=PEJLmPsLqqAvS09aGDoJ0hcJU1Dhikbh3br+Gq+sGq5MFbfjGpWEXkErtBQjdY+T+K
 tPnCjxUDZDSpWukmd3em2B0nuP7AJQUoLxshC9jmJkZzzVOdOOqfIxOGH96puvZcSwhh
 5JEaikIl5Vxm5lcnSPox+BIPTAt+Y3bUFuR+75Pi+AGpxYJfgGZ0ZqpUS34mg8Kk73tl
 Q695ah6QLipa4EaYL4V4TdYUvwF2ao0luH4rAOz0Y61g5Y7WSCV+DzonAX9B7gP+AFA3
 WLhKl/kIvE1VDW+FSuFa0eNPyfvOtWeAyZDcIEp/YPZZDn51X/XNMozUAGmnII4rCcZn
 Z/zw==
X-Gm-Message-State: AOAM531f9PDvl+r+0dc4QS/ewY8dOUKsUgISr/05LSzb+CvOhBZWq1yZ
 l911+s28KpuldY8sRrUA+ePt0g==
X-Google-Smtp-Source: ABdhPJxKLiJn098g+A6y4NWEb4pZx+Ro+yEniW+fCbR/jJLf8gPOa1nqxsmv9r9NEk9oYPOgaUjfxQ==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr4431876wmk.138.1594132683827; 
 Tue, 07 Jul 2020 07:38:03 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 07:38:03 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2 11/28] ASoC: pxa: pxa-ssp: Demote seemingly unintentional
 kerneldoc header
Date: Tue,  7 Jul 2020 15:37:25 +0100
Message-Id: <20200707143742.2959960-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 Daniel Mack <daniel@zonque.org>
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

This is the only use of kerneldoc in the sourcefile and full
descriptions are not provided.

Fixes the following W=1 kernel build warning(s):

 sound/soc/pxa/pxa-ssp.c:186: warning: Function parameter or member 'ssp' not described in 'pxa_ssp_set_scr'

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/pxa/pxa-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 6a72cc1665b7c..d1e09ade0190d 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -178,7 +178,7 @@ static int pxa_ssp_resume(struct snd_soc_component *component)
 #define pxa_ssp_resume	NULL
 #endif
 
-/**
+/*
  * ssp_set_clkdiv - set SSP clock divider
  * @div: serial clock rate divider
  */
-- 
2.25.1

