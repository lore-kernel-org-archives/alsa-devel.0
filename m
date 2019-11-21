Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE4C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 02:28:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13283206A4
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 02:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EOXnt6JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13283206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DFDD1729;
	Thu, 21 Nov 2019 03:27:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DFDD1729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574303322;
	bh=3SWifRFCe+nwZfUWylTjbVh85fPMQ/uloBpurVvCkPQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EOXnt6JQVjxuE5WWMcrR3ep+Szs8mExgPg/jjioh1z0koRcaJ3qixVJ4LPVInabXC
	 B5lUS7Yfw3Dn0ZJYXGyxz6liwoRapM4qIaQOVWjCYQEhpG511rhvqXLpxRkReMHty0
	 xQXQ3zGpA9sgNxxn/yIW/jZd8LFGOvk55XxBP37U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8877F8014E;
	Thu, 21 Nov 2019 03:26:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E071CF80146; Thu, 21 Nov 2019 03:26:55 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 575A4F800C1
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 03:26:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 575A4F800C1
Received: from 61-220-137-34.hinet-ip.hinet.net ([61.220.137.34]
 helo=localhost.localdomain) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1iXcBH-00025C-Nt; Thu, 21 Nov 2019 02:26:52 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Date: Thu, 21 Nov 2019 10:26:44 +0800
Message-Id: <20191121022644.8078-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121022644.8078-1-hui.wang@canonical.com>
References: <20191121022644.8078-1-hui.wang@canonical.com>
Subject: [alsa-devel] [PATCH 2/2] ALSA: hda/realtek - Move some alc236
	pintbls to fallback table
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

We have a new Dell machine which needs to apply the quirk
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE, try to use the fallback table
to fix it this time. And we could remove all pintbls of alc236
for applying DELL1_MIC_NO_PRESENCE on Dell machines.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4c83ed4b0d5c..4ebe104cb592 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7512,20 +7512,6 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x19, 0x02a11020},
 		{0x1a, 0x02a11030},
 		{0x21, 0x0221101f}),
-	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-		{0x12, 0x90a60140},
-		{0x14, 0x90170110},
-		{0x21, 0x02211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-		{0x12, 0x90a60140},
-		{0x14, 0x90170150},
-		{0x21, 0x02211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-		{0x21, 0x02211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-		{0x12, 0x40000000},
-		{0x14, 0x90170110},
-		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
@@ -7823,6 +7809,9 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
+	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x19, 0x40000000},
+		{0x1a, 0x40000000}),
 	{}
 };
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
