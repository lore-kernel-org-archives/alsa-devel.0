Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D112C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 08:58:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB9E613E9
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 08:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB9E613E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8375A1793;
	Fri, 14 May 2021 10:57:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8375A1793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620982681;
	bh=b6pXeH0crn3hVx4oKR9ugHFBMC1ZXD8r0ocr5zcUS0M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cYbE4j5eLT7TCTiB6l7BGlYD7EVrRJHX7wu1qlv3W1g4xvSTiGsrsrsv0JK+149qP
	 LnSPpMp+oxcXez81j7iaGRlxrfQxvuqCEDte02dIhocuzVoernqUzxML5s3D99u5Hm
	 nehuQIUPd7OP6RNSvUxhykPS/Ghv/X0/JUuNxSbA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72B11F804AC;
	Fri, 14 May 2021 10:54:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B25ACF80425; Fri, 14 May 2021 10:54:55 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 505CEF80272
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 10:54:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 505CEF80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="pq6tqyKJ"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="PnRkTF81"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id EEEC55C0170;
 Fri, 14 May 2021 04:54:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 14 May 2021 04:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=cp28RYTAs2knT
 qTMV7AbRmlPpvNei8UiGM3sSdQZRtQ=; b=pq6tqyKJzOyiQNQcP86jLljBDcptu
 AeRHz8pGWJ7yqXq4SRRHsWMzRGiSL+8+OD3j6UwrSUb2XPD0Qpe68G5E9bRaLKPJ
 S2ILyy86C+DLVAEWRws+bl8LzUEX8WzCgvKxKlqrDDTfTSbPa4iUKL962zPYWPkP
 inDAc7q1g17ng75XZEK248KW+PjmonR9mwJ5fSd3HOZBVxdLp8XifEyWE08bKZlf
 2EAkDAKo0PAMfzM+TLEeVuj2OkPoy0tlK+KSiuxwvHgHmT3bARqsVQBXjQGYQkMc
 BLZknCClAJHO4UjsDVnDR2hhrJFiqQhbr4+36Lwk9/9dv54SeK82dTnJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=cp28RYTAs2knTqTMV7AbRmlPpvNei8UiGM3sSdQZRtQ=; b=PnRkTF81
 VQvgLwwoqNCKY9QzbYCKA7Pe7ZCJkCv+f9QQA3NBK0oehDJY/R5KZRUbIxd+UvQY
 ox4QvMQaJ6yozVk3bpG5GwwBSOzfZbQO4msQnF2ZDt5ozX8YXm3mwiRSljiT7d3q
 ViKWNLzbC0iGusfPEwdHMACys9LKxlhsRSIhx5dUKqSJYam+ARQxpIZp/fgNE21t
 FKx2O43E0vzoLpsquNlG3+idmPrEv7RMCsohQZt1obZAczpJPwCuipT/PB4tfoTH
 3kAgesQwRm0/Poiyi4s34JSE7jx+t64HysE7Pdhjngx0r6a7MX5Dmo/aNI4D9sSn
 PDcA3RccTeDTBQ==
X-ME-Sender: <xms:1zqeYGIvY1xIn6esR-ssHaVZZltS9aLOuIANYP5Wp2Pv1nhh3171kg>
 <xme:1zqeYOJUG2WrUd6hJfxFzuZQ3yFY5xg6-bmasQ1oUnWIartgo9Dyk87Zv-VTvYkNh
 oI6fDzikgskgFknM9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedgudefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudeg
 rdefrdeihedrudejheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:1zqeYGuIns5rZKlJjaoMVcgePPQAxx_3xIhXJMG_-tOJhFdBymz_xw>
 <xmx:1zqeYLajlznHmQ20q5bLQgHqSVFC390vW_iZmaMxTEjn-XBrfYOFjA>
 <xmx:1zqeYNb8sb7OBugxsBVhcySMAL_MZeionSFtckdIBjm4cCnSNgp_OA>
 <xmx:1zqeYOAn7m0ajYIQBssUubPrVZBCQ1NuoMeJ8sjT0s5Becq2kh7zbA>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 14 May 2021 04:54:46 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 5/7] ALSA: oxfw: code refactoring for jumbo-payload quirk in
 OXFW970
