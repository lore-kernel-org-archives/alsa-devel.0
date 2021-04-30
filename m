Return-Path: <SRS0=h5q8=J3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3D2C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 04:01:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E6560232
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 04:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E6560232
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C42716A9;
	Fri, 30 Apr 2021 06:00:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C42716A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619755293;
	bh=qUszJWRPkKncsPlREQcEwcpi6432UEVVtkuHrlzglno=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H9gsakwOYk8cXnd7+ZGKTHNnv4C2EYKHJgQU0ZdoUizUGTJUCgEAB616gKcO+a2+n
	 Z16FT2oVU3F/sZ4itK/4lEpa26HiEmv6giAJdrvIumktLPH1x/KFH5Frm1QwJtx54Y
	 /gXeVO0GV4gL9ip/65bAdZwfbI8bIfWyOBp4uW6k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E81D7F80425;
	Fri, 30 Apr 2021 05:59:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC125F80425; Fri, 30 Apr 2021 05:59:16 +0200 (CEST)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A6D3F800D3
 for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2021 05:59:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A6D3F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="IcstK0Oj"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="QjgomTaU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.nyi.internal (Postfix) with ESMTP id 3C889580990;
 Thu, 29 Apr 2021 23:59:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 29 Apr 2021 23:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=klNuigViCSgbY
 D+5aBtDCyvX8D0xhoqYJ1AnG3UNN20=; b=IcstK0OjpRCuhXgy7ZrYLs7PAfnh5
 kcFslzfniNLl2h6DBc7yB/5r8KrnogIgp4gKzHDBs5R7DlCJzfTh//HLsNMHFnNt
 9eqq5lg9f93FNAzx3y4OpZKEB847yJLOtN2+vYcM4nnNKxfMaAQGZO8vMxliiUNk
 TScITXLCCdc5b4ojEqaMJTvxgSE1LjeBddNktHX8nknoqQYwn/PLeMgxzg/87+om
 rmwFQ0R0hyjcComgiRrq9AnnwPJr1dkrJ3WcFYEmZYdtD8POg2nPKPa5kInIaRs+
 aNV0yuTKVSemigTG9FEplSC4tVYZzjCs9YaT03Ft3VS/xG37Z36we6IUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=klNuigViCSgbYD+5aBtDCyvX8D0xhoqYJ1AnG3UNN20=; b=QjgomTaU
 T8TMiLB8al919KfDxK7JRc+HXeI6UEjlqw7q9XV1rpI/v/a8GaCpd2HPE4Db7UmT
 fWN4Aef+CU3tCtmcWOeFp/g+mfBuy0/o32QcwugKJKlkTbp03If18R9IuoPIL2nw
 UhrGkfwrlLilgh76+tJ+WBqmQNU14bsu8dd7iLq7XrHUd6OqLJ59fiCl7z4oWYLs
 RZBFccvWVvSXGzpS/abVuffDY/P0Cyw6HMAB01/1vS2AbXZAy1G8N1dxGvCBtn80
 Wo1Rt02MJPCegiSIvJH3vp/53Ajs3wKK+SqHzZSRvrvA9T7mInlBz6btjAl9MUlO
 YcfVlM+9xOkysQ==
X-ME-Sender: <xms:jICLYCKQZ9WQguAyA8jjxD2de3IoXXL8O3LfMxU_zhhT83SA0-6MIg>
 <xme:jICLYKIG5YsWWPNi5-lEVO9MWIwwa-MNQ3uvn-gUWY0MwRa7137uH51FVMEV2LwYs
 _qyIiLV_I0rDHrsTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:jICLYCu3MeVrAyzwhGIoU1cGXn-GN3wABYMem_FrU1wHvxGeqXC5gQ>
 <xmx:jICLYHYLQ6tc-5f36XJsa9VqYvcqLx5cX6ocItkvL0jMwa50tbhZmw>
 <xmx:jICLYJap40hc3S2tyvn6_fA0e23G1Ivlhgpf3FOuHpZ4joiMIQN4wQ>
 <xmx:jICLYGTNf_EaLVt6Ao7Zt7rmxs2yAUwjFdO9_pDFzAJooiRQFl6fhQ>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 29 Apr 2021 23:59:07 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 7/7] arm64: dts: allwinner: pinephone: Set audio card name
Date: Thu, 29 Apr 2021 22:58:59 -0500
Message-Id: <20210430035859.3487-8-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430035859.3487-1-samuel@sholland.org>
References: <20210430035859.3487-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, linux-sunxi@lists.linux.dev,
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
index 51cbfdc12936..02712f85f6bd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -433,6 +433,7 @@ &reg_rtc_ldo {
 
 &sound {
 	status = "okay";
+	simple-audio-card,name = "PinePhone";
 	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
 	simple-audio-card,widgets = "Microphone", "Headset Microphone",
 				    "Microphone", "Internal Microphone",
-- 
2.26.3

