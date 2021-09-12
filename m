Return-Path: <SRS0=uEli=OC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEEAC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Sep 2021 07:30:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA9561108
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Sep 2021 07:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BA9561108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A633846;
	Sun, 12 Sep 2021 09:29:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A633846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631431846;
	bh=rGSW6XWZcc/IlpnDt4ABzBha5CJBUllDJyx+zCBTB6c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kj4ggoxPBedXk/kLdeK4drf18pq5pjcOUAXTGFaaMSIYJNeI6uVLwXCYc8a928pXv
	 5S8FFI9sWWDVhWzneatkQRNK9eZZkOQsey4G6Mhiu9PptqrDm0W/r7oM6GeeXczb8Q
	 hYOGdVRWPkBdkUywpAfMaYFbz6IN0M6kKRjEeX0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B168F8025A;
	Sun, 12 Sep 2021 09:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3333AF8027B; Sun, 12 Sep 2021 09:29:36 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5789F8025E
 for <alsa-devel@alsa-project.org>; Sun, 12 Sep 2021 09:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5789F8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kV0FwxCc"
Received: by mail-wr1-x42d.google.com with SMTP id b6so9379785wrh.10
 for <alsa-devel@alsa-project.org>; Sun, 12 Sep 2021 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q4RL0sqYDQpryks2hL9tjkn/HeWDVonzaaoKuLG05Vk=;
 b=kV0FwxCcUZPNv2Sxt7roikRo7jM6LiDDicK3Z0IAjf9ahaa9/SsZpSS8lIFmdFQajj
 xka8kYlyccXLabLzhnOcQpIkfve3AA3L8dWk2RWcgt5adAy0pj39oLYYKbM4ik0cORKQ
 gDo8aB3rA1Ybkd1MEzEZkvW3EEpn74O9kzlJZ7IFsEb3rdwWmHyV1f+slsZ7XL4kKLKF
 Iqiyt6FtmRE+ceskzSZw3X7zXHetZ1wrpc/tL8ZSYHUqhuVzYn59JWOyPxMpmknxroPZ
 2SXDjJDrbkMjDhXHJ8zYH0dDKDvNPGmXJ28LFJFjPcQ37iXo3y0E+PnaCbMsqkYsTqlk
 9ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q4RL0sqYDQpryks2hL9tjkn/HeWDVonzaaoKuLG05Vk=;
 b=Xr04mxt7nPyr4t6C/ihLT/vfNDKx6dF+jpT43UZp4JyW18SokooHEbszTJwcVadnoO
 QqzcPE80FvSpiZS383R9M1GaQxi36pXI8hw6GGN1/M5CmY8wNnL2KqHgQ6/7Ng1vr47Y
 FQlWb/HoKSebbl2e+CgvnLx5sAx0vFtZYNKHsb/R2JbRonE4gWh3r59S89oeSzOIKREN
 QnBxYPoLm9k+6XKfsjpPTrGTAyGB7mZETKPZkbOKMfCokGpHJQf6qdvwbk+hTlsd4bfO
 Fu6ecmRoR3VbD1aVvk0yl9TLeYxHPQOZhL4tQiEmXtbTDZBwXD62QEE2Ou/K+ypn5xof
 v/1g==
X-Gm-Message-State: AOAM532pMPM559N7Hu7fBk8d4OSOp59QjHmC9Ur2IMRGsfdDgY+sV+ZU
 cQdm2QkBWDq5vDvZxhB+B5w=
X-Google-Smtp-Source: ABdhPJyzGL9pJtzMKYuimQOy8clVHIFsJ1uTW6/YaQEONAIxa49BkFdACyZzJGio4nTTzUBvHyzDNw==
X-Received: by 2002:a05:6000:1081:: with SMTP id
 y1mr3890013wrw.14.1631431763798; 
 Sun, 12 Sep 2021 00:29:23 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net.
 [86.58.29.253])
 by smtp.gmail.com with ESMTPSA id t18sm3584889wrp.97.2021.09.12.00.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 00:29:23 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Subject: [PATCH 1/2] dt-bindings: sound: sun4i-i2s: add Allwinner R40 I2S
 compatible
Date: Sun, 12 Sep 2021 09:29:13 +0200
Message-Id: <20210912072914.398419-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210912072914.398419-1-jernej.skrabec@gmail.com>
References: <20210912072914.398419-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

Allwinner R40 has 3 I2S controllers, compatible to those, found in H3.

Add R40/H3 compatible pair to DT bindings.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 39b66e9ce3e3..7d48ea094c66 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -20,6 +20,9 @@ properties:
       - const: allwinner,sun6i-a31-i2s
       - const: allwinner,sun8i-a83t-i2s
       - const: allwinner,sun8i-h3-i2s
+      - items:
+          - const: allwinner,sun8i-r40-i2s
+          - const: allwinner,sun8i-h3-i2s
       - items:
           - const: allwinner,sun8i-v3-i2s
           - const: allwinner,sun8i-h3-i2s
-- 
2.33.0

