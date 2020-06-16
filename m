Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DA8C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:23:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055472098B
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="myO1zVvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055472098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 909F514E;
	Tue, 16 Jun 2020 15:22:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 909F514E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592313785;
	bh=npVwl565n5+MjoLHX/wbvbb80jDZ/w5W60o6XyInuf0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=myO1zVvRqVYkjYzPr3HrlNTaoev9cFq540+tHLrOfE4pr2fATd4EE0sszmsZcdMIS
	 2PcMsS7899/v0PSiZd3T9PX/JX6oOgBFSAR8vYPpqZ9dQcdvC6gfzNXzDxba8Sohlm
	 fUvGciCUNp1MVswIiD0mNOU6BIB0FOxtMdL6r5AI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37591F80217;
	Tue, 16 Jun 2020 15:22:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5AABF8022B; Tue, 16 Jun 2020 15:21:59 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89548F800EF
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 15:21:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89548F800EF
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4FBE0B162
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 13:21:56 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek - Add quirk for MSI GE63 laptop
Date: Tue, 16 Jun 2020 15:21:50 +0200
Message-Id: <20200616132150.8778-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

MSI GE63 laptop with ALC1220 codec requires the very same quirk
(ALC1220_FIXUP_CLEVO_P950) as other MSI devices for the proper sound
output.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208057
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d1b67d75f954..3ca93421e209 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2461,6 +2461,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1462, 0x11f7, "MSI-GE63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1275, "MSI-GL63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
-- 
2.25.0

