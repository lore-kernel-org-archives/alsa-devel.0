Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA04C48BCD
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 03:20:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918AA61418
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 03:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918AA61418
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 242DB1719;
	Thu, 10 Jun 2021 05:19:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 242DB1719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623295216;
	bh=l2Qtut3VbwZ6UM6Ttgeb7QGVD3my6oi3/TX10/O8b6o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HjfV/zGcpYfDOmHPKCLGmWgmNmE0LuaDs4+JeRf9D/7Zv+Y53b8u07F6lJlqf/pUE
	 /G9tgvLu5BXo0zlQVBOOF1X2+wvyebXivo8tzvPBPA6mBLq4ofE4hk33U4dy/7x7H8
	 40n2eT8JWcS1xT4ICC8/UIe2J9JbmRxJk0nUvnRk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EE8CF804D1;
	Thu, 10 Jun 2021 05:17:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 571B6F804C3; Thu, 10 Jun 2021 05:17:53 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8869AF80227
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 05:17:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8869AF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Gevctkqm"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="j7zYs+fx"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id C4BF95C012B;
 Wed,  9 Jun 2021 23:17:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 09 Jun 2021 23:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=oXvWhLbwOh/u0
 n7UxIKnxJd7w7AA/kV4i4aL6hsnj80=; b=GevctkqmhJodz+svBZ/6io+RYS9Ws
 nh1Zq5jl8GJg0rMbui3WfRuEyrWMrmn4bDoc8MUU5WMw2eYcKMNF2xMzD63bGAoh
 jg4VavZPp4q+JnMfwiFtu86+wuJS5MEsDjqjW/JizJ+wC56wmN7YYvYznCd4+IWd
 t0DqdtsPJW/sxf+peduijfpCOGBQiEUKi/8Ge8Gzjgx1oEWXyDNLfRtxT6N9klI1
 bXrjPCC3SBRxqMqJjV25zoxQMxChQ+y0nS3NpUec3HlbzFTn8q5+fisJ8DBwZIX7
 MI6Lbd1ez4oFGKJNwjr8UNpkIe3KbXVzXOotMj3ZaZqt364FLusxbKhjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=oXvWhLbwOh/u0n7UxIKnxJd7w7AA/kV4i4aL6hsnj80=; b=j7zYs+fx
 WnhGZ7O9fxJa3yVl8WOzALYylJn1PR40ZVazF/Vyfyh3/EWmARN1mgUH8Gzp4XxL
 4LJ/c4FlzzVl5GhqvYtk7+4nrMK07mxAiEpoVIlERkAA6ibkTYCut5uoL7s3XVBj
 pzD8gb9Gnw8bfjsn9ZfmbDvo4NG/00keohCV+1NGKDPskCfM8bYwLJbJJOQDflxf
 SMxR844809r4GfoWmQ991fTPvag/RKkfufaVIxw2iVjdabTFVllbiA3HO4EWj71o
 X3VQaThKNeDNBXj2WvMsVoHmPAb5+5Q5hwjy9TG6I2LAYXk0/DuCjBRMA3ivGp+y
 0jaIvTiiRVWCJw==
X-ME-Sender: <xms:VoTBYGSOaiS5l_pCW2CKNP9ASr62D2xfhkdZfFpTb33KOZoDjFidSQ>
 <xme:VoTBYLyUcoEsNIiCPDf6Xr3PdWxboY0PWBlYeKbHQqluETq2CyCueWtGKZ60fvmJs
 UHynv7KxsROlQZqx94>
X-ME-Received: <xmr:VoTBYD2UGiyOeIZoewd-KfNYpQ5uFq-ZI1mKggAXtilSejLZXJHKgbH8Q6tVr1UsRX_e1VQxuSXoWD3pii8u8B6bM61_2M5fd30y61MMKo3MkVr0FkZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduvddgieejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
 rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
 grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:VoTBYCBYn3t5yuMUmC__dQW2sjnYL0HZHdgzmfAoklIS5BdvxgddJQ>
 <xmx:VoTBYPgJyQWNQCKMnOZ9czOISSGyx-7w8C5JbtHe__c2PavPak2mdg>
 <xmx:VoTBYOqqFNeDHZG1sPuKEGM70QOPwk-6huZKAE0yGaZzU5-AwLatlQ>
 <xmx:VoTBYHZHPZ_0wgqQ0tuyc4eOu4y_wvBvmr1vW-KgJ1l9HMeWLylqNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 23:17:41 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v3 3/3] ALSA: firewire-lib: obsolete workqueue for period
 update
Date: Thu, 10 Jun 2021 12:17:33 +0900
Message-Id: <20210610031733.56297-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610031733.56297-1-o-takashi@sakamocchi.jp>
References: <20210610031733.56297-1-o-takashi@sakamocchi.jp>
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

The workqueue to notify PCM period elapse is not used anymore.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 15 ---------------
 sound/firewire/amdtp-stream.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 426a85b56cf1..1d9bc7b07df1 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -77,8 +77,6 @@
 // overrun. Actual device can skip more, then this module stops the packet streaming.
 #define IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES	5
 
-static void pcm_period_work(struct work_struct *work);
-
 /**
  * amdtp_stream_init - initialize an AMDTP stream structure
  * @s: the AMDTP stream to initialize
@@ -107,7 +105,6 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
 	mutex_init(&s->mutex);
-	INIT_WORK(&s->period_work, pcm_period_work);
 	s->packet_index = 0;
 
 	init_waitqueue_head(&s->ready_wait);
@@ -346,7 +343,6 @@ EXPORT_SYMBOL(amdtp_stream_get_max_payload);
  */
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 {
-	cancel_work_sync(&s->period_work);
 	s->pcm_buffer_pointer = 0;
 	s->pcm_period_pointer = 0;
 }
@@ -626,16 +622,6 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 	}
 }
 
-static void pcm_period_work(struct work_struct *work)
-{
-	struct amdtp_stream *s = container_of(work, struct amdtp_stream,
-					      period_work);
-	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
-
-	if (pcm)
-		snd_pcm_period_elapsed(pcm);
-}
-
 static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params,
 			bool sched_irq)
 {
@@ -1808,7 +1794,6 @@ static void amdtp_stream_stop(struct amdtp_stream *s)
 		return;
 	}
 
-	cancel_work_sync(&s->period_work);
 	fw_iso_context_stop(s->context);
 	fw_iso_context_destroy(s->context);
 	s->context = ERR_PTR(-1);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index b25592d5f6af..1f957c946c95 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -186,7 +186,6 @@ struct amdtp_stream {
 
 	/* For a PCM substream processing. */
 	struct snd_pcm_substream *pcm;
-	struct work_struct period_work;
 	snd_pcm_uframes_t pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 
-- 
2.27.0

