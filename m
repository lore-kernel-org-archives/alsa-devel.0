Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ADEC43464
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:34:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512D42145D
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pKCbjdaQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMGph5JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512D42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA7DB170B;
	Mon, 21 Sep 2020 12:33:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA7DB170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600684458;
	bh=w3Se1i0ln9IaTvFtx9Ktn4F+9Dhi4xvfdhzG9X9IyAE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pKCbjdaQfc7bsb7vuW4/LzGiaJUW+dJtW0e7yLdccHvb+L10z01cw64DDl6QKRBHT
	 dNO5+CuBg9gUxWdQWbE7Un67jbPQnUr3EaWhwZHuh8+ng2jA1CgxC5H3G37bygnLIY
	 5WAUZYSNyUZ6bECJ5vvQchQDc955wO+q6T3l79Q4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AE6AF801EC;
	Mon, 21 Sep 2020 12:28:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A2B4F802F9; Mon, 21 Sep 2020 12:28:07 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03A69F8028D
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 12:27:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03A69F8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="oMGph5JM"
Received: by mail-wm1-x344.google.com with SMTP id a9so12064489wmm.2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
 b=oMGph5JMS4IMByo7SEq/EEhqYCEJSAJWh1ORxSJdk937N8/sdqhkw4QGAVsLEGav9D
 OQFpLA3octkJqhiE8KvODqkhUj/cSYivsyKi9OqR7wqEf2miYf8SgoNuNstgFblEdovL
 rxM6CP2+VsdcY5KlAitt6Rkil21GvMA5c9JtyvpwSOWDBSNk9KC0Y9e5Rrd2aZOYwCyP
 L7E7v0KzcqsA4ttlb4JqDdWTi3WmbC+jGWmGWCbk8Db+ox+CVndkongV9gS7cPFYzJQK
 AiAjqenClWxrRUq749n4e5i4YAV3fF+wlv8aMDACpNhOk6N8HmN6GDWGDOnYAuWktxiA
 izBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
 b=iVD4v183nqwp47ZA0cfuczvsZ/UzNBLOT0iQUk7YmYNhMPx7mWJscYCfZc2UkG2vHd
 zpJnGZEjfr56DHlFj7CgnxCkelta57tdSyaD69+823L2qMtR3eF8KwG2W4Hk6xt9OvyR
 +iuKbLeZ9Q43RAkUNuIkKZaF4DVRBR8Q29ZJsRsfFRv8udtnz46tbmbvwCCSw30hmdhY
 YPTsfFClzdg4irz0/q0m7jtci0QPfa9atAOSWMZYVeFBBkSoQsPQzbbG1gve98ulU2qF
 7oQOanUGeaot9m1tz13jA5TqQ7KxDkPhFBjijwmlFNvtpGrzts9wz5G84bXlqO7hQQ/O
 0X5g==
X-Gm-Message-State: AOAM533f44Ld7g2P0ZcvzQ+ta7tKmpIEMJSk/uBiyt0xa74yXc+jcQ0r
 YW4mWcqcXUbr/AML+b/QG3c=
X-Google-Smtp-Source: ABdhPJxgV5A3pfob1xTad7/Ki6Cu/+R5MNVmZQTcenpCcuIPvax7TnEV66cdNM7NM+tYZOL/8I/gsQ==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr8080935wmj.123.1600684060840; 
 Mon, 21 Sep 2020 03:27:40 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 03:27:39 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v4 04/22] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date: Mon, 21 Sep 2020 12:27:13 +0200
Message-Id: <20200921102731.747736-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
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

