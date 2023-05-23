Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5720C7EE26
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 21:41:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C11D836;
	Tue, 23 May 2023 23:40:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C11D836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684878098;
	bh=VMXq1YKghvhXQUykCI5CUDnBZnr74qjPhj6vWnSYobw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=A25v8bxNw9jzIdiKHIGh53cBnGn943EmPRaFEL3cTFIQvVyYKEq6qJASY4NrRDDmx
	 hFpKIAimpb+EdsSbbXRR4Zrt+9LeDJcPrTHYnSem+dzm7kpGujvAWmz0Xr6U8WGfiJ
	 ZhfCTCsksCqN+kC5gc8iWFGiVylFkA70bDIRou8U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82DD5F805C8; Tue, 23 May 2023 23:39:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 184E6F805BD;
	Tue, 23 May 2023 23:39:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14F58F805AA; Tue, 23 May 2023 23:39:16 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ED10BF80425
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 23:38:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED10BF80425
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=ikhR7QD/
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-19a308a045aso149857fac.0
        for <alsa-devel@alsa-project.org>;
 Tue, 23 May 2023 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684877915; x=1687469915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix+1iyVwvq5YDYEbZ/aFgQhyfZBXx0DvBnZd+gR5Wcw=;
        b=ikhR7QD/PWZ9AYHLbDesyyyoL21t6ku6E+41m6IIb3rJAyTZa4y97wt1OdHqmM/ThV
         dQNCAVfTtqpH/ur0Wb+768h9L/sIAADrlZX3mccXAGngeKayrYtjU9zNcfWOQ6C+Rrah
         2BQ4Q1uqiJKhlh5ISf7UUQjMpS46akCCq8YUceSJVYEj/GTljoX7zPSE/Ecw85KHwTJX
         ElFjA9JBheP0pXhfqpRKOro/LgIxsgBYO0Wqq2l2aFP4eT/ukIy0Q/3GYBg4rVWfruF3
         wFnd6DlYtg0KKBb+J7/iIO3oxGX3S57WsL4Gl4Oz0tWMop4ljmmrYDPZREebi80HEV6Z
         DPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877915; x=1687469915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ix+1iyVwvq5YDYEbZ/aFgQhyfZBXx0DvBnZd+gR5Wcw=;
        b=YhU4jQ7B9wJMkXQux8qTRBPjxXk0AhkXRQXue7CrA0CTwzhHF20pJv61ms2UqNVsBy
         EMlKes+BUa7+PxrQ1CLdd7IWbKuHq3pN530FE78nXD9afWH3ByYfxmYOdlRR2S8zKgkX
         34y9ibrhkkLAPZbWnU6x5/HqPiYkvbtoQ7VMULYiLq2Sb6kUBIH2LguS7VQ4ZIix4t+w
         jclPV0U81XdTkKqizQIL6eOqe/ARF4BjHgM3nP1pensRWGWChC/tplBjumLKu1KlzFRZ
         u1Nw0YoPUDe25AsP0Q0/Hp7t051fhuOXaftVpgNuzpEjVbo3WDQcGnFNt9if4o/W9yCx
         jITw==
X-Gm-Message-State: AC+VfDxBxo/p3bl1mKlWr/zd/gtSju13t0zhW2ibwInQ2/YFS04HjGRD
	BKlfDTl2UYqbzJ/q9WzXIpc=
X-Google-Smtp-Source: 
 ACHHUZ5MneObFTHYZ+sAb7c/LwLONHBsL0zmQRw5S21Rr5FCtGfmJRScWF1vi/l6oY18WrpSERHDSQ==
X-Received: by 2002:a05:6808:4293:b0:397:fc20:385 with SMTP id
 dq19-20020a056808429300b00397fc200385mr4226191oib.28.1684877915719;
        Tue, 23 May 2023 14:38:35 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id
 y83-20020acae156000000b0037832f60518sm4442359oig.14.2023.05.23.14.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:38:35 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	zyw@rock-chips.com,
	sebastian.reichel@collabora.com,
	andyshrk@163.com,
	jagan@amarulasolutions.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 5/6] dt-bindings: arm: rockchip: Add Indiedroid Nova
Date: Tue, 23 May 2023 16:38:24 -0500
Message-Id: <20230523213825.120077-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523213825.120077-1-macroalpha82@gmail.com>
References: <20230523213825.120077-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: T4NTRHKYHAOJLBRWEIPYG7P6P2RB4KVH
X-Message-ID-Hash: T4NTRHKYHAOJLBRWEIPYG7P6P2RB4KVH
X-MailFrom: macroalpha82@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T4NTRHKYHAOJLBRWEIPYG7P6P2RB4KVH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Chris Morgan <macromorgan@hotmail.com>

Add Indiedroid Nova, an rk3588s based single board computer.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ec141c937b8b..3c5a204bcd81 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -542,6 +542,11 @@ properties:
               - khadas,edge-v
           - const: rockchip,rk3399
 
+      - description: Indiedroid Nova SBC
+        items:
+          - const: indiedroid,nova
+          - const: rockchip,rk3588s
+
       - description: Khadas Edge2 series boards
         items:
           - const: khadas,edge2
-- 
2.34.1

