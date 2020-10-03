Return-Path: <SRS0=cVLY=DK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC720C41604
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 14:25:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A2B206B8
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 14:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TA0VX6R6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/zauoV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A2B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41ED41A94;
	Sat,  3 Oct 2020 16:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41ED41A94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601735150;
	bh=BewnauDF/pdfaMjQKVYly+KokETkb3wOlXv4OXrcmmA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TA0VX6R6092y4KnEIOpIpf5p0xO6jpmbheUs5fqxoYV9RVoL8vIYP7oeMuWHdXI2f
	 XGew4xvHlmyFAYo3elAnXJdnps8JhWSzjMYM8+tyVAhUVskTOkp2IrDwZLoZLlSiXn
	 nNMPTtId2fXJbdvagyLA68rT728jBYUF+nMmiJzU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C228EF80332;
	Sat,  3 Oct 2020 16:20:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98B8BF80317; Sat,  3 Oct 2020 16:20:20 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78523F802F8
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2020 16:20:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78523F802F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="P/zauoV3"
Received: by mail-wr1-x444.google.com with SMTP id h7so1232628wre.4
 for <alsa-devel@alsa-project.org>; Sat, 03 Oct 2020 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
 b=P/zauoV3UnYTl9IFk5G7J+shBsL1VKfGUfuvwhKM5qXdyOoTdM0ivqT+4r5Keu9jwq
 J5cvAqMRRn6aHfjIxxHsOBNDAFdPDplnOqJ+zmZxCToFzK9qzLUk6nUXR1QU7XIaUrQR
 cqQLPJ+dIo5Mk+Holg0qxLMJb0fyjcjFo9AVu6ctPfEjDRRqbWVitvl+bi/k0xxlxzxY
 gJQKSEDtVE5NXh6z5f/D39hj8Ek+m3X8oyyjBgA6Jw2g3yMw3ExlnfJUjHuZ0oWyrY0p
 4xIHUGRCIb9Or65CQ3ppCbkBqqRNaeuxDIreQC418hjCKS5ImvSq+hfGLoDazW3F4+ch
 QOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
 b=b4QYyFPZqYGU1KbpMFduUIHmAHfOSLc1cJAMGkSG4Vqin1uVOf+QKMNVgvtFf95PfJ
 vjZZqV2SHgf3GoZigX8pfD8t+0H1KqtIkkkMdkvTYlZbzZCfTEeqVmjh5UHnN/3Shp4w
 RlfMhns0cl8qyKldXLeqRCz1j3dk0KVN0XhTZ68YjS1GdKuD0jtGXqWBhxBQXoMzwL9w
 NCFZdFQLIVjwPGZXawtIprjkF74+vjvQRQifzJ9RXgxCkIirYWyo4DkNgYI+lgMk3ohD
 +2T3A/X8vc1V+1hkvu0OZO85MlxgAqd2XdbLndo9XbqAMHg/q5CvdCokL5XRHDgf79G+
 ngSQ==
X-Gm-Message-State: AOAM530k8+B0HRPdjA8npCZsIzKBAT+0MCVCzdFdoUj9NaflORu4Cfzu
 gXG1B5gwMBwnZN/vLScfbns=
X-Google-Smtp-Source: ABdhPJzB6w8DsX08x6bzm4aOWIoCI26CAmWBZJm1FYCvLH8M4NS6Lv4C0xV5G4645Vl2S/E7KTT5JA==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr8427739wrq.59.1601734813670;
 Sat, 03 Oct 2020 07:20:13 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 07:20:12 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v6 09/14] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date: Sat,  3 Oct 2020 16:19:45 +0200
Message-Id: <20201003141950.455829-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
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

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to H3, except that it supports up to 16 channels
and thus few registers have fields on different position.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 112ae00d63c1..606ad2d884a8 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2s
           - const: allwinner,sun8i-h3-i2s
+      - const: allwinner,sun50i-h6-i2s
 
   reg:
     maxItems: 1
@@ -59,6 +60,7 @@ allOf:
               - allwinner,sun8i-a83t-i2s
               - allwinner,sun8i-h3-i2s
               - allwinner,sun50i-a64-codec-i2s
+              - allwinner,sun50i-h6-i2s
 
     then:
       required:
-- 
2.25.1

