Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02305ECAAD3
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Sep 2022 10:24:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3604D15C3;
	Wed,  7 Sep 2022 12:23:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3604D15C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662546256;
	bh=FHSdzLsqDAJ3+7Y2IFsLy4ODMvPvr/SzOE6kS1hg0rM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oCpAPnHtXvzQDFI25L/0MOVlJvy1nBiqeA+CqaRh2yORDGjwNgZfMCm9B+pK0nQ7R
	 5xqS1uvkUBjQHjTGqObm8hTTmJBOI4+jQnYdUSzQLVb65lemuoupnnckMzoatAb8QZ
	 um21tWFLRS9MmOaLf8rDjVfWKEx6uw9+Vc48SbWI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC07AF80249;
	Wed,  7 Sep 2022 12:23:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74EFAF8028D; Wed,  7 Sep 2022 12:23:24 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 662BAF80249
 for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2022 12:23:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 662BAF80249
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="YKseDWEu"
Received: by mail-lf1-x12d.google.com with SMTP id x14so6325353lfu.10
 for <alsa-devel@alsa-project.org>; Wed, 07 Sep 2022 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=DUZnAOXvnpwBSyYKpy7XC2+oubbqgditxTlrj9yISaE=;
 b=YKseDWEuQrei+DMXjAdhXWNkjPj/XhJlvCb3QGZ5L61lPym0S4hmAc/ek+LGwrpF6J
 TnQbf3UkUJUROG2eAEV0vphFJ3aIrx/O9wflRYVSJznxfGR4aznKVL6SoTRo7/IhPsUD
 s2+KzzSc5z/ivHykL5YgjKqTiVIQCteNe0H0j3odZoYhn0eft/dqcuGyQFikq1+h9Lq8
 X1iuaHT48VeuDWI2i0OvG2AypADRYKtAw3eWxTD5lBxUU8wp0fWvWEnMql8mAuC6YeHd
 41/6ZmqShTypXD+MP7XsD8swHbFbLal1AotIaRThcfR3zoCJzJTw5G13iBJK5gHMc9j8
 UCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=DUZnAOXvnpwBSyYKpy7XC2+oubbqgditxTlrj9yISaE=;
 b=DqxQwJ7x2EGB31Kfy61+NrjD6OxECxVxbbf2Pbllp7BHITwdeQj/g38Vi4e8A/zPNS
 cosIrjzsC248SQTod8KI7k8eCn7eRe6MRD9f2cBLLpw1oKhwFu/NyRZKXCJ63Cd1Htkh
 meemgv39HlCX6jdUkEDekUcLIAzO6ldAbn9pIWDKYwBgYLfAPysVMF39lndATIuimCEI
 wZOs3kFBuJFaSf0grve04YhbVTwVxNc785vUsNEQ6BgsEM3RhFKnEAkyu0Vni8oRtlT9
 kwxTGpoD2Da2tx+t9weqxXDTtULXxokweVk5HzMKmZjHn0he+aCLALNCH28f4LvOJcCB
 ZeQQ==
X-Gm-Message-State: ACgBeo0gBaulXMesgn2mLgAIhUEzLYKRA4shCeSLll6xEYT/f8FSMy5y
 8iG+eiE7XgRyEZlsiNgl3UI8MQ==
X-Google-Smtp-Source: AA6agR6tbubvvq8/DfaCTr0+Pf575TvwyTL1PYEUWtKKonjTxXHultN785WWU5YW7mRViESeUxF52A==
X-Received: by 2002:a05:6512:3f0a:b0:492:da2e:ce69 with SMTP id
 y10-20020a0565123f0a00b00492da2ece69mr817185lfa.269.1662546196496; 
 Wed, 07 Sep 2022 03:23:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a0565120b1600b004946d1f3cc4sm2378309lfu.164.2022.09.07.03.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 03:23:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: MAINTAINERS: add bindings and APR to Qualcomm Audio
 entry
Date: Wed,  7 Sep 2022 12:23:11 +0200
Message-Id: <20220907102311.38428-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Extend the Qualcomm Audio maintainer entry to include sound related
bindings and the Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
IPC driver, which is tightly related to the Audio DSP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0350effebe8f..453dc6fd0b80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16710,6 +16710,9 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+F:	Documentation/devicetree/bindings/sound/qcom,*
+F:	drivers/soc/qcom/apr.c
 F:	include/dt-bindings/sound/qcom,wcd9335.h
 F:	sound/soc/codecs/lpass-rx-macro.*
 F:	sound/soc/codecs/lpass-tx-macro.*
-- 
2.34.1

