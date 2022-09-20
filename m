Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF788ECAAD8
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Sep 2022 13:29:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E422B161F;
	Tue, 20 Sep 2022 15:28:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E422B161F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663680566;
	bh=WOUQBrIy2nuOaYfvDaQXTDXDqtrzKIbQcne/3MYSJbg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I9KBOfWpuaWHML1AEJ1wC/Fo+HMU1JJm5lMQFDoXopLtl09oTD05R2ouZwXKJxt3E
	 Eg+IVafI5HX41i9a8d7wEGmZVo18g3K2OSP7znXxGA5rvsSrYxVuwLLfyllgkA2o/y
	 W9bNboD3cRYIDiteitYRiX1Cu6d6FaAr5pj4tYq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B152BF8053D;
	Tue, 20 Sep 2022 15:27:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1DAAF804DA; Tue, 20 Sep 2022 15:27:39 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C94F5F8012B
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 15:27:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C94F5F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JGnJqYy9"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A4EE4B8293B;
 Tue, 20 Sep 2022 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB3C433B5;
 Tue, 20 Sep 2022 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663680451;
 bh=WOUQBrIy2nuOaYfvDaQXTDXDqtrzKIbQcne/3MYSJbg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JGnJqYy9PZG4SYQaDS8DD17bSV5ZObGQVIk8b/vW4R+D53BI3IhxOuA7hePFobBs6
 5UrVMIMaABXcM0Ka/9/6H3sudRQIfbDeTfOWWxo+nGZbHZN45xR725m6GhV0kqugo1
 yrt7iwhKLa43o2nm7TlD33hX9bEpWtPJkLjaiiuUJviXhvMO9NzGmmiC3sWS5cB3Pb
 enZCTUGqgsMB3b3M1R6pRPoa8PX6+gpfLfWUbXL6OsGA+eTKAOvwOt5Egjr73ifsO5
 QxOcOBqrTvcLOz3hsF23mN4v7AqP7n7ktSEUKtkheXOfG9WJENv9CjTAhPhnrJI/Er
 Km4Yh14ldfewA==
Received: by pali.im (Postfix)
 id 98E342D4C; Tue, 20 Sep 2022 15:27:28 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 2/5] ARM: mvebu: add audio I2S controller to Armada 38x Device
 Tree
Date: Tue, 20 Sep 2022 15:26:45 +0200
Message-Id: <20220920132648.2008-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220920132648.2008-1-pali@kernel.org>
References: <20220920132648.2008-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

From: Marcin Wojtas <mw@semihalf.com>

This commit adds the description of the I2S controller to the Marvell
Armada 38x SoC's Device Tree, as well as its pin configuration.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Tested-by: Nadav Haklai <nadavh@marvell.com>
Tested-by: Lior Amsalem <alior@marvell.com>
[pali: Fix i2s-pins name]
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-38x.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index df3c8d1d8f64..11e0e4286ec2 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -289,6 +289,13 @@
 					marvell,pins = "mpp44";
 					marvell,function = "sata3";
 				};
+
+				i2s_pins: i2s-pins {
+					marvell,pins = "mpp48", "mpp49",
+						       "mpp50", "mpp51",
+						       "mpp52", "mpp53";
+					marvell,function = "audio";
+				};
 			};
 
 			gpio0: gpio@18100 {
@@ -618,6 +625,18 @@
 				status = "disabled";
 			};
 
+			audio_controller: audio-controller@e8000 {
+				#sound-dai-cells = <1>;
+				compatible = "marvell,armada-380-audio";
+				reg = <0xe8000 0x4000>, <0x18410 0xc>,
+				      <0x18204 0x4>;
+				reg-names = "i2s_regs", "pll_regs", "soc_ctrl";
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 0>;
+				clock-names = "internal";
+				status = "disabled";
+			};
+
 			usb3_0: usb3@f0000 {
 				compatible = "marvell,armada-380-xhci";
 				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
-- 
2.20.1

