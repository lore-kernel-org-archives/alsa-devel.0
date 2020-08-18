Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8CFC433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:43:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575F82076E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HriGffZz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNH7Rb4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575F82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1D5C1781;
	Tue, 18 Aug 2020 16:43:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1D5C1781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597761833;
	bh=fNwZ5tJO+gAvlLoAKSWPXktLBc+TmaXWjd2yxlJUP/0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HriGffZzU41zATVWS+I8GLB/vhze8vwSOeaztqpExI2l5xD1j+HCNj8bFqO1Ia90G
	 loH2aalso0lvDYPeHp+aM3VDR8ygGmjFaFZsKb8rtVjdMFCLcoqA8t4kVCFW8jHM9/
	 mUrmn9Rm7aUKMZNc6xlEwaOhYT2/b0vg5lFIpszQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59B28F802C4;
	Tue, 18 Aug 2020 16:37:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4517F80338; Tue, 18 Aug 2020 16:37:42 +0200 (CEST)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4670F800D3
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 16:37:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4670F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="aNH7Rb4U"
Received: by mail-ej1-x641.google.com with SMTP id t10so22353773ejs.8
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=2UQZEODYOVCRlh1QRejLi/WzuJNA7W+JKPrcqeoHOhY=;
 b=aNH7Rb4UjQ427P0G/2djpJOYW+4jNcYTY5ueMZJdI+aPHwfi9IVWQ5lmpfsxgPoOyD
 2TembDjnXLlrJ/a8M5UAgVp4WnapO1DdLv6Z9TXH+CUQY9aWYahxInWFDBtnf2ZckZuK
 AXKdp/x2y4mmrDILUtOyZd5aSuFkRAX+X5z2oiFaOrCkQ0ZugqWmLtDxySXxGmQA2Yvz
 tep14aDEZDuEhoOfzeyidXqBxarz8eiwUJhOMdkx0QuWKYJN61zxdkXc/CgACP5Oco+T
 xJgT5p2ERAXYe45DoMXsh1b+c31xNrWX9ZRHjX+1wIklQj71eMW19I/v0zCKuEdPPIax
 Q5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2UQZEODYOVCRlh1QRejLi/WzuJNA7W+JKPrcqeoHOhY=;
 b=TgmX7a1643JZJ13k+741J3L4PrWLV9ANt2QV/FKiZG9WFAxtMYRet2xYBNXDMOqSiM
 n5k63UYZtrTRIVtLbLthr8x7SQy/hIxznMfa7L/80jw6jr20OkGmS9qkXiWdyc2zFZf6
 EV/OpQ/hDmOms7fGB5//ZsnR5BLSZP0JPVTbgwuhgKjbRZsFGogTRHYX7fQX0GZCySee
 wwmvWw05ZyetjNtDsUQRt/etk9/W6+1Odnd7Uj6wzjHIzxQBJiWk99/MEsBsiNYRbw/5
 QAzGYqjorRmSJ562WU4+PQl7vwQ+Sgq7R3CdiQt196h/fUV2KNOCp+ZxXcPXsb8ASqPl
 3KDw==
X-Gm-Message-State: AOAM533THWSgH2nty2C4omSqEuLpV/cBIcvIE1TScbid0ACqwwW4o+XT
 1FOj+bHNLXCkIluxaclLTfo=
X-Google-Smtp-Source: ABdhPJzVRX6brDlwaMQejDzk4wxMr/TJ+2T1mXXnWNI34f1CAvmV4y0EPIUTLj8CH4kNb+vCaskauA==
X-Received: by 2002:a17:907:20e6:: with SMTP id
 rh6mr20096569ejb.301.1597761455170; 
 Tue, 18 Aug 2020 07:37:35 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id r25sm16222575edy.93.2020.08.18.07.37.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Aug 2020 07:37:34 -0700 (PDT)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v2 1/2] ASoC: rockchip-spdif: add description for rk3308
Date: Tue, 18 Aug 2020 16:37:26 +0200
Message-Id: <20200818143727.5882-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org
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

A test with the command below shows that the compatible string

"rockchip,rk3308-spdif", "rockchip,rk3328-spdif"

is already in use, but is not added to a document.
The current fallback string "rockchip,rk3328-spdif" points to a data
set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
in the mainline as in the manufacturer kernel.
(Of the enum only RK_SPDIF_RK3288 is used.)
So if the properties don't change we might as well use the first SoC
in line as fallback string and add the description for rk3308 as:

"rockchip,rk3308-spdif", "rockchip,rk3066-spdif"

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-spdif.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V2:
  rebase
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index 7bad6f16f..62a61b68d 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - rockchip,rk3188-spdif
               - rockchip,rk3288-spdif
+              - rockchip,rk3308-spdif
           - const: rockchip,rk3066-spdif
 
   reg:
-- 
2.11.0

