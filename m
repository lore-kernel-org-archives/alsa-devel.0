Return-Path: <SRS0=sqcX=LR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AD0C48BC2
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 08:02:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8350960FEE
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 08:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8350960FEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECE6284C;
	Wed, 23 Jun 2021 10:01:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECE6284C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624435348;
	bh=fTNoj04QocHKi0X/ecxZkr/pxUXCA/JghnKdQKDrGQg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K7B7+PquCGjSNuguVHb0zbopAl0d2zC0ef+Wtfr8Q3xsukih+mKmWngWpo25ecyc5
	 CYdytRlWn3yGeZTizdjD/jcsxDM1/jRRVDlmY+as8bdQmaySkB5tXWw2KmD/ZyudRn
	 8z3eK5v1rjBChDqH4zFeSbIG2Tx9gx6+OGGnEeew=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDD69F804E2;
	Wed, 23 Jun 2021 10:00:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50F1FF804E6; Wed, 23 Jun 2021 10:00:10 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5CAFF8016D
 for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2021 09:59:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5CAFF8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="SM09ARAd"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="kSfQu7R4"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 2AAA01036;
 Wed, 23 Jun 2021 03:59:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 23 Jun 2021 03:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=/u8S7v2lJsCJn
 jwdwaF5QhfIFE0IS24rwXHQsyo8i+w=; b=SM09ARAdUKA+pYXxVyvFmRIeHy9Qk
 0UobFqkcziGsURAAfiYQE+K07Zqqet2veC2WdjqQogj0uGPwhhZx349TjzQiA/oK
 NrCwVwhqJheiZJ8sNXLhCh6Ry792fcLcbIsMF5teoyhCW0UMIk2K9+nY0TuAMpLe
 R2Cf9Ew2HdBD9flEVhqRonzMd+aWuiPuI5dTKZrSxbAVOanwp/AKLDS5l8XQlCZk
 rZ7Ed88GvT2bqIMUUO+AG+nRkYEtQnrv5JxlrqkW3xsa+rLnOKxsVRlRjFV+6ghl
 aAB+qAtV4px4TlnmmD7J7L5acUEtwNJqQ9kDZWxtajQOACeh7J+k4d8ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=/u8S7v2lJsCJnjwdwaF5QhfIFE0IS24rwXHQsyo8i+w=; b=kSfQu7R4
 2X/c9CPrvHZLGrK+hSndSSzXfwCeZkJb53U4rLHaEo2b3DEWmQ7fK+EaluJXGLLf
 oS3VSBTIc2Rt/bwF14e7Vd+SC8k6Ww+xWy/AD3+WDj7CJHYUTta+xj03fxd3z/Fb
 WSW6QiswardK62ZBeJhCnApLxQAkTlAVXgfMJiqdOLV7aWSFAmLPvcf4HbOIh6JJ
 mVLIeDCz5HIPc06try1fFwspxnR3O9cSJSZZ8OVDaY1oXv7GHXnw0AxPJkjIm34O
 d9osxuCwXvUwGWXTPZj031s0xCea6hKf/jJsl1fYpoeBDGnbZfwELffAedOQeZJl
 7UyaJeF2oJ5TZw==
X-ME-Sender: <xms:--nSYBjZSxFmWLyACkIubxVfngJN2b4wL2GgWph3G37IUzB7kQFJaw>
 <xme:--nSYGAbbbx1vmNx4SGS4kqGXbXjQUylodQHHw6VC0WBA9vUBnEOUMdJrb1u8VYPU
 EqNKqg1uBbts52CYiE>
X-ME-Received: <xmr:--nSYBFA7bTUmG-A05gft6x03gbFm7jBT-vGwKZDLF0bY_s9MvZw6DQsdgKEele48r32bdev3xzMn0WM4UJRTJttTDFrDIlfR5i2yNCYIXoNGfrChn6e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegvddguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
 vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
 hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:--nSYGT5IkPXjx-Rnk5ZwSaDRbUw3CgVNJ16_yHLOOam7c6VKpu43Q>
 <xmx:--nSYOzLZ97KNtVc-d3Zcb_QxXe2gtScfrwvoW7tDwKh19MqSmk1hA>
 <xmx:--nSYM533hnFqXqkjVejxWYS5kzSwKyxSNGYUolkyQOeRlVIOwGDgA>
 <xmx:--nSYDpNMqN5h_PTikpbVEFJ1i8h7wY88iT8QDLccP362miyNO0juw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jun 2021 03:59:54 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 4/9] ALSA: firewire-motu: use macro instead of magic number
 for clock source in v2 protocol
Date: Wed, 23 Jun 2021 16:59:36 +0900
Message-Id: <20210623075941.72562-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623075941.72562-1-o-takashi@sakamocchi.jp>
References: <20210623075941.72562-1-o-takashi@sakamocchi.jp>
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

This commit adds a series of macro for source of sampling clock in
version 2 protocol.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index 7893cc73e983..8865308c2c8e 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -12,6 +12,13 @@
 #define  V2_CLOCK_RATE_SHIFT			3
 #define  V2_CLOCK_SRC_MASK			0x00000007
 #define  V2_CLOCK_SRC_SHIFT			0
+#define   V2_CLOCK_SRC_AESEBU_ON_XLR		0x07
+#define   V2_CLOCK_SRC_ADAT_ON_DSUB		0x05
+#define   V2_CLOCK_SRC_WORD_ON_BNC		0x04
+#define   V2_CLOCK_SRC_SPH			0x03
+#define   V2_CLOCK_SRC_SPDIF			0x02	// on either coaxial or optical
+#define   V2_CLOCK_SRC_ADAT_ON_OPT		0x01
+#define   V2_CLOCK_SRC_INTERNAL			0x00
 #define  V2_CLOCK_FETCH_ENABLE			0x02000000
 #define  V2_CLOCK_MODEL_SPECIFIC		0x04000000
 
@@ -82,13 +89,13 @@ static int get_clock_source(struct snd_motu *motu, u32 data,
 			    enum snd_motu_clock_source *src)
 {
 	switch (data & V2_CLOCK_SRC_MASK) {
-	case 0:
+	case V2_CLOCK_SRC_INTERNAL:
 		*src = SND_MOTU_CLOCK_SOURCE_INTERNAL;
 		break;
-	case 1:
+	case V2_CLOCK_SRC_ADAT_ON_OPT:
 		*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT;
 		break;
-	case 2:
+	case V2_CLOCK_SRC_SPDIF:
 	{
 		bool support_iec60958_on_opt = (motu->spec == &snd_motu_spec_828mk2 ||
 						motu->spec == &snd_motu_spec_traveler);
@@ -112,16 +119,16 @@ static int get_clock_source(struct snd_motu *motu, u32 data,
 		}
 		break;
 	}
-	case 3:
+	case V2_CLOCK_SRC_SPH:
 		*src = SND_MOTU_CLOCK_SOURCE_SPH;
 		break;
-	case 4:
+	case V2_CLOCK_SRC_WORD_ON_BNC:
 		*src = SND_MOTU_CLOCK_SOURCE_WORD_ON_BNC;
 		break;
-	case 5:
+	case V2_CLOCK_SRC_ADAT_ON_DSUB:
 		*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_DSUB;
 		break;
-	case 7:
+	case V2_CLOCK_SRC_AESEBU_ON_XLR:
 		*src = SND_MOTU_CLOCK_SOURCE_AESEBU_ON_XLR;
 		break;
 	default:
-- 
2.30.2

