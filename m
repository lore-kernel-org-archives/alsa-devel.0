Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D944C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:15:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EC52051A
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kE6bFIo3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="l4QVEFNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EC52051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 592E21657;
	Wed, 15 Apr 2020 10:14:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 592E21657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586938503;
	bh=vqs4IsI2NE2+xEMaA+05p5j/KLHbFoCS1Gl7mohEWmo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kE6bFIo3tIY4z6v1xvsSaGQ8HoN64BO5AYLg1qoHdpn5hl1wOVAsF30mkPSJ5oRDx
	 Mbo6koEjTypOLEJcQA1Fg0rWsouZNM8kiKZg2S6MmJ4W00aYQ7fwINzYs1ZJPw/xXe
	 +ff6WHXhKBM4n57ycKeExh1FOyHYqUA6FP+ai1vQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48BB1F80266;
	Wed, 15 Apr 2020 10:13:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1F3BF80115; Wed, 15 Apr 2020 10:13:12 +0200 (CEST)
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD5C9F80115
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 10:13:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD5C9F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="l4QVEFNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586938382;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=JxDtJn02UGDLaqiwxhMrK0P0y2GkLVhXtvW50yKCoHI=;
 b=l4QVEFNMlUGcet1lHoC+LiCzkNN0zc5GKN4X/dxkTvnfMrvhe+FNeBMMxAf/t6wLkV
 ja2n/cKG2Y1reAJ3BmLcrH0To6/JpEk67PfDwewnAClnih9jobAv18BPMVAabu9xlm7J
 UxoLohrLmbn3w5+MmpeELiHXgSBa0GUXuui5zPMIxJfVdxF9IeSJ1t3Y+JlhsWkLIsIE
 XVZ3mKzFZWZUWGZC9eO7zhplol+tz+DKQ17hDgh3YqgPeZ9lTVSdY0vaz5l/q2KZfdie
 /9KGo0ltWKXAvhqxhlAQCiqjKGcuEwFGfvhirB7i3QuDB3F7hS4Ny2uZXnZ1I+LW1i8A
 Rxbg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NccuO"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain by smtp.strato.de (RZmta 46.4.0 DYNA|AUTH)
 with ESMTPSA id k074e0w3F8D20Dp
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 15 Apr 2020 10:13:02 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
To: Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/2] dt-bindings: soc: qcom: apr: Use generic node names for
 APR services
Date: Wed, 15 Apr 2020 10:11:59 +0200
Message-Id: <20200415081159.1098-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200415081159.1098-1-stephan@gerhold.net>
References: <20200415081159.1098-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 Andy Gross <agross@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
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

Device nodes should be named according to the class of devices
they belong to. Change the suggested names of the subnodes to
apr-service@<id>, which is already in use in
arch/arm64/boot/dts/qcom/sdm845.dtsi.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/soc/qcom/qcom,apr.txt | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
index f8fa71f5d84b..2e2f6dc351c0 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
@@ -65,30 +65,30 @@ which uses apr as communication between Apps and QDSP.
 		compatible = "qcom,apr-v2";
 		qcom,apr-domain = <APR_DOMAIN_ADSP>;
 
-		q6core@3 {
+		apr-service@3 {
 			compatible = "qcom,q6core";
 			reg = <APR_SVC_ADSP_CORE>;
 		};
 
-		q6afe@4 {
+		apr-service@4 {
 			compatible = "qcom,q6afe";
 			reg = <APR_SVC_AFE>;
 
 			dais {
 				#sound-dai-cells = <1>;
-				hdmi@1 {
-					reg = <1>;
+				dai@1 {
+					reg = <HDMI_RX>;
 				};
 			};
 		};
 
-		q6asm@7 {
+		apr-service@7 {
 			compatible = "qcom,q6asm";
 			reg = <APR_SVC_ASM>;
 			...
 		};
 
-		q6adm@8 {
+		apr-service@8 {
 			compatible = "qcom,q6adm";
 			reg = <APR_SVC_ADM>;
 			...
@@ -106,26 +106,26 @@ have no such dependency.
 		qcom,glink-channels = "apr_audio_svc";
 		qcom,apr-domain = <APR_DOMAIN_ADSP>;
 
-		q6core {
+		apr-service@3 {
 			compatible = "qcom,q6core";
 			reg = <APR_SVC_ADSP_CORE>;
 		};
 
-		q6afe: q6afe {
+		q6afe: apr-service@4 {
 			compatible = "qcom,q6afe";
 			reg = <APR_SVC_AFE>;
 			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
 			...
 		};
 
-		q6asm: q6asm {
+		q6asm: apr-service@7 {
 			compatible = "qcom,q6asm";
 			reg = <APR_SVC_ASM>;
 			qcom,protection-domain = "tms/servreg", "msm/slpi/sensor_pd";
 			...
 		};
 
-		q6adm: q6adm {
+		q6adm: apr-service@8 {
 			compatible = "qcom,q6adm";
 			reg = <APR_SVC_ADM>;
 			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-- 
2.26.1

