Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6C0C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 15:39:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AD75245B;
	Mon, 20 Jun 2022 17:38:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AD75245B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655739547;
	bh=nHdSbD037MBNsmlcd1AhQSTxDFtqe3idiSog85JclN4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1SnJZBDflSX5xRlRUlSIWBlJgx0hjZg0Atg4qLxZKpnO65qaOiUrff3QfT3inrbA
	 juoYLLl1uS7m9+pi0IUOaXOxpyWnpjahGPSetU4Gbh3SmkqOmhLIEB+ZPh2rrj+prT
	 11bCURblUjBhiM2jvJ23SWVWUXrLQTsCmnHRS5lc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27C24F89678;
	Mon, 20 Jun 2022 17:08:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48141F8051F; Sat, 18 Jun 2022 14:32:25 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D201CF8026A
 for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2022 14:32:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D201CF8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie
 header.b="V5PCq8ER"
Received: by mail-wr1-x433.google.com with SMTP id w17so8782518wrg.7
 for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2022 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=conchuod.ie; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xINpJVKkZcc5JKohFXfQpBMJJJBAJkhRdFvXLAdWINc=;
 b=V5PCq8ERofmOM5w5PRA0gL0n8OYBdm40lWb/asUOIntNfey82bGRsIn/7z+pxrNbjf
 4HTP30/j7DUAESFSB807hhF4Bn26V6IuYZIKFHoYEcp2foIsgjbMA8wAurn/dzRXLewU
 52ItLX9xQP38z8uMvLEfCM20A/gU6lUTh3j5F2TLw9cN7r3egdv+mFSv6ttkSKGiktCM
 4cZy3+rmKIWV13Hk4eddQtK9JA4//kbz9TiLmNmn6H/45fTkDeYaDf5zd/9LWbt7E4MA
 qvUYvHicfErpLqf59Y2120u88J/KmXmj/YaQstAYe0YdqaXfHU8uztd1zwCarccd64Pm
 J8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xINpJVKkZcc5JKohFXfQpBMJJJBAJkhRdFvXLAdWINc=;
 b=0VHk5R106JTBW7jwc+d2El8ZSUjLRJHp5C6FEUdnPHkPqd68sYD1UDWBto6i6MlCCt
 ScijphJ37ZN5gOQ1413rQj6h5TuTQDGFk6GpkvqF2UwBYdWM66DtvlgcdOYOznNPUAP+
 MKLM327vBiAC7mkvfKbuZtBkr8Wj5lhU2KiE+gffvhErebNgMEyadIJEnQ7xB6bk+Cwd
 alXe35KN5HhymzEK8lZGTlvGhqMJlOsFLKO9LsQsCRHjeMd7GBu7ymQZyU1xQAFODx+L
 e3NI6Zr1qm4gemQstlurpd+UZrzMIHUHAxbHS5QqdDeqEh2+fP8VegjmCxxvLVFtSecm
 NOGg==
X-Gm-Message-State: AJIora9iZZJkg2MndaKQlCy+Mu3oNSmq65V03ByczcwesS4N29RB+C+e
 Ewq062IhJEuTqEK3vUnYN5OgLQ==
X-Google-Smtp-Source: AGRyM1v9n76uzuiNQWIsMBMB4JQ7qpatVYHsEQGM4nI7CyfeZc8UgP+B/KjNDavOA6Fd5fJcVw4QCQ==
X-Received: by 2002:a05:6000:1b03:b0:216:43b4:82f1 with SMTP id
 f3-20020a0560001b0300b0021643b482f1mr13888381wrz.232.1655555541458; 
 Sat, 18 Jun 2022 05:32:21 -0700 (PDT)
Received: from henark71.. ([51.37.234.167]) by smtp.gmail.com with ESMTPSA id
 az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jun 2022 05:32:20 -0700 (PDT)
From: Conor Dooley <mail@conchuod.ie>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 12/14] riscv: dts: canaan: use custom compatible for k210 i2s
Date: Sat, 18 Jun 2022 13:30:34 +0100
Message-Id: <20220618123035.563070-13-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618123035.563070-1-mail@conchuod.ie>
References: <20220618123035.563070-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jun 2022 17:06:46 +0200
Cc: linux-riscv@lists.infradead.org, Niklas Cassel <niklas.cassel@wdc.com>,
 alsa-devel@alsa-project.org, Albert Ou <aou@eecs.berkeley.edu>,
 devicetree@vger.kernel.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-kernel@vger.kernel.org, Heng Sia <jee.heng.sia@intel.com>,
 linux-spi@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Jose Abreu <joabreu@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 dri-devel@lists.freedesktop.org, Paul Walmsley <paul.walmsley@sifive.com>,
 dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Dillon Min <dillon.minfei@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

The devicetrees using the Canaan k210 all have a sound-dai-cells value
of 1, whereas the standard binding example for the DesignWare i2s and
other use cases suggest 0. Use a k210 specific compatible which
supports this difference.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index ef46ddf3c00c..5eb6b69c1170 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -243,7 +243,7 @@ spi2: spi@50240000 {
 			};
 
 			i2s0: i2s@50250000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50250000 0x200>;
 				interrupts = <5>;
 				clocks = <&sysclk K210_CLK_I2S0>;
@@ -252,7 +252,7 @@ i2s0: i2s@50250000 {
 			};
 
 			i2s1: i2s@50260000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50260000 0x200>;
 				interrupts = <6>;
 				clocks = <&sysclk K210_CLK_I2S1>;
@@ -261,7 +261,7 @@ i2s1: i2s@50260000 {
 			};
 
 			i2s2: i2s@50270000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50270000 0x200>;
 				interrupts = <7>;
 				clocks = <&sysclk K210_CLK_I2S2>;
-- 
2.36.1

