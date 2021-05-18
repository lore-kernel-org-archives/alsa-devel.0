Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABBCC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 01:27:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B4D6113C
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 01:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B4D6113C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8761E1674;
	Tue, 18 May 2021 03:26:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8761E1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621301235;
	bh=TfL8bUZcEv4n50FjVL7b2N5J2HqWqOkMI767TC3L+nw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u4p2YLxs4cSTv/oTkNsywkK9qVEhUvMqgC+5pXoZw1G09a/7hti2wISavAYziP2jQ
	 vMvK887NEII4b05KsXDjUs9rq6YTHl8FtlmPUlPZRmZ7oY7a3iTV6gTPfRP61wNY/l
	 8GEcoSteWy8vHcKzZS8gQ1FyGJDPl6A5rC60ocyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1520F8020B;
	Tue, 18 May 2021 03:26:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFE54F80249; Tue, 18 May 2021 03:26:23 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C999F80169
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 03:26:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C999F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="ovGNGL1J"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Di6b8QXT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 237EF5C0101;
 Mon, 17 May 2021 21:26:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 17 May 2021 21:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=Qx5EOO9JcORbUxQvF4VZ6WpeCO
 3MxZZJb0IuffeAra0=; b=ovGNGL1J9LzmVfzkucnGHZ3JkI9vriLMHMUYte9S52
 RJ1aVVE7g1tfJtKxuBE9jC+qHZsEPhqU9Vu1ddHXNeIeLv5jMXvCnMk2jk+McDrT
 EMsXm8P/Xk/gV3l6+FtdOg9IZc4TGvOYR14U6OLNGyFI9aST+AeeFBRlBOMU7upt
 egp/MVVPQm5kdtvhfbSX5xPd1QmPtk+griKSoyIHniED1K7UyUwObeleuAbIZM6H
 CKWEQkwLgCMV0mqZGL0ziCuxXUSjHEvoZZVRQCerl8oGuGk7OmHSoeieqt5a0GkC
 tHB/Awdun42vHNi3iCVx6jQ5zK09oGg+Z1m44kP1+LEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Qx5EOO9JcORbUxQvF
 4VZ6WpeCO3MxZZJb0IuffeAra0=; b=Di6b8QXTOU+YxMiUTnC1c62jpvdgwlWGD
 HgqsRkb+Kb2W1hNP1x8cWwyPoIQDfGTsMW8z5maMo+gj2hYjQ3B+3a4y7w/tj5I9
 yCm4AOE4P3Yb8Ov4xbr3FjQwMfm7BOIDLI/8psn5ncWBm4rZdk/L4+sLd+V6bjen
 0ZG2QDhCHzliLPxCkEaPd4LkH1x2ZczwVGYiJ9XzQpl8xsuwRViHHBGX3j3ENUEd
 HhGlnmLPkE5kDqJNcHLWSYoCTQEDvZbzD077n/Z+bLecyOfaI5D6moOJk6V6oqOP
 ilas+d55QFYEuK/4Slqb6dCr7JvDK2uKAITRoyVj4OA9vhKhKZrmg==
X-ME-Sender: <xms:uBejYGLNYwcshtKFymGJ4izaThHYjU-MXhxQI1nanwYF9es9vSJUrg>
 <xme:uBejYOKaUmryTh89EcsrvOhbusPNwmwEgtdKhYs5bgheqc-PDfZp176Q0PbTZ7qj6
 NjmGh_kfY3PZCvvq64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiiedggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecukfhppedugedrfedr
 ieehrddujeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
 homhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:uBejYGtWCzie_nWvgGRp2txNwayxoTx7V4HHMKqCVhBC03dnwOSeBg>
 <xmx:uBejYLZZ_8Uf4mGFY5JNWctGXCg4dMKlxiNePmuRrvRIYOUt7fZ_kw>
 <xmx:uBejYNZ6XnzcjnQf2vO01t3b_nezldlDiZd2zM3Bf69j5cVXlOLm1A>
 <xmx:uBejYMylRzuj1mWHnAonotJb_go4XyxJoB-7WB8XKMbZBIPHORFmxw>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Mon, 17 May 2021 21:26:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH] ALSA: dice: fix stream format for TC Electronic Konnekt Live
 at high sampling transfer frequency
Date: Tue, 18 May 2021 10:26:12 +0900
Message-Id: <20210518012612.37268-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, stable@vger.kernel.org
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

At high sampling transfer frequency, TC Electronic Konnekt Live
transfers/receives 6 audio data frames in multi bit linear audio data
channel of data block in CIP payload. Current hard-coded stream format
is wrong.

Cc: <stable@vger.kernel.org>
Fixes: f1f0f330b1d0 ("ALSA: dice: add parameters of stream formats for models produced by TC Electronic")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-tcelectronic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice/dice-tcelectronic.c b/sound/firewire/dice/dice-tcelectronic.c
index a8875d24ba2a..43a3bcb15b3d 100644
--- a/sound/firewire/dice/dice-tcelectronic.c
+++ b/sound/firewire/dice/dice-tcelectronic.c
@@ -38,8 +38,8 @@ static const struct dice_tc_spec konnekt_24d = {
 };
 
 static const struct dice_tc_spec konnekt_live = {
-	.tx_pcm_chs = {{16, 16, 16}, {0, 0, 0} },
-	.rx_pcm_chs = {{16, 16, 16}, {0, 0, 0} },
+	.tx_pcm_chs = {{16, 16, 6}, {0, 0, 0} },
+	.rx_pcm_chs = {{16, 16, 6}, {0, 0, 0} },
 	.has_midi = true,
 };
 
-- 
2.27.0

