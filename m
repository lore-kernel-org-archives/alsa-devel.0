Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC72EC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 13:02:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016F061040
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 13:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016F061040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20B9516F0;
	Tue, 18 May 2021 15:01:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20B9516F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621342969;
	bh=lKVKzjwGhMBl9qfsHW6Qp4jZjlHmFR9KFh9CFePBfM8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m2Zo/vGBTAMrFZtzml0eFikEv66EomASHz5B2qqRGsQQdCgy5Al0+7+spw9w+78nD
	 g3X5YVTr7oYHZYC35X4sIgNeJXuA5GmF8Jli1lsQtR5SXAHNDk2d8AlM3BQ0/2sk14
	 EZAFAPrZk2n/UyTZKBaFvaanJHdCNQMvjdqnVfBs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C56EFF80430;
	Tue, 18 May 2021 15:01:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 639EEF80430; Tue, 18 May 2021 15:01:08 +0200 (CEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58CF5F80217
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 15:00:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58CF5F80217
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="IzZgnLgu"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="O6haf/rC"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 47B4E5C0036;
 Tue, 18 May 2021 09:00:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 18 May 2021 09:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=c3/WTsm5zzIZr
 KhzTUn6Q5t4wrHodywOq9IdX4OwGDI=; b=IzZgnLgujf1H5x0f9LBZ53TZwo3VN
 PdRpkD15MqipOcbCutG85OucjHhyP3p/fyr218tg15NSdLkRYxzLDdE3/bRgnSM9
 Hf2cn2CKW/vLhaLLBQ9tMNPARRCJCg6eq5doTJyCwRSnh4D6QNiYvf7Rx/jKyodO
 aOdwN4JhduI/okf+expIjNmKG3pRA1mMZ23G7z8VoBqqxpnHew3FIRicRWG9QWch
 px/2iXFHv2sr9WE69+FeEYAAx5mhkihe1HJLCrn4GR2qeWwonGYSGyvCalzeHx/W
 80L0jaLDZDHCXXsO7qP4MbhoXMSuIyR7Yg53xD1cFAzJq43Q7QNSx2Dgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=c3/WTsm5zzIZrKhzTUn6Q5t4wrHodywOq9IdX4OwGDI=; b=O6haf/rC
 ceLF0wJTHmH1lm74Estl4+fs0TzJGJ1vqu+NpHZSj7g1sG//I0fjhNebNlNzL/FM
 YMH43IldRg/JYb1V9WKUe7Xz1vzoSTJkybXXVepJpqTz3A0Ny+rrtNNtAwhlr8au
 Jzypvrny7YYzzb1Ow9vuWDPdQOaqEKUEFNptQSQWU90ziUiL8Wb2gjrwPYaaeICK
 cYQ+HWNqigyieFKkeEQC16X/rCO0t9+vJ+JPYzF0WbS9LngdQ+9VWxL5nFVBCR0H
 obYq1rgLz0p3CYIqgSoQRA7dtLCguhbMbGIir4pxMcioIT1Aa3JZHpjySI3jh1cV
 Aqc8giDjBcZ++Q==
X-ME-Sender: <xms:hrqjYCJ0DAc5lcmp4JhhjbOqEDuHpo12b5J8ICGSsA1owbRmm0sl7A>
 <xme:hrqjYKIa8gMyMD_xBkELA0qJ9uHwj2x67cupEmYs3fdnmbIfHLG541mgcK5IQDAX4
 HbJ55c4Fv_MD6FvSuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgheekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepieevffdvhe
 eutdelffefgeeiudettddvjeefudetveeuleehuedvteevjeettdegnecuffhomhgrihhn
 pehrgidrvghvvghnthhsnecukfhppedugedrfedrieehrddujeehnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgr
 khgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:hrqjYCs7uzIWF9YYcSzk7WhgSu1y9WgA0qc3obP44NEkeujmR3Qaug>
 <xmx:hrqjYHY_aOuLEQRTwFZd3-FHUBXbKXfkCBGSD2gA6QmDWNimR6ieeA>
 <xmx:hrqjYJbNcvVPh3Y1lsB9CTWqGkEiula5u18TTkwMbq0pwlzb2j9kMQ>
 <xmx:h7qjYKByZj58YeOkiQuusGXJDCPwP8QdPclWE5FJPbBSUhmlxbmU7w>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Tue, 18 May 2021 09:00:53 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 1/8] ALSA: firewire-lib: code refactoring to refer the same
 frame count per period in domain structure
Date: Tue, 18 May 2021 22:00:40 +0900
Message-Id: <20210518130048.146596-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518130048.146596-1-o-takashi@sakamocchi.jp>
References: <20210518130048.146596-1-o-takashi@sakamocchi.jp>
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

The number of PCM frame per period is common between PCM substreams
handled in AMDTP stream in AMDTP domain.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 3 +--
 sound/firewire/amdtp-stream.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 409274a532ed..ac37cd4c2b33 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -834,7 +834,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	struct amdtp_stream *s = private_data;
 	const struct amdtp_domain *d = s->domain;
 	const __be32 *ctx_header = header;
-	unsigned int events_per_period = s->ctx_data.rx.events_per_period;
+	unsigned int events_per_period = d->events_per_period;
 	unsigned int event_count = s->ctx_data.rx.event_count;
 	unsigned int packets;
 	int i;
@@ -1490,7 +1490,6 @@ int amdtp_domain_start(struct amdtp_domain *d, unsigned int ir_delay_cycle)
 	}
 
 	s = d->irq_target;
-	s->ctx_data.rx.events_per_period = events_per_period;
 	s->ctx_data.rx.event_count = 0;
 	s->ctx_data.rx.seq_index = 0;
 
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 0628b6e52fc1..c69042013245 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -147,7 +147,6 @@ struct amdtp_stream {
 
 			// To generate constant hardware IRQ.
 			unsigned int event_count;
-			unsigned int events_per_period;
 		} rx;
 	} ctx_data;
 
-- 
2.27.0

