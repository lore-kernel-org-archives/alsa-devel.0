Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D7C48BD1
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 09:38:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E43D613D0
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 09:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E43D613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58A7A18F6;
	Fri, 11 Jun 2021 11:37:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58A7A18F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623404317;
	bh=3ALWn7P3Z1dvFrBm4uHJdqRIuLujnQqkjmlVvb3cZZk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uRgHpQHk1kpdYqvlYPdhGqpHf6RwwSYq8zdsPo9pp4SQyeoAc52KxViF5yCqx+Mye
	 NlluUnPi+d2M5+A6pvyAPhkFIrB9K7Pt16YprjNwUYOdxgLYr4unxMzSqGK4AsqeZT
	 vPfmOsP4/hGTkNSx0XVyOJqOxOG9Rkn11Ro7XCe0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D40FBF802A0;
	Fri, 11 Jun 2021 11:37:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22765F802A0; Fri, 11 Jun 2021 11:37:45 +0200 (CEST)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 124B0F80149
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 11:37:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 124B0F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="3zRiRti6"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="jUY00AE6"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 528D31AF4;
 Fri, 11 Jun 2021 05:37:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 11 Jun 2021 05:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=DLkPD33ep/X/wxfHu3FRiM/cFg
 ippOLS6QQhYzo3w84=; b=3zRiRti6V0HxJvkCGxy23bVby64hWpfCPT6neUq/qM
 61/wQO3g8hmh78yY8twIHwRie8WdmektxhQHYQrYkARtyLdT6e0DNR36abi3xpyY
 YZsfsfxsloFaJCmdO6cmQx8PnM5fujeKW2VUySCWZc19rRElvasnKmyiL1OAMZx9
 uOIHznVdDEyjw5xzQUWNehxtyy8f38dgBYwIszue4j9U0jUT24Elmh8fYz2ZKbuP
 Ulo9ooME6YXwY7Ft9Lpi6t+uLOFhf12EHh3EEydkEKzvvelGalHWGdqlky4ixPKD
 jKU8uCCwjkFQZKGIhRVA7Rfgki+V82oV+6Ls5yzuk7jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DLkPD33ep/X/wxfHu
 3FRiM/cFgippOLS6QQhYzo3w84=; b=jUY00AE6VpBvk2UTB5zRfTGC2RU55hX7A
 m4ObirT3LQ58M5nVDgu/eyujovPYRtST+imnW3wTDXVSCnN/yiDlM+Na/c/C+9Xm
 aJ2/bCtK56EEM9xKAw2+vk/Umn9jng6W9KVYPYY5qXOhDbs232fphaHVjaibeSyA
 dyYLHeomB/nnr0ONZRbMVGYO//GdD9rL7gk3P3MIAxNf+r1vaWPcIIR650A/voaX
 7NiXujbZK+1/fhPXNr4K2zAykCvEO1dvLWVyVoV41+J/vx7BmezRIXnGezl2sB0v
 GbjghonOceQNQNa4nsjlxiL0FiJvkd13OaSK69zCGzJr6k+Ne6GVw==
X-ME-Sender: <xms:3i7DYJW_5pboE-Ihun8Ylc7hgsSshESF_AeSkNeOkdwnx9KCb_dYAA>
 <xme:3i7DYJmMsavt9_bMmjyouFGvcw0xN-4oBZT3uXPV7GWNdlUxURfBetpblJym4U9if
 EAedmnBtfZ220B0ZxI>
X-ME-Received: <xmr:3i7DYFarVuE-SbST2uNSPAINe0hF1E__Zgn7ONt5ghCSUl-WbzTSW11bV7dFKACwsrrpJyKq6NDKssZuprkkg9wA7IxRhiR75mRVQpQS7drpaKAGnyzn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedujedgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvddtgeegjeejte
 ejudffhfduvdefhfevhfelleevfeefhfelhefhgeeufeetvdehnecuffhomhgrihhnpehg
 ihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:3i7DYMWjAZwkJvsCAPoIJ7Sa--6Cg1FNBdrfJCbYX2Ml_GsYSylYCA>
 <xmx:3i7DYDl9tfGVKSILvN1oR-Og4gG1NX8JFHpsSRz-X0cMDLEHeyL4Sw>
 <xmx:3i7DYJcjOlimQXTJQ1GlDtzEKW40keJYniBFbsoxPtl35ENLhb2teA>
 <xmx:3i7DYLuCvUIzaFnZjx51_igirw1xJF_eDioS7cOAUUYpIRsXpt295Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jun 2021 05:37:33 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 0/6] ALSA: bebob/fireworks: device entry corrections
Date: Fri, 11 Jun 2021 18:37:24 +0900
Message-Id: <20210611093730.78254-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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

Hi,

After working for hardware database of systemd[1], I realize that
current device entries of ALSA bebob/fireworks drivers includes some
issues. This patchset corrects them.

[1] https://github.com/systemd/systemd/pull/19124

Takashi Sakamoto (6):
  ALSA: bebob: fulfil device entries
  ALSA: fireworks: fulfil device entries
  ALSA: bebob: correct device entry for Mackie D.2 FireWire option card
  ALSA: bebob: correct device entry for Acoustic Reality eAR Master One,
    Eroica, Figaro, and Ciaccona
  ALSA: bebob: code refactoring for M-Audio models
  ALSA: bebob: correct device entries for Phonic Helix Board and FireFly
    series

 sound/firewire/bebob/bebob.c         | 92 ++++++++++++++--------------
 sound/firewire/bebob/bebob.h         |  9 ---
 sound/firewire/fireworks/fireworks.c | 15 +++++
 sound/firewire/fireworks/fireworks.h |  8 ---
 4 files changed, 61 insertions(+), 63 deletions(-)

-- 
2.30.2

