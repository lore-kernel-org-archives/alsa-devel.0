Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4010C433F5
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Apr 2022 04:13:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB05E17B6;
	Sat,  9 Apr 2022 06:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB05E17B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649477633;
	bh=swf2x1AxLBLJD/F/Kx1AM1jKTEbLHYhSQjz6wTP15mU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WOyaGzBXh5QkI8VFNxvSSotn0kRY9B1eJNTQmkW0jE4KzSKdf6TDDqRWcQrXHidXF
	 m5aR+Nom4Wd86bF5t7Lslf8k8oXT9DZFjgnKZxrZhBrgTrlf9FSEfHRfk69M3Plyau
	 xC6oE6BSh4swgcr/BIu+MCykN/Dqvh2+F5CdYpeQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F05BF8027C;
	Sat,  9 Apr 2022 06:13:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13116F8027C; Sat,  9 Apr 2022 06:13:00 +0200 (CEST)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4AD8F80054
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2022 06:12:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4AD8F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="YyY0CKke"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="nK3P+zeW"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id CF6E33201DE8;
 Sat,  9 Apr 2022 00:12:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sat, 09 Apr 2022 00:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; bh=SnrLR3Sr37N2IK+ovWdtsG2oHIe46e1XW5qxi2
 8NvZs=; b=YyY0CKkeBs4TQ4eVNBXIMFQgjcC5X1ynOl+Y0Wz3ICfay3DcPhl/sZ
 akpkNVCR00i00WOOadJ+MBubnLhswKK21AcXcuWQgQFcN/i1EHavkIjZRS4Rnt+8
 1qzeIPmoLQjax6TFcFKdadzGTf1NGnw3KgTkja7TD14GVV0Hb6xb57A0BsHHtrbP
 lR7Ek8bhbeHPOhEnLwX9EVXXl7W/wuvPweDL+dw5L187xN5Di7ZkulzCsgqPNjuk
 p/+rDNbocBnEKsUvDBnLqiTGOVH76V4xf+FvSY84JBR0/3QbSTGY784vVyqeynYG
 VUg0j0SOIn/FSBw8kJSqN5rEMP/xhwPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; bh=SnrLR3Sr37N2IK+ovWdtsG2oHIe46
 e1XW5qxi28NvZs=; b=nK3P+zeW/T8wQL+Vg/eByQMkQFCjo6lpIqCE5RfyvRiS3
 wTcnh8817kj/hYjuDKKfTCo+fy/M1TSWiE747Ku8qOCzAPdYOLMOCjekoMiKjvSg
 PMCj2ztPqLFCGyvqrIg1UEQW3Fix/8WG0pQu5iV9455d/NqItzG+GBc6ql/qWjxe
 uIEYZvvi+K5+qb1PvHSC2qhqP35uQxUhCJ7R3DH/2h2TpTUZGVFS7hjg1PZtke6h
 8JhKvSj5/oUoEmK2wqtyKY1QyFIEPRxdXRR0w1vB4iLAsXhO7T9beJzCE3/T3dKx
 jcYCBeIyguz+nJRWtlCnhdpldQzCnlt8QaYWMXc4A==
X-ME-Sender: <xms:vwdRYn4yV8TT6W6H_b6oQP5UorSd1RvtwO6upMN3gLSRm64T0vEK1w>
 <xme:vwdRYs7PmwhsDOfoRNKjtFvj9En01kFezXCxYyuIqr__J08DOD8HJwXuXX48fOdm6
 fJzgdOSKTotfIAjvpg>
X-ME-Received: <xmr:vwdRYufmUtSkCKOiYrZxaD-hyEGVITvP9A8VTmyPpVlAHWIXULyN-x9_Lv-EDw7-aIoLu3AVs_gEKh90Aqp0sopvUm-kgT1gG7UIbZwXGbV2Q7A8efY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekuddgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteeiuefhjeekke
 efheetieekvdegfefhgffgvdeiheehhfehiedvhffgjeejuddunecuffhomhgrihhnpehk
 vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:wAdRYoJGl1alGqvkd6Z_2H7mtoj3cWK4cBCJY4nmJkTMouF2ARwJrA>
 <xmx:wAdRYrKV3b-w9kFXGWEWwymTSuu0bCVVEZ2IeRVyWvQ3u9Xffs9rRg>
 <xmx:wAdRYhxF1aKVxyUkvK965n7LcmSlnyU2DTEe3e_EmV_7np2Fg2mvWQ>
 <xmx:wAdRYiXnDkm2a3HrgxRukcapBjsMZmaOqhKyYYXRsEkAwkD1B2aw3g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Apr 2022 00:12:46 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 0/3] firewire: fixes for kernel v4.9 or later
Date: Sat,  9 Apr 2022 13:12:40 +0900
Message-Id: <20220409041243.603210-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
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

This patchset respins patches posted before to fix some bugs for Linux
FireWire subsystem. I expect them to be sent to Linus via pull request
by maintainer of Linux sound subsystem since the path appears to be
available after a short conversation with the maintainer. This patchset
is expected to be applied to 'for-linus' branch for v5.18 kernel, and
to stable kernels based on v4.9 or later.

This patchset includes below patches:

* [PATCH V2] drivers/firewire: use struct_size over open coded arithmetic
    * https://lore.kernel.org/lkml/20220210060805.1608198-1-chi.minghao@zte.com.cn/
* [PATCH] firewire: core: extend card->lock in fw_core_handle_bus_reset
    * https://lore.kernel.org/lkml/20220303183038.54126-1-dossche.niels@gmail.com/
* [PATCH] firewire: remove check of list iterator against head past the loop body
    * https://lore.kernel.org/lkml/20220331223601.902329-1-jakobkoschel@gmail.com/

Chengfeng Ye (1):
  firewire: fix potential uaf in outbound_phy_packet_callback()

Jakob Koschel (1):
  firewire: remove check of list iterator against head past the loop
    body

Niels Dossche (1):
  firewire: core: extend card->lock in fw_core_handle_bus_reset

 drivers/firewire/core-card.c        |  3 +++
 drivers/firewire/core-cdev.c        |  4 +++-
 drivers/firewire/core-topology.c    |  9 +++------
 drivers/firewire/core-transaction.c | 30 +++++++++++++++--------------
 drivers/firewire/sbp2.c             | 13 +++++++------
 5 files changed, 32 insertions(+), 27 deletions(-)

-- 
2.34.1

