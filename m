Return-Path: <SRS0=cdus=L5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6334C07E99
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jul 2021 19:43:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F43461961
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jul 2021 19:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F43461961
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABE3816FE;
	Mon,  5 Jul 2021 21:42:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABE3816FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625514218;
	bh=uwv0Eh4Pbs4VWAXXN7AS1twbjlGITpUC+Z5Ot/y197c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W5ZaYyazGniXICm0eerty4hGV3dC9dS3Eb5+tTWICflfUb6LSgFHQfCVPy1dPgHFS
	 HsURmNoxqWL23/zyCbrPIRszL/mbCm+lUcNOFXUDLNqVpHCGEKxL5BXUXOWZtLSnXI
	 xOoqkpMtbur6yuiu+RYe/pqTVfhJgfB1QMB1H9qs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 563E1F804F1;
	Mon,  5 Jul 2021 21:40:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F02A8F804E3; Mon,  5 Jul 2021 21:40:44 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58EA2F804E1
 for <alsa-devel@alsa-project.org>; Mon,  5 Jul 2021 21:40:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58EA2F804E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="jIBShcjC"
Received: by mail-lf1-x131.google.com with SMTP id p21so12451677lfj.13
 for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2021 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4k2Lhi4XHADfERCSjwVFS16vtcOe6zIC8KQOlIMZU8k=;
 b=jIBShcjC538JgnK5C1XgwRkm84HPCDo2Hdh+9fu6oOVgK2q4u5PvyN5VYtzntyBjII
 6jN6rKHFv6hNbdQJma9QrVIepKrIXuuSDv59V598BtWKaVNmJ2+wlvLYyAY5xXmZv26w
 FdoiqeygVU6pF9X4l7mfqkrIhlG/lLAB9LGj6EYYozGFlK5Vm9FqTAc7lZOpazXfgrmV
 EAUwD3zEsb+pRp/JSUYL6agQ+glq6EvyANNhMESjG3DLTKZU14fgHzewB587CpxteplW
 KGmxt7uybe4hyNaoZJa4hkBVjOgBDVz+HBtDBy4j1VmYjXgIczbv5BHeEIZ7mC03uDWw
 QOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4k2Lhi4XHADfERCSjwVFS16vtcOe6zIC8KQOlIMZU8k=;
 b=rMwcwKdP2uEtJOgHxEyPxq/yruAbh1XgINoy6yodzhXNyHHt50oczMX+D+B++Cs9Lv
 3qeMO5C9FmsM3Br7VAYQ9BVUrW7fQqFl9prkM9MoL7dp3Ok2mXnepTNVuPtAYoCnX1KX
 z40L9nVzMu/BRbpg5TZ4rCNpgOX/l2l2BseXE57P8/Aqw9PeTaZvq9uBOavYgoCtpzil
 LBoqC94//xeSz6Zw2zB6jTvIJx/RxrN6vG2rb61D74T3M2JZukD6k4CXUaxMMleSTsXM
 oJdYivgkaYOXSdGXmiqyu39uPIpNpOMCxCO4fr9HJ58/TclAOUeydlBpmGSKT6cOn8Ra
 sInA==
X-Gm-Message-State: AOAM531o9mbOf3vLkXGk5mH5+sw94MDIlGV0noyuUVG7WOKfule8bRSf
 qjuXfcRrwg5NUXuD0xHTGw0=
X-Google-Smtp-Source: ABdhPJy3GFU9RNsdeWX4eXSH9emH5bwRVUeKs/Ymfcu1rya5YJWrsKgzCGG/dhCkwa9ZTlYfj91zZg==
X-Received: by 2002:ac2:5234:: with SMTP id i20mr11343792lfl.2.1625514036078; 
 Mon, 05 Jul 2021 12:40:36 -0700 (PDT)
Received: from localhost.localdomain (91-155-111-71.elisa-laajakaista.fi.
 [91.155.111.71])
 by smtp.gmail.com with ESMTPSA id b5sm1167248lfv.3.2021.07.05.12.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 12:40:35 -0700 (PDT)
From: Peter Ujfalusi <peter.ujfalusi@gmail.com>
To: broonie@kernel.org,
	tony@atomide.com
Subject: [PATCH v2 4/5] ARM: dts: omap4-l4-abe: Correct sidle modes for McASP
Date: Mon,  5 Jul 2021 22:42:48 +0300
Message-Id: <20210705194249.2385-5-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705194249.2385-1-peter.ujfalusi@gmail.com>
References: <20210705194249.2385-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: hns@goldelico.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 lgirdwood@gmail.com
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

McASP only supports  Force-idle, No-idle and Smart-idle modes

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 arch/arm/boot/dts/omap4-l4-abe.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-l4-abe.dtsi b/arch/arm/boot/dts/omap4-l4-abe.dtsi
index a9573d441dea..8287fdaa526e 100644
--- a/arch/arm/boot/dts/omap4-l4-abe.dtsi
+++ b/arch/arm/boot/dts/omap4-l4-abe.dtsi
@@ -192,8 +192,7 @@ target-module@28000 {			/* 0x40128000, ap 8 08.0 */
 			reg-names = "rev", "sysc";
 			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
 					<SYSC_IDLE_NO>,
-					<SYSC_IDLE_SMART>,
-					<SYSC_IDLE_SMART_WKUP>;
+					<SYSC_IDLE_SMART>;
 			/* Domains (V, P, C): iva, abe_pwrdm, abe_clkdm */
 			clocks = <&abe_clkctrl OMAP4_MCASP_CLKCTRL 0>;
 			clock-names = "fck";
-- 
2.32.0

