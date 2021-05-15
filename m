Return-Path: <SRS0=bp7U=KK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F6C433ED
	for <alsa-devel@archiver.kernel.org>; Sat, 15 May 2021 07:15:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5547C613BE
	for <alsa-devel@archiver.kernel.org>; Sat, 15 May 2021 07:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5547C613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E09301752;
	Sat, 15 May 2021 09:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E09301752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621062906;
	bh=cGsgxVx4SICSYxecUuvLpb+mOSsx2bdT6MHDJf7pUtc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3vIkDSYzlKTi3egSqM99jbLvGP+lkAOsG/xmh36+P2gGncHEyydgsMNUPxZupYYM
	 QKLZXV9jiwSyY5y/7wqIIdEEhqIk6nUUeqw4cZ6a7QyMZfrnwbrqiP4ywurbFU41y1
	 LlDWBJtz+HxHKKLyBdAsBHj1bIkEmlfTUSx0KkXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B646EF804DA;
	Sat, 15 May 2021 09:11:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3B9FF804AD; Sat, 15 May 2021 09:11:34 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99D14F8042F
 for <alsa-devel@alsa-project.org>; Sat, 15 May 2021 09:11:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99D14F8042F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="hK610DsY"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="fU2fGrqP"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id BE9CF5C0124;
 Sat, 15 May 2021 03:11:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sat, 15 May 2021 03:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=I+LIoBqZzVhv5
 sXd5JVVXBsMPxBDTdXu/mIjbP9tQhM=; b=hK610DsYPQ/5zz/xDWHKFEGXsqsTg
 FIxhjEFsMbVYeUVgeo312xzG/3JGkhukqE/+7iWpIMt3zHTrv8RDvONDVQiKoWX0
 0xBH2UqvHiVUI8jOZCDXQkuExUpRibZQoJBimmR/Oh5S/k3LhQ0vJ+c8S38PPJXk
 35HUC/Fdae9GomqT7yZJTjjT6kr6CYMYCMhOwCVzi9RpHTMYtRV2nejrm0chpQRT
 BzK1fPQ3gZQPZHnB6n/P0+PpzSKSzvnMNZdCnlg2NuTtNUH1xVolBatli5JLf3sg
 5ktL5L/ibnzoxaTax/tKFuy6lZVn7wc/PnXKrsjj9kD8jGBFcFm6uPK+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=I+LIoBqZzVhv5sXd5JVVXBsMPxBDTdXu/mIjbP9tQhM=; b=fU2fGrqP
 fsREPbrvhuZ3z+DFLbQUPOT7S8x96WsiIkD4Zxlfkud5zJ2QOw0pHvtvYpqLvCh0
 sLhoHWpFIyBV3z70IDtSFusg6yd1qX2m71bHYsShhX8WKtaLqhoX6B8Fa+mz6jAb
 1sz1AKI1Nlh4qNcAn++wy3WXgl5z2tGqGtTqE9upvAKdCHAPSls3f7xH/Uzo22ua
 jk5wf2UcngfX1CjtSNZFXUIbrqYzeTcMMFBSDsN8fEq85n3zgTmmn13s6liJKOAG
 gqL2DMoqiwyBV6g9CxGvArEr/joYKgMQgaHRPmtvrvsSrpe+5lrb74KNT/6L7MrQ
 8J3UO1PDm0xcEw==
X-ME-Sender: <xms:HnSfYOV7FkRyVu2RP5a-j23pmen8AlQ_6tQq8SAvLfm3KGFWoGyzHA>
 <xme:HnSfYKma9EUeLZ9mpt2GQXGeZoA03WFIQIku7Fq42Gsr3P-8kvlkmkj0V1Kkwrhgo
 aJyTf6ZW9VPIGH2oh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehledguddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:HnSfYCYIRqWbX45OL0ANHbcfOo7WEoSj9waqBENv6_Dh4p0fN8xZvA>
 <xmx:HnSfYFUIDwbgUUDLyV8kT94Q3PSBZu8IplQ_guxDNLTW4i4L2Eu7tA>
 <xmx:HnSfYImugrZFOqTf67BpFBqdBNZqoP1Nvx76quZXQzQMRSbEtsqBew>
 <xmx:HnSfYPvD4byl9VuIxwz36Wq2f-m9jIcAiXmXIZBFqA4m37IJ5bLYKQ>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Sat, 15 May 2021 03:11:25 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v2 07/10] ALSA: oxfw: code refactoring for jumbo-payload quirk
 in OXFW970
Date: Sat, 15 May 2021 16:11:09 +0900
Message-Id: <20210515071112.101535-8-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210515071112.101535-1-o-takashi@sakamocchi.jp>
References: <20210515071112.101535-1-o-takashi@sakamocchi.jp>
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
index 9a9c84bc811a..90a66e1312fe 100644
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

