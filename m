Return-Path: <SRS0=B97g=IT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DCFC433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Mar 2021 03:31:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CAC601FF
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Mar 2021 03:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CAC601FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 502421685;
	Sun, 21 Mar 2021 04:30:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 502421685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616297507;
	bh=pVUGynMoMIEuhBA/1TWMsGFgxpH/KJYjf2NCP5EjJCA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GZG/rII/36xbD9VMcUEUAs4s0OOp28HhnY313/rajiizIY25gzufJdE6LP3yl6/4V
	 48uQm/DMVE8qlYM4A41ImDZkaoGVMqgXIlBR5vgv24rUhVtWzDuM6bIhtdbnQan4EN
	 wIeQrcNqLmewEZiCwdL9MqMVThCXCadzBsNifuvo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CDB7F8032D;
	Sun, 21 Mar 2021 04:29:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27AC7F80268; Sun, 21 Mar 2021 04:29:07 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42C86F80240
 for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2021 04:28:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42C86F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="C3H8sSFq"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Tr8u+c5q"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 505A6184F;
 Sat, 20 Mar 2021 23:28:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sat, 20 Mar 2021 23:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=LXUjgIizDuHrF
 EGsIif3/h6poA60pmXgx3X16FGvO5Q=; b=C3H8sSFqkfxaDAhk2rIWKDVqB/8D2
 Zc1P8PEc4ba/RgMeja43fzDYBl8YfFyO/sS6GVTjtlASIiYn15FSL2By471Rvt4c
 w6eOxBx/T25iYa907C9Z4JHqtG9PJdy/6zhEHVlBJdB9ozCrcCF7mvMqlmLn9X7u
 wfwzrAJrE/aCoGNivy9LkhH60cnhVxFql7Wz4mIpctMgM+xG6zlumYqDKsL4dklm
 18V/cMLnBaXC0rfYqRhHKSObgNo1jrdw7ZGnHcmRnF1qZGJumtqLK+einneFHkDU
 UoVVuabSOjwbMWAq0UHobihjDpP/038rqgK8V6jqcgJgFdJbne5K448Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=LXUjgIizDuHrFEGsIif3/h6poA60pmXgx3X16FGvO5Q=; b=Tr8u+c5q
 hcZGWZfpNcHksEa71gIOh4R16mo4NZURBNZ4i5mV9BFPorsMKCK31i6pVnTXmmHO
 Sx22B+qJF792y9vkq3EB6g4WpyTX/Mn1QHAEzYyqdM3rIPmoshojN5Y9OBCKTmfQ
 DF+DrXNRsdN00r4nGr17HBFE8T/3vTD95fPUxgkBknr4nmvtUreBqlqeMxW8eLIr
 W2UpGdO61r/g57838tdwbfUvPjFJfU2T8tNNHe+iRK71N9kszVyJKP6+06N9xC2r
 vyV2YzpAdt9PaTP3xJvSYXRpkLMZQNLoF7fb3CkARtb13UPJnls5eloFxmfsEZ5B
 mwbHdw/uq/niYA==
X-ME-Sender: <xms:Zr1WYLIfS6W5-m4kRO7SnlDz6OWB7cuERjZBtxJs8gdkgaiQ1aSpbA>
 <xme:Zr1WYPKGhLu4eCxUzj1pTphZs-wf7Tu2qhNBdl6tA5Taw8lO7n0lC06bHGKnk80nr
 0cBo2GKOFHdeDxJCPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeguddgieduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Zr1WYDs5IyMR4ubZcWRTi4uyObVmXTB8qlVWp6I-C3gfmDaklJxs1A>
 <xmx:Zr1WYEbMscyZ8LO-gpNvGRvKgveG55EzfS7jza_oPo7YlXlKVsRuwg>
 <xmx:Zr1WYCaiBiZJLzPFxcwRLwv5ipwYKfpPbqx4k46CpEuQVd5Ky_Lzhw>
 <xmx:Zr1WYLAi6npWIYtiZtMRbbPICrwHzO-6APqNO8vNme1DfwE4a22ZSQ>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 008492403E0;
 Sat, 20 Mar 2021 23:28:37 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 3/3] ALSA: bebob: enable to deliver MIDI messages for multiple
 ports
Date: Sun, 21 Mar 2021 12:28:31 +0900
Message-Id: <20210321032831.340278-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210321032831.340278-1-o-takashi@sakamocchi.jp>
References: <20210321032831.340278-1-o-takashi@sakamocchi.jp>
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

Current implementation of bebob driver doesn't correctly handle the case
that the device has multiple MIDI ports. The cause is the number of MIDI
conformant data channels is passed to AM824 data block processing layer.

This commit fixes the bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 23579a73e038..b612ee3e33b6 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -517,20 +517,22 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 static int keep_resources(struct snd_bebob *bebob, struct amdtp_stream *stream,
 			  unsigned int rate, unsigned int index)
 {
-	struct snd_bebob_stream_formation *formation;
+	unsigned int pcm_channels;
+	unsigned int midi_ports;
 	struct cmp_connection *conn;
 	int err;
 
 	if (stream == &bebob->tx_stream) {
-		formation = bebob->tx_stream_formations + index;
+		pcm_channels = bebob->tx_stream_formations[index].pcm;
+		midi_ports = bebob->midi_input_ports;
 		conn = &bebob->out_conn;
 	} else {
-		formation = bebob->rx_stream_formations + index;
+		pcm_channels = bebob->rx_stream_formations[index].pcm;
+		midi_ports = bebob->midi_output_ports;
 		conn = &bebob->in_conn;
 	}
 
-	err = amdtp_am824_set_parameters(stream, rate, formation->pcm,
-					 formation->midi, false);
+	err = amdtp_am824_set_parameters(stream, rate, pcm_channels, midi_ports, false);
 	if (err < 0)
 		return err;
 
-- 
2.27.0

