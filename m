Return-Path: <SRS0=nB+M=KS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3FC4707A
	for <alsa-devel@archiver.kernel.org>; Sun, 23 May 2021 12:43:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B76F61175
	for <alsa-devel@archiver.kernel.org>; Sun, 23 May 2021 12:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B76F61175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B58101690;
	Sun, 23 May 2021 14:42:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B58101690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621773796;
	bh=hRatnXg7jqCuPaLs6n449MH3ZPeX9RziChkj871bb7A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WRhZfgfc6T83G2/gedaYNT4YFlHhoG88QMOgNH6Q9z8YK94pz/alzacajYikG6cK2
	 yTh6O3PhNmXcqYYa2GRClfrfhaH9xlDrTp1OZV8YI1lK6yVo9ek1JhQlrp7mcdYlTH
	 ehZxLfz3cbT4vkjJmTNQC2j9R7NWT+dCK3JB7UzQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D1BDF8026F;
	Sun, 23 May 2021 14:41:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 516AEF80425; Sun, 23 May 2021 14:41:34 +0200 (CEST)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1755AF80137
 for <alsa-devel@alsa-project.org>; Sun, 23 May 2021 14:41:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1755AF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="v8ATr6ps"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="oCTNp4yT"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 6DAB7E7B;
 Sun, 23 May 2021 08:41:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 23 May 2021 08:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=t1orP0CsnTksR
 Db98nAaKJLpKlhFXWDERsIQfcjRKl4=; b=v8ATr6ps0BJdEIqNrxcoL6jJTIWdP
 sateSOYG5l71IRpte41n+uEYJMlVjvBFyCawUcBfG2HqrbifC9AUN0cSUkVTMeJV
 ISiLYBkapwb1hWc8p6u5xZnCWUsudzUk4T2L3RhHtlNnMMmHiublk73FKy+xt1e+
 /nF7mxON/KhIOX9B94PYZdE5gnIJWPup1cI+Zvwa00oIlB38ulPIFxrdwBzhgmDO
 IFod0/S/HACBAT0fPyJvSDv8X05+01pjyhh0uGbEU4Be3yiJcKKEGkwCXtfORNLa
 FVD2kn3CjygdCUL6k3pi5bPjiqBAcb5bLjSvEFoAFqJOlJbf6OlG1cxIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=t1orP0CsnTksRDb98nAaKJLpKlhFXWDERsIQfcjRKl4=; b=oCTNp4yT
 4St1HCxd9FUQ4iwEeJi5dTzqzrraOztLiqUXW2qsP5vk9R4qQbdC+LwREphwXAzq
 /0wVis8Pq9rcwG/J3fVvJuA7+X5QLKX2JgNkL6hhoYvp4fYOZZc3tdY8FR7D63Y9
 zY6Mk0FoYyILW5KxhFXxy+tp1NDsM1WehudvRaXRV2vw3o6LT3Zplk3BUjzMYzry
 5XkvI9wSuwZy1QLzGWfAQGWXohgo7sWjn0lKwXYlzt8Wel3vq+X2wp70VzR6VVKH
 XGNqW2afGb2lZPvhVB2E2I5MBVCeaEnex6Tp4gbH6RXd+Ab2G6WyjpqEvMIPAXgr
 NT4dioRl3kSq+Q==
X-ME-Sender: <xms:dE2qYIHsyEaJ5mekGPZg60OXN89ylF4UNVL1_nSGKK6tyemO1vnn_A>
 <xme:dE2qYBW16tRznIHnhHEgN43PwWEKLe22aUnas4DIq3o8mYiVMI0tEU-mSH_N28Yb_
 rd8MsSGAc93lxGUd0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejjedgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:dU2qYCJQXKPGqkk-nIgI-sBovUEwEkLue7JXAKxPZwU5BiIvBAd7mQ>
 <xmx:dU2qYKEWiB5zswjdS6R3sYOSCY19kmR2yZvGUvnYkSuwmRYXcXQmhg>
 <xmx:dU2qYOUM9vqjbGG4Mt07w2Lsf1gSsMbUWdGinNoSCMbT4eXIooZ4Qw>
 <xmx:dU2qYHeP4j8oAcDytGFpNchAWu8YOI1rKWSQ_H__akXNCMNyR5fJmQ>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Sun, 23 May 2021 08:41:24 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 3/3] ALSA: bebob: distinguish M-Audio ProFire Lightbridge quirk
