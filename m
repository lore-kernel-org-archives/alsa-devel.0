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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7403AC4332B
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:33:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40B42070A
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hCgX3VHO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvEENzKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40B42070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45157166A;
	Tue, 24 Mar 2020 13:33:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45157166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585053237;
	bh=MTk1NYcK35bQ52qf8Bxr6inpNQy/0xhtfdcX+IUHsPo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hCgX3VHOlX+WbXSKJWYMxVRMS58r/0yTpAue4IXlzbw1PQd900Cxt4oY6hfw9Jx96
	 zd6cJjAOTnmAAbVOWkfz/iBhbLDb4gj5RLW8jYC6JTIaINEYS9l7pYI4J57G2MHjjK
	 00jNtx1e4vq0UgLNiwMizF2pVxzz4oeX2jB/1H3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCCC4F80290;
	Tue, 24 Mar 2020 13:32:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BC58F801F8; Tue, 24 Mar 2020 13:32:10 +0100 (CET)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58B02F800FE
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 13:32:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58B02F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="XvEENzKw"
Received: by mail-wr1-x443.google.com with SMTP id 31so15170772wrs.3
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q8xyTZiiURMuZz55C+lV5frFi0juzWLh763pjmleRTI=;
 b=XvEENzKw2wGFTbrDGRT3ml/i9ciXc0tz7Wabz9yXGUzdkYE4+jwsp4Oz1tZnNsOQCx
 RmPmOt4EITNYP6enElBEOeeXIbsROyVn/p1lqndCXnzohUIBGvGRb/tiN60CTc0I7iJD
 l/pmAsVQna4eQPy3zsl1/eAfMPmPFeItIjs13dfnfRxcuhygA1DmUnp6Vu6Qm9nrK95+
 C6KCyFvUph3EfIxZqM3ZoEDoFrelVWO3c2sdPswtZjzNRrhkihhX/2HLq+yNX0gom61J
 zOVQeIk0PYGQCuoLabwoEAX8SlcTWE0gGuPQKBMgrN383EZ+iVcL4ZkKcqHdJOK1Htk4
 62JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q8xyTZiiURMuZz55C+lV5frFi0juzWLh763pjmleRTI=;
 b=O7RYocvz4AJP6XIxXOcRUNKCDktfwiN30TW8xyss3gbSJsLGS6f7c9ivSV/edHkTTx
 53IxOKpJEpPcvG2HJypNWD+t7m5NOIYFGhzfW7zDk4Vd7VV9bLvn42pEnL/oq3ufyuRv
 6gSJyzGZC+tVK/lIbsOEtJa9IaOTe1/sqvbtArkONehLw5CwVrJa2SyuVECWJA/eJBEV
 92m2K+mwYnPHLLuYUk6oFZuHNRiEWli8PO9Kxgws1fjZCB3UHgrDauJ6SIXv43A+DlIf
 cYzGlFI4q3PDn/Kf2ZBKjZeqArpv1/MojUXnSbP5Zdydf+vx4gxA1kNPsZTKO1HSroir
 2JOA==
X-Gm-Message-State: ANhLgQ0uKgojsuVSPNEo2gYzu2R3atanAUTxXOyxfBLCYch6JoQnkoMV
 uGrgsaCYAB5ka3PGlAF/Ajo=
X-Google-Smtp-Source: ADFU+vspS2iaiHICA89DEah3/meoLs+mzhJGZMZqXh2WzZtOitG+ZLB8tygXug0W+SCEjGmNzcIUmg==
X-Received: by 2002:adf:f892:: with SMTP id u18mr27024616wrp.367.1585053124710; 
 Tue, 24 Mar 2020 05:32:04 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id k185sm4215029wmb.7.2020.03.24.05.32.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2020 05:32:04 -0700 (PDT)
From: Johan Jonker <jbx6244@gmail.com>
To: lgirdwood@gmail.com
Subject: [PATCH v2 3/3] dt-bindings: sound: rockchip-spdif: add power-domains
 property
Date: Tue, 24 Mar 2020 13:31:55 +0100
Message-Id: <20200324123155.11858-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200324123155.11858-1-jbx6244@gmail.com>
References: <20200324123155.11858-1-jbx6244@gmail.com>
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

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like 'power-domains' for rk3399,
so add it to 'rockchip-spdif.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index 0546fd4cc..f79dbd153 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -51,6 +51,9 @@ properties:
   dma-names:
     const: tx
 
+  power-domains:
+    maxItems: 1
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.11.0

