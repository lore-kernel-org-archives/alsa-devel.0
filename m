Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FBBC433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 03:51:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE1F2076D
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 03:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HkypW7LY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="oOTWbThO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D4ph+k6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE1F2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4837917FA;
	Mon, 31 Aug 2020 05:50:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4837917FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598845903;
	bh=FZ7RxxDHabxkHJi9KnsQjfyCvi7RLY2n/9I0rrd/KjI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HkypW7LYKxjtC0+6+LXrULa/bPpYsKGZe0g5vosx03uTDQglL3uwBWOi0y9bHKqRR
	 n4rLiB3Lc6V/8woagu+08etm5K/3Ko0LnWiF60wERpXgTxODMaEvPSCNkcjTj8Zn7A
	 BbjF8b7sdO3yL3/lJnztsPLavO5Yrmh0L/7NREag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B1EEF80146;
	Mon, 31 Aug 2020 05:49:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0B16F802C3; Mon, 31 Aug 2020 05:49:11 +0200 (CEST)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EFC1F80212
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 05:48:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EFC1F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="oOTWbThO"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="D4ph+k6A"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id D27C8580535;
 Sun, 30 Aug 2020 23:48:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=xeWOte1Ts6wwOUtqKOVkgDpqDp
 6peOxWUO9K5MecHaM=; b=oOTWbThO0fOCflpcrx9HSCzTUPFxvgy6/2gTe5pIU4
 ykYxXvQknqai+NKjOsRR8kI1Sj5xdmJjgUVe3jWo13WHntTzKOGe1K0SQvX8V33+
 MuiidPXxlJaeFJOedBDRO8ZEOOljbsT7D8nmpC2tuH2uzhxTuwIPDN3maJrIek8i
 w2o4gNxmPw43VzUcpBZA5OnoXKPe2sGlIqxNf4Cfp1SS5tvWfqpuMSWxrywPMEPW
 0lzF/F+bpy4NwUd/HEwX9MlwelKgxGdzVnt3NCmoOD74rj7UY1lI4Po800yiEmJw
 3yjfdJVpT/R2JmrcgBVqCiT9K2Q9Px7UPgI/uAS7D/EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xeWOte1Ts6wwOUtqK
 OVkgDpqDp6peOxWUO9K5MecHaM=; b=D4ph+k6Axrxs0dvQ0ihVE94ahP0vbU1cc
 7ubCnCtblTUPWE5u7j3HMMTiVuTL5x0XBVzqQZ3+ibCwsGTd1yX04AblXfLECD8U
 iLiXdy0jNQ+TMrep12Pzyg/mWRx6wfv4bajw5+U5nStwLmsyPb5I7MSjNesnZwwR
 q7/9ntUS6lSWqQhZM/rQIaGIfV7PVnYvENOysgtK4W/2cH8I1wYBVNlOpU3iqJAT
 OeAPNfLaVMwqzm+TTTWts40niODeN4T0JI/2+j6U3Ol46V3RpcBWDRwakQNQ2mI7
 hsnywgAaLJDaL7GUPLKe2Wf0SYw4YaxwzhrBsaETVr1XfvOfPDRcQ==
X-ME-Sender: <xms:JnNMX62M67LkYfnWgbWpKBvgAiIKtPOcCgUrzLWbhsfO7i4WZjcBYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
 jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
 htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
 vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
 ohhrgh
X-ME-Proxy: <xmx:JnNMX9FvIMztCn-Dmys24DRhrEQtLHKqLhDezJ94ZFJz1NsYyI41RA>
 <xmx:JnNMXy66UVgmwH1B33qnjBEL0SRHpPjQgvdNGxNWcD1h9huBC1MBhQ>
 <xmx:JnNMX70FXdMs6gFIz340nJyTrTN2OVyll9zBZ5oXJ-McMyBk7iqEwQ>
 <xmx:J3NMX02QORIthQyCzObB74J1Nu_vNbNKcb1SMRWx3VqpfQu_usgxRQ>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id E2C923280063;
 Sun, 30 Aug 2020 23:48:53 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/9] ASoC: sun8i-codec driver cleanup
Date: Sun, 30 Aug 2020 22:48:43 -0500
Message-Id: <20200831034852.18841-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
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

Now that the fixes series is merged, here is a series of small cleanups
to the sun8i-codec driver. These help shorten the patch stack for the
next series, which will add support for the other two DAIs in this
codec: AIF2 and AIF3.

Samuel Holland (9):
  ASoC: sun8i-codec: Remove extraneous widgets
  ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
  ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
  ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
  ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
  ASoC: sun8i-codec: Fix field bit number indentation
  ASoC: sun8i-codec: Sort masks in a consistent order
  ASoC: sun8i-codec: Attach the bus clock to the regmap
  ASoC: sun8i-codec: Manage module clock via DAPM

 sound/soc/sunxi/sun8i-codec.c | 104 ++++++++++++----------------------
 1 file changed, 37 insertions(+), 67 deletions(-)

-- 
2.26.2

