Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF584C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Apr 2022 12:14:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 071A717BC;
	Tue,  5 Apr 2022 14:13:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 071A717BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649160880;
	bh=+7H+UNtukcqj5+PZFgw3Yc/3Dld7H+mJAp+cwsuTHvg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UmyoxFTC5gQ1OYgbAszUF4Kc8vXEu1eI6z/ZGrd1C0j/QI9JNqG+vKvKnZqd8xfNR
	 nWuncdgAQ1l7nrx6i2CWtFjXBh9ZjSNV/kYn0Ky0vSZXU+TtpueuqD2AdR/s8Vhz9k
	 kyjnCROD25z0cMa20TlWuyLHi2kpI6psEovH90Fk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93E57F8014B;
	Tue,  5 Apr 2022 14:13:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B372F8016A; Tue,  5 Apr 2022 14:13:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D3F8AF8012C
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2022 14:13:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3F8AF8012C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB9ED6E;
 Tue,  5 Apr 2022 05:13:37 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F7643F5A1;
 Tue,  5 Apr 2022 05:13:36 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ALSA: emu10k1: Stop using iommu_present()
Date: Tue,  5 Apr 2022 13:13:33 +0100
Message-Id: <5ac9b54285b2189b848da2595408eb3cae8e5e9d.1649160813.git.robin.murphy@arm.com>
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
if the given device has no IOMMU. Drop the unnecessary check.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 sound/pci/emu10k1/emu10k1_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 86cc1ca025e4..5ffab343b89c 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1751,9 +1751,6 @@ static void snd_emu10k1_detect_iommu(struct snd_emu10k1 *emu)
 
 	emu->iommu_workaround = false;
 
-	if (!iommu_present(emu->card->dev->bus))
-		return;
-
 	domain = iommu_get_domain_for_dev(emu->card->dev);
 	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
-- 
2.28.0.dirty

