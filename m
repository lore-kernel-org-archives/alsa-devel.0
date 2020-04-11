Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5163C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:48:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBBD2074D
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iO65M5oQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MFiiv7x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBBD2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FC6D1696;
	Tue, 14 Apr 2020 09:48:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FC6D1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586850535;
	bh=+4hsKxtTfGGuoBZKHyH71tYIlzafr/KQZR/SCmrDRYU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iO65M5oQp8jRsSwafV0QouakIAnODBc+vWwftnCMOP2jUnkb8gV6ZNxFgG1GXhqbU
	 lV1f51KtvDqTPoIiXKwlpdcFRHqToM5bFu/wBQcwqLCfuWYBDKpuqPelv8abaTkvow
	 gwbb4QIwQUp2doIoIaXhdnPsdii7kj8sGqqWOq8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFB36F802E2;
	Tue, 14 Apr 2020 09:42:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E8C4F80216; Sat, 11 Apr 2020 10:04:30 +0200 (CEST)
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A13BCF800CB
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2020 10:04:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A13BCF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="MFiiv7x5"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1586592268; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=nn24KJxCv5CBH4kdVxNd2V5W0FeWkwt+MwdO1L8CEGs=;
 b=MFiiv7x5XY9ysb/XhktXocRsy4L7tW+dCRXPaObzgLtLvshyHcQrHUZlcgIDNyDPGV3cX81p
 Gu8hGmtSNT4uSeiYMvnIXS4dgOT3k4JHPTgdDd7GjvvYg1faOBLdb9D6wnE2P90l4XwgAhET
 AB2DplJd+2YDqggGreFsR0wMi6k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e917a0a.7f930d4eb420-smtp-out-n04;
 Sat, 11 Apr 2020 08:04:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 69024C44791; Sat, 11 Apr 2020 08:04:25 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com
 (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ajitp)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 75C85C43636;
 Sat, 11 Apr 2020 08:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75C85C43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=ajitp@codeaurora.org
From: Ajit Pandey <ajitp@codeaurora.org>
To: alsa-devel@alsa-project.org, broonie@kernel.org,
 devicetree@vger.kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
 srinivas.kandagatla@linaro.org
Subject: [PATCH 07/11] Documentation: dt-bindings: sound: Add details for new
 dai properties
Date: Sat, 11 Apr 2020 13:32:47 +0530
Message-Id: <1586592171-31644-8-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
X-Mailman-Approved-At: Tue, 14 Apr 2020 09:41:47 +0200
Cc: Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org,
 tiwai@suse.com
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

Add changes related to new sub node defining MI2S dai's properties. Such
properties needs to be configured via board specific dts files.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
index a87a406..727ec03 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
@@ -16,6 +16,8 @@ description: |
   configure Low-Power Audio Interface(LPAIF) core registers across different
   IP versions.
 
+  See also dt-bindings/sound/qcom,lpass.h.
+
 properties:
   compatible:
     enum:
@@ -69,6 +71,30 @@ properties:
   '#sound-dai-cells':
     const: 1
 
+  dai-name:
+    - description: Each node represents an MI2S dai and conatins dai specific
+        properties that may change with board layout & dai connections.
+    - type: object
+    - properties:
+      id:
+        - description: dai id among one of value defined in header
+        - type: u32
+      qcom,spkmode-mask:
+        - description: mask defining data lines used for speaker
+        - type: u32
+      qcom,micmode-mask:
+        - description: mask defining data lines used for mic
+        - type: u32
+      qcom,wssrc-mask:
+        - description: mask defining word-select source internal/extrnal on dai
+        - type: u32
+      qcom,loopback-mask:
+        - description: mask defining loopback enable/disable on dai
+        - type: u32
+
+      required:
+        - id
+
 required:
   - compatible
   - reg
@@ -101,3 +127,10 @@ examples:
 	#sound-dai-cells = <1>;
 	qcom,adsp = <&adsp>;
 
+        prim-mi2s@0 {
+		id = <MI2S_PRIMARY>;
+		qcom,spkmode-mask = <SD1>;
+		qcom,micmode-mask = <SD0>;
+                qcom,wssrc-mask = <INTERNAL>;
+                qcom,loopback-mask = <DISABLE>;
+	};
-- 
1.9.1
