Return-Path: <SRS0=EA+P=KI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABA6C433ED
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 12:58:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C5761264
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 12:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C5761264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AE4F17C8;
	Thu, 13 May 2021 14:57:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AE4F17C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620910677;
	bh=IgFfUyNVqj4uN812NY8syRW28caQTc0JADY1uedKyTA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ch0ng/OqThC9tGI6OccBUXqNyS+zXemZPqBWtxduv3qHbzkzqtb2NAhXvUuA2PWi5
	 3EUz2pbndIo4gD+nutIpGF7gXynPdv8ufFrNj+ZcuXlKSdxwT0VB2MMiaqG4USus9p
	 gYlpXdbgOk4wOT+biwGHuz2P7PXVYhYLpWMvkxSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FC73F80245;
	Thu, 13 May 2021 14:57:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8526DF80245; Thu, 13 May 2021 14:57:04 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D108F8013A
 for <alsa-devel@alsa-project.org>; Thu, 13 May 2021 14:56:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D108F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="fuFDr2fh"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="PD4zKErK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 13B505C0134;
 Thu, 13 May 2021 08:56:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Thu, 13 May 2021 08:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=lY1k+/WVjXrLCOiGX1E/ngkgc5
 1it4t9mpbFfNx8J/0=; b=fuFDr2fhQwwLf+Feuxm50+g5g7G3cQAG2yBGDttYtx
 T7Nymey//JCG1yCJFtNKIxjFW1Cn3lBxQrtNRi3RFuBe+y6qVgK2vxsiA+iuSOrw
 2lfuziSexNpDcSl2kU+XDJ7tU3+bYl4xnLCbkXh5nvSXaBPZ/IEQLrv04dnw6Bsb
 wbJecfgFkCkHAkBwnjVFrInaRe55e2CU1LGi9Q6R+0Eq9vprP3orHZoggww+FZZf
 9i8YazIX3+WehcM6sGqvdr8M6y3AypdRLR+y25TzU/5UcbEDBdHdOStEVjdxJ0BJ
 sb5u4tXYpyWTnSKqJvgXjRP6NAWtY6H5nK/aqH2iatyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lY1k+/WVjXrLCOiGX
 1E/ngkgc51it4t9mpbFfNx8J/0=; b=PD4zKErKY9ZM0kYOF+xZkX32ow0o5b7vD
 juusXAbYI7hS5qeGor2Y+R3fxgDym5Vs89C1AYgobdviA8wQYn0tdwcVXI/oz1dd
 +qCOnDM5ivtQJ/3kp7uVbym/3KmsajTs8GjlDB5QYaYNtxTEUinZW2sO41G6LqwB
 1dkyJvS8REJZbWafr7R8LNiAqmTY/eEpGoY6MHcXwkgZK63RM/2CO18tDa50QYt0
 ZIyc7Bx1X4fg2VFc5B0ybaaTpDXleKZGIpDlndcOhFxeYROQM//20+cBzr4+q+oh
 YbT3BQ/1xCfhp5t77Cb089QNnYCjWySzTT6R9KjVlh2dKUhe99oXw==
X-ME-Sender: <xms:GCKdYAy_E1sgQyqnkQYX-dgrgrc0e_yYdTJfQgGvVpNPBo4nZH13Dw>
 <xme:GCKdYEQ8E1TROClHAo2j8kQDun4FyQ4ZyKYzHsItO1_6qCWwnfTcZmPejFIygPgsZ
 9s8S0w6AyVoakvZwm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecukfhppedugedrfedr
 ieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:GCKdYCUZZpKQentaC-py_ZGY9SlQJjsP_TLvGYSj5tKcbpn_hjpndw>
 <xmx:GCKdYOheD5nSgeR4sKosVWgM-41uSSr2UYAwRoUOC7R1Q4or1vcgUQ>
 <xmx:GCKdYCCd8-RgnOckHrlW_ypoi6gdtb1_QhETNK5pR2Eu7dUaS44fBw>
 <xmx:GiKdYNpVbQ4rUP3-yhCW5u4bH9nHRvTRRlpgufOwL8fsDw3CdSL_oA>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 13 May 2021 08:56:55 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 0/5] ALSA: firewire: misc fixes
Date: Thu, 13 May 2021 21:56:47 +0900
Message-Id: <20210513125652.110249-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
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

This patchset includes misc fixes for bebob, oxfw, dice, and
firewire-lib modules. The most significant bug to be fixed was
introduced by my work for AMDTP domain during 2019-2020.

Takashi Sakamoto (5):
  ALSA: dice: fix stream format at middle sampling rate for Alesis iO 26
  ALSA: bebob/oxfw: fix Kconfig entry for Mackie d.2 Pro
  ALSA: firewire-lib: fix check of jumbo payload
  ALSA: firewire-lib: fix calculation for size of IR context payload
  ALSA: firewire-lib: fix amdtp_packet tracepoints event in terms of
    packet_index

 sound/firewire/Kconfig              |  4 +--
 sound/firewire/amdtp-stream-trace.h |  6 ++---
 sound/firewire/amdtp-stream.c       | 42 +++++++++++++++++------------
 sound/firewire/bebob/bebob.c        |  2 +-
 sound/firewire/dice/dice-alesis.c   |  2 +-
 sound/firewire/oxfw/oxfw.c          |  1 -
 6 files changed, 32 insertions(+), 25 deletions(-)

-- 
2.27.0

