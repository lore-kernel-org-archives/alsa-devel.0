Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE13C4167B
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Dec 2022 12:53:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 786312E02;
	Wed, 28 Dec 2022 13:52:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 786312E02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672232026;
	bh=XPY58WEpe4eoW2n+/jB/Q8RnA1rtgZq68i4gnmqmx1Y=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=azRFPMa9hK69gSR9kFm629iHLLet4OzEsabEsI3JPKuqhPiJbgsYVD2J6w4EwLN5b
	 kBcc1GpBHR2kjrjqS0YAdemgi2wdyv7t0Shh7atak3p39KBKX9sDUHlvMNT4gFLo6P
	 tAcqM/XmbFRhiRx9tUwzroSU3SCtpOKTDZU6W7NA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23487F8053D;
	Wed, 28 Dec 2022 13:51:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1660AF8042F; Wed, 28 Dec 2022 13:23:07 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AF3EF80310
 for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2022 13:23:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AF3EF80310
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=huaqin-corp-partner-google-com.20210112.gappssmtp.com
 header.i=@huaqin-corp-partner-google-com.20210112.gappssmtp.com
 header.a=rsa-sha256 header.s=20210112 header.b=x/ZSlQ8p
Received: by mail-pf1-x436.google.com with SMTP id z7so4937192pfq.13
 for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2022 04:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0LQcrjzcqyHGx/EG+ZxulY1MidQR+dP6F+oRvG3vQs=;
 b=x/ZSlQ8pHG3xkV8dK6KyzVm22eyZhu3j80eOGMvGPMwCebW/JYa9bvXGKtSFn8vbV5
 5aC30qO+FGeVDqa6hM3f99d42d8Y+EUt0EWm8TFlq/4TkyPTXHubCPe6BK6txdD2JPJ/
 cYErJ2c2Ye/cFe9UA9HJlFki7EhknDZ7YBu+183MID3AA4U4OWc421E+CU5jvpKL53Wq
 SkMh7FCqoS9IAMN7cCNgH84NXgJcgvj083upOmOktH6ErMszWA+rp4ftCOeuQOWRWfUg
 VRaZLGm0Ka0jC0o/RtTXruMlZ0UTjdD0si5vTQceCk80DTEva2K3MqCzm6l5oU4u0gWG
 SGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0LQcrjzcqyHGx/EG+ZxulY1MidQR+dP6F+oRvG3vQs=;
 b=yfGWguDxgiCGKSYO9viITZ/8mtW9EhOwiwiFMMu0zSOEQneVJoQIz4wvcS2P72VC/O
 YEBWMAeqGGLTgSXitr0uMiSpJdkdilbfDuJ/dEst6yLuTAjKo/2bWzHn2qoL0akUgkA/
 l2adzzoEFWp9PkS8cub7gQUX6krO0hL+oENWwUrkOzCVEebiauUNmVPU2W2bXdFM4u1F
 tl80Sgwgg4eZE8gtdFPpc/HchH5+KJ4+x/Cl5Eb3+fL8lxD2nvVq48ri5PgAvsvfq6rr
 reOb+rcLpyfVVTQZBoj13RhmjnjbyRNwVUFacnMYaYVylMtA+iv1i+k8yEvqxBgLiyuJ
 pgbA==
X-Gm-Message-State: AFqh2kom+2bisqAFdWLKGCnL5vcMdzjS0B2TVAZPXVKlb04CdLYLj/vO
 1veZ4H0JDDLpVTRkffewze9Hsg==
X-Google-Smtp-Source: AMrXdXudRa1wP9H6e6vGFfQm6qY0zfkdkBMEcZaDW22e10mqSIjt3bIqPJ0YRH0r2IRG0HPaz0kP6g==
X-Received: by 2002:a62:16d5:0:b0:580:f58f:efb3 with SMTP id
 204-20020a6216d5000000b00580f58fefb3mr14897592pfw.15.1672230182928; 
 Wed, 28 Dec 2022 04:23:02 -0800 (PST)
Received: from localhost.localdomain (202.60.225.077.static.cyberec.com.
 [202.60.225.77]) by smtp.gmail.com with ESMTPSA id
 h1-20020a056a00000100b0058124f92399sm5236074pfk.219.2022.12.28.04.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Dec 2022 04:23:02 -0800 (PST)
From: tongjian <tongjian@huaqin.corp-partner.google.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com, perex@perex.cz,
 tiwai@suse.com, angelogioacchino.delregno@collabora.com,
 nfraprado@collabora.com, jiaxin.yu@mediatek.com, chunxu.li@mediatek.com,
 ajye_huang@compal.corp-partner.google.com,
 tongjian@huaqin.corp-partner.google.com
Subject: [PATCH 2/2] ASoC: dt-bindings: mt8186-mt6366: add new compatible for
 max98360a
Date: Wed, 28 Dec 2022 20:22:30 +0800
Message-Id: <20221228122230.3818533-3-tongjian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
References: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Dec 2022 13:51:26 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Adds new compatible string "mt8186-mt6366-rt5682s-max98360-sound" for machines
with max98360a and rt5682s.

Signed-off-by: tongjian <tongjian@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
index 9d3139990237..aa23b0024c46 100644
--- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt8186-mt6366-rt1019-rt5682s-sound
+      - mediatek,mt8186-mt6366-rt5682s-max98360-sound
 
   mediatek,platform:
     $ref: "/schemas/types.yaml#/definitions/phandle"
-- 
2.25.1

