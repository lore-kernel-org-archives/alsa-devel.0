Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4A7C7EE2F
	for <alsa-devel@archiver.kernel.org>; Thu, 25 May 2023 13:40:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 948A6820;
	Thu, 25 May 2023 15:39:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 948A6820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685022047;
	bh=8t4KIzZIlw9ChbpF1oe4CON4OVHVpP/2/UwMGrIiRKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SmQKwqcdVvBulGqjsRIeGvV+V7ZZP2VU28JDURl8ZkDXksqmrf9//hNCcay7jFuc5
	 Dpe+//qWxUrGWCOQzEtBaMqPWRg6wH6ODgSgySP4zp5yAsuFvCn5fK38geMY9Qonmc
	 4+TtgUHvJZRgO+viPHfzhFpyt/72Dufr2OlvbsFE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7335EF80563; Thu, 25 May 2023 15:39:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 32471F80557;
	Thu, 25 May 2023 15:39:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 264BCF80425; Thu, 25 May 2023 15:39:02 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 051C0F800DF
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2023 15:38:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 051C0F800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X1Hw6Xzq
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30957dd7640so1456889f8f.3
        for <alsa-devel@alsa-project.org>;
 Thu, 25 May 2023 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685021927; x=1687613927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GVjrhO4+wX67tAd5gKWT8UX+KnLSIyA9RaY+rGVUm8=;
        b=X1Hw6XzqT2tCaEFAbBeyu2o+ljfzQPvtuTFskLmVPUAkg/4BkcJV8Zd6VaLsby29Gg
         vMDO16B7GXss94RdI/jUOvLfpkyHTCixhDSG+fvY5UT3CvijIF8j9RqwWAWaHgSzN+Tv
         HON9LXdlJsqIxG7l5Hmuq4m//jDrI++PiFLuHvdsbL5hjsRJ2UceFXWZ+077bluACqAq
         jh/fE4iwx5s5zAeh4bdbuGw15gcnYAeDlvHA4IgUpOz5IgW6EZZF0snzJR0d4MLxIMhx
         Fb7X4++8GSf7phrVGaBFNWP/7tAp8UzF4F5GHbdaGSHjCNGMpatzDStjoDJiVO22qBQ7
         cKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685021927; x=1687613927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GVjrhO4+wX67tAd5gKWT8UX+KnLSIyA9RaY+rGVUm8=;
        b=Q6TsnQzFjsrROFZu+EVGLgTmv2JaCzceITFp9rNXNx1vcnBenoDyVPCFs56CIp3UUE
         uKR4Yqg6ThxbwV18gHzcD5+pKOJjDEZ+kPqb3Kus9P8PWIR02xsLq9qMSVoAKK3f89uz
         sl61kaMuEmByWRKINLIuZQIjEvOSVBYGcFhcFsk/4Cb2CXMFD5SmHCwAV+lVM5D7rlTe
         P5ksCMj3zXfxtac/rM4u+f6RsyNv0oQmCvhi3XhE/TpSfyUVV99X5yg0NaxCzY3V8hGY
         bOlP7hkdUFB8dY0QrPQGEcFJXluZHPgr7gnIrgQfhZEqu4Bd9DI2ayHXz9oSP9Az6Wdi
         /1bg==
X-Gm-Message-State: AC+VfDwefMhQWPy3KJtD/chysfdzV+zCLQHwzlQZG+qEM5Qzl+/+LJMI
	JzYyGY45MTxeVwhQYWdkuAOpMFISSPK/BV/Mo64=
X-Google-Smtp-Source: 
 ACHHUZ6Lu2fKZX/yZXuoFi3bejKut7TLYsvIETK97sRG+Lg3mxkQOniLqXLg/UUGGJm7TtAtx6mDdw==
X-Received: by 2002:a5d:4526:0:b0:306:36ef:2e3b with SMTP id
 j6-20020a5d4526000000b0030636ef2e3bmr2078354wra.70.1685021927652;
        Thu, 25 May 2023 06:38:47 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 z17-20020a5d6551000000b00301a351a8d6sm1803641wrv.84.2023.05.25.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 06:38:47 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Cc: andersson@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	sanyog.r.kale@intel.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/4] soundwire: qcom: update status correctly with mask
Date: Thu, 25 May 2023 14:38:09 +0100
Message-Id: <20230525133812.30841-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SV4GMRINQ5JAAZP2DV7J52MZNOYAUKFP
X-Message-ID-Hash: SV4GMRINQ5JAAZP2DV7J52MZNOYAUKFP
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SV4GMRINQ5JAAZP2DV7J52MZNOYAUKFP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SoundWire device status can be incorrectly updated without
proper mask, fix this by adding a mask before updating the status.

Fixes: c7d49c76d1d5 ("soundwire: qcom: add support to new interrupts")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index aad5942e5980..9440787e924b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -515,7 +515,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
 		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
 
 		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
-			ctrl->status[dev_num] = status;
+			ctrl->status[dev_num] = status & SWRM_MCP_SLV_STATUS_MASK;
 			return dev_num;
 		}
 	}
-- 
2.21.0

