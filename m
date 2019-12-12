Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F843C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:06:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2582173E
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KyoTk5BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2582173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35EC116A4;
	Thu, 12 Dec 2019 09:05:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35EC116A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576137979;
	bh=Eq3wFzFUDuDTCYBs8VXb9oPKyPi1D8Qdk0tECU/9QG4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KyoTk5BHKLi37qJQ9OFxNo5Zly5gwAi858tBJpOnqreFMPLokRj04t3+e4pq2f/2q
	 9zZCtQDyneNi9TzMu5DkzsXGUgSpl5k65OtI6C2eplsrK9A3C2Ru5SEHcgUMaDtP0J
	 hIP7Fq/M0tQ8R47aFKIcp0TcXkrD5X1w+JlzcsM8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B65AAF800EC;
	Thu, 12 Dec 2019 09:05:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66D01F8020C; Thu, 12 Dec 2019 09:05:26 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F074BF800EC
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 09:05:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F074BF800EC
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 95EB6B15E;
 Thu, 12 Dec 2019 08:05:20 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 12 Dec 2019 09:05:18 +0100
Message-Id: <20191212080518.6522-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [alsa-devel] [PATCH] ALSA: hda: tegra: Fix unused variable compile
	warning
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

Forgot to remove the variable declaration as well in the last commit.
  sound/pci/hda/hda_tegra.c: In function 'hda_tegra_runtime_suspend':
  sound/pci/hda/hda_tegra.c:169:19: warning: unused variable 'bus' [-Wunused-variable]

Fixes: f36da9406e66 ("ALSA: hda: Support PCM sync_stop")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index fc2e0a294bc1..269f242fcbfd 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -166,7 +166,6 @@ static int __maybe_unused hda_tegra_runtime_suspend(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
-	struct hdac_bus *bus = azx_bus(chip);
 
 	if (chip && chip->running) {
 		azx_stop_chip(chip);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
