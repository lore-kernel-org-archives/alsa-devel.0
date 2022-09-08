Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117C3C38145
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Sep 2022 09:22:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4449516EB;
	Thu,  8 Sep 2022 11:21:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4449516EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662628957;
	bh=7vwWCNfKHjy4BThutFo9CHxrjqK0PKYige6llxYL3GM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HByVB8bbr0FAAH9p2YWZfaK3FEddtlwxj0XS5FwaugyUeMn6lBFKp+i5wa1S7H/Bf
	 IuMS2O6kzC5BmEYPOxxqvsrDnWPWA/wKO5RF3dpkBFLNKn49lqBhKxXWNbo1hoQD4n
	 2gDUznWwdnxSXJ2jJbck4vJCQCsGdhE8hnUtn9EU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59DC2F80564;
	Thu,  8 Sep 2022 11:20:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1D3EF80549; Thu,  8 Sep 2022 11:20:04 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52181F8053A
 for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2022 11:20:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52181F8053A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="s3F6VUZm"
Received: by mail-lf1-x131.google.com with SMTP id k10so12090100lfm.4
 for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2022 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=Om7NL/8n/AZHbaNF9gisHUFy/iTMOZIGCGU/AWMpqjM=;
 b=s3F6VUZmLEJvv6zvjBQg40i1axUWt3+JJdgs4yt/GB6omeW0dE+2w3sgAdqXd8CO4H
 EjhtYwhMtxpU5nTjGD/pAK74KbyuW97PiGSSHgAtkf2C4x0HNDj7ZfqLJ2JnHduQhvuH
 K3xLQoJke+1OWs1BSJIc4yfI275XPt1VnKad40eF9q2mRgRUV+rbvYPwFZbbBhKTX3he
 oQhrQnCyom76zocntvMbIB5usBwoXGfh9ul2ebOGEA0NScUDOZDzVxY1cHqs9FMv+qO3
 CelmNIzegsZklrWL7dBDspWZe+f4MUz+XSuHbRVLBvfVi30PJnb03YAoss4KtgojXYrs
 tqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=Om7NL/8n/AZHbaNF9gisHUFy/iTMOZIGCGU/AWMpqjM=;
 b=gB5R5FX8heP2J2QTeoHWkry9AG2sZd+KofgYWRTpgvuvIyCm4neqZqMtfeztOWrjN/
 S/+Ujp3yNFeWyLOLbkkd7cmCnUU+fqocvUB9AQdOccXixhFZ0uyKsr6RhFkR2WdwYCVH
 IggMYfuG5dnMaLfupUWRRdsZxmA1dPzj9tQmZxNES8RdilqT0leXUGjViOEPV9PtezAH
 l7lxBsENYR9lEL7ektvBtXfT/QYx4M5Pxg34sfWroUeOvVzv5rMsvDFltITQ4+4w//Tf
 pDU0mDN/s8eCh3uHYo5A9f2bLI4yb9wZRns4mdwyqPv80k54yKu9mvPWNahLRUPy7wMu
 Q7rA==
X-Gm-Message-State: ACgBeo0acUVRhPRKuZSPWE0Y3i21004EAiDNjxpADdw7ZNS7kCePvo7I
 DN2LypA0W4Y4zz4+eFLyLQ2Fqw==
X-Google-Smtp-Source: AA6agR739bmADnlz9UMhbMUSLTU5hJ7EkzCnvwRUlCOppWXSP38GZm+/4RN3Rjek/hu6p9Bk449QVQ==
X-Received: by 2002:ac2:4f02:0:b0:495:79c7:f2f4 with SMTP id
 k2-20020ac24f02000000b0049579c7f2f4mr2473093lfr.35.1662628799439; 
 Thu, 08 Sep 2022 02:19:59 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a056512211100b004946a758d21sm218219lfr.161.2022.09.08.02.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Sep 2022 02:19:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/14] arm64: dts: qcom: qrb5165-rb5: align dai node names
 with dtschema
Date: Thu,  8 Sep 2022 11:19:39 +0200
Message-Id: <20220908091946.44800-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
References: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects DAI node names to be "dai":

  qcom/qrb5165-rb5.dtb: dais: 'qi2s@16', 'qi2s@20' do not match any of the regexes: '^dai@[0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index bf8077a1cf9a..d39ca3671477 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -867,7 +867,7 @@ &qupv3_id_2 {
 };
 
 &q6afedai {
-	qi2s@16 {
+	dai@16 {
 		reg = <PRIMARY_MI2S_RX>;
 		qcom,sd-lines = <0 1 2 3>;
 	};
@@ -875,7 +875,7 @@ qi2s@16 {
 
 /* TERT I2S Uses 1 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
-	qi2s@20 {
+	dai@20 {
 		reg = <TERTIARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
-- 
2.34.1

