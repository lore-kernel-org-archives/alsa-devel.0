Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D5BCA9EC0
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:08:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26806208E3
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hvMUnIb9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="opYDE4ta";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KhFMx6Md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26806208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70CE922B2;
	Wed, 30 Oct 2019 09:07:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70CE922B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572422922;
	bh=MmX7Moxu2KmVAiuUVj/TBVJ+d/8YulZgiyrIm6WT6mg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hvMUnIb9eVLeUV5qQnmJIFr6u5p2bRBiUvp7QYaTAwEAeudpdIDLhhpOlrQ9gZNf6
	 5mxbeBFKxBbCNpPiYHF7AUqFwjN7K/IchLBKsIM/31MKXyLDZfbSONNWe+Lu+8aPKc
	 TuSou3Ue8WbP9hHGHC1JOVo/WKzITpmnQ8pyndHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB0E5F803D6;
	Wed, 30 Oct 2019 09:06:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5BD8F8044A; Wed, 30 Oct 2019 09:06:55 +0100 (CET)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54B41F802A1
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 09:06:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54B41F802A1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="opYDE4ta"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="KhFMx6Md"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 14E1221EAE;
 Wed, 30 Oct 2019 04:06:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 30 Oct 2019 04:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=DcXYelHo99VsW
 jxIstdjT3ymsXZIM6dBkeNTwKawQdI=; b=opYDE4taL9Kc4gU4QmuUJJ+tgdm9g
 S27UQzSrkXG1mNsD/Od8bBX2n0tgTInGmGbAfo89+u5cKqqWdMNNkae1X/wT+D3o
 U1uTtRgjSQqjJoqFggE/HNiShkf8bJXbwkL33/OlaeJECDzQPmuUA2CdWPjpGZ83
 hzZMdnc04E1NSXpA8yyH0ztNNhqR+DITFAQs5h8CNBBY4j4UB7kgZ1ZDZuZ/PFVo
 dluIdM3aCEoZBwE35plbupPV+xg4S8xUOP4BVdNIArHa3JGV3eoNGnqtBebL3eyE
 us4WP0IquAlGZMEFmyEJPcnjo3I3zsilcqvX+sT9qr/vEb83X1ZdKNjHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=DcXYelHo99VsWjxIstdjT3ymsXZIM6dBkeNTwKawQdI=; b=KhFMx6Md
 uJMc7fLduZKudmkTQFsL6hAN1rsy/l3YC7ul/jcCvaiCPx6h/FbgTtDFZJD09DNR
 8oGfGjcFn23zzqbwajA2C3sVxAbulXs60V2kKHKf1ZKSNc/o7rxNwA5sQgM/LQm1
 ZvEOoe3+u4Ch9fBFcjo97C/E3z0DAS/9+T7reyfqCWF5KH1m/xYxTafEGVwflMMw
 82OEcP1WXwqywcqcHHgSp1y1XhWXKDXi1FtM4dGramM5C1Phmca25JAnfAsB9VbZ
 76eIzDz8C+6QTK1YtUXTh5P5b1jk13T/kQSjBbHkdiL+cFQCNTV+tPibHx8RpPQz
 euLmATB55CtIgw==
X-ME-Sender: <xms:mUS5Xd0hcIKs3548Z053J8QRYdOH02GtCPyn761ztYOE-nYpVFKzkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddtvddguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekud
 enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
 hhhirdhjphenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:mkS5Xe9gTFJ5U4FsAhiMzMP5oQTDe3K4K3BuD2DUF6t_VcWSIfKiuQ>
 <xmx:mkS5Xe3f97W9ObfP0Wyp1nMiXYzSPHl8dmX13ln7whKIGLcmJ0xPdQ>
 <xmx:mkS5XR2kCx2R_Tt5DW_6eadZBI2ZbNq-AJDg6nRwfYizvkzgHbsHxg>
 <xmx:mkS5XQilHFmzc3B3ona9gowRwqYWQadio1ZuHOBKYb_8LiRR_oZg3g>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id D0DE13060060;
 Wed, 30 Oct 2019 04:06:48 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Wed, 30 Oct 2019 17:06:39 +0900
Message-Id: <20191030080644.1704-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030080644.1704-1-o-takashi@sakamocchi.jp>
References: <20191030080644.1704-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 1/6] ALSA: firewire-motu: fix wrong spelling
	for macro
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

