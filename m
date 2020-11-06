Return-Path: <SRS0=gYtK=EM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4994AC2D0A3
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:16:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4315F206F9
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JBj8CFaa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3j3Ypm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4315F206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90068166F;
	Fri,  6 Nov 2020 07:15:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90068166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604643394;
	bh=xeVKDqHwNQrCPDZ7u3USnaGYaUbx9tyXgOrc0U2HBCs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JBj8CFaaT/yLb2lOHT4lms+NoLfUYqBYp+bhbgaw7zEh3fKFfXw1Q6VihF93tayUK
	 2wY48c7NXoe5R0FsrCgtisY6SpCMFDreZg8YPe4YvQR8Du+J2PQSdkz/+JdQPZuIZh
	 wvmsdDpit9D2OB+KmWOTSxe6m6zrFyHbQgpV65ok=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35EA4F80247;
	Fri,  6 Nov 2020 07:14:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F1C6F80259; Fri,  6 Nov 2020 07:14:54 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 803D4F800BA
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2020 07:14:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 803D4F800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="j3j3Ypm3"
Received: by mail-pg1-x52e.google.com with SMTP id f38so149335pgm.2
 for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2020 22:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l5wJhSF1myKTxNCEOkUYzTRb2ml1CsAb8yYtcmdDQEc=;
 b=j3j3Ypm3ruFiRx011vvNly7A5X1a5FTVUBD0VHrZdFLR2zwy/mlqzqfssGSOSUX7kz
 MieivpEEWrdLOc1R3xFYVIB6oKzXWqyW4jFiVluwTwT7K0Wbt4oe1XsifHVWEtD43WcU
 SlDwmaEtn8FUGoMr8wiBnYXLRcgTTLoT4eAheSe/5hKUMRdJvbEDhfIYPXZAygzxdIj7
 2jzoJ4zmcQqY7LZwBHvbNQGtCDMPML/lCvfroFN7BxyVdyxgKc9qCIFMRS6bAOJghScK
 bcNOSO/xGqt+3tAZfI2Ner2fjeGL3GWjaTzijlUDG5a1GJGBN1Uio3icMREanKlpTI5T
 I8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l5wJhSF1myKTxNCEOkUYzTRb2ml1CsAb8yYtcmdDQEc=;
 b=niB7WgbxkCIrBgQgUENwzKGIYmgPRLM47qCorChLAwsMmB8v7jpPQ/5LnilTPtTk6U
 dAumIxSBDLNJBNLXqLiEw79HA19RNOJg3BmJe/t1/D0nZ80g1dRYpx+UajkskwpT1YHf
 TtkZ1BU+jPfVd8tEp5TtoSuLxqhBl/9dw3sQumiS3s9Yass2V9m3MyzNwLf0UOSIAWgG
 ijPkJfGh1hJhccifoCfsu9HdXktwezJtx3RRdxBRiVzw/3oihzzxNX3UZFm4NfQ1HTU1
 6mnpICCBc+Luc6VyANdH/UNA/JAmzjJv9gcnNWpK/Y3mIIHVcd272bfTi6nGXl00bm+v
 fENQ==
X-Gm-Message-State: AOAM5326eE5DtJJ6gwNV3cPFWQPqbNJLVqjRNpJtPC21Q9J28pgpwhPs
 i3tCOFd16vxMSkP+xrIc1GI=
X-Google-Smtp-Source: ABdhPJx3Ggm4pls83AmffE9szLmq4frqWWbLnvgrh2jxFHSlCYaeyAYS0j8558fwaKy/sRuhwrFFhQ==
X-Received: by 2002:a62:17c8:0:b029:18b:5a97:a8d1 with SMTP id
 191-20020a6217c80000b029018b5a97a8d1mr467274pfx.15.1604643285394; 
 Thu, 05 Nov 2020 22:14:45 -0800 (PST)
Received: from localhost (114-34-18-97.HINET-IP.hinet.net. [114.34.18.97])
 by smtp.gmail.com with ESMTPSA id q5sm746472pjj.26.2020.11.05.22.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 22:14:44 -0800 (PST)
From: Ajye Huang <ajye.huang@gmail.com>
X-Google-Original-From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] ASoC: google: dt-bindings: modify machine bindings for
 two MICs case
Date: Fri,  6 Nov 2020 14:14:32 +0800
Message-Id: <20201106061433.1483129-2-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106061433.1483129-1-ajye_huang@compal.corp-partner.google.com>
References: <20201106061433.1483129-1-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: dianders@chromium.org, robh@kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 tzungbi@chromium.org, srinivas.kandagatla@linaro.org,
 linux-arm-kernel@lists.infradead.org, cychiang@chromium.org
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

Add a property "dmic-gpios" for switching between two MICs.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 .../devicetree/bindings/sound/google,sc7180-trogdor.yaml  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
index efc34689d6b5..ce050a9dec94 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
@@ -34,6 +34,10 @@ properties:
   "#size-cells":
     const: 0
 
+  dmic-gpios:
+    maxItems: 1
+    description: GPIO for switching between DMICs
+
 patternProperties:
   "^dai-link(@[0-9])?$":
     description:
@@ -83,7 +87,7 @@ examples:
   - |
     sound {
         compatible = "google,sc7180-trogdor";
-        model = "sc7180-rt5682-max98357a-1mic";
+        model = "sc7180-rt5682-max98357a-2mic";
 
         audio-routing =
                     "Headphone Jack", "HPOL",
@@ -92,6 +96,8 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
+        dmic-gpios = <&tlmm 86 0>;
+
         dai-link@0 {
             link-name = "MultiMedia0";
             reg = <0>;
-- 
2.25.1

