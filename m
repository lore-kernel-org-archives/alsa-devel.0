Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC94CC48BE0
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 08:35:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8DF613C6
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 08:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8DF613C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70CCD18C7;
	Fri, 11 Jun 2021 10:34:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70CCD18C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623400535;
	bh=UelWmVYwxbshIAuaFaIBCXeC4Yf40Sa+kZ6HKU4LmhE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BPiGBlHkTYE6rALDFBFxqP3M1QyPZ++ZITlufvgdFm/ipuUZm7dppSxpwrRWr8Cpa
	 oNqtLvLYRVgm1sxIS0mRYlhXAGm1nZe3Rievm+vLMSGFOH9UqseXr2xb6yR3Z4fjuk
	 NZ6qTMNnmHJEG6C/cYADjk95dCPZzByKPLVGzA9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6AFCF80212;
	Fri, 11 Jun 2021 10:34:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6FDBF8026C; Fri, 11 Jun 2021 10:34:42 +0200 (CEST)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F24AF800FB
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 10:34:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F24AF800FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="naR0N4YI"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="T3+M7u8i"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id DE7421B08;
 Fri, 11 Jun 2021 04:34:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Fri, 11 Jun 2021 04:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=YJuxYYJ/3Q6t3ThueWW8KO8Dxd
 dr8NZLT6qsa/b/rxY=; b=naR0N4YIgLrgBXnvjWW5WPK5e0JSpJyrQ74NMk6zk1
 u7JRXjTApbnjG+EBwSsNj2sn3vg0+xTTg4ezm796WCIUZTFeSxRYVvk+1hFy/pdb
 M8k1MxC0u8dNCrRM/sXZpAXKcjQNZwLvfMacmPJKXTKQw1F8SFil/MOI2BjJxIyL
 E1Xc389+kHC0c2cBMc/ys7xAbi/5zNWi6D/BrRW+cAeQCUxKBgY4yXvJMwGPj0S9
 5F0FNikpmVAU5s//quCCMRC8NIYWZxE4kVMJI38Eyw+6Guv3T/1kEcdNo52rpQNg
 g5JZxgzGUfKX9e5dximqEtY4pUK0MSUWt13KoK+jU2DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YJuxYYJ/3Q6t3Thue
 WW8KO8Dxddr8NZLT6qsa/b/rxY=; b=T3+M7u8iBSl6JvRPhrKKi4H7tZgUU/nXs
 XYa49SKgEnulTO/ZFG53F71bKOkeb/TwD+mP9PVz48hrK/D13C8TRuZEmr4iGPvT
 e8bffJKfB8DgoGXsz/s+bGI5tWX65jLS4zfNNToFNEiJtwg+MLddjS1g1jSfqKRA
 dnsTkJlpVfEPDX+6/0Ud79zXH1WAS0Ao40uyLE85KmHL3Wz69YB3E4/KQDOWRmU0
 7zuPCaj9PZyobbQ012vGCW0iEB49Q0kK8cJpVsQ/KXCD9FdTneLCoJjqgoZniOM9
 /M9HEdjDds4yuxKy5TbPj/t6XLZrxfyPBaihncdAlr0hj3OuqQ+jw==
X-ME-Sender: <xms:FiDDYPSrc6ZI_sQ_uJK_nduTes8f44ElgIKgrYBbVOFTxaUBFLsoYw>
 <xme:FiDDYAyLozB69wi3sgJsZOn5Y71M5FPezSU6PNzNFNB-SFTRDM7xH1-q4ftFoN8dv
 M7DgN620B_Oqg6C6vU>
X-ME-Received: <xmr:FiDDYE1U_zLbopmsPc3EHU5i_Jg__4r8A2pQoGP0LfAwA-HdzrBU3wxSvqoY7ldCIZbPUIXilR5JupqEE5icge2Faw8rfz6UI2NENR7TS6o4j4nOtnqK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedujedgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecuvehluhhsthgvrhfu
 ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
 grmhhotggthhhirdhjph
X-ME-Proxy: <xmx:FiDDYPB-U95eHOpp4a2z_dy2_RC4JEx8BIKQyPFOWoFk_YgxXUjp5g>
 <xmx:FiDDYIhwHA-aIycbTk640UeyXsoE0SzS5v4Fxkmzn40bdkcXz79iJw>
 <xmx:FiDDYDq2fCqjt4hmY5gn-BbUWbtcjfXo75zPs98Cw_JFZfv8wN-WyQ>
 <xmx:FyDDYEZ4oQhEGdQrPECJDLkgdkJsz-ywoy6SAMumE1tySthktgOGUA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jun 2021 04:34:29 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH] ALSA: firewire-lib: replace in_interrupt() with in_softirq()
Date: Fri, 11 Jun 2021 17:34:25 +0900
Message-Id: <20210611083425.61204-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.30.2
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

Tasklet is used to handle isochronous context of 1394 OHCI. The explicit
usage of in_softirq() may be preferable than in_interrupt().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 2 +-
 sound/firewire/amdtp-stream.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index aa53c13b89d3..5fd2aeccdfc2 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -49,7 +49,7 @@ TRACE_EVENT(amdtp_packet,
 		__entry->data_blocks = data_blocks;
 		__entry->data_block_counter = data_block_counter,
 		__entry->packet_index = packet_index;
-		__entry->irq = !!in_interrupt();
+		__entry->irq = !!in_softirq();
 		__entry->index = index;
 	),
 	TP_printk(
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 1d9bc7b07df1..aad9778d1c4d 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -610,7 +610,7 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 		// buffer associated to PCM substream to process PCM frames in the buffer, instead
 		// of receiving notification of period elapsed by poll wait.
 		if (!pcm->runtime->no_period_wakeup) {
-			if (in_interrupt()) {
+			if (in_softirq()) {
 				// In software IRQ context for 1394 OHCI.
 				snd_pcm_period_elapsed(pcm);
 			} else {
@@ -1026,7 +1026,7 @@ static void generate_pkt_descs(struct amdtp_stream *s, const __be32 *ctx_header,
 static inline void cancel_stream(struct amdtp_stream *s)
 {
 	s->packet_index = -1;
-	if (in_interrupt())
+	if (in_softirq())
 		amdtp_stream_pcm_abort(s);
 	WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
 }
@@ -1738,7 +1738,7 @@ unsigned long amdtp_domain_stream_pcm_pointer(struct amdtp_domain *d,
 	if (irq_target && amdtp_stream_running(irq_target)) {
 		// In software IRQ context, the call causes dead-lock to disable the tasklet
 		// synchronously.
-		if (!in_interrupt())
+		if (!in_softirq())
 			fw_iso_context_flush_completions(irq_target->context);
 	}
 
-- 
2.30.2

