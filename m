Return-Path: <SRS0=qOpI=3C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54FC33CAE
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jan 2020 07:35:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58229207FF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jan 2020 07:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BANo6o7n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Venis7p5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXuOBLAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58229207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B87D5850;
	Mon, 13 Jan 2020 08:34:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B87D5850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578900923;
	bh=QnmmHXqXkQmdmdmxDjO30nOUI+9wtszixlIgp96wXFc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BANo6o7nevU4Bcq+PhTgrIfMdyMUyUtD1vYvjmuD66be7qiZZfFCvKHeGO+ht5d3+
	 ELv0J/StE5xfcpkPxLG1IW2BKCWrejGLD6scXRPXbbBFekLmY+v5OH6CzOmBU5mdBB
	 rhOh/8rKy7tkQfk0GoAaolBXCm7kY//oNSocavlg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBE02F80227;
	Mon, 13 Jan 2020 08:34:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4EE2F80227; Mon, 13 Jan 2020 08:34:29 +0100 (CET)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6972BF80122
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2020 08:34:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6972BF80122
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Venis7p5"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="lXuOBLAa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id A1D3421CC3;
 Mon, 13 Jan 2020 02:34:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 13 Jan 2020 02:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=98UmuQXIx1mscEQsZmRjw6dYaR
 ldAEL4UyVsbVbI05o=; b=Venis7p5M5BKQAesYC5NR99YH1gcs0u71bl0B5AqMP
 FE4Q1xeBqlhGpSXOqOjcoTHzk/1xYL2PlntQeIC6auuSXe/kE86k76/9pbp50aBP
 ocUUhpeb8Okhe2iDJkMyLeqPGpHJUttDkQ3mPMn99pfyI7v7+HNFsuTubsjxG/4y
 vIQaaI3H5F5kIJDs7hxaNoKFbwVp6HKk1UtYYfIw/cW+LaeEgvWeT7l/zwu6Wx4j
 dX7EFILoLjzEL3C5KRiaYloBl/VhEqgyquz3MvJQBWKpzPj+BuE68EJCseLmLSQP
 HuYaoFuQWPXM1go26MQmeUIhfYQ8OEXt0NMh+IQl6EmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=98UmuQXIx1mscEQsZ
 mRjw6dYaRldAEL4UyVsbVbI05o=; b=lXuOBLAa2tEouOpDssMl8w578e8aBBHLC
 55urxPIDnswtjlJ5+ZSTg94W1LJQtj+7T/CqOp9dgb4Q5w06Qk55b3/7VK9vpgoC
 yy5UN7nclGYalMypT7I+Frp1TD9QxwZ8If/cDcqxhpFrIcykBVJmS5N0MCjUbXNn
 h7/51yZ6wVwFYJNd5TFBPZmwdPpMO3gS16BX1wMXd+Pmam/1civD2xTjLR5BVbBD
 nYXAG1/7bKwS/dUcNvW3TxFr1EMsEsU1G8l0M5yrL70VrtIWxDPnFhXmZ+PlJp51
 fQBNDKAwuzVhU5RkmbkJVfomcbjmHp25T+098YZQVhVp/9BrdBLUw==
X-ME-Sender: <xms:fh0cXrIE3MF7I4quAi7Rdf6tJwG32Y4M5G0LffdUAs4XhSFwa0SKpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekudenuc
 frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
 rdhjphenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:fh0cXusqHIXWDrcr8OdO3oDfJSmLvgRgcmi53575eUy8ZaJDid_FqQ>
 <xmx:fh0cXoD7rDiX6mnZB7JlHbzenYrkQ-K7RM9Cm5t8L-H8MZLT6C99BQ>
 <xmx:fh0cXm6VfKaaV_YYbwVZqlqmFyhxKlQHm7Ukkge1-VQR8CNfXRqOPQ>
 <xmx:fh0cXt2JgBK8wJ260ow-XuuafEaCjWz7CjAQBFNlIDZsBacqAitbnw>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4853680063;
 Mon, 13 Jan 2020 02:34:21 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Date: Mon, 13 Jan 2020 16:34:15 +0900
Message-Id: <20200113073418.24622-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 0/3] ALSA: oxfw: fixes for Stanton SCS.1d
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

Hi,

ALSA oxfw driver includes functionality of former snd-scs1x implements.
However, since it was merged in Linux v4.5, the driver can't add sound
card instance for Stanton SCS.1d due to its quirk.

This patchset fixes the regression.

Takashi Sakamoto (3):
  ALSA: oxfw: use ENXIO for not-supported cases
  ALSA: oxfw: don't add MIDI/PCM interface when packet streaming is
    unavailable
  ALSA: oxfw: fix for Stanton SCS.1d

 sound/firewire/oxfw/oxfw-command.c |  6 +--
 sound/firewire/oxfw/oxfw-stream.c  | 82 +++++++++++++++++-------------
 sound/firewire/oxfw/oxfw.c         | 39 +++++++-------
 sound/firewire/oxfw/oxfw.h         |  1 +
 4 files changed, 74 insertions(+), 54 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
