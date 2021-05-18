Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D1DC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:51:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2806124C
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2806124C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32B4F16E3;
	Tue, 18 May 2021 10:50:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32B4F16E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621327862;
	bh=i49Fp8cR1cpc77Ja4+LP2qrMl1LjwFW0g/irVuCYRH8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EsqrDWJ4eED0V2oFoZgiNwmBBVWE/7+BL8lOJbrgafKUNextIlD+pJ+SQl0qFBraE
	 g7Fpypz2I3OYE4WY8zO+YqealFm/WG3GUlb1NteIIAMt9tRWx88c5b4klhPjcfVw4B
	 GWPS/kNJ+78rRUi3+96k1HSn01a+BtpElfDsBRt8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E291F804EB;
	Tue, 18 May 2021 10:46:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42992F804AA; Tue, 18 May 2021 10:46:20 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 408DCF8049C
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 10:46:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 408DCF8049C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="tuYiDOEH"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="VRz/v4vX"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 789305C0127;
 Tue, 18 May 2021 04:46:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 18 May 2021 04:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=a8rWYDAHF7RCi
 UhMU9VRr4U5B32VDR14jltI6pbDoJ8=; b=tuYiDOEHzbQI789RGtBw3hutbP6J4
 v+6HOURmINJJWhaJvrlV2Ngt1gdKoTZ9/Ed96jTj4ALH8SysUwmWyyzpbDFn0SU0
 uQ9jTHY9lPNYMsL0YE/YxPytu5bqUG+qyYiLjH0fXN7hGYzWaRHInzd8YoR6IwH0
 5IM9wbGv6yxIX8+IEzi5sNH9hvtoax7RNfYu9zLNe0xo3CQAtwjDvwaGjN6C2oBr
 zMiF9TQMQZ3w+VO0vFcAcA+4BOI9NVKZ6WHbHOMDC5U48oD29PfD//b6mBNshEpO
 E1DPnT0wA3pdAHyO4/1R7s68/tPjuIss6+hsdXxV7EOq/XXWulwxnY4wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=a8rWYDAHF7RCiUhMU9VRr4U5B32VDR14jltI6pbDoJ8=; b=VRz/v4vX
 EEelaWevJxMpfJ8lAI1O9G5GPiEI86NuMLDUOaiiuXdkgFV87SI5MGHcZLQekD63
 Fq+RObnjnHShgv3iXKkvDkJgXtcOe/fszIs05WxDjYKPCpzd/4JMbhI7CKJ6TgUW
 LDzBjj1mqkalrxto25ETX/lj2IymVB8d6Nv3NhmGzyGlhem8zSTD4Fs/lydNUJ+Q
 EYgAHDDmBb0GODgWlIRwfi+yN1Tgbj4zwxb5ld7LHanoArJKuk6NtCzIJ0jRQwmt
 gfD0BvNTxmfR4i09F9qQWIbyBQAF95QVAR8q7xdGF29G3pU5Ova7wnMbh2GLdh2e
 8ui+SIJwOrOYEQ==
X-ME-Sender: <xms:136jYCGnq4Hw4DUgWhmjGfhZM-vXkC8N0xgvQHHZTQRtjfCT0_1ROw>
 <xme:136jYDXrn2Z7UkTaMifkskKLGwPQL2QsmTf0GGf9bm_d_vhcWgBUYQ63dFcmDVpWz
 u0Mo988E-rxSveAJ5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgtdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:136jYMIbpSHuEY-Ocw5FuKX3Lh6an0KSAq7KmlHRgcVB0ITZfQ0i_w>
 <xmx:136jYMGJ-MHyIVUmwFeL4Nk0yt_Int9j7DgZRHnxtFKCpobT65dFlQ>
 <xmx:136jYIXRxXqc3rcVKXnotbNuzwnTynBzNAes1Y3_tk5DzFkss-1w-g>
 <xmx:136jYBcv3Yu0BsSquUO_BxNJWjyRILfnjxhtF8ZzTqj4k9ASXTImiQ>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Tue, 18 May 2021 04:46:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v4 10/11] ALSA: oxfw: code refactoring for wrong_dbs quirk
Date: Tue, 18 May 2021 17:45:56 +0900
Message-Id: <20210518084557.102681-11-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518084557.102681-1-o-takashi@sakamocchi.jp>
References: <20210518084557.102681-1-o-takashi@sakamocchi.jp>
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

A new entry is added to the quirk enumeration for wrong_dbs quirk to
obsolete structure member.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 2 +-
 sound/firewire/oxfw/oxfw.c        | 2 +-
 sound/firewire/oxfw/oxfw.h        | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index c06173fd247d..5771ff44dd5d 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -163,7 +163,7 @@ static int init_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 
 		if (oxfw->quirks & SND_OXFW_QUIRK_JUMBO_PAYLOAD)
 			flags |= CIP_JUMBO_PAYLOAD;
-		if (oxfw->wrong_dbs)
+		if (oxfw->quirks & SND_OXFW_QUIRK_WRONG_DBS)
 			flags |= CIP_WRONG_DBS;
 	} else {
 		conn = &oxfw->in_conn;
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 90a66e1312fe..966697dace47 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -176,7 +176,7 @@ static int detect_quirks(struct snd_oxfw *oxfw)
 	 * value in 'dbs' field of CIP header against its format information.
 	 */
 	if (vendor == VENDOR_LOUD && model == MODEL_SATELLITE)
-		oxfw->wrong_dbs = true;
+		oxfw->quirks |= SND_OXFW_QUIRK_WRONG_DBS;
 
 	return 0;
 }
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 07aa0d25e100..4002998d41e8 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -36,6 +36,8 @@ enum snd_oxfw_quirk {
 	// Postpone transferring packets during handling asynchronous transaction. As a result,
 	// next isochronous packet includes more events than one packet can include.
 	SND_OXFW_QUIRK_JUMBO_PAYLOAD = 0x01,
+	// The dbs field of CIP header in tx packet is wrong.
+	SND_OXFW_QUIRK_WRONG_DBS = 0x02,
 };
 
 /* This is an arbitrary number for convinience. */
@@ -51,7 +53,6 @@ struct snd_oxfw {
 
 	// The combination of snd_oxfw_quirk enumeration-constants.
 	unsigned int quirks;
-	bool wrong_dbs;
 	bool has_output;
 	bool has_input;
 	u8 *tx_stream_formats[SND_OXFW_STREAM_FORMAT_ENTRIES];
-- 
2.27.0

