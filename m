Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A002C63697
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 14:02:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757802223D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZCBmdRcE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxD4BW5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757802223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C911017B9;
	Wed, 18 Nov 2020 15:01:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C911017B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605708165;
	bh=cdCnhWNwtTkMNU7okWv2gCB2pWFhZYO+A3MGfiypVqQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZCBmdRcEDCvLQwcQzvPOPpH/Ce+TTeeK6A1c6Lqy+mcEsrzv3CjoGBn3kt4IwmPFI
	 OMvMu25aiUZIXKk2QHNRyeE0fvp4YaNOPcgWZlywKjaFEKCez90rveNePgwgMsusbG
	 2wzDwVj85IV9oDcbGaEjM7wbyO4crqY9gq69QBCE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14694F804F2;
	Wed, 18 Nov 2020 14:58:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96534F8016C; Wed, 18 Nov 2020 14:58:52 +0100 (CET)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77BB8F8019D
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 14:58:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77BB8F8019D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YxD4BW5c"
Received: by mail-ej1-x644.google.com with SMTP id f20so2885049ejz.4
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 05:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MNzWsDtU39BR4iFEfSJQ9mnoYu92ToJLMEGgLWUUrPw=;
 b=YxD4BW5cjmQdz4D/NWPOTYFDoj79erTso5jj6MSUrfUHf5OPHU//Y+UjP6rHQ8VYEi
 vBjQQBNvcP9cw+uaMWj5PTsXnqGwi+kVyf/BQa0kDaY381yNAEK3VpqAAZ093jnk/LMK
 uTtUZiMYKd8Yzkuafi0CZD6v8UN+ngYxLTCukSBE1wNJ/fl4NlZ4t+DWlUI+C/vjax69
 nouAaB5P0vcCRk3Ub6qTmGOojyV8lhP+JClrNBmQxficjyoktGm12RqQIMnkW051Za3x
 r2gagmHv/V2uVmIY3M0N9T9Dl9MIz3112FQOwMO59615Oe+Zq9Y611rb0gojGj2SwgSl
 KrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MNzWsDtU39BR4iFEfSJQ9mnoYu92ToJLMEGgLWUUrPw=;
 b=E7Nyg2YEf5sAd45UZNDI3g7Vx26bGaAdWaIJ/TXz5Vq7u84G/v/SmJeHErggqorChw
 guib4LB8N3XnfmGbZo8/2TX9ttNzx2S846Nh3arTvubjyEk7h2SbLI1jrGShmYFwgAj8
 L1ca4FUtXBISfHhPHXKVj4HM4Jm24U9ST0PaLzm0yeIh8WxTt8U+bOs1E6DONp6/3Wsv
 4j2W/kydBQhQJ6jutJHBKve9oH37sOHLuXOCRiQ4WeesmeK48tDMAtOfEmpSU8r6BW58
 GtHhlysCLOF9JdW/1oaK2tuZwhncEmsFlJ7sIDdht+u9mI4ln8mzfzMvDjEAYX/VXEVe
 Wjvg==
X-Gm-Message-State: AOAM531crKV5IlqjCT4fk/e8IIQ0y29gYiDnlT3QlxMLzv8aLeBTvBe6
 ba/4L6Ro+NI1tOXlNjAkHyk=
X-Google-Smtp-Source: ABdhPJyl5SpYNZp2HUHCYYO8l+T0uxxnjSi9rjNGR0CciOkx5xPSCoFR3ksws8b0r8sM04dsBaG9wA==
X-Received: by 2002:a17:906:374a:: with SMTP id
 e10mr14400381ejc.246.1605707918063; 
 Wed, 18 Nov 2020 05:58:38 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id cx6sm13721384edb.61.2020.11.18.05.58.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Nov 2020 05:58:37 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v5 7/7] ARM: dts: rockchip: enable hdmi_sound and i2s0 for
 rk3066a-mk808
Date: Wed, 18 Nov 2020 14:58:22 +0100
Message-Id: <20201118135822.9582-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201118135822.9582-1-jbx6244@gmail.com>
References: <20201118135822.9582-1-jbx6244@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
 airlied@linux.ie, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org, lgirdwood@gmail.com,
 sboyd@kernel.org, robh+dt@kernel.org, broonie@kernel.org, daniel@ffwll.ch,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Make some noise with mk808. Enable the hdmi_sound node and
add i2s0 as sound source for hdmi.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index eed9e60cf..5fe74c097 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -116,6 +116,14 @@
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s0 {
+	status = "okay";
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.11.0

