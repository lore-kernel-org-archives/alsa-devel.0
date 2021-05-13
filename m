Return-Path: <SRS0=EA+P=KI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2434CC433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 12:58:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA25A61421
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 12:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA25A61421
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 179ED17A5;
	Thu, 13 May 2021 14:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 179ED17A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620910728;
	bh=oIKLkH0gxcxdOQHwM6fhI5+PrC5frByE3pknPVmNSYk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BiZIHVL8WB9/CjzlO9capnPbt+gSRbYF/E+BghCOQLx+O1PxMk0KZAWrDMAnnGuKj
	 uOlGTAMsutJZEctkrQZrGZluxgLaKBvJg5dHZAPpjgoT0pfNcj7VY6YuWnA9PgiimS
	 gJMNDFhwdP/mveaLOWVMKXxvtU7yg3FKbkLnK1m8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49F1FF8013A;
	Thu, 13 May 2021 14:57:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2D6CF80425; Thu, 13 May 2021 14:57:07 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6FCBF80156
 for <alsa-devel@alsa-project.org>; Thu, 13 May 2021 14:57:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6FCBF80156
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="0XW2hESe"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="YO6+Bqg/"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 8FA905C00DA;
 Thu, 13 May 2021 08:56:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Thu, 13 May 2021 08:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=oqnqLSzWwArX3
 UFdvvQl06g8qMhU2lbmwvSxgSDHNd4=; b=0XW2hESeiRm31CL5g1XZ7Wvp7asut
 4Ofb58Neay0so1+969lKOtQd8uLopxFb0dppHOwDUAUQ/98wPZ6QfFcgIwHoy30w
 BnJ3eSbKiZIjoxsZn/BVk258A7AN+LJpB0JYVjCwlKlK8mmyYI0Qx1FpTUDPcAka
 SvmExRThRr4zDZwXkVcohQXKkf/iI59npaiUozymJ9/aHldaefDG7JNKjoLufaXH
 NXfqPcDcAirbEGHKXmPgizsOOgrs5bazUJPTpuE2d7PNTaCcWSUaASbNo3EmKY6t
 RxTebz/ybsa26Jv2uIhvvIDm5zFdIqbqwpYSLQu0M1j26AijDLN2O6org==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=oqnqLSzWwArX3UFdvvQl06g8qMhU2lbmwvSxgSDHNd4=; b=YO6+Bqg/
 YcQYo9OhI+Lr2xwKf+tC1iE8CEy4+1yd2aI3zi8kaUTAuaaPcaZRoZGfOeYKG6Ga
 i5pksK25roEcT8pqRIzqhRE3cEx9Vm4ILM+x6XP2ch7uZ3DA9Lju9gD/0WPFd8pa
 PIn1cvCjGGrIxFOf8RBOTuHdBfjQ/5aTCgGFs/gAz8SEoWDyP11PyMAinmzGe2g6
 0btjj6ASnvooM2QkpgpFyyMnTsAM1bwdbIvfDHclrvuHFjXYJ/GfUmFYWX5pcCpr
 n+3sCUSRoTzcVW/sPaR2+PKPYMMyjdSZeMzNAxYVf1J9u9Z4ZE2cnniObDxM0Ksd
 A7K5qpQNOhIuIw==
X-ME-Sender: <xms:GyKdYA54XIrCgWNNkySfm4DxsLqREbOGRHpLzMA4zMjjsfDOA0H14Q>
 <xme:GyKdYB7OGRa2bdTxijEnTdszx9PcvRwCTmc0ezF9y5tJ-QOz0Y179bLPc2ZgqCWvT
 aX13glcxZyKHt9lVAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:GyKdYPcONJcUh4itQ3-uWjCT2wrwWr6JOyISwEt-35cQwbpaAgpQvQ>
 <xmx:GyKdYFK1M2lKU9sHizzOJU85MqKubu0mRd-xPWYoLYbTUrnP7M8Zow>
 <xmx:GyKdYEKkx7_nIbWHJrAjw9_uSVnpfTQ6YlIZm2wfpyPiTaH_A4EsWw>
 <xmx:GyKdYOhYeevTL5bQkf9FEDFgB_jW5sola-LZY4jrm61De6_uOuI9Vw>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 13 May 2021 08:56:58 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 1/5] ALSA: dice: fix stream format at middle sampling rate for
 Alesis iO 26
Date: Thu, 13 May 2021 21:56:48 +0900
Message-Id: <20210513125652.110249-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210513125652.110249-1-o-takashi@sakamocchi.jp>
References: <20210513125652.110249-1-o-takashi@sakamocchi.jp>
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

Alesis iO 26 FireWire has two pairs of digital optical interface. It
delivers PCM frames from the interfaces by second isochronous packet
streaming. Although both of the interfaces are available at 44.1/48.0
kHz, first one of them is only available at 88.2/96.0 kHz. It reduces
the number of PCM samples to 4 in Multi Bit Linear Audio data channel
of data blocks on the second isochronous packet streaming.

This commit fixes hardcoded stream formats.

Cc: <stable@vger.kernel.org>
Fixes: 28b208f600a3 ("ALSA: dice: add parameters of stream formats for models produced by Alesis")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-alesis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-alesis.c b/sound/firewire/dice/dice-alesis.c
index 0916864511d5..27c13b9cc9ef 100644
--- a/sound/firewire/dice/dice-alesis.c
+++ b/sound/firewire/dice/dice-alesis.c
@@ -16,7 +16,7 @@ alesis_io14_tx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT] = {
 static const unsigned int
 alesis_io26_tx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT] = {
 	{10, 10, 4},	/* Tx0 = Analog + S/PDIF. */
-	{16, 8, 0},	/* Tx1 = ADAT1 + ADAT2. */
+	{16, 4, 0},	/* Tx1 = ADAT1 + ADAT2 (available at low rate). */
 };
 
 int snd_dice_detect_alesis_formats(struct snd_dice *dice)
-- 
2.27.0

