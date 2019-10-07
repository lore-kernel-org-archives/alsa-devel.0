Return-Path: <SRS0=Jk6f=YA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ACEC352AA
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:06:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A108820867
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LMwea0+v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="h8+edoMw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJbRuEsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A108820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 233E785D;
	Mon,  7 Oct 2019 13:05:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 233E785D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570446396;
	bh=mM4DRl3EsLF+Avz5T2daGdo0vRIIa3Ln4Z4AHZaE5pg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LMwea0+vLjkxcFOl9BREHMD4bIW/F7iSUB9a2aCqbqWobdJbn6cxquESigN0Ew0R8
	 q9PEtzkv6IB+q9LYOR9tjJf6uHleYi/AhenTpaiR0O2crYdz9HcvYWjiwCvxQaXJFT
	 CELaLiHbtprZWMPjw4qoxuW0bok0e4sroVj6uDOw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F0FEF802BD;
	Mon,  7 Oct 2019 13:05:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2985DF80308; Mon,  7 Oct 2019 13:05:44 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DC54F802BD
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2019 13:05:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DC54F802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="h8+edoMw"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="SJbRuEsg"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 1FE8921CBA;
 Mon,  7 Oct 2019 07:05:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 07 Oct 2019 07:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=ddJW1QiqqQnhP
 vyTBrEKBZ/dWJnl0IWFQWDd+c7O9rw=; b=h8+edoMwPAdmDzhWCSV8nNv1NVwl5
 6yKiCmSviGaydlC/LWtpjmBi3tGl0T6gkhCEWIEWuVUpj++0ML0e3uszn2dgDoWH
 aUHhnp9vFPSfGRTzZ33rePE/GwbhRn/Wi+HlbrKfVwsspfTyrRJ8L332gOJoOFoc
 PsYuX5rwrDxtrg+AMIPomo6m/FPx8d/E4nBVmXqPQJPqtTIg8omm+h5CUrMIOMOm
 3qkl2oYj3CPF7l5KPGaU3uYx5HTkBpzCo/VGuUfc6M1f1l1Ks9AXimEFtHQCLgXK
 IcEJuQ10JQH8l086TiC+Dv3YjFjxY/a3nFgXF+T8nOvgsiYdk0YRdS68g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=ddJW1QiqqQnhPvyTBrEKBZ/dWJnl0IWFQWDd+c7O9rw=; b=SJbRuEsg
 +TzIj/2fOIzQz7auTqnunk3iKwGP33Fp9vgpknwqdfK3pnb/w/94kCKSy5SCFW1W
 U+6OoCT3oyhzN9UEbSQodFnbOlehCLIUHWTCJxsMd+fLk14E+9Igc69AvBSHXlYC
 c0GEFhVyqj5mkc+IJ3q1KNGmUBlgDy3sNZ0FUTJmiyhdyGzm+hP22R8Oi42naqaK
 5GClljL+JYbEZpbRjjI3p5Myywcf6fsCI0lQeQ3zQz3CM757fKNJqdnyi53wDiP9
 s88xbQ3iAHi8gQ4ThdYQPNiWBkQTzAyCtCM9FgU7yM6FEfba7fCnwEYMtelIOplK
 vdgZbLmLjD99Cw==
X-ME-Sender: <xms:ARybXZODBUqfakSoAec0jAfPRQuc5E9y0gw9OJjizxSPqta9q7U6Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheejgddvhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekudenuc
 frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
 rdhjphenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ARybXQVRZAYZc-PLxjkY7bwOwEvB4I8fFT4yy_EGnYcMJwYnp30NWw>
 <xmx:ARybXWI6yxLkwUWppUSRblQJTsvRnfhXY15rj3AZtMz4vFhfNjw1pA>
 <xmx:ARybXTp-3qvHRttUALC_H46IgQgQHol7MbXk2UHz3_krIXAGs8VyRA>
 <xmx:AhybXYlhVSFhj1QmipGpu6qkdYQrc8wd-0vDee4eS-tudzzHF7kPYw>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id A3C5B8005A;
 Mon,  7 Oct 2019 07:05:36 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Mon,  7 Oct 2019 20:05:16 +0900
Message-Id: <20191007110532.30270-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007110532.30270-1-o-takashi@sakamocchi.jp>
References: <20191007110532.30270-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 01/17] firewire-lib: add a member into AMDTP
	domain for events per period
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

In IEC 61883-6, it's called as 'event' what has presentation time
represented by timestamp in CIP header. Although the ratio of the number
of event against the number of data block is different depending on
event data type represented by the specific field in CIP header, it's
just one in the most cases supported by ALSA IEC 61883-1/6 engine.

In 1394 OHCI specification, applications can schedule hardware IRQ
by configuring descriptor with IRQ flag for packet against each
isochronous cycle. For future commit, I use the hardware IRQ for
isoc IT context to acknowledge the elapse of PCM period for both
playback/capture directions on AMDTP streams in the same domain.

This commit is a preparation for the above idea. This commit adds
a member into AMDTP domain structure to record the number of PCM frames.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c |  4 ++++
 sound/firewire/amdtp-stream.h | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index e50e28f77e74..838f695b20de 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1143,6 +1143,8 @@ int amdtp_domain_init(struct amdtp_domain *d)
 {
 	INIT_LIST_HEAD(&d->streams);
 
+	d->events_per_period = 0;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(amdtp_domain_init);
@@ -1221,5 +1223,7 @@ void amdtp_domain_stop(struct amdtp_domain *d)
 
 		amdtp_stream_stop(s);
 	}
+
+	d->events_per_period = 0;
 }
 EXPORT_SYMBOL_GPL(amdtp_domain_stop);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index bbbca964b9b4..d95a4ed15f20 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -272,6 +272,8 @@ static inline bool amdtp_stream_wait_callback(struct amdtp_stream *s,
 
 struct amdtp_domain {
 	struct list_head streams;
+
+	unsigned int events_per_period;
 };
 
 int amdtp_domain_init(struct amdtp_domain *d);
@@ -283,4 +285,12 @@ int amdtp_domain_add_stream(struct amdtp_domain *d, struct amdtp_stream *s,
 int amdtp_domain_start(struct amdtp_domain *d);
 void amdtp_domain_stop(struct amdtp_domain *d);
 
+static inline int amdtp_domain_set_events_per_period(struct amdtp_domain *d,
+						unsigned int events_per_period)
+{
+	d->events_per_period = events_per_period;
+
+	return 0;
+}
+
 #endif
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
