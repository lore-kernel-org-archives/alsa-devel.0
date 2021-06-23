Return-Path: <SRS0=sqcX=LR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E60C48BC2
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 08:01:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D95D60FEE
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 08:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D95D60FEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04F57844;
	Wed, 23 Jun 2021 10:01:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04F57844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624435312;
	bh=DMCDI1FdvNasocrQJktJqB2zcCM4p/48bnCig+pN+7M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FYu1ADLi2nWW42p5HsQ6HBrAAlpIJYS4ulsUEj3pm+5vMKq0GhC1XfPYMotWh/GU0
	 Ny5xm9vVGQDJCoJcshk+CX55RbQyRhwjdAQ3r4nt8n+uzpTL1e7qbckhg4QT0UkvUa
	 f17Fmj0BMCyrwjXrl4GBHe2laxe4x+2rGcR/XxoA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2917F804E1;
	Wed, 23 Jun 2021 10:00:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8120CF800E1; Wed, 23 Jun 2021 10:00:05 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4373EF800B5
 for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2021 09:59:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4373EF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="T07mB0Mn"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="dR01G1Ga"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 9951910C2;
 Wed, 23 Jun 2021 03:59:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 23 Jun 2021 03:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=AJoHG+kNq+Bts6rhDXUUelwOON
 7hFs2SO1t8c/q0w9A=; b=T07mB0MnMVDZF5Gj8qZLOTGE2Ks2bK6qXuwIPw0qEP
 1IUolNXjhu27blph3a3aqOOzVlaIi30IevjYajy4H8lWHx7hFj5T8IH04Z/NxWlA
 mUyfzsYIPoFzW3QFd6nPo0SlucIPp4RZN0IJRubo0oDbKXoMAda4X8Sh/Pruk7OG
 iUbeLPGH6vBaa7qKqTELgQVCw/KYXZVzJDrGhFbaEc3427vb0Ibr4FGKXjEQ3nCB
 V+/43YRx/F7/5gl5b6ORiBLNB5nIOwRvlgnew9LCFfL0ZYitUQVkuVChoj+DeQFT
 leYHNXgAKDTWDqWnx9DmykNWwGEfnIs83qN7QCbSlJgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AJoHG+kNq+Bts6rhD
 XUUelwOON7hFs2SO1t8c/q0w9A=; b=dR01G1Ga9P2uOKodhBOp8uPc+VBRijwOj
 MQ8sbuB24p0sPW3FLcheq/oYaaHiD920UXcr2VY1YDOyTheOh/hAdTBg9SowEEij
 ZzE4p9n+dGrIchYLGEiabPtk2XhE5hiIzFWYpPEic0iVx4f3VYumXxX03pyk2cbV
 dq7PWLxDoGwgVhBqkEmq+mReTzSUBaHWAkSGyMYqqw0iZwoXEvO0tdI0vGu1xRj3
 fPpI6Jp9kOymMHr6IkluxwjOwOt64DYSIfHlcgMK+k2ew/cB2L1OxzwFIj9Ml6Wo
 Cn1t7do5N6kZqNfV4RJYU+EkWrn9mtwmWOCfv5z/LBsdpMB9wbTOA==
X-ME-Sender: <xms:8unSYBS5MZChT1sjgUVdaL7J8c9UaZjEtg3T8lP04ayXHX9R3GVmPA>
 <xme:8unSYKzh2U_uSME2a4dFAE28IlUQB-MB60VO2JvrVPMDbpUdJdJhKsxy_YCcSofhT
 KX9NU693Uv1aK4CxRc>
X-ME-Received: <xmr:8unSYG32derAXoT0kv2ywB03RaM4vbTP5uCYiJ46A1P-3UORvNCVUwkBQlVEeHwc_GrhfeFyJI4yg9Fn9xb5smDYReNMdxNmFQrP4At29b05rD4jWgKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegvddguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedujeetlefhtd
 dtkefgtdeuieelhffgteejjeehkeegveduvdevgeeiheeuueekjeenucevlhhushhtvghr
 ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
 hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:8unSYJBG_8bgENRseJJC2YRpppdy2xOUb8dxVwH70rvlm6-UbXob_Q>
 <xmx:8unSYKgvGj1r9BQd5bvteQTX6OIC3_U5FN0jOYC1A18OPOEsE3Ok4Q>
 <xmx:8unSYNrWvarqrzqoBmRMkw2ce0joo4g--Lh96tKmmwUja-cxu6Qg0g>
 <xmx:8-nSYOaT4vGe2RuEi8RUOcM5sW4ylSHJVWh_cHKW4bxYQNYbJfyGIw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jun 2021 03:59:45 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 0/9] ALSA: firewire-motu: misc fixes and code refactoring
Date: Wed, 23 Jun 2021 16:59:32 +0900
Message-Id: <20210623075941.72562-1-o-takashi@sakamocchi.jp>
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

This patchset includes misc fixes and code refactoring, mainly for
detection of sampling clock source and 828/896 support recently added.


Takashi Sakamoto (9):
  ALSA: firewire-motu: fix detection for S/PDIF source on optical
    interface in v2 protocol
  ALSA: firewire-motu: code refactoring for detection of clock source in
    v2 protocol
  ALSA: firewire-motu: add support for AES/EBU clock source in v2
    protocol
  ALSA: firewire-motu: use macro instead of magic number for clock
    source in v2 protocol
  ALSA: firewire-motu: code refactoring for packet format detection in
    v2 protocol
  ALSA: firewire-motu: code refactoring for source detection of sampling
    clock in v3 protocol
  ALSA: firewire-motu: use macro instead of magic number for clock
    source in v3 protocol
  ALSA: firewire-motu: fix register handling for 828
  ALSA: firewire-motu: fix register handling for 896

 sound/firewire/motu/motu-protocol-v1.c |  86 ++++++++----
 sound/firewire/motu/motu-protocol-v2.c | 176 +++++++++----------------
 sound/firewire/motu/motu-protocol-v3.c |  79 ++++-------
 3 files changed, 143 insertions(+), 198 deletions(-)

-- 
2.30.2

