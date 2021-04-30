Return-Path: <SRS0=h5q8=J3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE45C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 04:02:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C391B60232
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 04:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C391B60232
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57FD21694;
	Fri, 30 Apr 2021 06:01:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57FD21694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619755346;
	bh=YJmUKp1y5MOSZgUou1lQJatVduAkx6bfD+iWjii90E0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9qdr6Gm3vxEqp0yGzddcCZp7ZUI7seluWXTvNcoVpM0bfnfz5F1z73Z2dZL4p8KH
	 oP+iFVqn4N7tTCZ5TfwSHnpFIUYnYBNovy9iapm41h0AoDB4G5Q307grOW/er3P1qB
	 buAM/ke2083rOcnGpK7uaM1w2QcZu8s971Zz9Hxo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB15AF804AB;
	Fri, 30 Apr 2021 05:59:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E2E4F80171; Fri, 30 Apr 2021 05:59:17 +0200 (CEST)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5705DF80218
 for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2021 05:59:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5705DF80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="a5VCO5oH"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="a3t3wL6L"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 809F6580991;
 Thu, 29 Apr 2021 23:59:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 29 Apr 2021 23:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=pw3UViUjMVgmZ
 bCu3Ja0rB/pgHOsIsfcqpXmNDlOmSI=; b=a5VCO5oHhRMhi9ChsSAySrkudBfSd
 0eOPTSTDwyEILVhDRxNt9KwGQI9bzarLWMiU2LJGzUBHuUmJGQ2JBv7MXmQpNx15
 TnGflFX4XTBeQOWSXsuJvQbkddwCW98iveBdn1bcCsJJfia9zXkbD0SXSs4MBly1
 2YAXyYiphU6nn4it7+ZIbf5F+YurYl+KKpToeVjhtH8YFRFkB8l1Oa44pE/K2lOj
 sWXPRIYr5PnaRn8MBcijTblGiCv85WFZhBpsGKjg4MqDmk8SgfxlyW9C5Dh6o8JL
 KzxLfYK3T2KzO5rfnwnr+TAp1U+8TzOK90eeHbLP70H06g6GUdhf7jKOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=pw3UViUjMVgmZbCu3Ja0rB/pgHOsIsfcqpXmNDlOmSI=; b=a3t3wL6L
 TSTdfVhubUu+hKlDxFV6KYcsDtsalT2NJOpsOvwGiTDHvDzZNXlww1gXFP2AZ3Pb
 SNEOg2ZwOXek1JkcqMYKdk4tZmahQYNrja8uw8Jj13Pg+8h8UkNt67LhRHjNOGng
 5uxN1cX2GkSsGpEOSilhZPf23TLD4lDvbFEjkVRNgGB/j/ipVrrd5iS/3ntekM8x
 V27x8tl41lOd2HqJjnYIb1VE/F64ng/mdUnhDNIAot/mf7Dkn2BNb/ymWma68zeh
 131aeEXxiyugWYeLdeGoo67wRfcu8i6BUpJKmbOo60XpjnLwTz/kyjp6683HUEmm
 BQrkkoKZCf2bxg==
X-ME-Sender: <xms:iYCLYHayzEGFDqL4O3hjhxbCXN8q6czJK6eLIhTffnjo6isyAeyFHg>
 <xme:iYCLYGYcPA1ek0OCP0xDDHZXcu09z4cyzFPUTjWCAGVSdu0wEQSvwuZPsWib5lRyu
 1gO94nf67yLiirZMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:iYCLYJ8ThD3C2MteHxqF8Jz3aU4Cg7bOsawyOJ5TDB9Dxo0V3Y2Gmw>
 <xmx:iYCLYNqgVBioghOvaVmPYXTmIQ5m4BsqWQ9ipa0xcRwzkaBHmI3M3A>
 <xmx:iYCLYCodyPUIXMhOWshNPe0DQn8Nk4mpxATKfJFRoF-OLUQLzZi_OA>
 <xmx:iYCLYB2sm5ZMAo3FIhIHY5XrdXGMLYztKyR0s2F5AH0ZrTaCywqSAw>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 29 Apr 2021 23:59:04 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 4/7] arm64: dts: allwinner: a64: Add pinmux nodes for
 AIF2/AIF3
Date: Thu, 29 Apr 2021 22:58:56 -0500
Message-Id: <20210430035859.3487-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430035859.3487-1-samuel@sholland.org>
References: <20210430035859.3487-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
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

Now that the sun8i-codec driver supports AIF2 and AIF3, boards can use
them in DAI links. Add the necessary pinmux nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 3061031780de..a583355a3128 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -658,6 +658,18 @@ pio: pinctrl@1c20800 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			aif2_pins: aif2-pins {
+				pins = "PB4", "PB5", "PB6", "PB7";
+				function = "aif2";
+			};
+
+			/omit-if-no-ref/
+			aif3_pins: aif3-pins {
+				pins = "PG10", "PG11", "PG12", "PG13";
+				function = "aif3";
+			};
+
 			csi_pins: csi-pins {
 				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
 				       "PE7", "PE8", "PE9", "PE10", "PE11";
-- 
2.26.3

