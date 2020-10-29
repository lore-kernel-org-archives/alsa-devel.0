Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A5C55178
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:56:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878DD20EDD
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ChKHOUqU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z32XblI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878DD20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8ABC165D;
	Thu, 29 Oct 2020 08:55:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8ABC165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603958187;
	bh=yOKs3p0p/bAL4SuC/ZQI4Sof3Dcan/4S5ufa4RBa4LA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ChKHOUqU8v41XFKwE0xErgWO4bc1n5PbUBXCFmLCYgDViPMC7y5S7se70d2m8UZHq
	 A7CukVN9TH5uMX1JGS/Q5+nxG6AvmttkbEJ6RfeMSUg+Ci+aumsHEhwcCLQCT25AtE
	 Y/zGOz8Z0xln+Y7vxEmpw1q1SwDrLY8OjE8tFCGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 593C1F80524;
	Thu, 29 Oct 2020 08:50:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99768F8020D; Thu, 29 Oct 2020 08:44:56 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8D98F80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 08:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8D98F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Z32XblI1"
Received: by mail-pf1-x442.google.com with SMTP id o129so1663233pfb.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4m44KFmOk0eNak9iaIXUK5dhQnw6EEz9bAOQ7LV+kgQ=;
 b=Z32XblI1UwfpGeY8IGKRoOCREAJBv4Wxmzx/PLQRnyG9iRBWogbO/1HMCzCTfeM0nn
 oOUKxXvcMs67QtS/qOVos3656g5Jru9a1AHxBB7pGVLZsWUcn/TZ0zZZ5Byco4SUgk0h
 vGFKD7MjWb3EH5ezFm9ywERMaTOFjjtZjCTN7NhYZE+RPKUCIMReGzXZZgNxr9CqBKMs
 WLBf3tg31g9bfiem+WrEr8Oy+AcIC95wj21pLn5u0J6QaPk92dPGhyS+JWobMgU7rCsS
 YN5VGPSvTqYgAvGoQZQgHylg7ECE9n9yJh3oNq4tF6RstGsRSVhUQn2FXlbQPw/lUoBk
 DIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4m44KFmOk0eNak9iaIXUK5dhQnw6EEz9bAOQ7LV+kgQ=;
 b=A30zRH1Bg/u0/L6SFrkFq7rvuQ4eyDhakSk/zYbTFeCBuOIREJ458u51CJSnQN00Yb
 5c+CLK+qDZVUVdxnMTdLyfaKJApt2GfrGVn5C0YGTceaFtQO1z2/pItT76XIr9Mcekf4
 h5C5d/FEPQaBMGR8kJaqi4oHl2Y3m1Esv0PYpM6R5EMAvEJDoCExKra8aAouEeC3huRn
 42cggFKnxgk7YJyIEjJxSEyWNdgnAI+aceQufK/ckY+wMoKBbaCDoljp3d4UaNmYRZH9
 8cb+cTMwgPSNPmr/XyghrLA2nqL6NCO7BTo188qyofy7FS3NhyL6miykiAsL3RHGBJTE
 KyZw==
X-Gm-Message-State: AOAM533u3tWF/Vc3t3UOx/PFFJCL9rTSS10oQXcyP1yhoPQlE7EUvlGv
 YeUVPuQ9vmYEYgNvyrHbG4Q=
X-Google-Smtp-Source: ABdhPJxUStiKBOq+y2Ae/MQ+HXEPed/8Ir9KaIDXM7129LlFpnxTXtwP3ZWBQNm6V8CiZ8tUgGLDjA==
X-Received: by 2002:a63:490e:: with SMTP id w14mr2951099pga.275.1603957492230; 
 Thu, 29 Oct 2020 00:44:52 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
 by smtp.gmail.com with ESMTPSA id s11sm1960068pjm.4.2020.10.29.00.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 00:44:51 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 15/25] ASoC: stm32: sai: remove unnecessary CONFIG_PM_SLEEP
Date: Thu, 29 Oct 2020 15:42:51 +0800
Message-Id: <20201029074301.226644-15-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2020 08:49:55 +0100
Cc: "moderated list:STM32 AUDIO ASoC DRIVERS" <alsa-devel@alsa-project.org>,
 Olivier Moysan <olivier.moysan@st.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
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

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/soc/stm/stm32_sai.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 058757c721f0..40c9e554a3d7 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -245,7 +245,6 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	return devm_of_platform_populate(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * When pins are shared by two sai sub instances, pins have to be defined
  * in sai parent node. In this case, pins state is not managed by alsa fw.
@@ -280,7 +279,6 @@ static int stm32_sai_resume(struct device *dev)
 
 	return pinctrl_pm_select_default_state(dev);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops stm32_sai_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(stm32_sai_suspend, stm32_sai_resume)
-- 
2.28.0

