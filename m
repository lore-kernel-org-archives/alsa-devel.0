Return-Path: <SRS0=Sdsu=W6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A935C3A5A2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:02:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3292022D6D
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ox8sQj5N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Ht/45pru";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kH/Bhwil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3292022D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF2941676;
	Tue,  3 Sep 2019 17:01:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF2941676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567522965;
	bh=RL8fZn9VJbuN2C88icVgZLA394al2+gcRIvdmrnI5SM=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ox8sQj5NpItRweu2NeZQ5CzTWSGI3yGHYuclF4KdvuPQKVtKDER971tSLpjaq9UVD
	 PRWLwmUl/Ear/6bhDV/AwA3NjP80Ppg7NstwCE8Bd+Td8iyg2JvHhR+BOAL8OCuTY/
	 SEYFO4IlT+fEXZV6dKlhmPyNOABkthFt1EHxXYuA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7831EF803D7;
	Tue,  3 Sep 2019 17:01:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D74E4F8045F; Tue,  3 Sep 2019 17:01:53 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 332BCF80392
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2019 17:01:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 332BCF80392
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Ht/45pru"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="kH/Bhwil"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 0D7DD220E1;
 Tue,  3 Sep 2019 11:01:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 03 Sep 2019 11:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=GYEKrkGFe+6PHocrT18QLbwFvs
 Cty7iXKZ8NZtXqtBQ=; b=Ht/45pruw/MCgLjRSBXyJl18S+KQSa7MiGrSRvn+Nc
 btaT3lz6016YewNRrwI2+frNi5o1LvlvuLiH+Vs/bomlX9+sfg/A+fbjXW+lyG/x
 MfBGP6pHSN2jLLxEHZdnAFJ6fJyek0LA++47YruaJ/0uIxgCZSLD74WmcGAeJh9p
 Wrv2ygiHl89vAat1h+aMLCkAWw8Arli2eKotTEuWY20AtL2cKlRY6WEcCYKjzec8
 7c7w3CpH4P70ux5qM90qNsu9L948OEOTa+hmPlTin2SduMTyRNA3TJK8a/894JPh
 J9vjOe6sxwXWdeorIXlJUUZjIm0jbx0oQP67lP8cPXVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GYEKrkGFe+6PHocrT
 18QLbwFvsCty7iXKZ8NZtXqtBQ=; b=kH/BhwilQ75ZwTtepb2dlIGPlTuCs3dxo
 1iKrXPzbswMzGikRdJk5LGWudUQwnwzZQrEGfb363A5Kmfj5kaPS/Er5qy0KDnkv
 +BLCjA699AxqLDChmopkrwztWCvLV9LIzXxTAsYCfmWz9Wjdkcgx8Q5wL/maIaXn
 LyIDoJujmtW7vzuT8NrF1asLv2IBml0sz/n7MSGpwNWb377fdXLmk4Z6oY/7J3H+
 kOton5m07wZIMjtopTT3GsKQxUYsOuEFN2JmxVgb5Kalik5NG3+sGZEV+S9vRFYn
 OHv+Wuwtg7PnI1vNfojkme/UX8HcXA5vTAK9ZUmbePQKr8foXeMHQ==
X-ME-Sender: <xms:WoBuXX7aS5yJJ0niYHZGIF0XMLmo6sa83lUjJcddFI5ztUaoQHb1OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejfedgheehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
 enucfkphepudegrdefrdejhedrudekudenucfrrghrrghmpehmrghilhhfrhhomhepohdq
 thgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphenucevlhhushhtvghrufhiiigvpe
 dt
X-ME-Proxy: <xmx:WoBuXRzP-i-Ay9TrXrLbdB9ufVmt8u5_uyT-PYITtyH7Wi4tQdOemw>
 <xmx:WoBuXQ3XgNLnXwHgOwhZbJ5XnGydTM0uutLufJ9E7ZXYO4SFtfGgkQ>
 <xmx:WoBuXWLlAU6KMBsTiUSVEu9NKpDqudhJCCtwQ4dlVoxsVDSEt3y-fA>
 <xmx:WoBuXbG10obOHxnMPqHIPY0Mmu4pIqI5EJOTdKAhNf3YdVyqAdSVjA>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id CC01BD60065;
 Tue,  3 Sep 2019 11:01:44 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Wed,  4 Sep 2019 00:01:41 +0900
Message-Id: <20190903150141.24484-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] MAINTAINERS: update entry for firewire audio
	drivers with UAPI header
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

The most of drivers in ALSA firewire stack supports common ioctl commands
to enable/disable packet streaming as well as some ioctl commands for
model-specific features. An UAPI header is exported to userspace.

This commit adds supplement for entry of ALSA firewire stack with a path
of the UAPI header.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4200194e69ea..6bd54ce6dc66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6271,6 +6271,7 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
 F:	sound/firewire/
+F:	include/uapi/sound/firewire.h
 
 FIREWIRE MEDIA DRIVERS (firedtv)
 M:	Stefan Richter <stefanr@s5r6.in-berlin.de>
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
