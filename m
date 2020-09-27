Return-Path: <SRS0=Oq54=DE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB6AC4346E
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Sep 2020 19:32:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61188221E5
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Sep 2020 19:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uIzPo4Ce";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gei0Cili"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61188221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C41A175A;
	Sun, 27 Sep 2020 21:31:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C41A175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601235138;
	bh=w3Se1i0ln9IaTvFtx9Ktn4F+9Dhi4xvfdhzG9X9IyAE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uIzPo4Cea1P8L1IT8ZlNLZwwpSxKRwCQOHIjKezZblJcl8JXtMmJnzXPouG0oqMWz
	 tlMgq2sYGuGtOh0M2d8VNT8knj34srT0UOq67VRQIYyI1ct9SVqtQSKARqVm2mQIiu
	 pq99CWzKkOQt3Z+rbcGYT9mRFktu+ZpsOrceAbSM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5684F802E9;
	Sun, 27 Sep 2020 21:29:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42C03F801F5; Sun, 27 Sep 2020 21:29:32 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59F68F8020C
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 21:29:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59F68F8020C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="gei0Cili"
Received: by mail-wm1-x344.google.com with SMTP id w2so4398784wmi.1
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
 b=gei0Cili4R4kTLkWnNRS5LS1Snz1H99u64OKPgiJCVtJPbMwQl9pR6qWMTQsaH/PgC
 1rGHjXmIksEg5lBqJ585jkMIMz6Q2pGWdILg8YfcO5MduEXLdTee3gEfmTy8K74Z5aRv
 O68KaYgYFDHfQNx1ycz6Gu+WL+QCbinnvI64ODJUJ6EliM+gywZwSw0RJenpf8VAgK6T
 hylQp5/09retHIeeoctImxzV3MfS3wDQwjvlQEI22CdCpMJw8cklaa1Q58CYwNomcQpd
 7/O7bF3stvBN+WpRoZuiqvG8M62hqt2NYprUPr/ojYk6Jm2KGuwq0vp8R+0n0ysmZPbR
 osIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
 b=EJS9/o+b7vc84FUmcNa1vL8qLT6OukeqaboejvCESoXmLN7VHVxIhZmLphvZufshsP
 CHt72n9FYAWaQjnBXzisuXuYRAaBLOsWVWcdd+HF6nl6rk0hEqjEst0p3Hw4iHMsZJOX
 PpjX1AQQXKrX8PpZSDBM8+wyoACuJQn0LiYLJ/LTDzlpL95a1JWSsS1YYBWQuL7vM29m
 AKbijmsBE3lHu/9/BgcTKd8AEsJbcZ9hGUHxr/de3aTwFvr5ItQ6eyLHNIHg5ukAU3gi
 kjW7BGD7ao57l8xpSwFNFtugE8bZvVXQ953OHxkroOyL9rkilvN8ZQ8WQOuku6qxLEop
 tG2A==
X-Gm-Message-State: AOAM533Bfqn60SHTMQcL1kOIQvY9iWIjTNTUdZc2BpLWJPhaFT34+8Gs
 24m2jJO2BJZffu7mQjBfexM=
X-Google-Smtp-Source: ABdhPJzL20IuSoEos5Hr/m63YoY7P83YNnDH8cnMV0uhx/ViCSshnGfScEiigkftVS0N2E/abt+i4Q==
X-Received: by 2002:a1c:9a10:: with SMTP id c16mr7591922wme.96.1601234962423; 
 Sun, 27 Sep 2020 12:29:22 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 12:29:21 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v5 04/20] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date: Sun, 27 Sep 2020 21:28:56 +0200
Message-Id: <20200927192912.46323-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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

