Return-Path: <SRS0=gYtK=EM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A952C2D0A3
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:18:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663142075A
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I/3yYqkC";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="Y76Elr4b";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+6JNkqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663142075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 867101681;
	Fri,  6 Nov 2020 05:17:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 867101681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604636327;
	bh=6RkecJTxbjiBWPPsGg0f3fht1kOimHRMtCr869hK3mw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/3yYqkCamiI2piAIKptlKxSb11dbH49xnNWpVa1i+ONdtJ2j2yAB8EehVUq1D2CK
	 Ww/neu7ms97rm1aAAVKSdwvhKDfuIX8f3v6TF3ZQczLx08RbszDyjp4mxNfl2+5k8a
	 XId+AKNxSGHcoW6fgV/3D4XRITtX/lndIK6daGG0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00C22F804E3;
	Fri,  6 Nov 2020 05:15:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91D0BF80234; Fri,  6 Nov 2020 05:15:29 +0100 (CET)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC060F80247
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2020 05:15:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC060F80247
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="Y76Elr4b"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Y+6JNkqR"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id E82F258054E;
 Thu,  5 Nov 2020 23:15:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 05 Nov 2020 23:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=W/MZfcPsKjjE0
 7OoMylhK1zbNQ9x3iHbAhoJsJ612hI=; b=Y76Elr4bPsbKDNXA2/YsuSziM1Y6U
 SfXGbu5uvaHFmWDZRI+Moll6T+uOyQhJVoshJlSnZr7c/MpTIl9dpUTjNYk6zie/
 RjkOsMn+7LQxvXoyPme5ay9nsA4G9NHqPeC78fVvglCSsZCRHzj6XJEFZcMA0R/3
 vAMEOwAhN6gHOPGn1ABv1wcDg6A5+MqUkEkC7ug6uFfifZ9Y4x1mDI1fewGn6To0
 XMaOQRASdIw9SDCyss2CgN/7kcJBbuwj+zg+WbG8Lnj8RisMdfCt1E5P4nImKrmE
 S/+hc3EI1dCfsXTCeISr+et9EvT9rhbnKF02rSgMQ+7NqcCbWHYdvs9Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=W/MZfcPsKjjE07OoMylhK1zbNQ9x3iHbAhoJsJ612hI=; b=Y+6JNkqR
 tfuYhFH0xWB2MG+gCyjs1au8FDitidc3wtuUd1HWiZZCLKXKSWnuWDzHDgqaQu/t
 /wgZ+xDTENWwv5EgrlA7jeTPtORu3BrywetZWOwx5GTF1O/fJn675Jh/7jxb57o0
 RIwJkn+G4h8rxohNpogY+uSGzECe5+rwN94OHMwomdxMBdKeQmtQRamto6LEB35H
 8N0EvQ32OTMI+O/T2ahqI9zppBUs44WjSwcOMUukjNQpuuMm3SxnWrBiaqS2rd/k
 M+qVg4q4Kpu6VFM/XlQP/L7lEjWiKDQLKBr3i4UUWBn61t1kkqnGzK9xuo9w5tQE
 nFOACrpnEPlEPQ==
X-ME-Sender: <xms:1M2kXxusPWl1MAhDoWx3EPfp6YccUd1mGRt5rqm4LGYnJAXiPCaXCA>
 <xme:1M2kX6elvJKQwlbcn3sEDqVl4DyjApSoHTRdnJWFKgJT1U--NUjXGw0Z6Ubo7JZ1v
 w9StPjVzODg5cPNug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:1M2kX0zqenZaQQup5fsZutclBUijNuxSBk-3kExtX_J_dQEZIiwrKQ>
 <xmx:1M2kX4N2yQt6COq_St-PhMjvRBlMNoBlDFwyNhkNcKEDyZxjMW7HFA>
 <xmx:1M2kXx_sSBx7qRIhh8HwjSLzz3zt3Mrv9ZyL5T_bk1YYixDGwevtjA>
 <xmx:1M2kXwY-hYG_c1WLeYrlaDfn5-kMW-XSuMP3CyESTwhQYRReVUa23Q>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 24BCB306005F;
 Thu,  5 Nov 2020 23:15:16 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 5/7] arm64: dts: allwinner: a64: Allow multiple DAI links
Date: Thu,  5 Nov 2020 22:15:11 -0600
Message-Id: <20201106041513.38481-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106041513.38481-1-samuel@sholland.org>
References: <20201106041513.38481-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

simple-audio-card supports either a single DAI link at the top level, or
subnodes with one or more DAI links. To use the secondary AIFs on the
codec, we need to add additional DAI links to the same sound card, so we
need to use the other binding.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 97334e25ddd3..06c2b355d80f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -131,12 +131,10 @@ psci {
 	};
 
 	sound: sound {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "sun50i-a64-audio";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&cpudai>;
-		simple-audio-card,bitclock-master = <&cpudai>;
-		simple-audio-card,mclk-fs = <128>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
 				"Left DAC", "DACL",
@@ -145,12 +143,19 @@ sound: sound {
 				"ADCR", "Right ADC";
 		status = "disabled";
 
-		cpudai: simple-audio-card,cpu {
-			sound-dai = <&dai>;
-		};
+		simple-audio-card,dai-link@0 {
+			format = "i2s";
+			frame-master = <&link0_cpu>;
+			bitclock-master = <&link0_cpu>;
+			mclk-fs = <128>;
 
-		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec 0>;
+			link0_cpu: cpu {
+				sound-dai = <&dai>;
+			};
+
+			link0_codec: codec {
+				sound-dai = <&codec 0>;
+			};
 		};
 	};
 
-- 
2.26.2

