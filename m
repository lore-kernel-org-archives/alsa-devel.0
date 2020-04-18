Return-Path: <SRS0=riU+=6C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5E2C3A5A9
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 14:42:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCB922240
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 14:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BCZ8SzF1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5HNev90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCB922240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B85D1612;
	Sat, 18 Apr 2020 16:41:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B85D1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587220954;
	bh=Jvy3ne5DgM8OayHGMO9Ywg9q85cO1bdmYPOMsFS877Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BCZ8SzF1U2FFZO7sAo4Nv+roYdKTp0QEwO4X3fJE8RJm1KmQalOySkPDBnBUqWDTQ
	 OGYgMOCE4FkKEpTQnK+vCDOmr4I+k0ARe0pFtNuzqodbBebzGUXxEYbV4YtmI0xaNb
	 Xd9l6+Sq++T7GFIWIBGQxfPzkQ2eFG5fyyAAjAI4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A850F8016F;
	Sat, 18 Apr 2020 16:39:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCE7BF80290; Sat, 18 Apr 2020 16:39:38 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9349F8013D
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2020 16:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9349F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="q5HNev90"
Received: by mail-wm1-x343.google.com with SMTP id u127so4916141wmg.1
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2020 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0RLyOmcQjC6vn1XEI3ccjJ++FkYMXRfGQ9jNbYoBA2Y=;
 b=q5HNev90MzXTL/ywnewZwrnzuyIqxvWF/Kr5tUh24SzGbZFJmIRryOT5Cne5AqSmRv
 jdt5+JW2IUSB+CLsoguUYD27kcuJ7qzXbg4BFujwC79yB6hpHcW/nHeJez/eqLWKeGO+
 Ufn0Fz+U8dKq6Q6QJ0PFYKEJFK3dU26R30ikE296gF2mi2pO1sSLRw9c32lll9aa929C
 tb5Bn9Tv3SghyHF7ArFMxWm0OmVKUizia4vv+e3iRk7n0Li55z/HYKxbK1tDQ6NvEZRI
 JRFKzjVL61ilvfzUDvWmCtbaFM5de1FG0eShlLhI4TMw00HfqQrTY3ftWVGCILa3QXLQ
 4mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0RLyOmcQjC6vn1XEI3ccjJ++FkYMXRfGQ9jNbYoBA2Y=;
 b=oHfHkUz9GgbNMgiGMwftn6BCJ7d6dpOt8+uuY5A/mG7oIEGQ1gybyp7xAvGaVnap4I
 UmMhIgOnRAawmKFzp9CcPyhUfsQxMsJ0c2kVduZptXAUQ0qCaeu882e4gDZQTdauESny
 dX+9dZESwCmXkFLvcVm6cpe01PMxEHI3+Ted8fopWDOJ6AnFE6Ndl36TjzS3iaeuQInd
 7sk3Rpg+3ZxeWYjcFmV/ZSW2U90zdy0zr+nABsJDLFv/FDA4Q+Mha23prkfuxrTCMNux
 qMg9YLSvdOFE2R2cNib3D4iz+U9xTp/jdAV2cgqmgKAWnCaHoH6Un1mVEGwG+5f0TwVu
 oZCQ==
X-Gm-Message-State: AGi0PuYvXqi3ReP3n4Kx36WgBY6SUu8stRgHqPxEXvsi7iNaNw9AvJSY
 1CIk/vTF4Jj9SMspIII79XA=
X-Google-Smtp-Source: APiQypLxyXDor7+tKSZgFN2C/9biQv72swhCvNXp4GtJiTquiN8BtbiZEPJAKGuJ5Sp1vGD1nVcH8A==
X-Received: by 2002:a1c:8084:: with SMTP id b126mr8178036wmd.135.1587220769442; 
 Sat, 18 Apr 2020 07:39:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
 by smtp.gmail.com with ESMTPSA id
 s9sm25375322wrg.27.2020.04.18.07.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 07:39:28 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/7] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date: Sat, 18 Apr 2020 16:39:18 +0200
Message-Id: <20200418143923.19608-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418143923.19608-1-peron.clem@gmail.com>
References: <20200418143923.19608-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Jernej Skrabec <jernej.skrabec@siol.net>, linux-kernel@vger.kernel.org,
 Marcus Cooper <codekipper@gmail.com>,
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
2.20.1

