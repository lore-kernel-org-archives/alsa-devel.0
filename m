Return-Path: <SRS0=0Rat=K2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D980C47080
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 14:37:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C19F611CB
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 14:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C19F611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08796847;
	Mon, 31 May 2021 16:36:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08796847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622471838;
	bh=7pP0uNIs+qAt9GWoFndY1JcwooSb663giI0fGIhcrnc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vYFq6RrKBMCqqiV5OvqfOH4CabbcNODf1vIkxnH1uvZo5a/BM2TaizFfkr3wVinCu
	 Wi3C0UKitrURTj/eTuxrDNjTf5yooJGnn3uEYVJCJz0bdlLgzgMAoqEaElLMI6HG//
	 616h17g2Ia/zYuB9+U3DRcQ+chP4scMyMiFEhfaw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79072F80273;
	Mon, 31 May 2021 16:36:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90F60F802E2; Mon, 31 May 2021 16:36:24 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60759F80088
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 16:36:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60759F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="GDoDjavg"
Received: by mail-pj1-x102e.google.com with SMTP id ot16so6710072pjb.3
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TvjojEYkUcciFGjoK9PExTv10PVSKxQplxp1sRiaIpI=;
 b=GDoDjavg9WSUFrStI/x6zQaKFfLe1Uvdwa5cASUXP4s7OJeyQZr2HQ6GFpvCGHSoFm
 2sy14JP+rK8li50dKlW78CtrFVFRhsKjOJjbkP/kfSFnFe0P+Kjukg1PyFriTmiECNaw
 90wQ6HotjoUquPiLEr5bHy+mJQx0juqP0kbD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TvjojEYkUcciFGjoK9PExTv10PVSKxQplxp1sRiaIpI=;
 b=SQx6GTq0kOX/vVf148KW7dZGbFAakjJRAecxWyK96uvZmImmuchtnOy0Gxtt2Wlwcl
 WMNqVMyCEue82Aou/jslrr3kyTiajLytKIUsqR8Q5AwqYHOpdqdmFk9gvkn5EZyG8B1i
 ZwqdUlSB374vfaGQzkjb7Stsw+ltHNuYK8IIdkkp9SOjGOeej1AowWnCpHLkO0B1XAdq
 R179yJ6WrNP1ZBDAdrLgZhTLBSXRMTrAK7OAxTTvOyuB4cfjOGk9eHApotJulJL9Lwu4
 plVSlxAYn6uNaJuxUraWIAlHGmQUX0Ed6byIeZlwz05E8SpVP6qBUQJZV1h4hQrr0zzN
 4Gsw==
X-Gm-Message-State: AOAM532VbETr6xAxHZPCfd2IikXAUW8fZm55w7ymvo9sCUh2lHEeCEH2
 915ThXOCaEM3tjUFnfTmLT+mlQ==
X-Google-Smtp-Source: ABdhPJynM/jfg1vpJVL0xht4RCkyvJQ0dUIDAdwAvZEuU2SZChGp5iLKAsrha1qhoK4RQMdFt2WprA==
X-Received: by 2002:a17:90a:8e82:: with SMTP id
 f2mr20123792pjo.157.1622471768974; 
 Mon, 31 May 2021 07:36:08 -0700 (PDT)
Received: from judyhsiao-p920.tpe.corp.google.com
 ([2401:fa00:1:10:ee09:a901:df78:da19])
 by smtp.gmail.com with ESMTPSA id w123sm11072498pfb.109.2021.05.31.07.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 May 2021 07:36:08 -0700 (PDT)
From: Judy Hsiao <judyhsiao@chromium.org>
To: broonie@kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: add lable for secondary mi2s
Date: Mon, 31 May 2021 22:35:57 +0800
Message-Id: <20210531143557.3975917-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Taniya Das <tdas@codeaurora.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>, Patrick Lai <plai@codeaurora.org>,
 Andy Gross <agross@kernel.org>, dgreid@chromium.org,
 devicetree@vger.kernel.org, judyhsiao@google.com, tzungbi@chromium.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 swboyd@chromium.org, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
 cychiang@google.com, Takashi Iwai <tiwai@suse.com>,
 Judy Hsiao <judyhsiao@chromium.org>
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

Adds lable for secondary mi2s to allow overriding.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 24d293ef56d7..2027914a0bed 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -772,7 +772,7 @@ mi2s@0 {
 		qcom,capture-sd-lines = <0>;
 	};
 
-	mi2s@1 {
+	secondary_mi2s: mi2s@1 {
 		reg = <MI2S_SECONDARY>;
 		qcom,playback-sd-lines = <0>;
 	};
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

