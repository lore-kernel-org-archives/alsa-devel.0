Return-Path: <SRS0=sqcX=LR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31E8C4743C
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 08:03:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B36060FEE
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 08:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B36060FEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91AEE166F;
	Wed, 23 Jun 2021 10:02:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91AEE166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624435398;
	bh=g0vn32DNepJneY8Myao8mIp+iG8XcyVC59GzTXkvlpU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MDfi15+JP3cAif9ITWS8SexHM1xiZ+UVf1OHThDYGdC3gHNhLYZ7zsh/KXMciJKMz
	 fSFP1SbYx1/ek+chezbge3OYgVIcGaOQPAIQq2lDMp60f5roW7i4WOuosCngSWFS0h
	 FiV1CVM0nRDSJlKK5Qz/HpwMfwydMGGBPasL0OJE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3345F804FB;
	Wed, 23 Jun 2021 10:00:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D667F804E7; Wed, 23 Jun 2021 10:00:12 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5464BF801D5
 for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2021 10:00:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5464BF801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="KbIptk2c"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="vjddERoP"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 4A26210C8;
 Wed, 23 Jun 2021 03:59:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 23 Jun 2021 03:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=bgM+BBaiYgnlx
 KK+lDh3YhTF6GAJBpRYHulmrUHniZE=; b=KbIptk2cIjmQD4OZyL4JJCRTQBXX4
 YTPBD2dbjvR2mQ6m6qW/3nUlYE8bVb/oHn3+PVYMRUIHZump7nNs68s1/QjE7hzp
 4DK5Y2wRc7ZlgkdJXhx4VcKTt2VWwRHllAeD5mp3P0v5NByTvtUbzT/GroxhccSl
 QQHdJKfH3h4pGmcG79iBj8ylbSW/LojZ5jIFIvmJKKfcCyCDe/Yi6L64uO/PFf6S
 fpFyDxSkmoEDQpddSmZo5XT0oF68PMcJSHyiFsemfWoXrNKsmEuZ+tq/xQrfnz9K
 PdVhHIwps6B8yQ8L1eeHvuI7Wl/shnPxbRaMNJ3+axQaLDvr/VxgBh8mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=bgM+BBaiYgnlxKK+lDh3YhTF6GAJBpRYHulmrUHniZE=; b=vjddERoP
 O8/YEFufJCUiYFgUI4oJ2GSGNXUaR1vdwR+1lhEYXh/IkPjlEQHGYqj3B92WAX+S
 iv/ZAbHaynQdzeK+oY4Mcc06Y2VELnibeRUasGohwSQQoWC1X2exRQmhPMO0cvw9
 5Fiuk1hj1qYx7wJnF9/ExQsY1nGhlDp5aZkKw54dFIXPMbaNuihcTKCzGqc68h7U
 BffUizxEl9Bjarl46JTazgaWBhq3e9QibuUqEl+O6cUP8oRT/dl3EhUgnVWfinZD
 htz7bjldIX8v5D5INAT0Pz8ksV/BOXJpOA33Qbb7azPcjYRq0DflYFMQD69AIBKF
 bWR2ywx1Kx9UqQ==
X-ME-Sender: <xms:_enSYKb1ln46hIQsigG6BNVqU9sxC91mQLnkRf9T99Owjk3pawkZpQ>
 <xme:_enSYNbX9ze0Tg_YAcAnxbAzLKuZm3xRaMOwhK-O8chzYMjwTepRPsshICt0b95BV
 cjClrQ4j40-pbTLmR8>
X-ME-Received: <xmr:_enSYE-CGQXJ-u3b_xijuzz0o4FoRFMXFWJrM1v7zY8Nuxfr0Jl9wuhvBarN9mU2htnFR1BQiKdydH8AesShdWy82Qya-tbyxFbmbIUrSCdGPNZh4gvL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegvddguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
 vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
 hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:_enSYMrhpv61CXl5tQy33mvy2Ug1Qpc7T1KRsHJ0xOjFnGe_7_hQGw>
 <xmx:_enSYFpjZepZ2TCo8IYm87sndoVzZUbzuFIqDojM8DqlrVPMlfbVcQ>
 <xmx:_enSYKTFTAh0UCNUI90S1Xc-6HhAtxERKholo7_S9c1OljJkvNnN6g>
 <xmx:_enSYGCcSK0nVj8VTVAyaDwzYfc7CcDLk5z5IRltBIBJ8XcFNJh9Bw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jun 2021 03:59:56 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 5/9] ALSA: firewire-motu: code refactoring for packet format
 detection in v2 protocol
Date: Wed, 23 Jun 2021 16:59:37 +0900
Message-Id: <20210623075941.72562-6-o-takashi@sakamocchi.jp>
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

Current implementation of driver has several similar helper functions
for packet format detection in protocol version 2.