Just replace 'SEPARETED' with 'SEPARATED' for macro.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 2 +-
 sound/firewire/motu/motu-protocol-v3.c | 2 +-
 sound/firewire/motu/motu.c             | 8 ++++----
 sound/firewire/motu/motu.h             | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index 9e2f16eebe0a..a42f77fc3858 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -191,7 +191,7 @@ static void calculate_fixed_part(struct snd_motu_packet_format *formats,
 			pcm_chunks[1] += 2;
 		}
 	} else {
-		if (flags & SND_MOTU_SPEC_RX_SEPARETED_MAIN) {
+		if (flags & SND_MOTU_SPEC_RX_SEPARATED_MAIN) {
 			pcm_chunks[0] += 2;
 			pcm_chunks[1] += 2;
 		}
diff --git a/sound/firewire/motu/motu-protocol-v3.c b/sound/firewire/motu/motu-protocol-v3.c
index 5eafa506e8a9..ba5794c724be 100644
--- a/sound/firewire/motu/motu-protocol-v3.c
+++ b/sound/firewire/motu/motu-protocol-v3.c
@@ -187,7 +187,7 @@ static void calculate_fixed_part(struct snd_motu_packet_format *formats,
 			pcm_chunks[1] += 2;
 		}
 	} else {
-		if (flags & SND_MOTU_SPEC_RX_SEPARETED_MAIN) {
+		if (flags & SND_MOTU_SPEC_RX_SEPARATED_MAIN) {
 			pcm_chunks[0] += 2;
 			pcm_chunks[1] += 2;
 		}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 72908b4de77c..680e363d0a4b 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -178,7 +178,7 @@ static const struct snd_motu_spec motu_828mk2 = {
 	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
 		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
 		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
-		 SND_MOTU_SPEC_RX_SEPARETED_MAIN |
+		 SND_MOTU_SPEC_RX_SEPARATED_MAIN |
 		 SND_MOTU_SPEC_HAS_OPT_IFACE_A |
 		 SND_MOTU_SPEC_RX_MIDI_2ND_Q |
 		 SND_MOTU_SPEC_TX_MIDI_2ND_Q,
@@ -224,7 +224,7 @@ static const struct snd_motu_spec motu_828mk3 = {
 		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
 		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
 		 SND_MOTU_SPEC_TX_REVERB_CHUNK |
-		 SND_MOTU_SPEC_RX_SEPARETED_MAIN |
+		 SND_MOTU_SPEC_RX_SEPARATED_MAIN |
 		 SND_MOTU_SPEC_HAS_OPT_IFACE_A |
 		 SND_MOTU_SPEC_HAS_OPT_IFACE_B |
 		 SND_MOTU_SPEC_RX_MIDI_3RD_Q |
@@ -240,7 +240,7 @@ static const struct snd_motu_spec motu_audio_express = {
 	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
 		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
 		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
-		 SND_MOTU_SPEC_RX_SEPARETED_MAIN |
+		 SND_MOTU_SPEC_RX_SEPARATED_MAIN |
 		 SND_MOTU_SPEC_RX_MIDI_2ND_Q |
 		 SND_MOTU_SPEC_TX_MIDI_3RD_Q,
 	.analog_in_ports = 2,
@@ -253,7 +253,7 @@ static const struct snd_motu_spec motu_4pre = {
 	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
 		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
 		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
-		 SND_MOTU_SPEC_RX_SEPARETED_MAIN,
+		 SND_MOTU_SPEC_RX_SEPARATED_MAIN,
 	.analog_in_ports = 2,
 	.analog_out_ports = 2,
 };
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 35ed8b6bb8e8..08e3d568221d 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -86,7 +86,7 @@ enum snd_motu_spec_flags {
 	SND_MOTU_SPEC_RX_MIDI_3RD_Q	= 0x0200,
 	SND_MOTU_SPEC_TX_MIDI_2ND_Q	= 0x0400,
 	SND_MOTU_SPEC_TX_MIDI_3RD_Q	= 0x0800,
-	SND_MOTU_SPEC_RX_SEPARETED_MAIN	= 0x1000,
+	SND_MOTU_SPEC_RX_SEPARATED_MAIN	= 0x1000,
 };
 
 #define SND_MOTU_CLOCK_RATE_COUNT	6
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