Date: Fri, 14 May 2021 17:54:33 +0900
Message-Id: <20210514085435.92807-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210514085435.92807-1-o-takashi@sakamocchi.jp>
References: <20210514085435.92807-1-o-takashi@sakamocchi.jp>
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

This commit adds enumeration to describe quirks of OXFW ASICs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 20 +++++++-------------
 sound/firewire/oxfw/oxfw.c        |  3 +++
 sound/firewire/oxfw/oxfw.h        |  7 +++++++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 80c9dc13f1b5..33a7d0f308f1 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -153,12 +153,18 @@ static int init_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	struct cmp_connection *conn;
 	enum cmp_direction c_dir;
 	enum amdtp_stream_direction s_dir;
+	enum cip_flags flags = CIP_NONBLOCKING;
 	int err;
 
 	if (stream == &oxfw->tx_stream) {
 		conn = &oxfw->out_conn;
 		c_dir = CMP_OUTPUT;
 		s_dir = AMDTP_IN_STREAM;
+
+		if (oxfw->quirks & SND_OXFW_QUIRK_JUMBO_PAYLOAD)
+			flags |= CIP_JUMBO_PAYLOAD;
+		if (oxfw->wrong_dbs)
+			flags |= CIP_WRONG_DBS;
 	} else {
 		conn = &oxfw->in_conn;
 		c_dir = CMP_INPUT;
@@ -169,24 +175,12 @@ static int init_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	if (err < 0)
 		return err;
 
-	err = amdtp_am824_init(stream, oxfw->unit, s_dir, CIP_NONBLOCKING);
+	err = amdtp_am824_init(stream, oxfw->unit, s_dir, flags);
 	if (err < 0) {
 		cmp_connection_destroy(conn);
 		return err;
 	}
 
-	/*
-	 * OXFW starts to transmit packets with non-zero dbc.
-	 * OXFW postpone transferring packets till handling any asynchronous
-	 * packets. As a result, next isochronous packet includes more data
-	 * blocks than IEC 61883-6 defines.
-	 */
-	if (stream == &oxfw->tx_stream) {
-		oxfw->tx_stream.flags |= CIP_JUMBO_PAYLOAD;
-		if (oxfw->wrong_dbs)
-			oxfw->tx_stream.flags |= CIP_WRONG_DBS;
-	}
-
 	return 0;
 }
 
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 958f5100b794..8a0bb8229c66 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -86,6 +86,9 @@ static int name_card(struct snd_oxfw *oxfw)
 		goto end;
 	be32_to_cpus(&firmware);
 
+	if (firmware >> 20 == 0x970)
+		oxfw->quirks |= SND_OXFW_QUIRK_JUMBO_PAYLOAD;
+
 	/* to apply card definitions */
 	if (oxfw->entry->vendor_id == VENDOR_GRIFFIN ||
 	    oxfw->entry->vendor_id == VENDOR_LACIE) {
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index fa2d7f9e2dc3..9e1c12546ab5 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -32,6 +32,12 @@
 #include "../amdtp-am824.h"
 #include "../cmp.h"
 
+enum snd_oxfw_quirk {
+	// Postpone transferring packets during handling asynchronous transaction. As a result,
+	// next isochronous packet includes more events than one packet can include.
+	SND_OXFW_QUIRK_JUMBO_PAYLOAD = 0x01,
+};
+
 /* This is an arbitrary number for convinience. */
 #define	SND_OXFW_STREAM_FORMAT_ENTRIES	10
 struct snd_oxfw {
@@ -43,6 +49,7 @@ struct snd_oxfw {
 	bool registered;
 	struct delayed_work dwork;
 
+	enum snd_oxfw_quirk quirks;
 	bool wrong_dbs;
 	bool has_output;
 	bool has_input;
-- 
2.27.0

