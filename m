Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C555FECAAA1
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Aug 2022 12:15:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10A2516B9;
	Tue, 30 Aug 2022 14:15:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10A2516B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661861757;
	bh=YYLd+Cs5QGsDz06izEnWlCQeTzLKAW79M6x7JsZt02s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fmjbvgitCqFV6SsVCUeq9UioINpi6L+zdW5yHx/lSlqw0FGkc0h9UG42dDAc843qK
	 ZyuOV2rfM1fnwukiNUCvL9954jiV7qbiI2H0VUP/mZdnW4a/BO+5e3yXb7gOe/GTDe
	 DLFn+XmK6xgNXKoI5VTqR/o7gasM1+EsRoRtqCVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AB34F8052F;
	Tue, 30 Aug 2022 14:14:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7BCB8F804C2; Tue, 30 Aug 2022 14:14:17 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18880F8023A
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2022 14:14:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18880F8023A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="gvk48BAu"
Received: by mail-lf1-x134.google.com with SMTP id m2so11477216lfp.11
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2022 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=tV1opztXSWwn25vhDNpyv3M9Wuq0qcdEHDEQPaQUNQU=;
 b=gvk48BAuaZbx67DTS/zy27STTJa1CiM72il9+U1fi55xMqIncbK4p4JrASXirY19eg
 N/Gm1b8vrMghy3M9CEGIpeZIdjeII0fITiDQIxHegJ6adLTJalEcXIwEz1ep0Lzyj8Bt
 EhhlDX+Wf8lThwNTjR72qy07Yf+b/MG+At8XKN36V4NbIK++56lSnWgPr4p6b/xKWhP0
 /atTQucHFtYyAKtZI3Vj3+vQeo2DQX/pSfKqrAUpYbByhkPYZnbTQlqUBNBxPUI0duks
 Mx2ElAbBpcsJ/wwnP9ktoyd2ogCeIe6TStsJpZhyxipvUgQIie/tl7pJZzcdLM5IBbnZ
 oDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=tV1opztXSWwn25vhDNpyv3M9Wuq0qcdEHDEQPaQUNQU=;
 b=p/FF7UvyAue0JEbqT+v8s5JBjIWypS1/VEYNstQuFcIQQAvCvl1viqapJ2Q+kUywMS
 5wpHjFh++2zEhErCOSiWgdUKJZYAiXHEkLhTWtCNEkFB0e4XcEsPqiPSTGvo2QemyyCg
 9fHld3OfRazyKIXmXqXlVt6OPUKDmHv/yekp6Z8euL8nff4wW41PJWMyeFNUYcMtUwMK
 XkRHotBUB2kKZiYCbV7AMdQ7/VbCr67ia7U80KJyHHAFSgEseoHRCdvep/nnwdNIbsPQ
 8eeAL38Fb557HMN7vftoMQcmfBGzw2DcvSTNyZvJqvSAGzvNB9cojs8ilvRbGbEWqcbq
 PWpA==
X-Gm-Message-State: ACgBeo3zg0je4D1EMgLsJXmODuM4r57ZHezL/lkeHbjmuEU+6HmnzhFg
 wbmC7iAnAWQEePefZ/w4ypxarA==
X-Google-Smtp-Source: AA6agR4WYnjWeLAeGRO6Z3iE3KEFyNKY3aDbcTKotgzRbCAOOWTHqUA6Ic12LhVaqAs8aXNrydO8cg==
X-Received: by 2002:ac2:4c48:0:b0:494:6dc8:3a91 with SMTP id
 o8-20020ac24c48000000b004946dc83a91mr2388200lfk.280.1661861646093; 
 Tue, 30 Aug 2022 05:14:06 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a2e984e000000b0025e57b40009sm1742436ljj.89.2022.08.30.05.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Aug 2022 05:14:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] slimbus: qcom-ngd: simplify error paths with dev_err_probe
Date: Tue, 30 Aug 2022 15:13:59 +0300
Message-Id: <20220830121359.634344-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830121359.634344-1-krzysztof.kozlowski@linaro.org>
References: <20220830121359.634344-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Use dev_err_probe to skip printing of deferred probe errors and to
simplify error paths.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index bacc6af1d51e..cec11aa106bf 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1543,10 +1543,8 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
 			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
-	if (ret) {
-		dev_err(&pdev->dev, "request IRQ failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "request IRQ failed\n");
 
 	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
 	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
@@ -1575,15 +1573,14 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
 	if (IS_ERR(ctrl->pdr)) {
-		dev_err(dev, "Failed to init PDR handle\n");
-		ret = PTR_ERR(ctrl->pdr);
+		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
+				    "Failed to init PDR handle\n");
 		goto err_pdr_alloc;
 	}
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
-		ret = PTR_ERR(pds);
-		dev_err(dev, "pdr add lookup failed: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
 		goto err_pdr_lookup;
 	}
 
-- 
2.34.1

