Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472EBC388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:25:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2BD21D43
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QcROCNlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2BD21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B6B217FD;
	Fri, 23 Oct 2020 12:24:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B6B217FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603448696;
	bh=6aADyqAfopKffA5GqqvMTGt9ZZ15q0VjXp23BM8ltdM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QcROCNlNVUzG9kioqQp8NanKt8lRr7Pl3PhQuqEait/QrN3s0BrDAVx8o7Sb9PE6I
	 t72WtSbnZ8U7FqzwCaa7iiktHsnjJAujkMkcjUk8imNoP4zQVlGYz/XwA/ZZoL5TEn
	 Rw0YtTrgefjanwNolEin+Tul9/RFAY/C1skvVZes=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18E15F8025A;
	Fri, 23 Oct 2020 12:24:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB169F80264; Fri, 23 Oct 2020 12:24:04 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 721ACF80245
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 12:23:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 721ACF80245
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1kVuEh-0006R7-5W; Fri, 23 Oct 2020 10:23:51 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH 2/4] ALSA: hda: Stop mangling PCI MSI
Date: Fri, 23 Oct 2020 18:23:36 +0800
Message-Id: <20201023102340.25494-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023102340.25494-1-kai.heng.feng@canonical.com>
References: <20201023102340.25494-1-kai.heng.feng@canonical.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Alex Deucher <alexander.deucher@amd.com>
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

The code predates 2005, it should be unnecessary now as PCI core handles
MSI much better nowadays.

So stop PCI MSI mangling in suspend/resume callbacks.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_intel.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 749b88090970..b4aa1dcf1aae 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1022,13 +1022,11 @@ static int azx_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
-	struct hdac_bus *bus;
 
 	if (!azx_is_pm_ready(card))
 		return 0;
 
 	chip = card->private_data;
-	bus = azx_bus(chip);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	/* An ugly workaround: direct call of __azx_runtime_suspend() and
 	 * __azx_runtime_resume() for old Intel platforms that suffer from
@@ -1038,14 +1036,6 @@ static int azx_suspend(struct device *dev)
 		__azx_runtime_suspend(chip);
 	else
 		pm_runtime_force_suspend(dev);
-	if (bus->irq >= 0) {
-		free_irq(bus->irq, chip);
-		bus->irq = -1;
-		chip->card->sync_irq = -1;
-	}
-
-	if (chip->msi)
-		pci_disable_msi(chip->pci);
 
 	trace_azx_suspend(chip);
 	return 0;
@@ -1060,11 +1050,6 @@ static int azx_resume(struct device *dev)
 		return 0;
 
 	chip = card->private_data;
-	if (chip->msi)
-		if (pci_enable_msi(chip->pci) < 0)
-			chip->msi = 0;
-	if (azx_acquire_irq(chip, 1) < 0)
-		return -EIO;
 
 	if (chip->driver_caps & AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
 		__azx_runtime_resume(chip, false);
-- 
2.17.1

