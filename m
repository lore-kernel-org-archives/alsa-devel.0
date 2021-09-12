Return-Path: <SRS0=uEli=OC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D4C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Sep 2021 07:31:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62489610A6
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Sep 2021 07:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62489610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03635166C;
	Sun, 12 Sep 2021 09:30:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03635166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631431890;
	bh=Volx7wmFV6PjX4Xk43ufPp11kUL+07xAbVQzs74utfY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JNIUyIn0WssUjq34gNrdB0RSm1DIo5xBIZpbhaY4bH97bDpglCRtzXmELBosLNhEb
	 e7TYagB7oQgwjODU9YFZmM54eEA8JJ0i4teVJLuDmBAS44bNhXctcMd7rA0uXqAJZp
	 1p6Vy9TLzthL/SCEWHOa5sYP/VKSsyHn4673dK0c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4937DF804AE;
	Sun, 12 Sep 2021 09:29:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D8C4F80113; Sun, 12 Sep 2021 09:29:36 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7372DF8025A
 for <alsa-devel@alsa-project.org>; Sun, 12 Sep 2021 09:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7372DF8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="mbstrXTZ"
Received: by mail-wr1-x42a.google.com with SMTP id b6so9379738wrh.10
 for <alsa-devel@alsa-project.org>; Sun, 12 Sep 2021 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CZBdcwxffYSz2RZwsY3FdiDmTR5iWVRuIsz5WG9s6e0=;
 b=mbstrXTZ7CJiqgHTD8VzbSlUC5f6gbW37gVX8U1iiDAj/2mWI2mekhdTml88dmdD5j
 V+rGzH+CeRwm4cC/MgzrxEm3KfMylmQAUszcB+yz9/QADmMXzczGMgAvbClBXXPezWPP
 2KySYmMvvflXGznsO/uxHdmT/Bbv17WAtj/WGSuX00yAcCWbr+3tmc/zasDUxRzsYg1d
 QK5I1SwNqT/Y318H0RkT/Kie+iToCUI01OZ/wffJUsMrqlD4saVwGpF8wdlXlzgdZVJM
 fafkaoj+jqafTRhMqRb6+nOmLeTUzQWMpjid90n1YyFPNguJpT/93Hh8xTYkMWacaj3L
 Csbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CZBdcwxffYSz2RZwsY3FdiDmTR5iWVRuIsz5WG9s6e0=;
 b=mrFo3n9DeuI4e6X5rChSTUER6+r3jicjLwADEbvmUI8L6+YyMF/Ejesb7ciuvVcRN/
 BeL5isf7cl7qTQzSRdkIzHXXAJeuRBC00DjbNP9rQpFv2hy2YfyhEFgTxK4LQQNFk934
 /LV60v1+XooO5NWzyaE8ftMAVYAyPbHjmPWDT3GMxdmbTT01iGEowLNHYZh102NS79Q1
 q+XRW5bfHoJSEe/MN2p+G2gIIcMBZJq3ycA/1EKjdSLfkQKhnRcl6BPK1CVRrBalms2C
 BUuCwTy4stgPFMykLHt/gRRzHoOHdwH3VMN9VOpPF2Fxfpnyp5aHkwQ2aHMETPtGhfUw
 hP3g==
X-Gm-Message-State: AOAM532evjc6xgqd4fv7UDf/ds7HQGV6w0lK7vYwMVLcjF+4ZgN61hJd
 rx6gLL8k9FJNVviveJTjO5Q=
X-Google-Smtp-Source: ABdhPJz4nvfQiFNKXBcEJWr2d1iLp+AdlSJBArr3BW9WSAH6qQxaUTFzEymeHIWc0lqAOCiJ+EZ+Xw==
X-Received: by 2002:a5d:4f88:: with SMTP id d8mr6382713wru.358.1631431762809; 
 Sun, 12 Sep 2021 00:29:22 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net.
 [86.58.29.253])
 by smtp.gmail.com with ESMTPSA id t18sm3584889wrp.97.2021.09.12.00.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 00:29:22 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Subject: [PATCH 0/2] ARM: dts: sun8i: r40: Add I2S nodes
Date: Sun, 12 Sep 2021 09:29:12 +0200
Message-Id: <20210912072914.398419-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
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

Allwinner R40 has 3 I2S controllers, compatible to those in H3.

Patch 1 adds R40/H3 compatible pair to DT bindings.
Patch 2 adds I2S nodes to R40 DT.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (2):
  dt-bindings: sound: sun4i-i2s: add Allwinner R40 I2S compatible
  ARM: dts: sun8i: r40: Add I2S nodes

 .../sound/allwinner,sun4i-a10-i2s.yaml        |  3 ++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 39 +++++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.33.0

