Return-Path: <SRS0=qOpI=3C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D6DC33CA8
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:49:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F382020678
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sSg7RnQ+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="zFLRPveE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNVhJpr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F382020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 417271668;
	Mon, 13 Jan 2020 09:48:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 417271668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578905362;
	bh=uBclgG+mWUlWHp6tsEwqt21+Fke2yV+exfc1jv4oKyM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sSg7RnQ+7OUjml6DgNPA2izsGAv1ptXtn46nFaFofH81T8pY4okDjhJBBaHxbA3F3
	 cR76qS2LHZ9ohLmCn+hCX2vo3O935kYaVmEvLHnUrc7FLJ8RMNdUvtuv1o6zXG6EVZ
	 OYP49dDM4XT+TcUQNk/II7+QLqn/2kHD54qshGNU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 320F9F80274;
	Mon, 13 Jan 2020 09:46:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D339F80227; Mon, 13 Jan 2020 09:46:43 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A8D3F8014B
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2020 09:46:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A8D3F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="zFLRPveE"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="ZNVhJpr0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id EC3A322015;
 Mon, 13 Jan 2020 03:46:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Mon, 13 Jan 2020 03:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=v8OgXzbeCcKFo
 FG1ZVh0kIlliEtxH3Bv3UMR5RkbquI=; b=zFLRPveEtmbhkYS753LP7IsnsPjTt
 R1ohg3CfMigH3lQVZ2ck3WLPUF2hYuQwUilf571BcNKO8N9LZwjiF4ihO0iCrH/x
 U0cxcy89reYl4jjp32HIe/3Irt+VKCgaQs1u1M45eAv5az6JkKfcFe2wizgdy8ZC
 Mcg3yWlNF4Ku1Tvs+Wo2wwzDeLm7usAAaevyh4ser2Z+ZtoigMeXvDie91Lc9QIm
 L/Hmd4tCwdaoqNlK2R/viZJM3Bjf3cR/THM/yGBP7wcI0ffygefUyQxX2fjP2mXE
 +hxnACVyGlGZ0oXgbJ94yIm2AM6VpABLpJOcXfWJn5IJadbUMCunpkQ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=v8OgXzbeCcKFoFG1ZVh0kIlliEtxH3Bv3UMR5RkbquI=; b=ZNVhJpr0
 +c45y7+xO0TIWCUS73P+d5PIBpRZXMqdV9TSCQCE08OZftm5rd/ebTl70LuHc+kD
 e5uRmP2dnkvyePiJyFraHn9TZRdve6IO7HdESbqpaVOvNWsGHFOKsGf1Gtp0Cyfn
 aoZWxuG/93g67vtGxp6eoGCgpf2tZu1Y+bkb3rrDIbAcP+AK/InYqIDXtSVW4PWK
 K9RzySrDFI93BCiDyK5CbuiaBC73C8GyhWJibEmlr39sto+ZvM3LuYbF1n0I8ZBw
 XoqPQtZqjFZyDf2kUp5BqsgGRtMViOhdj3aEm4g5GVJSpOun9A3ByUUFUXnIQqN1
 pMJeSHVebzSnKw==
X-ME-Sender: <xms:bC4cXoLMuCO499s_o3pebWZ4b1957SjydBdEttui2u35VAQrMWt7XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledguddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekud
 enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
 hhhirdhjphenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:bC4cXvhVTI-ZGxTGnmAripWjEhcQDYb0WYtsdrWzNUt9lGhFWvKNNQ>
 <xmx:bC4cXuRuK-gAYcUR8Q25vnRIsCqGSq5qkVJUxtmLD0w991B389bWgA>
 <xmx:bC4cXhXrkr2fQKOFHfmQ7JXR19Kr5E-NGL7ueiT1cy8xo1G3DkHqOg>
 <xmx:bC4cXlEwX_igAA6zOubxkpYhkMWy25GLXocGwyr_11s7HQgWUFPjlg>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0219430607B4;
 Mon, 13 Jan 2020 03:46:35 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Date: Mon, 13 Jan 2020 17:46:29 +0900
Message-Id: <20200113084630.14305-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113084630.14305-1-o-takashi@sakamocchi.jp>
References: <20200113084630.14305-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 2/3] dice: loosen stream format check for MIDI
	conformant data channel
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

ALSA dice driver expects devices to multiplex MIDI messages into first
port of isochronous communication. Actually devices perform for it.
However, check of stream format is invalid for second port of isochronous
communication. As a result, when the device supports two ports for
isochronous communication and the stream format is hard-coded, ALSA
dice driver fails to start packet streaming.

This commit loosens stream format check for MIDI conformant data channel.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 6a3d60913e10..8e0c0380b4c4 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -224,7 +224,6 @@ static int keep_dual_resources(struct snd_dice *dice, unsigned int rate,
 		struct amdtp_stream *stream;
 		struct fw_iso_resources *resources;
 		unsigned int pcm_cache;
-		unsigned int midi_cache;
 		unsigned int pcm_chs;
 		unsigned int midi_ports;
 
@@ -233,7 +232,6 @@ static int keep_dual_resources(struct snd_dice *dice, unsigned int rate,
 			resources = &dice->tx_resources[i];
 
 			pcm_cache = dice->tx_pcm_chs[i][mode];
-			midi_cache = dice->tx_midi_ports[i];
 			err = snd_dice_transaction_read_tx(dice,
 					params->size * i + TX_NUMBER_AUDIO,
 					reg, sizeof(reg));
@@ -242,7 +240,6 @@ static int keep_dual_resources(struct snd_dice *dice, unsigned int rate,
 			resources = &dice->rx_resources[i];
 
 			pcm_cache = dice->rx_pcm_chs[i][mode];
-			midi_cache = dice->rx_midi_ports[i];
 			err = snd_dice_transaction_read_rx(dice,
 					params->size * i + RX_NUMBER_AUDIO,
 					reg, sizeof(reg));
@@ -253,10 +250,10 @@ static int keep_dual_resources(struct snd_dice *dice, unsigned int rate,
 		midi_ports = be32_to_cpu(reg[1]);
 
 		// These are important for developer of this driver.
-		if (pcm_chs != pcm_cache || midi_ports != midi_cache) {
+		if (pcm_chs != pcm_cache) {
 			dev_info(&dice->unit->device,
-				 "cache mismatch: pcm: %u:%u, midi: %u:%u\n",
-				 pcm_chs, pcm_cache, midi_ports, midi_cache);
+				 "cache mismatch: pcm: %u:%u, midi: %u\n",
+				 pcm_chs, pcm_cache, midi_ports);
 			return -EPROTO;
 		}
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
