Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D44C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 06:09:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274CA23132
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 06:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274CA23132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88D961712;
	Wed, 13 Jan 2021 07:09:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88D961712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610518197;
	bh=sNg6H38ULc5OB4OZKrHBfUG50lyVfBFaeG5s/aKcYhk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFHImTuLcjgUepUsqKS6Vgc4XWkn3XohP0fv62qPSz5G31cTucpnJxAjvOP3XLhky
	 jECf3WLY2nWi1Ri9VpPJWMi0SDI0iS0NdQ2RIhm1JrI+6Hz+Ien/W82vqzRkAFdWhW
	 2UscPG/tEYjpkTdFlD9JyLnsuTG6vOyfWGfX9Bgw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F8E3F804E0;
	Wed, 13 Jan 2021 07:06:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26D8FF8025F; Wed, 13 Jan 2021 07:06:38 +0100 (CET)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com
 [64.147.123.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 470F4F8029B
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 07:06:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 470F4F8029B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="SMRDqMvK"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="PUU9cBF1"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.west.internal (Postfix) with ESMTP id B880C1BA2;
 Wed, 13 Jan 2021 01:06:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 13 Jan 2021 01:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=UPQKNjnKYcvfU
 tSZvIh/RoQ33u+HBfkHdg3flk5F7LY=; b=SMRDqMvKCVIy4jszgS4R1HlPRE0OT
 Fzlz2h8sxqaKOK1LpQWuOZ4NboE3mJls4tX3sNkDRdBWxP6wqTWHMl+2sZ6aytEG
 pnbVSnCQp+W32sfhaYk2G5Vbl/gLnPET0VrS7nU3cfsn1q5yVo6QajhGA5Vc2ZbX
 d6lqRxA8Pf/CaiheBgC6v7z9IMFIeb8b+6jKatQmNKO008AG4c5XxHtgza5m2ewS
 GcJVFplwRqUhq37p5unTiHyP3N6c0jEwQsLiMGJmBVgxeZRCybNGIj2nXECP4mwn
 gOEwH6rsgjs2Ug5EoisfJwGci0GycZKg1pdDNB/2jTNFU35egtdA1d/QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=UPQKNjnKYcvfUtSZvIh/RoQ33u+HBfkHdg3flk5F7LY=; b=PUU9cBF1
 NNRl+/gI/l93aeZyLxj7VFAMpED/I7dOjsgTlHVt58QEbRUj16f+Zpqxl4L68Zi4
 wpJ9TIPcirTqPVwX1ZyjTlD0GeWWgmwX5eqvbuhOy8AJKD/aVB6FeJ4MdtNYtkEs
 MgnPquIXvwriv015F78vQhwzOyk42ndNFwcP7wecXedesFEbtT65KUULipGPmu6S
 FwnfweHC/+PaGs3+87gA/XZs66GZQ+aD3sB9kofcOV3iEo5f8pn2+0tf/pO3ilKc
 /j5PTYbV3zrni/8zcX0pRZev3MPWbZB2HiNSmbc8Q48XHizkXhSQjCSO/T1idHk2
 vrvkuLEG4zOUWQ==
X-ME-Sender: <xms:3I3-X3aB6zCisi8S5XNfl057I5kVIRK68MFVi_N6ehkvBa_d3BRmBw>
 <xme:3I3-X90aMMlQ19UoXCQEvqVKAjR1mQu3cvZ01zvDp0JodPn1mBkj_mXoCipe-a8pg
 tMZgovrSXlA2nYN9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdelfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
 jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
 gvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
 rdhorhhg
X-ME-Proxy: <xmx:3I3-X3UG2H-vQe5x2U4v0tLwdfXv4nJD3GSgDDGwXJXKGAb6lfdxMg>
 <xmx:3I3-X3Vhbtd-fpHgFsIgBAjuCX00sk1jxBHpsgReVwj7Ux4e5DTRIQ>
 <xmx:3I3-X2cYzJ21o6FI2wi0u2ijcjYPXECAWYk_y2ApV0hIeH5gq6QnBw>
 <xmx:3I3-XwI-liGhNtt2JLvLIrp06tzBf5YVyUy1B9yahw7NEySNxW45BL-Eh5I>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id A00DA240057;
 Wed, 13 Jan 2021 01:06:19 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 7/7] arm64: dts: allwinner: pinephone: Set audio card name
Date: Wed, 13 Jan 2021 00:06:15 -0600
Message-Id: <20210113060615.53088-8-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113060615.53088-1-samuel@sholland.org>
References: <20210113060615.53088-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, linux-kernel@vger.kernel.org,
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

From: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Add the "PinePhone" name to the sound card: this will make
upstreaming an ALSA UCM config easier as we can use a unique name.

It also avoids an issue where the default card name is truncated.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
[Samuel: Split out change, updated commit message]
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index e0db2f1373bc..cf6dcdd135b5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -425,6 +425,7 @@ &reg_rtc_ldo {
 
 &sound {
 	status = "okay";
+	simple-audio-card,name = "PinePhone";
 	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
 	simple-audio-card,widgets = "Microphone", "Headset Microphone",
 				    "Microphone", "Internal Microphone",
-- 
2.26.2

