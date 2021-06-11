Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D7DC4743D
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 03:51:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B270D61357
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 03:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B270D61357
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E5341840;
	Fri, 11 Jun 2021 05:50:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E5341840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623383504;
	bh=qkScbxKvt+M+ESpOsuf3Ww6xk+asGsP/3RbV+0iIbEY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LMHHzR6aIXdzaogXhGJL9EyYPtuuGLFpHr/Rpda9fxZtRvjCiMAUm9twQ4MagNjOf
	 Iggx6lrNRfMoygMJ0wyLEY7TvHn/tDXd8qZt6ujshZuTdZ+kUPvobe0EveiPYI8eRa
	 iBQ6odbcEX9ByLTNr9yc9Nn4JPZSSWNcQciGMCu8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7910F802A0;
	Fri, 11 Jun 2021 05:50:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D4C8F80276; Fri, 11 Jun 2021 05:50:22 +0200 (CEST)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E16E5F80276
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 05:50:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E16E5F80276
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="pflvsn7R"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="UoMDAL+o"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id A73741B98;
 Thu, 10 Jun 2021 23:50:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 10 Jun 2021 23:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=CMi6nwQXnQReD
 0V1CCZ75333nlU6hpE84b1egm3r2yM=; b=pflvsn7RjmHDOZmSKabXJc2vV7pTg
 SJucmYxBH2Jn36EcdjUOl+ikOe4bShNKXAHku4C3X1sfacHdtN4Q1erKUgT6RDun
 qX49nf7u5+68u6BWPn1IgQXb6GeZIz+TIJB9JhimgZwWqlKzZ5vbHHh5HUP3Gf05
 0w0PoA0tEzzJ2u9URgoGswaM8ZqPw6vg/iUP3vM7d13EoUDbb5BePnb1DdJbnqEI
 oLOYEuF0LKNfcyO8gRHziMbarDSrZqCgn5a+aYPu+GWjhK8FtYR7ZOnNqvcvECxK
 4Jw2xo1lYYvV0cotSKNCUWgwuI9FI4KTz3cIjW7DG5mnOdaRKoM7DJUlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=CMi6nwQXnQReD0V1CCZ75333nlU6hpE84b1egm3r2yM=; b=UoMDAL+o
 uKq5m+kfRHEYRraw4XIWvNj1S6/acW5AgtZsZU0vbZ1qFGiDoR2THHbPxdcSO5Js
 Gf7c+IBWYkBrPA8GVI6la9t8c0gx0ejlFD+S2CMnzOQLO2+CWT3qwyk2MCwwcgeV
 mLwTm1LE7G5xBxrAgBGsv0TsdfR9JNyJVxl7zV0hgvuux9VJ7c3GvgZci+PsRP82
 XDYX9qdgt1undeo9wysJEuyY15mq7Ij1Bvh0IhD9fEn+z9cqARnobL2c0dU+XxhM
 tksdQ8D4XBLGUDchCBJr+TlIoXNNnC0LJPDUY7Q02Gwm5gembrpmUQ1sVqmwXNwc
 ODmkdKea4VnWSw==
X-ME-Sender: <xms:dd3CYDKtxcnfch-qPb9EpBBunvxlxItjOBGaYcwq5x12kHkVCiDdNg>
 <xme:dd3CYHLG09D-f4pNMyOsyWblLZYmyv88E3FysrpI6B_sK_g-1Fd1Tr-Tq2mFrCrF3
 yP186XJcRd_T_Sm9jo>
X-ME-Received: <xmr:dd3CYLtC7vLhnVSmcgebQKqz3no3mU7ejbBa805iM_E2ktesOG08i_zrZ2kn_6nCZ0dCtEjKt9MVbv0uPWH2SioDQocrVGya423wlf-J7VqriXx-Bfel>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduiedgjeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
 rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
 grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:dd3CYMbXrXIN_oulaiuCG2lXHegz_3lPH05vv1HvuY8rhCrpPLYGHQ>
 <xmx:dd3CYKaHrN77yIxtnhEoVk44gUwEO5cjHnWp_yZQytS0Sxi6AWdfZg>
 <xmx:dd3CYACCQ1Nl9ueoX845PIr482oyQPRCUs3KIRinpfmn_-Upx_vARA>
 <xmx:dd3CYNzVYQY13H692xO23FasaPbOQQZp91FMoQm4Cv7erGJsNzmJrA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jun 2021 23:50:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 2/3] ALSA: bebob: delete workaround for protocol version 3
Date: Fri, 11 Jun 2021 12:50:02 +0900
Message-Id: <20210611035003.26852-3-o-takashi@sakamocchi.jp>
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

In a commit c4d860a0d256 ("ALSA: bebob: loosen up severity of checking
continuity for BeBoB v3 quirk"), a workaround was added for the quirk in
BeBoB protocol version 3 against the discontinuity of data block counter.
As long as seeing with sequence replay for media clock recovery, such
quirk disappears.

This commit deletes the workaround.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c        | 7 -------
 sound/firewire/bebob/bebob.h        | 2 --
 sound/firewire/bebob/bebob_stream.c | 8 --------
 3 files changed, 17 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index e7dd112c31c5..25222cc27e43 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -75,7 +75,6 @@ name_device(struct snd_bebob *bebob)
 	u32 hw_id;
 	u32 data[2] = {0};
 	u32 revision;
-	u32 version;
 	int err;
 
 	/* get vendor name from root directory */
@@ -108,12 +107,6 @@ name_device(struct snd_bebob *bebob)
 	if (err < 0)
 		goto end;
 
-	err = snd_bebob_read_quad(bebob->unit, INFO_OFFSET_BEBOB_VERSION,
-				  &version);
-	if (err < 0)
-		goto end;
-	bebob->version = version;
-
 	strcpy(bebob->card->driver, "BeBoB");
 	strcpy(bebob->card->shortname, model);
 	strcpy(bebob->card->mixername, model);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index edd93699ce1a..fc2b9b36159c 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -109,8 +109,6 @@ struct snd_bebob {
 	/* for M-Audio special devices */
 	void *maudio_special_quirk;
 
-	/* For BeBoB version quirk. */
-	unsigned int version;
 	bool discontinuity_quirk;
 
 	struct amdtp_domain domain;
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 6d47c25654e6..02972b32e170 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -456,14 +456,6 @@ static int init_stream(struct snd_bebob *bebob, struct amdtp_stream *stream)
 	}
 
 	if (stream == &bebob->tx_stream) {
-		// BeBoB v3 transfers packets with these qurks:
-		//  - In the beginning of streaming, the value of dbc is
-		//    incremented even if no data blocks are transferred.
-		//  - The value of dbc is reset suddenly.
-		if (bebob->version > 2)
-			bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC |
-						  CIP_SKIP_DBC_ZERO_CHECK;
-
 		// At high sampling rate, M-Audio special firmware transmits
 		// empty packet with the value of dbc incremented by 8 but the
 		// others are valid to IEC 61883-1.
-- 
2.27.0

