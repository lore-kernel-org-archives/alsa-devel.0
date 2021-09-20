Return-Path: <SRS0=8ObE=OK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C2C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 11:08:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6E960F56
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 11:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F6E960F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50DB81688;
	Mon, 20 Sep 2021 13:07:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50DB81688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632136124;
	bh=PgUGc1SWyn7yYZ6Jp8nV2BbeuCrYklqp4q6fwnROAHw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VKdSOcOzd6OtMekO84pBm/Ryz1hUDOLrKXhFGOMT+8LUnEqIclTNtYM6L7FuTACxg
	 eNqEWO9zOs71veGWEMXtjr5GYi2wzipcx8a4uwTQ6QvsNBrgR7w2cSJgCAnQ0SpAr4
	 X79us8G0aEqecTa89WK6i2ETqGH1mv4jgpevQDvg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE131F80129;
	Mon, 20 Sep 2021 13:07:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF585F8025D; Mon, 20 Sep 2021 13:07:52 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41A45F80129
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 13:07:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41A45F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="giIS6sDg"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="NFpRM1F1"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 076615C0048;
 Mon, 20 Sep 2021 07:07:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 20 Sep 2021 07:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=1MCndy9cLnlMIcCifBnqzwJc/+
 Zfm3QLxX/qfshnxIM=; b=giIS6sDgRzSwSn+8t9vSyp8FA8blvOcarGEp41GDea
 XOLUI3hsP0s6mIRKJDlqB0f1Tt04RjEZ7UcHnQcT8p1HMTlzPKwnxUZCucXTZqj2
 ILAt+LOBBUrD1xTngkTnmClXReSKinylePKK9GXOC0kFDqOWkkW097bMcY9XzBIo
 XgvGqLzivMFGlZR860eDWb9r0AouLgeKKwCrPC/0uh6vbRKNW7aMwmjwW9Bx8Nbg
 k3XfB6ndPAlqaXvEEPI4wjSEKZoP8B+YLvE9sicfreSmunDdyAQCGibos6YR1Onj
 WvTAUbxpOxNP/+hd0QGwToIX63OzPmD5LMagxSBC9zWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1MCndy9cLnlMIcCif
 BnqzwJc/+Zfm3QLxX/qfshnxIM=; b=NFpRM1F1ztT+Hv6+pKC4XEP2TEkhPdpqN
 vBusmnHVP+qj2l9bb3cRZFspHcKxSeJRXDXnsPQM3BDKgyzCdedeVGpmZ0El0JGu
 CXiVQG+5qkPN86wZ6SCOY8x4tyCPwWwEGNaIxXNe50vjltgAFrGLH3yFgZjqD6j/
 nfxUSneRqfAhoHJyXXk1pV4QrRBOFRe/rLi1Sqalu3mqAbuuV3n8EkdhN1Tk2mcO
 ItU1n29AwV9KVJP/aOYycHvx94nOXfCwFnZnUeUZzpec5lM6tmcg9S5M9NH+jAFv
 HIt5chMAbQopMwLwoRfZdFk4OBC/6waP5cCDWM0FcT9fbSEnfJXAA==
X-ME-Sender: <xms:e2tIYVvDmFINcuJiFK2d_MRyk0XC2Lx8iuxgSyfl7ZZ4A1iXch1CUw>
 <xme:e2tIYecLabQswtpiWAoEUeRLX5qEy5QLRl2rTuJnNBqNl35czPzl-7-fkfnLGZ-0E
 xZGXP6cf_e2wwcBj70>
X-ME-Received: <xmr:e2tIYYzzv3OwSkch2C1p7gC-0CAUD2to6WsgJQI2fvVx37UdWwN2Fkx8j6CFPdxFbJrNtzGPxnHERfTyslyRG_wKRgFhZo5m09c-H0yrlw6InYwtcJ55>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecuvehluhhsthgvrhfu
 ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
 grmhhotggthhhirdhjph
X-ME-Proxy: <xmx:e2tIYcPmfe_Bww4c149BsVcW6oDPm6Mb1MZnP8VUBFgAnpAZE5W-Nw>
 <xmx:e2tIYV839ie9qBygWjakTWzEUgu90N9k40C65cFW1TNFbkny788zDg>
 <xmx:e2tIYcWJDyi_YJAFMo2ccN5TQZjjjXqietw9jgw9aqG5tGJxj4TpYA>
 <xmx:fGtIYXIxp9H9wO4Ldz6JEAjqXRTVDA5_7DDyCbsSLC0zHOJEgskEnA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Sep 2021 07:07:37 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH] ALSA: firewire-motu: fix truncated bytes in message
 tracepoints
Date: Mon, 20 Sep 2021 20:07:34 +0900
Message-Id: <20210920110734.27161-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.30.2
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

In MOTU protocol v2/v3, first two data chunks across 2nd and 3rd data
channels includes message bytes from device. The total size of message
is 48 bits per data block.

The 'data_block_message' tracepoints event produced by ALSA firewire-motu
driver exposes the sequence of messages to userspace in 64 bit storage,
however lower 32 bits are actually available since current implementation
truncates 16 bits in upper of the message as a result of bit shift
operation within 32 bit storage.

This commit fixes the bug by perform the bit shift in 64 bit storage.

Fixes: c6b0b9e65f09 ("ALSA: firewire-motu: add tracepoints for messages for unique protocol")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/amdtp-motu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 5388b85fb60e..a18c2c033e83 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -276,10 +276,11 @@ static void __maybe_unused copy_message(u64 *frames, __be32 *buffer,
 
 	/* This is just for v2/v3 protocol. */
 	for (i = 0; i < data_blocks; ++i) {
-		*frames = (be32_to_cpu(buffer[1]) << 16) |
-			  (be32_to_cpu(buffer[2]) >> 16);
+		*frames = be32_to_cpu(buffer[1]);
+		*frames <<= 16;
+		*frames |= be32_to_cpu(buffer[2]) >> 16;
+		++frames;
 		buffer += data_block_quadlets;
-		frames++;
 	}
 }
 
-- 
2.30.2

