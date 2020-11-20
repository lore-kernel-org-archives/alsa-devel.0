Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0F4C5519F
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 12:39:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB6722227
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 12:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WMmNlDxY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rESZQpuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB6722227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A441169A;
	Fri, 20 Nov 2020 13:38:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A441169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605875969;
	bh=fMPLeFwCduQ0uaLu+A4IQqR739owS1/Il0iRZAG3z3s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WMmNlDxYhUMoTSRqvha+owN5TrCIpI8wF+9RWMkdnZIuZrB3uangKoYTQGY2WlPBp
	 euUsruZI1xT7luTObN6LiAybZ+jm4HGTe7l+gxLNXWy7pqWgV8c9L1HwuE9fLjeaG1
	 +pPcjLwnnfdGBoYvNZ3zwQfTQb/m1nNveDJK8LOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0673F80168;
	Fri, 20 Nov 2020 13:38:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1AB6AF8016C; Fri, 20 Nov 2020 13:38:37 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2DF4F800F3
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 13:38:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2DF4F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="rESZQpuG"
Received: by mail-wm1-x341.google.com with SMTP id 10so10227176wml.2
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vEmyo3JSr762eH2n2pzrxXah58hd/mU1Bud5fRydKiM=;
 b=rESZQpuGcSrvt2ffCEv2QJy7xTi6ru4+XCkp9AK66faCuMcAB0uWtMyQsTBj5QKy6w
 h/sIJUyvuqpki28CLToer7fI3ySDItHpEqavDnyavzZcAtlG5YxAAzNx7Jbys9TtcHoy
 OIYqZBwS4VThCbKwQXBjZ5MSw0B90BCLJcQ4J20yAuS1rweGL5M16153v90tmSWMPUK5
 xDB1sXMScwaJ2D2I4g97+MzmpUu6GXly5Ln6HE+RKzcZceqi3/mEPp6Xjux8doAyGJrM
 W9rZfUKprlRS1O76qCcuTqOU+cITrZZblOYLYFcxAYoDYCyUgcKx19tEOZCuqOwwEtLs
 8wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vEmyo3JSr762eH2n2pzrxXah58hd/mU1Bud5fRydKiM=;
 b=HsS0LJgTD+h0kOwj0qp5/oToUo2WoQm+Qc9WIIIW6iCRh+1eWgzC1Wnmc8fOWog+pG
 a4CW78kXTUYptPvntIZ+sQl6I/DgY0Tx7vNv8A/eEelUfwf7WuLpGoCrgx44LPEslToP
 YDZYl7Dmy6jxuO9laC1nHbla/pGZwLFFP3i/Ge7rC/dwmS0ihNoDmEvAjjvcQXCORmIL
 ldz7TeRh7wvg38uYmGn4HevWGwgIZGBEdv+plYKemMBqTWBzkd63tAW9hSppZcJslNLl
 G1ya+hcskl+yWujCjn4QKhca52lfxJMiCZ55iujE4hjwzTlfiMX8Jn4MwzhftEO5K4Xm
 tLGg==
X-Gm-Message-State: AOAM5312hOEFVHkG1yoN18iM31fsyKhSEJ82ojPbrw5xpTeRKLSe1U52
 Km4exvrLuZhZT4qDLdJ5KjFvQw==
X-Google-Smtp-Source: ABdhPJxpTQmnN+5QlUL4e6UoM96c5XQtVIYgBjOBJCzFei03yqOLNhBudG8PwUNYtSxsGDyFGqhWFQ==
X-Received: by 2002:a05:600c:2601:: with SMTP id
 h1mr5652661wma.35.1605875903730; 
 Fri, 20 Nov 2020 04:38:23 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id m7sm2717566wmc.22.2020.11.20.04.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2020 04:38:22 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH] ASoC: codecs: lpass-va-macro: add missing MODULE_DEVICE_TABLE
Date: Fri, 20 Nov 2020 12:38:13 +0000
Message-Id: <20201120123813.14059-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com
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

Fix module loading due by adding missing MODULE_DEVICE_TABLE.

Fixes: 908e6b1df26e ("ASoC: codecs: lpass-va-macro: Add support to VA Macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index b604de07e650..3e6bbef26dcb 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1487,6 +1487,7 @@ static const struct of_device_id va_macro_dt_match[] = {
 	{ .compatible = "qcom,sm8250-lpass-va-macro" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, va_macro_dt_match);
 
 static struct platform_driver va_macro_driver = {
 	.driver = {
-- 
2.21.0