This commit merges them as code refactoring.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 79 +++++++-------------------
 1 file changed, 20 insertions(+), 59 deletions(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index 8865308c2c8e..93d5df1ae550 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -218,59 +218,9 @@ int snd_motu_protocol_v2_switch_fetching_mode(struct snd_motu *motu,
 	}
 }
 
-static int detect_packet_formats_828mk2(struct snd_motu *motu, u32 data)
-{
-	if (((data & V2_OPT_IN_IFACE_MASK) >> V2_OPT_IN_IFACE_SHIFT) ==
-	    V2_OPT_IFACE_MODE_ADAT) {
-		motu->tx_packet_formats.pcm_chunks[0] += 8;
-		motu->tx_packet_formats.pcm_chunks[1] += 4;
-	}
-
-	if (((data & V2_OPT_OUT_IFACE_MASK) >> V2_OPT_OUT_IFACE_SHIFT) ==
-	    V2_OPT_IFACE_MODE_ADAT) {
-		motu->rx_packet_formats.pcm_chunks[0] += 8;
-		motu->rx_packet_formats.pcm_chunks[1] += 4;
-	}
-
-	return 0;
-}
-
-static int detect_packet_formats_traveler(struct snd_motu *motu, u32 data)
-{
-	if (((data & V2_OPT_IN_IFACE_MASK) >> V2_OPT_IN_IFACE_SHIFT) ==
-	    V2_OPT_IFACE_MODE_ADAT) {
-		motu->tx_packet_formats.pcm_chunks[0] += 8;
-		motu->tx_packet_formats.pcm_chunks[1] += 4;
-	}
-
-	if (((data & V2_OPT_OUT_IFACE_MASK) >> V2_OPT_OUT_IFACE_SHIFT) ==
-	    V2_OPT_IFACE_MODE_ADAT) {
-		motu->rx_packet_formats.pcm_chunks[0] += 8;
-		motu->rx_packet_formats.pcm_chunks[1] += 4;
-	}
-
-	return 0;
-}
-
-static int detect_packet_formats_8pre(struct snd_motu *motu, u32 data)
-{
-	if (((data & V2_OPT_IN_IFACE_MASK) >> V2_OPT_IN_IFACE_SHIFT) ==
-	    V2_OPT_IFACE_MODE_ADAT) {
-		motu->tx_packet_formats.pcm_chunks[0] += 8;
-		motu->tx_packet_formats.pcm_chunks[1] += 8;
-	}
-
-	if (((data & V2_OPT_OUT_IFACE_MASK) >> V2_OPT_OUT_IFACE_SHIFT) ==
-	    V2_OPT_IFACE_MODE_ADAT) {
-		motu->rx_packet_formats.pcm_chunks[0] += 8;
-		motu->rx_packet_formats.pcm_chunks[1] += 8;
-	}
-
-	return 0;
-}
-
 int snd_motu_protocol_v2_cache_packet_formats(struct snd_motu *motu)
 {
+	bool has_two_opt_ifaces = (motu->spec == &snd_motu_spec_8pre);
 	__be32 reg;
 	u32 data;
 	int err;
@@ -294,14 +244,25 @@ int snd_motu_protocol_v2_cache_packet_formats(struct snd_motu *motu)
 	       motu->spec->rx_fixed_pcm_chunks,
 	       sizeof(motu->rx_packet_formats.pcm_chunks));
 
-	if (motu->spec == &snd_motu_spec_828mk2)
-		return detect_packet_formats_828mk2(motu, data);
-	else if (motu->spec == &snd_motu_spec_traveler)
-		return detect_packet_formats_traveler(motu, data);
-	else if (motu->spec == &snd_motu_spec_8pre)
-		return detect_packet_formats_8pre(motu, data);
-	else
-		return 0;
+	if (((data & V2_OPT_IN_IFACE_MASK) >> V2_OPT_IN_IFACE_SHIFT) == V2_OPT_IFACE_MODE_ADAT) {
+		motu->tx_packet_formats.pcm_chunks[0] += 8;
+
+		if (!has_two_opt_ifaces)
+			motu->tx_packet_formats.pcm_chunks[1] += 4;
+		else
+			motu->tx_packet_formats.pcm_chunks[1] += 8;
+	}
+
+	if (((data & V2_OPT_OUT_IFACE_MASK) >> V2_OPT_OUT_IFACE_SHIFT) == V2_OPT_IFACE_MODE_ADAT) {
+		motu->rx_packet_formats.pcm_chunks[0] += 8;
+
+		if (!has_two_opt_ifaces)
+			motu->rx_packet_formats.pcm_chunks[1] += 4;
+		else
+			motu->rx_packet_formats.pcm_chunks[1] += 8;
+	}
+
+	return 0;
 }
 
 const struct snd_motu_spec snd_motu_spec_828mk2 = {
-- 
2.30.2

