Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F161C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Apr 2022 22:04:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B45C0AE9;
	Sat, 30 Apr 2022 00:03:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B45C0AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651269888;
	bh=HrmksGOAMfGQwizNpLXeKjbZUIiJWAwnsGk4TOnjp2U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QwztSLmuF+k2owUfnqC2je7BYD/n8pF/q7vfjgnFv8SJl7tg6rhsji6FKvt7I1rz4
	 pTBkbwFkOoNCKHrifqdmnnzBnzIWaNI6ty2FzitzhUwu+JYz/hvZ4QFrdkD57ZJ0gY
	 A0YYF0GgWnzArqX9qE9gJo/aHvetaZRl+kOqE2O4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3058EF80269;
	Sat, 30 Apr 2022 00:03:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADC80F8012B; Sat, 30 Apr 2022 00:03:56 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04E6DF8012B
 for <alsa-devel@alsa-project.org>; Sat, 30 Apr 2022 00:03:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04E6DF8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="n4+px7AC"
Received: by mail-wr1-x435.google.com with SMTP id e24so12383055wrc.9
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2022 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WlKreU/40nqHXZVuM04jB73cOMdB6bCilZH4/EUmsSc=;
 b=n4+px7ACcUlP0Wfx+T6iHCxr1Vc86umHuGfMRGQrobKs8oP6qIIMABXE2sci6KtQ5x
 P2XMRlvR4DTb0ZYnKuKWVtmdZWlCrXoOi47WkyNeciToZnJMCb4JT1S4KrYGGShYBAlg
 GaeJKPYNUtrL3Dk+aCvys5N5viggYDwCRqxGdjnFYL+FS1XwfSqRAV0Njc5UCyb+b0Rv
 dd3kxk3swMQApOibnAll/ohTcRjlHRFrAa9GWYf+l1OO564yPZVCK58VCesMngbZRJcJ
 oFctmt7CezIieGMBj5WlyW9f7T1z6gNxEi41JqYWMbxx2xL+qEzvncQ1dDOBmHDL2kjj
 ME/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WlKreU/40nqHXZVuM04jB73cOMdB6bCilZH4/EUmsSc=;
 b=dIxA/JIVN4z5ugB/iZYjQja5dCgKvKJ/CU4OZ1Qm2hSh26d/bMdqbHfvHo90IR0dxa
 IFoaHshnlFVnr9DDIDUnEK69dc0D6/T7My7HrD+69X7V7d/KE6nVrj/wtjhl5NkezUb3
 kGrZDEGZ+eNjCwjhRD6ECYVObYbBH8PM2LdC0lZ+cVCMKBnEHMYcfhfyt6zNtYoj6UYs
 tKhhy3SEREV0LYd4j6MUuh1/0XXr6l2Aw5kLqX5bmLXzeQ23n0x/FHJA76WPZBgs/gYx
 274QBcZ2fk3XmJz2D1HWyi61hwcfF9jD2huCPObVwLIAr+77cVklhjiSqJ9p59ngMMWJ
 k5tA==
X-Gm-Message-State: AOAM532cqEhTLQIss7R46kNYJDPl8LGAJuJpIOO7JYSgViJID+xoGnsR
 wNi+b19c/SrfCl8CcKlBmcmVng==
X-Google-Smtp-Source: ABdhPJza79uXwOTQLJWxXmqcwnPj+Fq2RYfShAd+r4351XRF8jTdg3JbbWq8/PrrhDZGryRtqmMKQw==
X-Received: by 2002:a5d:4702:0:b0:206:b8d:3dce with SMTP id
 y2-20020a5d4702000000b002060b8d3dcemr866064wrq.646.1651269832079; 
 Fri, 29 Apr 2022 15:03:52 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie.
 [188.141.3.169]) by smtp.gmail.com with ESMTPSA id
 k15-20020adfc70f000000b0020c5253d90dsm338311wrg.89.2022.04.29.15.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 15:03:51 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: srinivas.kandagatla@linaro.org, bjorn.andersson@linaro.org,
 robh+dt@kernel.org, krzk+dt@kernel.org
Subject: [PATCH v3 0/2] Fix apq8016 compat string
Date: Fri, 29 Apr 2022 23:03:47 +0100
Message-Id: <20220429220349.1142759-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 bryan.odonoghue@linaro.org, devicetree@vger.kernel.org
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

V3:
- Marks qcom,lpass-cpu-apq8016 as deprecated instead of removing - Bjorn

V2:
- Adds Reviewed-by: - Srini
- Adds Fixes - Srini

V1:
Reusing the apq8016 on msm8939 I found running checkpatch that the compat
string for the LPASS was throwing a warning.

This is easily fixed by alinging the YAML, DTS and driver to the documented
compat string

-			compatible = "qcom,lpass-cpu-apq8016";
+			compatible = "qcom,apq8016-lpass-cpu";


Bryan O'Donoghue (2):
  ASoC: qcom: lpass: Fix apq8016 compat string to match yaml
  arm64: dts: qcom: Fix apq8016 compat string to match yaml

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 sound/soc/qcom/lpass-apq8016.c        | 1 +
 sound/soc/qcom/lpass-cpu.c            | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.35.1

