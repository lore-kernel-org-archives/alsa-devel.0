Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FF3C4332B
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:43:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A720B20775
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NIszLvse";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egl2JmPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A720B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5462A1612;
	Tue, 24 Mar 2020 10:42:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5462A1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585043027;
	bh=igXrb9qdEZYOj5ehb2SErZBtWnWwW2HBq7f6TXmK8BI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NIszLvsenWOkamNs+ckayC3Ngsm+jvgHADjf+Vep+HqgJ/7MV3yEqHMxZhhMgKyti
	 4qtwPDcGmBoqAlyuDh54HA5uWSsxs2CVP8dFHmASzJjzNdqwak7EwCnQIhXht94JGw
	 daHJSdf+Nk+yJhuDh5SUdaT23xPCnYScGnRCja2A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 120B7F801F8;
	Tue, 24 Mar 2020 10:42:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E222F800FE; Tue, 24 Mar 2020 10:42:02 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A4EBF800FE
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 10:41:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A4EBF800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="egl2JmPR"
Received: by mail-wr1-x442.google.com with SMTP id 31so14513416wrs.3
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HNjGIiYj2PpNEKaGwYof99mf+bU/+Ss4GMUxM717vYs=;
 b=egl2JmPRGAUxRuOSAc1Jl1OqrLWKRg2CePCkrpRwV/8U2wzDPGGB7qXbEBo096GqjC
 GU1SkgX7ePypv9GkhRSPvEUbUN/QQHc092ELTeQLX4c2vHak9eIK9eboKOA7ZKrFO3lJ
 0FnuTJgeXdNL5zblpPbjtgWJUPNoPYq9HL5KMttBbjHzMh/mN9piTviAuPdLDuK1X1JJ
 LzPTeRD14ukONHC3+G+SqAMFrQ4LfX9fVqtSoU4glVxCJdu70Qa1g5T373UicfCdnbPC
 SjDQ98IZY/dNwrAWLc+amI9ubxYWky2cL46kf655OkghRmEyiFkqnQPqZbX9bRXlf9WR
 pbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HNjGIiYj2PpNEKaGwYof99mf+bU/+Ss4GMUxM717vYs=;
 b=cj7ed2yaNmNS0hpovLD4MItpA0mKZBVWdyXSwuQylTc9vpYyUFkvbVHDKF+UK5sy0M
 8MUIl4SUNyqpUM+Bn0hUE7sYXZAy+ecutbMkonRPGSLXDn71NtNTgsvMpGp7JkFs/RTT
 XB2Vzdz/GR8f/4vSSP4wyh+CI8ObmNhRu6t9KEGBjl7rfwgJCiwhPQw7EqDZ8ixj0AlR
 +DnOLG6rEKxo3dEBpQ65YIQ93nf+3tGvUlBPUbZTdR3ttfDOfDhZIkF3KI2c+rOcUkxj
 ycmMh6efzOFES833nsos/4CV2uH4z8DJvZ4P8jkqdkQRM1R10uzpgI1Fc9I/AaZ8po2O
 JIkA==
X-Gm-Message-State: ANhLgQ3wLDSeU4TcvVXalvu2MVDtBMdBLUn2pKbabsZy8XN3FHwXoDNF
 ze3Ufl+bopXQIeaMWEJ0xKTkJWhY
X-Google-Smtp-Source: ADFU+vv8C9cjYZxaDsbHr88EK25zLIa2C+78e0CD6QBdRLrO+K+8pTvsjYRa/RwUpjye0rYJNRrOew==
X-Received: by 2002:a5d:44d0:: with SMTP id z16mr13006905wrr.28.1585042918365; 
 Tue, 24 Mar 2020 02:41:58 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id r15sm22489916wra.19.2020.03.24.02.41.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2020 02:41:57 -0700 (PDT)
From: Johan Jonker <jbx6244@gmail.com>
To: lgirdwood@gmail.com
Subject: [PATCH v2 2/3] dt-bindings: sound: rockchip-i2s: add #sound-dai-cells
 property
Date: Tue, 24 Mar 2020 10:41:48 +0100
Message-Id: <20200324094149.6904-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200324094149.6904-1-jbx6244@gmail.com>
References: <20200324094149.6904-1-jbx6244@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-rockchip@lists.infradead.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to 'rockchip-i2s.yaml'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changed V2:
  Add Reviewed-by
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
index eff06b4b5..7cd0e278e 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -77,6 +77,9 @@ properties:
       Required property for controllers which support multi channel
       playback/capture.
 
+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -85,6 +88,7 @@ required:
   - clock-names
   - dmas
   - dma-names
+  - "#sound-dai-cells"
 
 additionalProperties: false
 
@@ -103,4 +107,5 @@ examples:
       dma-names = "tx", "rx";
       rockchip,capture-channels = <2>;
       rockchip,playback-channels = <8>;
+      #sound-dai-cells = <0>;
     };
-- 
2.11.0

