Return-Path: <SRS0=0Rat=K2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE5C47092
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 02:53:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A789B61220
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 02:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A789B61220
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4519D1655;
	Mon, 31 May 2021 04:52:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4519D1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622429626;
	bh=HqdKuKQ9bJCxCIbGg0IzBaynzCnRLxkWq/ImixgHWMM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XyRCuSmoY0B/Jbx1nqC3yH9sxaNeAY0bpoTQaRYbWL92LsK4tj7dS6/k92u2axcTn
	 MVNUU6WtcV5eM/dkTrpW+pJhXksH5tKYFJDhiilMV/KCC3e6JHAqHoYC6SZAbVEtX2
	 1NC+ZUm4dp7g83u2D3y40IM20hkWZva14aQKve6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6694BF804BD;
	Mon, 31 May 2021 04:51:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C63FEF804BC; Mon, 31 May 2021 04:51:25 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F63EF80277
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 04:51:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F63EF80277
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="pfRKEmhF"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="pTvUtFI0"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 471315C00B2;
 Sun, 30 May 2021 22:51:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 30 May 2021 22:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=/BYYuZgvjT58c
 P5lDLIIyC/6U9/ZgrnTFZk3eIp5oH0=; b=pfRKEmhFkfoY0Au4Is4IGRAImeWSl
 JOEK/Vl9wAH3bhGXAdNOKWGZ4oaluVU8MqqWxuaU98cFmUKcDevPUJNFVoRG+ypC
 +B5cHlLGtqJy4OQXPXoFSJD6isul3Mu+I+wMx4TVFjB+jbkXLYTfxeJNGnh/qCD/
 PMuNur9XvoKPVE2don/xu7jdj2+5JNiREgL2XbLPDminQjq8/zqA9ua5VvW2HdXj
 4iByclzzdAP9oShh/GKZr3G9pVfZOAA1SazCZMLZBow0UDKOsa5vDjb9aHV5/K2j
 1segDbqFOUR/vxd8QeOcShuKlk6Tm0zodybiP8G26ohKo6ewoojClz06g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=/BYYuZgvjT58cP5lDLIIyC/6U9/ZgrnTFZk3eIp5oH0=; b=pTvUtFI0
 gM1mqEUbEIWTEpMJQRD4DkpMuV4U5oNKay7E8A59xC5TX1oOOxVQa3OnWAXCR/9N
 WvrJoeWgxTuiuW0sudaeVDodZfIjJ2xDm9JyK+KYpwweYlzbnOAXkocv5v9cdifH
 nJP1/szak8cWlBDQN7AmD4APMCKfOLA7SQAaAT4H7NPZbcfcauQ0EJOQkuTMPa/w
 OQzXaodjj0r4irgENb9ZuQ7evTKWFganHKcfHavhXh3YgdTRLCQbOcIK2SuJidVT
 w1t3wb0gleoAbhkSd6tHrCDVe00WjUW0gmetJ3Zz6MyJjFzqER/7+YdGAD55yOVF
 3+uGkQLmu+n9vg==
X-ME-Sender: <xms:JE-0YBDPxeNVjcAMK-h59lCU6FILeWcoPd-FjCiEA_kSa3yCfCyGmQ>
 <xme:JE-0YPil971nJZ4f71jul6KFj0NkdbecPGCxDld9Q3rwG8vrzaSKBYSCDghSXN8Kp
 9NJzuCfEn8jFgzpC2U>
X-ME-Received: <xmr:JE-0YMnSjmnTtnw6DElHDw9h-lwtwsp_kQIhPEsIeBuLshemUpPKEy71vwEy3iJerE50Z6Ny9oTFpcOz5oRpasQrv_oiPCOng4e-aJVIPn-FXpfZAFYR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelvddgieefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
 rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
 grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:JE-0YLzBXyfLMEgtmHnAX7grQPVFhyU0fPqXb8zM3Ny-hedaGGCTKw>
 <xmx:JE-0YGQpaKnvrelBaPiXVsoKU3IuZ_Es6eqWpb6_Co-luDHy4fpDEA>
 <xmx:JE-0YOYToBcsiOQbXasi3WATklw3aFMrWhGZMWeu2wprRjYukGHx4g>
 <xmx:JE-0YJLILmx-2K1VMDD-f4AkXZYBKbfc6d0T8XEGCXXxUwtHzdtcqA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 May 2021 22:51:15 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 6/6] ALSA: fireface: perform sequence replay for media clock
 recovery
Date: Mon, 31 May 2021 11:51:03 +0900
Message-Id: <20210531025103.17880-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210531025103.17880-1-o-takashi@sakamocchi.jp>
References: <20210531025103.17880-1-o-takashi@sakamocchi.jp>
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

This commit takes ALSA fireface driver to perform sequence replay for
media clock recovery.

The protocol specific to RME Fireface series is not compliant to
IEC 61883-1/6 since it has no CIP header, therefore presentation time
is not used for media clock recovery. The sequence of the number of data
blocks per packet is important.

I note that the device skips an isochronous cycle corresponding to an
empty packet or a NODATA packet in blocking transmission method of
IEC 61883-1/6. For sequence replay, the cycle is handled as receiving an
empty packet. Furthermore, it doesn't start packet transmission till
receiving any packet.

The sequence replay is tested with below models:

* Fireface 400
* Fireface 800
* Fireface 802

I note that it is better to initialize Fireface 400 in advance by
initialization transaction implemented in snd-fireface-ctl-service of
snd-firewire-ctl-services project. You can see whether initialized or
not by HOST LED on the device. Unless, the device often stops packet
transmission even if session starts.

I guess the sequence replay also works well with below models:

* Fireface UFX
* Fireface UCX

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/amdtp-ff.c  | 2 +-
 sound/firewire/fireface/ff-stream.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/fireface/amdtp-ff.c b/sound/firewire/fireface/amdtp-ff.c
index 119c0076b17a..98177b0666d3 100644
--- a/sound/firewire/fireface/amdtp-ff.c
+++ b/sound/firewire/fireface/amdtp-ff.c
@@ -168,6 +168,6 @@ int amdtp_ff_init(struct amdtp_stream *s, struct fw_unit *unit,
 	else
 		process_ctx_payloads = process_it_ctx_payloads;
 
-	return amdtp_stream_init(s, unit, dir, CIP_NO_HEADER, 0,
+	return amdtp_stream_init(s, unit, dir, CIP_BLOCKING | CIP_UNAWARE_SYT | CIP_NO_HEADER, 0,
 				 process_ctx_payloads, sizeof(struct amdtp_ff));
 }
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index 97c356f2ac04..95bf405adb3d 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -199,7 +199,11 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 		if (err < 0)
 			goto error;
 
-		err = amdtp_domain_start(&ff->domain, 0, false, false);
+		// NOTE: The device doesn't transfer packets unless receiving any packet. The
+		// sequence of tx packets includes cycle skip corresponding to empty packet or
+		// NODATA packet in IEC 61883-1/6. The sequence of the number of data blocks per
+		// packet is important for media clock recovery.
+		err = amdtp_domain_start(&ff->domain, 0, true, true);
 		if (err < 0)
 			goto error;
 
-- 
2.27.0

