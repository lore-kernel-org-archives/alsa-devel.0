Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6D2C761A6
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Apr 2023 13:28:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DBC182A;
	Mon,  3 Apr 2023 15:27:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DBC182A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680528512;
	bh=Iwjy17kg1P0i5i4AbZWulGFs1IIbNqfPDxXfBkZ2OPQ=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=H/5dwblVhvutDAUGk85YVvPh/Rw6Eb8VwadAcZ8dejnndcHIxlMWMYP3Yiww2Vv6f
	 H7THgYeaTcpC+aS2RA2eRLbWVztG9b596QUO6rB0+Ofy0Y1teVfEPEKBsLscothGQY
	 MUKFxXSPc6mPn4Or4lCvfjKj2tg91VGhmFcC1qVw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD343F8057E;
	Mon,  3 Apr 2023 15:26:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17D44F8026D; Mon,  3 Apr 2023 15:26:00 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 292C3F80495
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2023 15:25:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 292C3F80495
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Nr3g+Hbl
Received: by mail-ed1-x52c.google.com with SMTP id h8so117331400ede.8
        for <alsa-devel@alsa-project.org>;
 Mon, 03 Apr 2023 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680528315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weKVU1kTnYmV8Kz2hO3iwF9H+hKHLTD9FkkPqYTBdb4=;
        b=Nr3g+Hbl9L+w1ge2cQP835ENaUyoy3GnzYz3FXpww7GCn4U/JCBEF21ElDfb3y4+zw
         hi1mf3tfYM+l2M2IpoJwtOg09JjGLoj5NZJjpyzIalK02GcJSePgcGzl++cFH6Vknsvu
         3ZRqtxNYkovZVJ6+F5EbrdkHkxzREnDGxpdGBhzeexv+OwhW8rBJbh+MMcpSoUo/oUHt
         +fKjFbEO8uFyxXqd11LTqio2VmwruzhoZXvZnTHG+Wiq3lX/3q+/GK93LBKvZ00nINbb
         3nd6ogV80OnDN916s9frwHl8pJzQdoQqOy4+SAJ5p7AtT7eXFMG1E9tTdLt1VHB3MkNN
         yh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680528315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weKVU1kTnYmV8Kz2hO3iwF9H+hKHLTD9FkkPqYTBdb4=;
        b=X5rQCPRSMKlq89uFPVCYoNpytI/disqVVBl6BkpwQ9btjMHvHMiO7HkyleLHJJLJSD
         wEEO9WepUs4ITR0CPbcwaeEJn1h+QzvawDprmf0G6K/sMS0JsK8Wt2ENl1Ic440FfAqx
         w6UFn3nAWdUFu4dDameEJqvQxnasIkwAK+A7ip05MoTgKN/fTUsavK/p1GaaWrkwnMQE
         KBmdAf5NbxlhkKPF+icmdR1nVYsjjrZ7hkeybghWpOuA8Gf8j8t2aZRvGgXjH9SiwwIL
         qy4KcbSMHKaj9oNgbJRZU3LxRqfpFZZ7hx4y/bQJBv7X1ARVW72MezSP2Rj0CZEx2sTe
         Zqrw==
X-Gm-Message-State: AAQBX9dx1t4AdZmRWN7yZomk1son8940VOT0yxtX2DA5KBha64yJicXC
	Xt816YpltwZ3hh5hYLwo9z1H/w==
X-Google-Smtp-Source: 
 AKy350YWrarnG+pOFyqN5H8GPs94VDiB0504oYYt4205v8N6P8ovj34ASsNOxyFu/AbLwsjVAIXL0A==
X-Received: by 2002:a17:906:81d5:b0:93d:ae74:fa9e with SMTP id
 e21-20020a17090681d500b0093dae74fa9emr34019824ejx.7.1680528314726;
        Mon, 03 Apr 2023 06:25:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id
 p18-20020a170906229200b00930ba362216sm4658489eja.176.2023.04.03.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:25:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rao Mandadapu <quic_srivasam@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH v2 7/7] soundwire: qcom: use tabs for indentation in defines
Date: Mon,  3 Apr 2023 15:25:03 +0200
Message-Id: <20230403132503.62090-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3DE3OVXZT4772XAFV6TVWWSFLRNOZYJJ
X-Message-ID-Hash: 3DE3OVXZT4772XAFV6TVWWSFLRNOZYJJ
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Patrick Lai <quic_plai@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3DE3OVXZT4772XAFV6TVWWSFLRNOZYJJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use consistently only tabs to indent the value in defines.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index f2e1135ef113..77a5e4cbbe9b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -58,9 +58,9 @@
 #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
 #define SWRM_INTERRUPT_STATUS_AUTO_ENUM_FAILED			BIT(11)
 #define SWRM_INTERRUPT_STATUS_AUTO_ENUM_TABLE_IS_FULL		BIT(12)
-#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2             BIT(13)
-#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2              BIT(14)
-#define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP               BIT(16)
+#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2		BIT(13)
+#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2		BIT(14)
+#define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP		BIT(16)
 #define SWRM_INTERRUPT_MAX					17
 #define SWRM_V1_3_INTERRUPT_MASK_ADDR				0x204
 #define SWRM_V1_3_INTERRUPT_CLEAR				0x208
@@ -125,20 +125,20 @@
 #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
 			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
 
-#define MAX_FREQ_NUM		1
-#define TIMEOUT_MS		100
-#define QCOM_SWRM_MAX_RD_LEN	0x1
-#define QCOM_SDW_MAX_PORTS	14
-#define DEFAULT_CLK_FREQ	9600000
-#define SWRM_MAX_DAIS		0xF
-#define SWR_INVALID_PARAM 0xFF
-#define SWR_HSTOP_MAX_VAL 0xF
-#define SWR_HSTART_MIN_VAL 0x0
-#define SWR_BROADCAST_CMD_ID    0x0F
-#define SWR_MAX_CMD_ID	14
-#define MAX_FIFO_RD_RETRY 3
-#define SWR_OVERFLOW_RETRY_COUNT 30
-#define SWRM_LINK_STATUS_RETRY_CNT 100
+#define MAX_FREQ_NUM						1
+#define TIMEOUT_MS						100
+#define QCOM_SWRM_MAX_RD_LEN					0x1
+#define QCOM_SDW_MAX_PORTS					14
+#define DEFAULT_CLK_FREQ					9600000
+#define SWRM_MAX_DAIS						0xF
+#define SWR_INVALID_PARAM					0xFF
+#define SWR_HSTOP_MAX_VAL					0xF
+#define SWR_HSTART_MIN_VAL					0x0
+#define SWR_BROADCAST_CMD_ID					0x0F
+#define SWR_MAX_CMD_ID						14
+#define MAX_FIFO_RD_RETRY					3
+#define SWR_OVERFLOW_RETRY_COUNT				30
+#define SWRM_LINK_STATUS_RETRY_CNT				100
 
 enum {
 	MASTER_ID_WSA = 1,
-- 
2.34.1

