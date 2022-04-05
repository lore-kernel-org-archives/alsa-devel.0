Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25BFC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Apr 2022 13:29:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0914517A3;
	Tue,  5 Apr 2022 15:28:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0914517A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649165344;
	bh=851Am/y/3Qe8RTujRmNXmGwSJgfHwN1co9+dKMyVOiE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VCFHjr3HQqmZBPOLSng6/lHrBYLFNCZdyAvtJY1x5NMx0ttuQ7WNj07SLVCjiM35J
	 SYlfI46ksXPHY6Me4Dtlu4nb4wF1KOFHIlIo5yQ4AJsQwGbGPl8Wg/naY8pflTwhYd
	 yVCtj2AWudkKoKysvUvFV6NMkluMnPAxIQ98oenw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7026CF8014B;
	Tue,  5 Apr 2022 15:28:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3E5DF8016A; Tue,  5 Apr 2022 15:28:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id DA7F8F800D1
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2022 15:28:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA7F8F800D1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D57D6E;
 Tue,  5 Apr 2022 06:27:58 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24DE73F5A1;
 Tue,  5 Apr 2022 06:27:58 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH v2] ALSA: emu10k1: Stop using iommu_present()
Date: Tue,  5 Apr 2022 14:27:54 +0100
Message-Id: <9b506b4a4fe8a7f40aa8bad1aafc82426cf3dd92.1649165210.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: iommu@lists.linux-foundation.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

iommu_get_domain_for_dev() is already perfectly happy to return NULL
if the given device has no IOMMU. Drop the unnecessary check in favour
of just handling that condition appropriately.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Get "!domain" condition right

 sound/pci/emu10k1/emu10k1_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 86cc1ca025e4..3880f359e688 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1751,11 +1751,8 @@ static void snd_emu10k1_detect_iommu(struct snd_emu10k1 *emu)
 
 	emu->iommu_workaround = false;
 
-	if (!iommu_present(emu->card->dev->bus))
-		return;
-
 	domain = iommu_get_domain_for_dev(emu->card->dev);
-	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
+	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
 	dev_notice(emu->card->dev,
-- 
2.28.0.dirty

