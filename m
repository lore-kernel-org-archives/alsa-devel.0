Return-Path: <SRS0=h5q8=J3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EFAC433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 04:00:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553C461419
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 04:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553C461419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B44D1688;
	Fri, 30 Apr 2021 05:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B44D1688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619755201;
	bh=eKjFwzg2ko6J7I9dfjneqxBVR0WkmF8Ja0P7qafpn/g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ksa46IHIP3+Q6yeXYW4nORTBVOq+Of44OB4T0gRoJaI/rngh6hThjrRGuyJDckT8S
	 wol8/upgQthZYScGV4tBJc68kzQXj1WyWjyQCFjOVVUFgYRICsxOCO6FQ099e6RA+C
	 DO+N7LSWrf+HiXvGsKZSVO/D2DU3GScNonXZpUIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6410EF8029B;
	Fri, 30 Apr 2021 05:59:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 825F7F8029B; Fri, 30 Apr 2021 05:59:08 +0200 (CEST)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2186BF800D3
 for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2021 05:59:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2186BF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="gjHSHAxp"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="T/9KMg4E"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id D0A3B58098B;
 Thu, 29 Apr 2021 23:59:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 29 Apr 2021 23:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=xVY04ejPlSyjMR303yZ9gk9uyq
 UXH76hunsc1D+ucg8=; b=gjHSHAxptF0w8Pf5Dvk0ucNQQoYJLA9+1Cs195XphT
 9JFLUT7m5J/ObR7I50nVgb1Ti2qgNpRp6uj1v8ksv/SgOeM5CsCpcNYsOMIUlF7b
 Ozos/PTPsINxVl8Ede/+wpkOESOCNCktKsi/HON9STzTccJMR5/E4/0DTY3M9ZEF
 maFQCEjj4mXRQo7r8fQsIseD319V+sdYLgTlkUQMouFIACgrp7mql1pVCBGyJMXU
 cd1/ZoS5eOu4nv9xjdXmMh9fJuK04hz3cXwMAqvaW+DB7X5+gY2my9K3BNPQiOx2
 4vBLVzzuL7K3GVdzm48ebNyOmyygt5nuFRZRiIM3hFiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xVY04ejPlSyjMR303
 yZ9gk9uyqUXH76hunsc1D+ucg8=; b=T/9KMg4EQsjz6xUkFYRE8DjBFTvtFZa0+
 lupIfLi/iNKx+ncf2uY53M7Uw6e+JE7yVTM9omCbxNkGmrhgcCtEbo6b7oyrT+qu
 wDSW8lLWnwX4EJRDo89JLG0t8y+3YD7HxDn9D6F/ye9etEc98f3BxVbfALWJ5H3w
 HhdoeXhBw0OW5GOlyWhwM3VyUUdm0ItbN8FkbFNCwZqwzYjcCoqJ9MO6gUaXf/OH
 YsnvMrW27Htle0mFF36/MS/2KFOzsUSrBWL8SgQ1SpX1M4EsEpmkTZ5MAVgeu3Y1
 YBuK4lphXr9QNMJrYPySIAFmkIWJS25Iz8beVdUs066EEUtHm9f4g==
X-ME-Sender: <xms:hYCLYJZ1vT_eSbn-8aPJhM29rn8XBZRwL2W8OrztpvfBtLJNp_iCPw>
 <xme:hYCLYAbxjR1cFAhxT36RxaXSj3ugDjygKPIPa3j9bkZNLJeIX7XEYxdbzsxo4VVUU
 iDkxEXmyexOYIHW8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
 jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
 htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
 vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
 ohhrgh
X-ME-Proxy: <xmx:hYCLYL9b43hiWASNECLJhkYoQsLlxgL4n777uv08FJtEcW6dtHpE0g>
 <xmx:hYCLYHoWMzjc1tJssE0HadIvsWUSBa3lDacaKBOl3quyi5wGENodTA>
 <xmx:hYCLYEryrZQYGn9epi-6jDXxGyLtTNnfqUEwMzVvDxanXTflbey95Q>
 <xmx:hoCLYL3JgresNieHYASlfJWUgwAwop1uFmUfMGZ7OrPUjmWhJHgPaQ>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 29 Apr 2021 23:59:00 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/7] PinePhone BT audio bringup
Date: Thu, 29 Apr 2021 22:58:52 -0500
Message-Id: <20210430035859.3487-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
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

This series uses the additional DAIs added to the sun8i-codec driver to
add hardware routing for BT SCO (headset) audio on the PinePhone.

The BT audio connection is represented by the "dummy" bt-sco codec. The
connection to the Quectel EG-25G modem via AIF2 works as well, but I do
not include it here because there is no appropriate codec driver in
tree. We have been using an out-of-tree "dummy" codec driver for the
modem similar to bt-sco, and I'm not sure if such a driver would be
desired upstream.

Changes from v2:
  - Also accept #sound-dai-cells in the binding. Since dt-core.yaml
    already sets the type of this property, it is not possible to use
    oneOf, nor make a specific value deprecated.

Changes from v1:
  - Fixed DT binding example to follow new binding

Arnaud Ferraris (1):
  arm64: dts: allwinner: pinephone: Set audio card name

Samuel Holland (6):
  ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
  ARM: dts: sun8i-a33: Allow using multiple codec DAIs
  arm64: dts: allwinner: a64: Allow using multiple codec DAIs
  arm64: dts: allwinner: a64: Add pinmux nodes for AIF2/AIF3
  arm64: dts: allwinner: a64: Allow multiple DAI links
  arm64: dts: allwinner: pinephone: Add support for Bluetooth audio

 .../sound/allwinner,sun8i-a33-codec.yaml      |  8 +++-
 arch/arm/boot/dts/sun8i-a33.dtsi              |  4 +-
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 25 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 ++++++++++++++-----
 4 files changed, 60 insertions(+), 14 deletions(-)

-- 
2.26.3

