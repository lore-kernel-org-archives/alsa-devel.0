Return-Path: <SRS0=1Izd=FK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BA1C4361B
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Dec 2020 13:36:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF36322D08
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Dec 2020 13:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF36322D08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3109B179B;
	Sun,  6 Dec 2020 14:35:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3109B179B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607261809;
	bh=e1CdGycGD6LX6+DJfyJDdmzXiXHPLIi8pyzGeSRKKJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pJ7bmUXOeoj3mFi9HdKjwxUCCaY/NRkRb4s+BGMpnwMLiu93BDjMAHxjpfToiPKZq
	 Zx7fXLJXutVNMsNEW6VXvghEF4jUVlxNt1XgZT4NL9F3tf1bLqgxRpLIRxW0G2iCx3
	 Fa7TY0SkOtd6FXS84UPctYzh59lyADsNuG7nrPi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1689BF804D8;
	Sun,  6 Dec 2020 14:34:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFA58F80260; Sun,  6 Dec 2020 14:34:18 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07B50F80253
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2020 14:34:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07B50F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VyMr2Z2Y"
Received: by mail-ed1-x536.google.com with SMTP id u19so10821212edx.2
 for <alsa-devel@alsa-project.org>; Sun, 06 Dec 2020 05:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
 b=VyMr2Z2Y2FxVMjApnc35MnfMrKlfVe62MA73cWFUYFKdSao13p18AZKDCQ+AunENQJ
 0smVDtZJueGCSqpz90+Q0ghFZy0UViSu31AEWd+pH6kF9OrNDBnodljF3Qy1MOMO58D5
 xKBgYx6mK431AusxL2+qYZ3hU0+QZf7tmbPdtREX/jsFaUVKjlzkkEd6nokY+CZEoK8e
 DJzHQ0qWdcPIdsqqNdLd1pFK4HJ5+t24UPV5b7Hfp0V19a8gLDU/jd8jwIpAgEvA/4WM
 cyxB2IpQUGhhs4YMLz/fi/zrcf59//JIl7DLjaXmj72PowGdVJkZfVYHw7ifH/kjhoDG
 45Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
 b=YKlVA32WS2riMc/RGgrFDr9n2IN2oXIJBKWUj6YMWGooaOScrWgwqByTy1lmWNBorb
 JJgjjSTrVsRDIiCLgt7YL/1q602gpOiq74lJEFV1CQkYkgUymQGWhTgtcVFB+ht6Bbbf
 6EnS99Ov5wh0jlCmkqvS6K8X2HeAtVp0RB2VLXrzFR9F4tgoDxiFebE2XaIRuQwm52+e
 TiKPkuB+qsU77a8sPDs23E7hpmlsywjlQFyGeCeubKquL/BZ3guVkiFaEg1xEY+nLaqj
 5x9HfKuM7MHTFlj1/ByQAN1dqWPZ7iWOm6O9s6HPB3A4L7ltYzAti5wDsiKcHXARbQq+
 bA4g==
X-Gm-Message-State: AOAM531r669AJOGWsjbHTfL4wrO4g98ADN8Pc5s9i3MEzsIjlwJirEl+
 yPK+Ed988H93qhhJla0WegE=
X-Google-Smtp-Source: ABdhPJw1Wm1W5qPXXa98kmLBiwpshvAAU1dUvFzjqg3/KeUGfBrmVqaOo4gngpFc6QMwaVBCy31C+w==
X-Received: by 2002:a50:dac7:: with SMTP id s7mr15721439edj.106.1607261650199; 
 Sun, 06 Dec 2020 05:34:10 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id qh23sm7770129ejb.71.2020.12.06.05.34.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 06 Dec 2020 05:34:09 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v6 4/5] ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
Date: Sun,  6 Dec 2020 14:33:54 +0100
Message-Id: <20201206133355.16007-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206133355.16007-1-jbx6244@gmail.com>
References: <20201206133355.16007-1-jbx6244@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, broonie@kernel.org, hjc@rock-chips.com,
 dri-devel@lists.freedesktop.org, lgirdwood@gmail.com,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org, daniel@ffwll.ch,
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

Add hdmi-sound node to rk3066a.dtsi, so that it
can be reused by boards with HDMI support.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 67fcb0dc9..f91ce3054 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -49,6 +49,22 @@
 		ports = <&vop0_out>, <&vop1_out>;
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+	};
+
 	sram: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x10000>;
-- 
2.11.0

