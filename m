Return-Path: <SRS0=/ZdJ=6D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4200C2BA2B
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Apr 2020 07:20:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFF421D82
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Apr 2020 07:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KElkQIVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFF421D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBAEA1663;
	Sun, 19 Apr 2020 09:19:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBAEA1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587280824;
	bh=NY+Np638p15qSLolt6P9fviXEUQWlQYNLLV9nWh40A8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KElkQIVcRCSmdkw1e7mayKcctzRw4j/b49qGm1EzOmiuvfmFzXrAjUnbG2onZ2Ce3
	 IzFGvLIuiQg+0580kq4ygyg66HzNAVOBLKrA0wLu2etSU4Uzd06E9yKsic4V8luOzn
	 F07P7cMk8lD0CW3fMokBEnSUs3zf50MgqHZ9r/BI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5C2AF800BA;
	Sun, 19 Apr 2020 09:19:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32DBFF801F5; Sun, 19 Apr 2020 09:19:31 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98FFEF8011F
 for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2020 09:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98FFEF8011F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B84ECABE7;
 Sun, 19 Apr 2020 07:19:27 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Remove ASUS ROG Zenith from the blacklist
Date: Sun, 19 Apr 2020 09:19:26 +0200
Message-Id: <20200419071926.22683-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
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

The commit 3c6fd1f07ed0 ("ALSA: hda: Add driver blacklist") added a
new blacklist for the devices that are known to have empty codecs, and
one of the entries was ASUS ROG Zenith II (PCI SSID 1043:874f).
However, it turned out that the very same PCI SSID is used for the
previous model that does have the valid HD-audio codecs and the change
broke the sound on it.

This patch reverts the corresponding entry as a temporary solution.
Although Zenith II and co will see get the empty HD-audio bus again,
it'd be merely resource wastes and won't affect the functionality,
so it's no end of the world.  We'll need to address this later,
e.g. by either switching to DMI string matching or using PCI ID &
SSID pairs.

Fixes: 3c6fd1f07ed0 ("ALSA: hda: Add driver blacklist")
Reported-by: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a5fab12defde..d7adae316c0d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2092,7 +2092,6 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
  * should be ignored from the beginning.
  */
 static const struct snd_pci_quirk driver_blacklist[] = {
-	SND_PCI_QUIRK(0x1043, 0x874f, "ASUS ROG Zenith II / Strix", 0),
 	SND_PCI_QUIRK(0x1462, 0xcb59, "MSI TRX40 Creator", 0),
 	SND_PCI_QUIRK(0x1462, 0xcb60, "MSI TRX40", 0),
 	{}
-- 
2.16.4

