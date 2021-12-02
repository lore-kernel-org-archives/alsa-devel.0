Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D420C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Dec 2021 07:35:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA60D2446;
	Thu,  2 Dec 2021 08:34:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA60D2446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638430537;
	bh=gKdSC1IMxkGrpuEBbzAIqUn1qALu8KCYfv7jQxTPq5A=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iCxyeFsfKNh5FQo/jPhertRiOVaS+flbGuhNnNQ4tQLVrJAx+F16HwoECnl80Ucpx
	 wrk9kGn9LMQsiLOhWV/PvaBwJBRARJ9H+ES7Si9jEBgUsvRId95RxM+G6gAeHpHB67
	 2zkbDKxfZJEBpc4ZR3jK8PGaRTVy1JOhyanYzxE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33CFCF80290;
	Thu,  2 Dec 2021 08:34:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCE42F802A0; Thu,  2 Dec 2021 08:34:36 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62735F800CE
 for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2021 08:34:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62735F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="Y9JzoMKt"
Received: from localhost.localdomain (unknown [10.101.196.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4BE0140078; 
 Thu,  2 Dec 2021 07:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1638430466;
 bh=daGfkCmFd2T/mh9PjPT6uP/gwdzM5b89BaR4Dee9AME=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Y9JzoMKtUSVYu7DWExsE8O7aCVt5r9gqMeOMA14v4kdvgJ1dHQavtfbv2KNN/d4XI
 hZ/CCtgN5EVwSapE6+KdCO7ekaEQgBZEQl6q7v9xrMSiKoPneeX9ndOaDxPdipbZJl
 R/NvmazaFiTCNPxbpjCpglLBD8KQpSiX912SL1o9FCmSMaHesXmBiR5RoOPXZ3ldWg
 3UsjIzIw84hwjp/lFSphRMD8d85/xmHJCiqrL42lIaOEfHDH5t3xCyaOciNeTTkMDD
 KCcxS0T18DZpkIBzffcKGHpqboQTAjj7H1dlvbxwEfO4LSSFtTUmv3zIE+ucXVbr9Z
 WFOaABUwDfMgg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda/hdmi: Consider ELD is invalid when no SAD is present
Date: Thu,  2 Dec 2021 15:33:35 +0800
Message-Id: <20211202073338.1384768-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
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

There's a system that reports a bogus HDMI audio interface:
$ cat eld#2.0
monitor_present         1
eld_valid               1
monitor_name
connection_type         DisplayPort
eld_version             [0x2] CEA-861D or below
edid_version            [0x3] CEA-861-B, C or D
manufacture_id          0xe430
product_id              0x690
port_id                 0x0
support_hdcp            0
support_ai              0
audio_sync_delay        0
speakers                [0xffff] FL/FR LFE FC RL/RR RC FLC/FRC RLC/RRC FLW/FRW FLH/FRH TC FCH
sad_count               0

Since playing audio is not possible without SAD, also consider ELD is
invalid for this case.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 415701bd10ac8..e7c2f3167f311 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1535,7 +1535,7 @@ static void update_eld(struct hda_codec *codec,
 		}
 	}
 
-	if (!eld->eld_valid || eld->eld_size <= 0) {
+	if (!eld->eld_valid || eld->eld_size <= 0 || eld->info.sad_count <= 0) {
 		eld->eld_valid = false;
 		eld->eld_size = 0;
 	}
-- 
2.32.0

