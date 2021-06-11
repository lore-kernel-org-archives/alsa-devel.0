Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB1FC4743D
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 03:51:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3B8610E6
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 03:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3B8610E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4AF31833;
	Fri, 11 Jun 2021 05:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4AF31833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623383508;
	bh=zpwedSey2iPVaQsFw7XYv1YPXgYvYPWEzyBJJj3K8HM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l91o72j+5cbn6nEvJ7YuemRyKbHZEKYhqyDVLxUf1vf25XgA9763h2A3K1zK+TOkt
	 H+NvSIlOFj9wux2OwRkduc0m64+IK7Ht76dkrDjhDpI6Zx3cbWc6ZeiksajNtEl/Ij
	 IrdQYqqTZSvU5/WOk38PaSz+9h4zWYH97f6Ynn60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31CC6F804BD;
	Fri, 11 Jun 2021 05:50:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE9D6F804B4; Fri, 11 Jun 2021 05:50:22 +0200 (CEST)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8054F802A0
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 05:50:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8054F802A0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="RpcHZ+LX"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="p5wN97c4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 665021943;
 Thu, 10 Jun 2021 23:50:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Thu, 10 Jun 2021 23:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=dASBS8SIufRV3
 e4q6dP0/X+IyHfWlNItgGggAGbji4E=; b=RpcHZ+LXEXzpColXPScqDRQgpEpTI
 y0ZV1w53dy9BOB4lbxbbXplc3lbkTHCEs14Z4aXei3A1DgmKEJiWKZO3OKBm3unC
 53+pHGyJwAgzhTRssZ5RYa0YFms3ys/FVt6MG0VHBeSVvuymyvD4sGNcvpNSnbZj
 bJ/ZC9B3VWO5rIQdRhTmH0YfQFqGk7n1ctflHkD4qA5hN9ScR6r2OjzLymvwg3XK
 kL+QqcSi2FLwI0mpt+9X1gQteYnbVUysh5/7zgrK2anP+KraRV2vCMmkFiq77gue
 EONeeaYDTOZ/uBNB4POUahntSCJZrqzuXKjx/eEA/d3iAs67QXnmJnCKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=dASBS8SIufRV3e4q6dP0/X+IyHfWlNItgGggAGbji4E=; b=p5wN97c4
 qxstyKNicPWqlaNeIn2px8rcpMpU2qht2WKxsq9+ZcRB5Ib3Ypv8VhA71lKmPBYd
 4TbJePpDclWyA357dEmMpmj788Ryv1l+ZdLNCc14rXJA7IS3Ipu1ZbZApn9z1SRf
 U5QTaoBKtphF4VUby7hp/Pm6axVFHgRCNMghM/0PKzAOteLccNDP00WsC4kXS2TE
 uR0eVQtjpJUvqPH3PT/ghFrwrb3eI40Xj38ATGil/pP6ik11w6oIwFv+xPKqhA6W
 oWMKjkwbjrnGmMp8Fyw2PdNQrV2A7Bfz+zx7pB5AOZWHaI3Nz7YiQn+UqKZnHmen
 RaCDtG4jY74gKg==
X-ME-Sender: <xms:ct3CYFVnI9fCnquJhqrsjweV9kLK8QsRpKwKnkVS14d2x2PoLwpBVg>
 <xme:ct3CYFl5O6ksTGIHxns-K5vhiyzLJDIzSyoOSKuMRZz3XGEjGwVVIuknVyOVYe1JP
 BrONJLG51fGnWSGod8>
X-ME-Received: <xmr:ct3CYBb5xIBI5gOK2OxOsZOOnI8mh1Nkvkm_-Fp4V-nZJ_7bzeV1ZgRXma6U4SyzypWiKDeMllV4ACW84JRP99vPw0F-ZuOTJ2p3REpQORzWXM5029se>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduiedgjeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
 rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
 grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ct3CYIU-08QYw-XtpPtSU22jpgf_Hr1vO4EGbhz4_3AQjIOTKkFf0g>
 <xmx:ct3CYPng_MwdZl-hAqqrYo149lzQ3CkoB1TDOMHjbGN1e2lE1rSd4w>
 <xmx:ct3CYFccPk7szXRWYiehhFtmFFDrr4BNKaVsU5KWNa264sbYSGWEEg>
 <xmx:c93CYHu1n1Lyz910ZT-jVAwK8FsZsWx6CDry_rIy-xD4wa8Q1zoWlQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jun 2021 23:50:09 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 1/3] ALSA: bebob: dismiss sleep after breaking connections
Date: Fri, 11 Jun 2021 12:50:01 +0900
Message-Id: <20210611035003.26852-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210611035003.26852-1-o-takashi@sakamocchi.jp>
References: <20210611035003.26852-1-o-takashi@sakamocchi.jp>
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

In a commit d3eabe939aee ("ALSA: bebob: expand sleep just after breaking
connections for protocol version 1"), a workaround was added for a quirk
of freeze in BeBoB protocol version 1. As long as seeing with sequence
replay for media clock recovery, the quirk disappears.

This commit removes the workaround.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 470c2b70cbfa..6d47c25654e6 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -401,12 +401,6 @@ static void break_both_connections(struct snd_bebob *bebob)
 {
 	cmp_connection_break(&bebob->in_conn);
 	cmp_connection_break(&bebob->out_conn);
-
-	// These models seem to be in transition state for a longer time. When
-	// accessing in the state, any transactions is corrupted. In the worst
-	// case, the device is going to reboot.
-	if (bebob->version < 2)
-		msleep(600);
 }
 
 static int start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream)
-- 
2.27.0

