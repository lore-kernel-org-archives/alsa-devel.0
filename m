Return-Path: <SRS0=HRrq=LM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B469C48BDF
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 04:06:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A374E613B9
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 04:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A374E613B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E8EF16F6;
	Fri, 18 Jun 2021 06:05:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E8EF16F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623989158;
	bh=WjeuMdOxD1tFRIc7RVsh34+0WXc8jXfKkJqEW0RlGTU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RJhODS7+wObPhNGMg6j2gpd633NrYwM5hJR/R3MFmDIJFmHkxWv/13z1+U2ZtLvmB
	 BgnxgWOVA9EEyU2lqwyIqVEhFAH9GAVt2vc7YSRNs6ygHto7P+PYnTg0KnaGSxVoah
	 y8a3DVVA6JURfII9tdTnv5YVUmU1fTkybH4kN9hA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 069CCF802E8;
	Fri, 18 Jun 2021 06:05:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD7C5F8032D; Fri, 18 Jun 2021 06:05:06 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CA29F80084
 for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2021 06:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CA29F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="wRObDCK4"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Jc4gSKE0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 2BF685C0164;
 Fri, 18 Jun 2021 00:04:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 18 Jun 2021 00:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=xJDE0vGMmQognTkuv3PR5iAnF9
 qfNxOnot9Cue/GBi8=; b=wRObDCK4ruc8ZL+mUE2ZzgapYVdF9e3jsjhelM+K6M
 jppkIgmLSPCBKdgUHzm9Kcd5/mkXbNViPnLf9wZqwaiefQjT4owZUiksQe40cNrw
 XK0MRd7TByO46MjL9TLgPVhTWTg9hUovo4DULOlcHymCElPSzdaFQgZnt6NHGWN+
 sBMYMGCsXJ5SrUJveG6HSEQuFJp/YmahsPf37DC2gLBCSkWFdhPJoFsclOglxVb2
 YBpBnPeEMqYNjYji9Gom2p20XayJKiJ75daIZRNFW0QEFGzSoYaWzbJGKfCBjPOI
 +auslsJFlPyxQO1iDj+3SubGc+PQVfQt0Z6fZvIYQCGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xJDE0vGMmQognTkuv
 3PR5iAnF9qfNxOnot9Cue/GBi8=; b=Jc4gSKE0br8Y2mzlx71IKBrJdFAhExupx
 ROdh/RTwK/fh8THzerPN6oYA00SwdS64KKINB40+H07iNwXf5oMO62Lzdx+EBjjs
 1njE0gdL0/GyCeRjey1bSmVmAyNzgAaeImAX1SkG06/MUD7dWtowPmGgikX7A5/0
 X08KgyQyV2ysC9xfotP+3hLk5wxuniOz/QLO2yHiV3aXfxCGBdzW1RtHT4dX87DE
 /fE+wW6gTxXpbSf+jlCj4SLGSlxw/Q0jTuf42JJhRtmf3DprqqVMXJXlo+9h6BL8
 njFiAb/UhVyQgBy3HjaFs3syqWF+tkiIJrGlSb0/GfXYVn0k7WKJg==
X-ME-Sender: <xms:ZBvMYIuJZCIjxnJ-46nu1bDuc3xFX81vQPBXS3gLlY9vxLiYTXGzBw>
 <xme:ZBvMYFeOe5bcaTVDKdDj_T5vGop0nMXuSshJZrK7M_ROu_-M2hkK4U6fvVOfospjF
 xKixLMCTjf4nNG0edM>
X-ME-Received: <xmr:ZBvMYDwdErYVSV_2IOUHLGweedAK00KxoixpK43coTE2VFO1neqCiCh8UKlZOx9Ib1iD3Y19UD1UiXjHhKe3Uo0U1urTu8-otDhfpQmnZ7VRZSvpKUhW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefvddgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecuvehluhhsthgvrhfu
 ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
 grmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ZBvMYLPGLQz_bIAvUNQfOZ2ErCoTcgnPvA6T9nsnsd8E7g35W960zw>
 <xmx:ZBvMYI8wSvMNXz-yL2yb5h1dyrDBf0F8mezaDxUQLwo6hDBA4c-_1w>
 <xmx:ZBvMYDXD8YTw7WO3t4HyUnN3pfr1ISS6BgxiX9EEA59RFdVhmvswPQ>
 <xmx:ZRvMYKIgLwMklYzYesA9H-BfGD0UuZr73Ek_WFwepeRXrwfjsHFpnQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 00:04:50 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH] ALSA: bebob: fix rx packet format for Yamaha GO44/GO46,
 Terratec Phase 24/x24
Date: Fri, 18 Jun 2021 13:04:47 +0900
Message-Id: <20210618040447.113306-1-o-takashi@sakamocchi.jp>
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

Below devices reports zero as the number of channels for external output
plug with MIDI type:

 * Yamaha GO44/GO46
 * Terratec Phase 24/X24

As a result, rx packet format is invalid and they generate silent sound.
This is a regression added in v5.13.

This commit fixes the bug, addressed at a commit 1bd1b3be8655 ("ALSA:
bebob: perform sequence replay for media clock recovery").

Cc: <stable@vger.kernel.org>
Fixes: 5c6ea94f2b7c ("ALSA: bebob: detect the number of available MIDI ports")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index e3e23e42add3..8629b14ded76 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -856,6 +856,11 @@ static int detect_midi_ports(struct snd_bebob *bebob,
 		err = avc_bridgeco_get_plug_ch_count(bebob->unit, addr, &ch_count);
 		if (err < 0)
 			break;
+		// Yamaha GO44, GO46, Terratec Phase 24, Phase x24 reports 0 for the number of
+		// channels in external output plug 3 (MIDI type) even if it has a pair of physical
+		// MIDI jacks. As a workaround, assume it as one.
+		if (ch_count == 0)
+			ch_count = 1;
 		*midi_ports += ch_count;
 	}
 
@@ -934,12 +939,12 @@ int snd_bebob_stream_discover(struct snd_bebob *bebob)
 	if (err < 0)
 		goto end;
 
-	err = detect_midi_ports(bebob, bebob->rx_stream_formations, addr, AVC_BRIDGECO_PLUG_DIR_IN,
+	err = detect_midi_ports(bebob, bebob->tx_stream_formations, addr, AVC_BRIDGECO_PLUG_DIR_IN,
 				plugs[2], &bebob->midi_input_ports);
 	if (err < 0)
 		goto end;
 
-	err = detect_midi_ports(bebob, bebob->tx_stream_formations, addr, AVC_BRIDGECO_PLUG_DIR_OUT,
+	err = detect_midi_ports(bebob, bebob->rx_stream_formations, addr, AVC_BRIDGECO_PLUG_DIR_OUT,
 				plugs[3], &bebob->midi_output_ports);
 	if (err < 0)
 		goto end;
-- 
2.30.2

