Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9FFC7619B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:02:26 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7133620679
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7133620679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C219A1687;
	Mon, 17 Feb 2020 08:01:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C219A1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581922944;
	bh=07SJnFSa8Mr8KJLdeoYlaJp0eX0V5z6+MRmIRYSWONE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r9UZjSfpPbnznJrIKfv7pFF6LwMl+ndIj+eDxlMzUtxMlWPo5SjYVDGKE1/mnH/Qa
	 axs2mLN8DV7darUD8fay9GPh0qzsa5ID9yxTKKq9HvLjmhm6f/YBkDin5Zc4zdf4CE
	 CUSb3Iy39T9bWHaIVm1lCEO/IlnfZt7yXvBzab9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EFA3F803CD;
	Mon, 17 Feb 2020 07:44:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22C98F80316; Mon, 17 Feb 2020 07:43:52 +0100 (CET)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B7FFF802C4
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 07:43:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B7FFF802C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="QUKM6AOj"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="AQ68Ly7p"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 51C465765;
 Mon, 17 Feb 2020 01:43:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=ZF8SAW4rQvPZn
 izR7+Q+SkTY2Egxs+9JoHdYrQXsQ1U=; b=QUKM6AOjP/Twe7eoBHAQKS5dTNskk
 Zln3Evb6nyQxsbumN3xyqRalHaEM4qH60NvMudMQA04tPizlqy6ksUBmxhSvoBT3
 W8OlgZm2ZkheD/xwWGYyXoNFyRNYppDn/VYNM6qw2Wb1mNbV0f1ee1TBVZiVZbku
 uIT4kexaLomLlC8C0YbnyEfcntIubz94LyNuAEPHoNOCYx7dfDOrVjpuy2oeduv1
 RSc8bpHdsjJxZ/zS1/7VUNapzrZiibj7gFjuaQXLJ8QKLqbxUUaz8Qc4WFmV6mUn
 HV4zbU6q4VP8i2QRePZJa6R24VH7/AcFBult/ypSVAt1N4LWuer+SUCBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=ZF8SAW4rQvPZnizR7+Q+SkTY2Egxs+9JoHdYrQXsQ1U=; b=AQ68Ly7p
 zAl6vsx52jkKL75gSioyGZtz9ePntnRpVp71wzX54WBZCfB4x1sgINRDiYwHslH7
 Nky05f/DUiewyUZ87HIylinlEUp5gXAvhk43LPoLep4S85UlA5f+0xz7BkEcNLc1
 i5xTKPSLa5D/ubLvlFk5lw03Kup7j+4qnN5LQ4XGzJVZUoOCw0C9kibbTOEzAgwd
 8eCDDyXd0px1YNMMrFJ/UFZfh/0/Ftum6fWE1GLHbBRr+Gr14vcTmuAeMudpFmsr
 /qrZ9OrG/wC5F5/FFWJE89qyqQn0hZ7UEALGbOsY81aIFuhwIkfue3himru0Y2FR
 QV6GN2XqFfHhMg==
X-ME-Sender: <xms:_jVKXvuBp_mEd46PUReiDRDWv3BCTJLZ6df6k-hmkrPexB2msLrwMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
 ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedvjeenucfrrghr
 rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_jVKXqFdycQ-KgwWZbfRNzMXzBWDeVNx_0H65Si0_6tswTB_IwIt-g>
 <xmx:_jVKXmPrrM5qaogaLnV3QJW2huXuxTawYzj5Rd7-wtBeOW0iCfBDBw>
 <xmx:_jVKXlELZ6JsKbYaeqYVkIDTkfUpMPhdyIpqSo4pPcHiBa-5ocvU9Q>
 <xmx:_jVKXsH5kwqYZ9fXkyUWTY9NZlrV4f8SEdMvjk147YD7l02FnPW32g>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9370F3280059;
 Mon, 17 Feb 2020 01:43:09 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>,
 =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date: Mon, 17 Feb 2020 00:42:47 -0600
Message-Id: <20200217064250.15516-32-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
Subject: [alsa-devel] [RFC PATCH 31/34] ARM: dts: sun8i-a33: Allow using
	multiple codec DAIs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The generic ASoC OF code supports a sound-dai-cells value of 0 or 1 with
no impact to the driver. Bump sound-dai-cells to 1 to allow using the
secondary DAIs in the codec.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 40b903fa73da..a16c2ca11131 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -200,7 +200,7 @@ simple-audio-card,cpu {
 		};
 
 		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec>;
+			sound-dai = <&codec 0>;
 		};
 	};
 
@@ -240,7 +240,7 @@ dai: dai@1c22c00 {
 		};
 
 		codec: codec@1c22e00 {
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			compatible = "allwinner,sun8i-a33-codec";
 			reg = <0x01c22e00 0x400>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
