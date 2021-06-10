Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB8C48BCF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 03:18:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49DF613BD
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 03:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49DF613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFADD16FB;
	Thu, 10 Jun 2021 05:17:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFADD16FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623295118;
	bh=dKkauYZ11aH5MNg1/8EDrrvhq99F/T//A1gguE2d+S4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CEW29gvALDLd1FAlLUmUiUixrkbvzPjbRqsxCuTvRcEjph6bspam/yQz3S4QW2teZ
	 w3lGHujI9HQx5Rrt09F4YhQY9+RIOKRDJmjE5VPGQxvZynjseYY9lPZT+xSJ0lNqY7
	 KGBQunoXc4QrBinH3XwN6J4+8A29EQoDWTtjHlsI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48511F80149;
	Thu, 10 Jun 2021 05:17:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9A6AF804AB; Thu, 10 Jun 2021 05:17:44 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB8A6F80149
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 05:17:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB8A6F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="O62J7e1d"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="V5E4aGZm"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 626725C013E;
 Wed,  9 Jun 2021 23:17:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 09 Jun 2021 23:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=cvSZLmkO6A3ujaBQvErecP5PeH
 exxUfhtONxM2n9GQA=; b=O62J7e1dfI4DaJwqpD36n1GCiwSlr652ZjGjxkqbog
 U3B8B6nHNV7xIYvkb+7DuWfoypEM8AuUU1y12tpSBEeYa4utdFJ/pUCCC/O2ynmV
 dYSKDK18hfHwtJcEIeFKhVju9E6pYudoiuHmQq/b0hsWh6tw4Z4E8/uXfT/axbRB
 FY7siV6no+HjCUENCj69G8knD+MneESZtN30L5PyR3Bf92GIlJ0eGGkE9L3SK5TE
 63IO9Zcod2m5TKJLfcoYMK4s3PRDQXU5+CXemr8xp/Erfg81DTuj5hfQh3r0B0Tw
 jzjeku3wRKl4crx9B7+EA950QX8MDimcmHq0x1M1+0Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cvSZLmkO6A3ujaBQv
 ErecP5PeHexxUfhtONxM2n9GQA=; b=V5E4aGZmO3MYbflayqGltCyYZAfBcVXsm
 AMDy3FxrUQBFIbAqaCvJKoNCO9VD9MzQ2iXA41ofJdE0sUfb4cmx0W6Wm9W3ku4H
 WwQDCEOZIhcYHA2Lwtb7boVB2mkFU3qn3XOTAl9zAjqdajNE4rq/lVvtGU4Z7fjX
 +MGO40GSXs7elrRnqsoBiKS9lJsNN4/BcyHw85hWAJdC83vZU9NE4nbQkwz/uqke
 zO5h7FIha35xP92Ee4eZ4cHabr2f8OQ7I0WMSKgSARZbyr+Ru01Yvb0u3g0xhgJd
 v8hkJqM6Ocfbas253e24i+3TiuWSv9sy/UWSEBHbWx4YbeWHf2exA==
X-ME-Sender: <xms:UYTBYI-ln8utLYPuA2lJZlc_4-njUUJiZ-eHhDX9289z3j_JGlEgXw>
 <xme:UYTBYAsUggvS9Q52qstFGUb_qwK6iB-1oWelYjPdlM6QCIX-nz9oo59QPp2-tZIB0
 xMEWwgLnH6qlvYanN8>
X-ME-Received: <xmr:UYTBYODC6L9vSAqnEeNZpI5_uJrEQ-0fJhqYdtEt1LN4NGwWcdM39lCOv_4eST0Do7boiMNMgokziZiOZ0eQXzsMDtCnPfbPr8QFaEQkvVM0bCbviyI1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduvddgieejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteeiuefhjeekke
 efheetieekvdegfefhgffgvdeiheehhfehiedvhffgjeejuddunecuffhomhgrihhnpehk
 vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:UYTBYIelkwAtLGJm4KnVDKdO9Gsxh7xxBWTQKHog83nz5E5vyTkE6g>
 <xmx:UYTBYNOITMz3OBGpI4hhwYUu7uuJmDHN8ofz4CFgb7MuCkgSaZTfRg>
 <xmx:UYTBYClw7lx2Wr-NQenYUINvPmzF5DuDb6PMGWjjGx3sDOQFzZnzeA>
 <xmx:UoTBYL06sac7IABMOP0whA6ejxQIIeM0FeExJSheWLMkxuqZ1w-paA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 23:17:36 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v3 0/3] ALSA: pcm: add snd_pcm_period_elapsed() variant
 without acquiring lock of PCM substream 
Date: Thu, 10 Jun 2021 12:17:30 +0900
Message-Id: <20210610031733.56297-1-o-takashi@sakamocchi.jp>
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

This patchset is revised version of my previous one:
 * https://lore.kernel.org/alsa-devel/20210609143145.146680-1-o-takashi@sakamocchi.jp/

All of drivers in ALSA firewire stack have two chances to process
isochronous packets of any isochronous context; in software IRQ context
for 1394 OHCI, and in process context of ALSA PCM application.

In the process context, callbacks of .pointer and .ack are utilized. The
callbacks are done by ALSA PCM core under acquiring lock of PCM substream,

In design of ALSA PCM core, call of snd_pcm_period_elapsed() is used for
drivers to awaken user processes from waiting for available frames. The
function voluntarily acquires lock of PCM substream, therefore it is not
called in the process context since it causes dead lock. As a workaround
to avoid the dead lock, all of drivers in ALSA firewire stack use workqueue
to delegate the call.

This patchset is my attempt for the issue. A variant of 
'snd_pcm_period_elapsed()' without lock acquisition is going to be added,
named 'snd_pcm_period_elapsed_under_stream_lock()'. The call is available
in callbacks of .pointer and .ack of snd_pcm_ops structure.

Changes from v2:
 * delete context section from kernel API documentation

Takashi Sakamoto (3):
  ALSA: pcm: add snd_pcm_period_elapsed() variant without acquiring lock
    of PCM substream
  ALSA: firewire-lib: operate for period elapse event in process context
  ALSA: firewire-lib: obsolete workqueue for period update

 include/sound/pcm.h           |  1 +
 sound/core/pcm_lib.c          | 64 +++++++++++++++++++++++++++--------
 sound/firewire/amdtp-stream.c | 46 ++++++++-----------------
 sound/firewire/amdtp-stream.h |  1 -
 4 files changed, 64 insertions(+), 48 deletions(-)

-- 
2.27.0

