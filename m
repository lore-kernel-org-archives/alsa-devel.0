Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD91C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 06:17:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF87F60F02
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 06:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF87F60F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5716416D3;
	Tue, 26 Oct 2021 08:16:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5716416D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635229041;
	bh=HVNhZEosIZG2ZOM5a8TxEntfP+mglIaWAAeEWFr+3YA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CsVEqPcP+HiTvuCtXrRf3kqfqQRa0UzOS49mIs2hlRIE4c1e4Iwp33boXs7CDoDzh
	 Wwwj/8gSPEmRZxRHFJXosjJ8HiR5jl/Yyj86VZyU7261tfnw18uXaYiHGDX0ZMmuPp
	 IBosZRmxhbIua+WL3nMj7GrkikPWxrF3V9AdX6T8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16781F804FB;
	Tue, 26 Oct 2021 08:14:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D551DF802C8; Sun, 24 Oct 2021 11:44:03 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DD56F8013D
 for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2021 11:44:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DD56F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HSwL1A9Y"
Received: by mail-pl1-x643.google.com with SMTP id i5so5856874pla.5
 for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2021 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=koX01uZWlNS6Kdoh31vOXRzgvcfPWXmHOS+HdaxihXo=;
 b=HSwL1A9YGktQJTMqsCMKdB9+CPrT6cUxMYh9g1WXPmwmMiGRXnoYwN24kz94Vnf67s
 4XSfRGhyCX7R0yDuzetkGxleNiqGyUPH+M8qQqZaRlIBAPUcNIJRlydbv39nWbePKa+Y
 0ypGKX1FeKxwoOBBjczq2S7F+PRNQzfgRr9oxTHgxPEXPcLhOOVYYa18CRYpVePm0iiZ
 ocDQv7XnhKeFFWGkPqDnP84sLuhXoIA0XVUbczGs5y9/Cri4iazqUJq5+mGEECx8T2V3
 baUUJy1rcMH7IraHuFbW2RxXExFHdIHafKMmE42mo7e1vhm5cLFlRdk4vpNw7FOm5LyN
 cofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=koX01uZWlNS6Kdoh31vOXRzgvcfPWXmHOS+HdaxihXo=;
 b=eM3MJQ2O4LQFu9cusx0bSBRMaH/HSsAeI2BPeAquaT8Ssmo0yXOb0cLK7Tnt8xcEfW
 9c4A4LxKlsbeN36CBUmr+M0RUsH3ww+1rp3of+TeJQWmB8tMWwVi/XwBjipME8pzKmBa
 NZ/8ejEvOFaU8fgf6u/MXu8bQK/j8iBvv8C1ho5PnXUIr4UbTcbD4+Tk+m86vnMiDSKP
 4tDNGJC1IdyiUHwfH1iBtEafmi80AINnXesQgFKUlvohkZSrLcdmW5EKM7F7OGpsOjHr
 F2MAbWvp6rLb3JoQwdRn0QXQRu892voPQZPCzHVB9u+ovN1Rid/B7HPtyl3qoG3g+mE0
 /nSg==
X-Gm-Message-State: AOAM532GC4pPN1CGpvrli0rhn25QrOKr0pcMtPPxa2QMdj0MpBt00JeS
 HFzpDRdxn+LpjPf3JjnFhIY=
X-Google-Smtp-Source: ABdhPJzAI733xx8YDzpNfnXppn57xPuG7NBFYIs//bB6I8NYhti9wOBCw/H9HAFq2+ukvRV3+fGunA==
X-Received: by 2002:a17:90a:5642:: with SMTP id
 d2mr27213022pji.200.1635068634203; 
 Sun, 24 Oct 2021 02:43:54 -0700 (PDT)
Received: from lxb-server.lan ([2403:18c0:2:7e::1926:817])
 by smtp.gmail.com with ESMTPSA id p16sm17636619pfh.97.2021.10.24.02.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 02:43:53 -0700 (PDT)
From: Yunhao Tian <t123yh.xyz@gmail.com>
X-Google-Original-From: Yunhao Tian <t123yh@outlook.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] arm64: dts: rockchip: add spdifrx support to rk3308.dtsi
Date: Sun, 24 Oct 2021 17:43:17 +0800
Message-Id: <20211024094317.1641949-4-t123yh@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024094317.1641949-1-t123yh@outlook.com>
References: <20211024094317.1641949-1-t123yh@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Oct 2021 08:14:36 +0200
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Yunhao Tian <t123yh.xyz@gmail.com>, linux-arm-kernel@lists.infradead.org
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

From: Yunhao Tian <t123yh.xyz@gmail.com>

The Rockchip RK3308 features an integrated SPDIF receiver.
This patch adds support for it to rk3308.dtsi.

Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 0034312ef8f4..bbb0d2c74505 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -710,6 +710,22 @@ i2s_8ch_3: i2s@ff330000 {
 		status = "disabled";
 	};
 
+	spdif_rx: spdif-rx@ff3b0000 {
+		#sound-dai-cells = <0>;
+		compatible = "rockchip,rk3308-spdifrx";
+		reg = <0x0 0xff3b0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SPDIF_RX>, <&cru HCLK_SPDIFRX>;
+		clock-names = "mclk", "hclk";
+		dmas = <&dmac1 14>;
+		dma-names = "rx";
+		resets = <&cru SRST_SPDIFRX_M>;
+		reset-names = "spdifrx-m";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_in>;
+		status = "disabled";
+	};
+
 	spdif_tx: spdif-tx@ff3a0000 {
 		compatible = "rockchip,rk3308-spdif", "rockchip,rk3066-spdif";
 		reg = <0x0 0xff3a0000 0x0 0x1000>;
-- 
2.25.1

