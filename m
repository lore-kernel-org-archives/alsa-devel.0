Return-Path: <SRS0=I1aD=YZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F232CCA9ECF
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 13:16:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789582067D
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rd+LtUK6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Lx9aV4d5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBCBiGao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789582067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9831D217E;
	Fri,  1 Nov 2019 14:15:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9831D217E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572614171;
	bh=UigfHJTpE6B/mjHIw1wIBmhuKw9r3Kk5BQB9BPrEppE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rd+LtUK66Rl8j0emYCBeeRWBeR78a0cICuqyxk1hCDQPPh+4j0oy/pIJk3GAD9nLZ
	 B9e8gBVxbFCsNOQm4SGIWSiv1bF6BX9dxFUQunIRu5E0TAci7MwlGI+fTPwor7PF36
	 TuMyIhg7gErgIXF/mzvLYMM5ZCt7p/Kcqc4AHYcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29720F80600;
	Fri,  1 Nov 2019 14:13:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9B72F803D6; Fri,  1 Nov 2019 14:13:40 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A717F803D6
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2019 14:13:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A717F803D6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Lx9aV4d5"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="jBCBiGao"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 7DDDB5AD;
 Fri,  1 Nov 2019 09:13:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Fri, 01 Nov 2019 09:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=11hS4dQy3tMBS+qiDTWkeaKpxf
 j3Q0lRSXOxNxRodPw=; b=Lx9aV4d5wpBH0vuQ4peS49zv1lVHLPqlQQpZVD7A6R
 eGpjVXEAnoUwykeSX4bGOaYTdBwfe6PplRQ83YA4d08lqgoYnC9tN8IyBN1Sf4zQ
 akHR/QTj5unPNxfwcl/fWLZjtTOmvFZIgrXOhlcW8s8sr1A/lMlOrL4guNI8f6tS
 JJlJki6sZ5/zi6IIBmn4MuAcnzujupj5loYWDIJCtMbbtxd/9UqV3j6gogYpIXsC
 fzo8DbmzGeEz1ShS2lOm1Y5Qx+ri7rw+3ieqV0yw+HveWLXE9a3RXv6IYHBTXVDR
 PdbBWdYVwE/EIGhSkLRgZvni45lKib96Hn+NlDl53Raw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=11hS4dQy3tMBS+qiD
 TWkeaKpxfj3Q0lRSXOxNxRodPw=; b=jBCBiGaowvn6HtzLwu65asfdh4dVBgsU1
 Oq/Wk+0sdLQnSLKVpxyp5sPdP/kiopezzjw3n3JWnzrnXHv+qFcTLW+tV/SzPFVz
 1RCWXqi8kW15dZc2R9ttxSmiKm3gt7AqRfK8EgAtkFgOY5GOuOC+p2wXfU7w6T2v
 ruIy5sZcaDuL6/Gy5fK7JckwfYrIYkt5JUe9TAm0m11/L4++LUhAS1X4uehudp9J
 ylHjYWPEfHLoIV6Pi7n3JNiGvFC/U+KOD1KT0dygyp9Nsy+xBtKcQI4MfvCG/UUK
 4siVwJrmgV60g0y+XTAf3SjMsS/LWVlnN5/4bASl2Uswfag8Oa1+w==
X-ME-Sender: <xms:eC-8XQCMYwahcRUSuZiyU6vncKtE4AOThb87xkBc7hL0aSAh1937Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddtjedggeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuffhomhgrihhnpehgihhthhhusgdrtghomh
 enucfkphepudegrdefrdejhedrudekudenucfrrghrrghmpehmrghilhhfrhhomhepohdq
 thgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphenucevlhhushhtvghrufhiiigvpe
 dt
X-ME-Proxy: <xmx:eC-8Xb3I3WrNE8lbp03KUCU3omoXrjX190K4EcaLyp1pVVBxzXvsnw>
 <xmx:eC-8XSWRgSWvHLZDGOFSzLpm8_VuwPka23sjF-s_Adq5KrXCyWy77w>
 <xmx:eC-8XRxbi0IWTHWyb-d55sfYqVREQE5rMYshiMTf0NetzeDsjk52JQ>
 <xmx:eS-8XYZnxu9JkS7GgZWgw0ByMvqIYRtjCFzbUksNcZcNsUbC2gU47g>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id D54753060057;
 Fri,  1 Nov 2019 09:13:26 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Fri,  1 Nov 2019 22:13:20 +0900
Message-Id: <20191101131323.17300-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 0/3] ALSA: bebob: misc improvements for
	starting/stopping packet streaming
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

This patchset improves model-specific issues in a point of protocol
version supported by the model. The changes are relevant to packet
streaming, thus it can brings some regressions.

For testers, I prepare for a remote branch to backport the latest
codes to Linux v4.17 or later. I'm happy to receive any report.
https://github.com/takaswie/snd-firewire-improve/tree/topic/bebob-connection-issue

Takashi Sakamoto (3):
  ALSA: bebob: expand sleep just after breaking connections for protocol
    version 1
  ALSA: bebob: expand delay of start for IR context just for version 3
    firmware
  ALSA: bebob: link the order of establishing connections and Syt-match
    clock mode

 sound/firewire/bebob/bebob_stream.c | 76 ++++++++++++++---------------
 1 file changed, 38 insertions(+), 38 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
