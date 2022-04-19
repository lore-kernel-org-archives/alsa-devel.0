Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54620C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Apr 2022 11:56:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C0CE181D;
	Tue, 19 Apr 2022 13:55:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C0CE181D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650369358;
	bh=NiRqID2KbLl6kxegULZqRjH2szoblFzNFB5sgXlMMuQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TDpoSIrtsyICAQ11pycPZd0wkKsiahz/Zzc3nx+sNWW+HqfRkUjlGEX54dfIdrwyH
	 k3mEJwnV7SQ4eQ5gdJfvzLwyK3ARNnv8Utz9fQCsFhLpX8B3sMbnIJlui+1MiTYvfz
	 nY6Euu9HGjXSXYeG6nVhRWCRe3e0x1lks4VpJbis=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65F1EF80543;
	Tue, 19 Apr 2022 13:52:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8BFEF80237; Tue, 19 Apr 2022 13:37:48 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 767E3F8025D
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2022 13:37:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 767E3F8025D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="RWYzHRgQ"
Received: by mail-wr1-x434.google.com with SMTP id bv16so4890518wrb.9
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2022 04:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ngAHAx8KCTZqbA/wVhf/k9wvjiY7TwrBlQ520mj9F/4=;
 b=RWYzHRgQvZfHJo2jU1/3xQvDpndr9fLc4vmm+s1BwCsaTM5fkpaOaFXDbaldi6SvJV
 OQWvGg085wQjB0YR8W9rXIn++WOJDihmIhludfuVC25fVHl4WZLrQMmRE10yStrUegQY
 /enNo/GFtSEPSfKrqANfzwD0khRqSpjFmtS8fI77A5NvGC0u9cybPuf90RsD+vxxUKLI
 dT3nLJ18prverfHSkK7wItLWuLXzdfX47uNvJ1dpn/qTlVXbNr2+eTz2NhNlrR2dYppq
 NSU7laxJFuiA97AiDk8lC4ffozjk9OxzRlUHIGG+arVHYDbySWGBzrOEfcBLSTWiBaeO
 SKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ngAHAx8KCTZqbA/wVhf/k9wvjiY7TwrBlQ520mj9F/4=;
 b=CzCiXmWHJG6NIKRscaagrZzTzNleLTTl5CgtIkmRo5D8aQcNz4ZOE02ni948M8bsqG
 oS7FSpNzaSRWShKBzPkLcgzszQcOXm0BEjCpl2Ni616kwTVdvYu3/xE/MbS+xWQhqdO/
 AZ/PF0IBB0JQPVgcgNcwZ8m20usKkfJm8UmhHZhbpoVp7WZL1xSXuVD95KHeK4sW9HI7
 VOL253jkd0A9o9tkqOpEe8BW0anvWU+dB+IzPewTif4iQ3sj4yC31YN1RWVliKrasLxj
 72on0XWLWQpNo2d0LEf3DP9miH+Hbn8ou1cMBx++VKl9DPWsEABzUpHywytHuqo/Sqo7
 TV7A==
X-Gm-Message-State: AOAM533lZtXwUZ5QdADiXZEDOj6OBuZobXUxLW9auc+KzsGo3KvOQQe3
 hNe2ZMTTUEu6/3DnDzjYOiQd1w==
X-Google-Smtp-Source: ABdhPJzYlHv5jsgVw0JJzX41AWoasKG2ZwaufFSf+pYOjoDA/UaEVrv0D3EgneefbiktzNCqamSPyg==
X-Received: by 2002:adf:e48c:0:b0:20a:7e29:e16d with SMTP id
 i12-20020adfe48c000000b0020a7e29e16dmr11628539wrm.595.1650368258616; 
 Tue, 19 Apr 2022 04:37:38 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie.
 [188.141.3.169]) by smtp.gmail.com with ESMTPSA id
 bk1-20020a0560001d8100b002061d6bdfd0sm14202120wrb.63.2022.04.19.04.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 04:37:38 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: srinivas.kandagatla@linaro.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: Fix apq8016 compat string to match
 yaml
Date: Tue, 19 Apr 2022 12:37:34 +0100
Message-Id: <20220419113734.3138095-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419113734.3138095-1-bryan.odonoghue@linaro.org>
References: <20220419113734.3138095-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 Apr 2022 13:52:22 +0200
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

The documented yaml compat string for the apq8016 is
"qcom,apq8016-lpass-cpu" not "qcom,lpass-cpu-apq8016". Looking at the other
lpass compat strings the general form is "qcom,socnum-lpass-cpu".

We need to fix both the driver and dts to match.

Fixes: 3761a3618f55 ("arm64: dts: qcom: add lpass node")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e34963505e07..452cdfbf8ef9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1392,7 +1392,7 @@ sound: sound@7702000 {
 
 		lpass: audio-controller@7708000 {
 			status = "disabled";
-			compatible = "qcom,lpass-cpu-apq8016";
+			compatible = "qcom,apq8016-lpass-cpu";
 
 			/*
 			 * Note: Unlike the name would suggest, the SEC_I2S_CLK
-- 
2.35.1