Date: Sun, 23 May 2021 21:41:14 +0900
Message-Id: <20210523124114.272134-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210523124114.272134-1-o-takashi@sakamocchi.jp>
References: <20210523124114.272134-1-o-takashi@sakamocchi.jp>
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

In former commit, ALSA IEC 61883-1/6 packet streaming engine drops
initial tx packets till the packet includes any event. This allows ALSA
bebob driver not to give option to skip initial packet since the engine
does drop the initial packet.

However, M-Audio ProFire Lightbridge has a quirk to stop packet
transmission after start multiplexing event to the packet. After several
thousands cycles, it restart packet transmission again.

This commit specializes the usage of initial skip option for the model.
Additionally, this commit expands timeout enough to wait processing
content of tx packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c        | 10 +++++++++-
 sound/firewire/bebob/bebob.h        |  1 +
 sound/firewire/bebob/bebob_stream.c | 12 +++++++-----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 90e98a6d1546..5938aa325f5e 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -64,6 +64,7 @@ static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
 #define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
 #define MODEL_MAUDIO_FW1814		0x00010071
 #define MODEL_MAUDIO_PROJECTMIX		0x00010091
+#define MODEL_MAUDIO_PROFIRELIGHTBRIDGE	0x000100a1
 
 static int
 name_device(struct snd_bebob *bebob)
@@ -210,6 +211,13 @@ do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
+	// M-Audio ProFire Lightbridge has a quirk to transfer packets with discontinuous cycle or
+	// data block counter in early stage of packet streaming. The cycle span from the first
+	// packet with event is variable.
+	if (bebob->entry->vendor_id == VEN_MAUDIO1 &&
+	    bebob->entry->model_id == MODEL_MAUDIO_PROFIRELIGHTBRIDGE)
+		bebob->discontinuity_quirk = true;
+
 	err = snd_bebob_stream_init_duplex(bebob);
 	if (err < 0)
 		goto error;
@@ -476,7 +484,7 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* M-Audio NRV10 */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010081, &maudio_nrv10_spec),
 	/* M-Audio, ProFireLightbridge */
-	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x000100a1, &spec_normal),
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_PROFIRELIGHTBRIDGE, &spec_normal),
 	/* Firewire 1814 */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010070, NULL),	/* bootloader */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_FW1814,
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 4e0ed84adbee..cba6793bfdb2 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -115,6 +115,7 @@ struct snd_bebob {
 
 	/* For BeBoB version quirk. */
 	unsigned int version;
+	bool discontinuity_quirk;
 
 	struct amdtp_domain domain;
 };
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 975670a29a72..91306da1bafe 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -7,7 +7,7 @@
 
 #include "./bebob.h"
 
-#define READY_TIMEOUT_MS	2500
+#define READY_TIMEOUT_MS	4000
 
 /*
  * NOTE;
@@ -644,12 +644,14 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob)
 		if (err < 0)
 			goto error;
 
-		// Some devices transfer isoc packets with discontinuous counter in the beginning
-		// of packet streaming.
-		if (bebob->version < 2)
-			tx_init_skip_cycles = 3200;
+		if (!bebob->discontinuity_quirk)
+			tx_init_skip_cycles = 0;
 		else
 			tx_init_skip_cycles = 16000;
+
+		// MEMO: In the early stage of packet streaming, the device transfers NODATA packets.
+		// After several hundred cycles, it begins to multiplex event into the packet with
+		// syt information.
 		err = amdtp_domain_start(&bebob->domain, tx_init_skip_cycles);
 		if (err < 0)
 			goto error;
-- 
2.27.0

