Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9035CC63697
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 01:45:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35E220791
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 01:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FxLDSNuu";
	dkim=temperror (0-bit key) header.d=huaqin-corp-partner-google-com.20150623.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20150623.gappssmtp.com header.b="QZ/PChYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35E220791
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E27CB17A8;
	Thu, 12 Nov 2020 02:44:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E27CB17A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605145528;
	bh=SIHLv4064EnA4c8OdDouJ6Yput7I9AxxKUKQqrnf6/I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FxLDSNuuo/utwYB4yKQIhkgN2bQQJcm6eYyebPeBTMzAud2+9z9/n08eCg2XuCxuY
	 7BXr4z2wsayLfKOr67uqpKsQd1VV9+EirRwY66uAcuLD1V0+eYZsRN7aZ1rcdGnZti
	 8ESt2xazWJ78GU1xRKoWS39S8IBz4c+5UOsfGBIY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADDA5F8022D;
	Thu, 12 Nov 2020 02:43:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E62AFF8025E; Thu, 12 Nov 2020 02:43:51 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42625F80059
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 02:43:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42625F80059
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key)
 header.d=huaqin-corp-partner-google-com.20150623.gappssmtp.com
 header.i=@huaqin-corp-partner-google-com.20150623.gappssmtp.com
 header.b="QZ/PChYo"
Received: by mail-pl1-x644.google.com with SMTP id g11so1931195pll.13
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z7QBX/BgardFaKvLv1+8d41yalYkEi5pE27cczcK9p4=;
 b=QZ/PChYoddyuq3JaN/kKbFxu64rCiVockPcVMwx/lHoclsRoTl/jjlsJx3IgyHe6rc
 HlwpFPqbkpDUGYmKIiGP5GobmHvpRmOFjSSl8j13zKo3zqEak2xVHx7faykxEgDlInvG
 VEEAshdF6ZhTn0Wr1a21gVDHaQjovXRMvSBGTevGFEFJGbOVh1bsT4qX/oT369gDUkEo
 h6ptvoCyPoHJpQQxykx0bGWAzNiNxQ5KCeVV7D3BvWlu1hFaU3nSWzZHVHU7OQlBrg/n
 EwKBjo+ez9+0eyXZpEQoa5xw6oRDRvONS2fJOoC9LIB9mYYRuPfPdlAIHyk7lHjw+dIj
 2xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z7QBX/BgardFaKvLv1+8d41yalYkEi5pE27cczcK9p4=;
 b=o3R9/u+y3RyyROvM/zM7n50Ck4d7w53Kdd4br351QrQn1GFlhwLcknkfdG0mveTIRa
 w7BRr39btm2VXEPMAhW902EgfpEmy0HxSe1wqDRg6LVvXb37iq1uOqTwyU78M2NdSbIz
 DU4orRAccvkiXPqla8l6eE/C4tazZoreLvYR+LC56AX148c5meabhuz0GhaxARWy47xR
 7qf0JhQv12XuwLywKdxQ2WBs9Xt7LmQsG7z7MzXywsDrg+98xKziX7ITVrsUt08l6Nhu
 mIZiPdYNz7mDS187UjKHOW4guqiH0+GP7n88rUqr8yCICKT1aC18VNQW2icl3vIj5gY6
 M6Ug==
X-Gm-Message-State: AOAM531pJ+s8DGEZEYoY8P/kjCOeAxDN3I7OYQ4fl46DdN1wNmEpRVR2
 JlgW28ATBifbbMaIfTs4hZIJ
X-Google-Smtp-Source: ABdhPJzedmVR729LAKa3+B0hZGeKE4pYmHO6lasGnkD1nL/whI3qy1v7blA8jiftDQqSoyWXN7fPAg==
X-Received: by 2002:a17:902:9a4c:b029:d6:a250:ab9f with SMTP id
 x12-20020a1709029a4cb02900d6a250ab9fmr24126046plv.20.1605145426755; 
 Wed, 11 Nov 2020 17:43:46 -0800 (PST)
Received: from xuyuqing-ZenBook-UX425JA-UX425JA.huaqin.com ([101.78.151.194])
 by smtp.gmail.com with ESMTPSA id
 m6sm4062413pfa.61.2020.11.11.17.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 17:43:46 -0800 (PST)
From: xuyuqing <xuyuqing@huaqin.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: google: dt-bindings: add new compatible for
 sc7180-coachz
Date: Thu, 12 Nov 2020 09:43:27 +0800
Message-Id: <20201112014328.695232-2-xuyuqing@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112014328.695232-1-xuyuqing@huaqin.corp-partner.google.com>
References: <20201112014328.695232-1-xuyuqing@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Taniya Das <tdas@codeaurora.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>, cychiang@chromium.org,
 Patrick Lai <plai@codeaurora.org>, Andy Gross <agross@kernel.org>,
 dgreid@chromium.org, zhouguohui@huaqin.corp-partner.google.com,
 devicetree@vger.kernel.org, tzungbi@chromium.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
 Takashi Iwai <tiwai@suse.com>, xuyuqing@huaqin.corp-partner.google.com,
 Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, judyhsiao@chromium.org
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

Add devicetree bindings for coachz in documentation file

Signed-off-by: xuyuqing <xuyuqing@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/sound/google,sc7180-trogdor.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
index ce050a9dec94..5095b780e2c7 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
@@ -15,7 +15,9 @@ description:
 
 properties:
   compatible:
-    const: google,sc7180-trogdor
+    enum:
+      - google,sc7180-trogdor
+      - google,sc7180-coachz
 
   audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.25.1

