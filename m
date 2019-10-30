Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C515CA9EAF
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:09:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B5520874
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HchaSfuK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GRcUU+gG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0D/8GBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B5520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E140C22DB;
	Wed, 30 Oct 2019 09:08:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E140C22DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572422969;
	bh=RoiyirFMGrWnz1CBBWwE8Ga3DPlrthRyFXpkdqGgF1E=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HchaSfuKLyFcjbaqnALjUzODHbQZS1TQgmSeDkAAzzsLXIfGrsY0hg0ef9iesUCyj
	 jpy0xKBN+wpZ+XORKIgtFaBYJmoqcNf90HpniBPkHgo0CnPHccFWvAWzbXq02k78ux
	 jICrGogSfoK6i10b1ELDPY7WIDeqGqIlyfhe9xh4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9F6DF805FC;
	Wed, 30 Oct 2019 09:07:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B0BAF805FC; Wed, 30 Oct 2019 09:06:58 +0100 (CET)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 359F1F802BD
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 09:06:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 359F1F802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="GRcUU+gG"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="v0D/8GBk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 9CCC521E29;
 Wed, 30 Oct 2019 04:06:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 30 Oct 2019 04:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=yrisgRAv+hEtQ
 8kdYK1taGGy69KSDtTWd95dzKPOUaw=; b=GRcUU+gG4lGrFOEGF+vXl381Frne7
 3Ck+hBcLkQxqnPrvogPFMC3Z4hmjkkjMLCOLMnXvwMIpyQJbGFmd7gplYaLvyHCZ
 wXuZd8Bx93TJEvcvpYSDSZGZGB06HzH9zdqUnN35sGi9KEOZakoBUkufxLcEnQiS
 lOgPx9mWUQf1uLJzMmTxjOVEB8AxbjwFwJWm4YUCNkVKkr+Gf5+TdkWgi0X1ifg/
 sC+s26wxTT0Vi/nYf60SCgcSzybIuxmMwsGI5Sm14OqjUpJzYuulduMXXkxfF2EY
 XeiYLP6K9+JeSCpmfJEPJA6YexOJaoH5CB/QjwEsbG/dRO01VlG0NBnRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=yrisgRAv+hEtQ8kdYK1taGGy69KSDtTWd95dzKPOUaw=; b=v0D/8GBk
 gvBMAnLHI9fhl9hK7uJqoBNFwbHg7DcBxxCx4ClriFawWEqsjyXHxN4nu15RRUjk
 d7TbrKYUd9hR0SKc07tmR2Y0pZLIBt4WSWoPO9UmGG6Q9HtBO8txHigs4cP5+Aaf
 Akmx4FzQiVyZByxm2v7Ie7h4zbQlmdD8Z+bVMBFR/wS/Sqe3qXpJXKjMrfI20tb9
 jpLdP3x2EJOcOEfWT1GCG7kPEkJLmcvIRH0eNVC6JRy21JxAFLv60HK9eICKHqkb
 i6K5zF2LT8jx2D3I1TkH0lfIfPPw1b8EPkP7poBlFp+UtH79IlP3QGH5N8bUp/HZ
 XEUyVtXE5rmMqA==
X-ME-Sender: <xms:m0S5XVblV7eERibYe9VpXDa9q4PpLTkX7dhPsqMr3jZuoJsixiSDUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddtvddguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekud
 enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
 hhhirdhjphenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:m0S5XY_Qi38w6En0cGngWinWEWMMZZzU8zdZE0XT-wjuCwjYgm2s4Q>
 <xmx:m0S5XcZ_YqWjJXDIsGUi-ghp3Fy3GW2tTTacYlrj7ZTm8wVAjUXTzw>
 <xmx:m0S5XadMuZiPWBb7yPjS3pbncLbRUxcOW7RqWz3MGAdSueg5lrpuHQ>
 <xmx:m0S5Xam3PlWBjNv46N1PY9VOXiHEqqdioM5KyXlyVWpQFWd833B3Nw>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 53BB3306005E;
 Wed, 30 Oct 2019 04:06:50 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Wed, 30 Oct 2019 17:06:40 +0900
Message-Id: <20191030080644.1704-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030080644.1704-1-o-takashi@sakamocchi.jp>
References: <20191030080644.1704-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 2/6] ALSA: firewire-motu: print for unknown
	source of sampling clock
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

When unknown source is detected for sampling clock, corresponding label
was not added for node on procfs.

This commit adds it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/motu/motu-proc.c b/sound/firewire/motu/motu-proc.c
index ea46fb4c1b5a..4e5767c0c8d7 100644
--- a/sound/firewire/motu/motu-proc.c
+++ b/sound/firewire/motu/motu-proc.c
@@ -19,6 +19,7 @@ static const char *const clock_names[] = {
 	[SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX] = "S/PCIF on coaxial interface",
 	[SND_MOTU_CLOCK_SOURCE_AESEBU_ON_XLR] = "AESEBU on XLR interface",
 	[SND_MOTU_CLOCK_SOURCE_WORD_ON_BNC] = "Word clock on BNC interface",
+	[SND_MOTU_CLOCK_SOURCE_UNKNOWN] = "Unknown",
 };
 
 static void proc_read_clock(struct snd_info_entry *entry,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
