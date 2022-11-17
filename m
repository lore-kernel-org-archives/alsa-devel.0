Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B91C433FE
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Nov 2022 08:43:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB37C1696;
	Sat, 19 Nov 2022 09:42:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB37C1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668847414;
	bh=zmGF4noHy7v/DUIAEvVI6KpAvIYJyaHR1qQnK5xNU4s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntSh0ADbe3X/1AvRXuXSvEPD7/RYH8WQL6reGcTnLeyhll65bMfsO5MogriskjMU+
	 QrDTzdcBCAsOlHEUXWSpXSEb0nR+tl3+dDtufm9mNrZvNa36/vYZL2DLLrS5ey9/Mw
	 P8HvKOecF6/OVLTiqZSXD80qjSB7p74RhdekZPU4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70F5BF80587;
	Sat, 19 Nov 2022 09:40:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A11A2F8051D; Thu, 17 Nov 2022 13:39:18 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 416CFF8015B
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2022 13:39:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 416CFF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="nGQ/qhtu"
Received: by mail-lf1-x136.google.com with SMTP id j16so2533490lfe.12
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2022 04:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHKEAmsNgrv5kSrbKaB4tLuFW91sEV9E738nyh8xMYc=;
 b=nGQ/qhtua+7pLZ4YSQyBIVtNYJgSwlmE5TpLx1oateA+BN4Fkgc57IFGtVkEd3XOUY
 OUU8btqbDJ87U0Vfh9BOtEQ2QX0NRwxWic0CiPkHzjuXerJtF9mMEkr2ctaBjbhrsI9l
 xzGUr6iwCmwuZJQDlBRY2v/DLhzCQr7D56BI7V0HJS8FlOgLbPwUK7GCnhOiKnqE3nN1
 mYXEYUE33TxRnczOoemTDlOmAGh89yBAu2koQyBjxYbKJIE2WkCdMeNzg9Krk9/Emy+R
 nUorOO10hpgyDies6XynMDR4bAeszb76YUfWXo7dU95L68xj0jSU7qa5bYpT4o4P506L
 LQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHKEAmsNgrv5kSrbKaB4tLuFW91sEV9E738nyh8xMYc=;
 b=6HnXiDCAkYlSt5ZJBFLXHKAl4kwvT9fEHUqbk62hHu/Ys0uwN3SU98LtRN0n3Y51jC
 JwCzDMcIsSLFzJG6YzT8kBJCIvHWGOg3nyVNo1YKCtKf1GalFZDg0OSF+D1cV21q84Jn
 szodjF0Shcxf5eQ1JVzlI4e3S6BJNmnqNha86HhLHvSj78427sQ7ANhXebcOCxZzwUTU
 Ri0+4A8g/EfG+AjCOpJRcrT6vRVpBkFbZIVZA4zaxQA+iZuTHNN0XC0olPaMMISfYG6w
 B/RmoEhJeBUFcXiOtZnfkOqDT2jt8pITBuo21OKROhpzAYJ9EpRgcxLXGPc7yc4d6biW
 L6AA==
X-Gm-Message-State: ANoB5plMuxWO/mj8XzsaNo36PeKg8R0ipHmKzOSRXxcv+mPtY61pOxye
 rnmD/+E0NjNCQViD6a/ZskdlWg==
X-Google-Smtp-Source: AA0mqf7bJF5hus73SI6iLS9vfYrboHghUm1Qt5VwLMlR9isaWE2bW+dP7MA4lSYoYUkY+ERTSndLsg==
X-Received: by 2002:ac2:4c46:0:b0:4a2:4f6d:78d6 with SMTP id
 o6-20020ac24c46000000b004a24f6d78d6mr819625lfk.679.1668688749810; 
 Thu, 17 Nov 2022 04:39:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl
 (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
 by smtp.gmail.com with ESMTPSA id
 u28-20020ac24c3c000000b004972b0bb426sm127855lfq.257.2022.11.17.04.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Nov 2022 04:39:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-can@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
 linux-usb@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-watchdog@vger.kernel.org
Subject: [RFC PATCH 3/9] dt-bindings: clock: st, stm32mp1-rcc: add proper title
Date: Thu, 17 Nov 2022 13:38:44 +0100
Message-Id: <20221117123850.368213-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Nov 2022 09:40:30 +0100
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Add device name in the title, because "Reset Clock Controller" sounds
too generic.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
index 242fe922b035..5194be0b410e 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/st,stm32mp1-rcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Reset Clock Controller Binding
+title: STMicroelectronics STM32MP1 Reset Clock Controller
 
 maintainers:
   - Gabriel Fernandez <gabriel.fernandez@foss.st.com>
-- 
2.34.1

