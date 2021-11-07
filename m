Return-Path: <SRS0=XTqg=P2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B59BC433F5
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Nov 2021 08:34:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A803261378
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Nov 2021 08:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A803261378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 254F41607;
	Sun,  7 Nov 2021 09:33:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 254F41607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636274082;
	bh=N2OSO0oetd/t6dLRAtr/M7eG8VhgpojONO7bbCw8XWU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=njz3W5BTpXUV82TggWBobdURlJhpFa7+/isGYQlhHJZvnRhQtJiApZuKnTuTWCwGP
	 aHfrDvgwOCsxMIY1WSnWlkCCG/DREgKvoXKGbwAZNZOk7EmdYeMJSkrnieRgYSw50w
	 O76pn0d3LZIGtf3PU29uy1nb5mqQEhOB6EDWspys=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2B31F80224;
	Sun,  7 Nov 2021 09:33:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7381F802D2; Sun,  7 Nov 2021 09:33:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0F3BF80107
 for <alsa-devel@alsa-project.org>; Sun,  7 Nov 2021 09:33:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0F3BF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="AZbP4HFe"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="j2UG/Wt/"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 84A2E2192D
 for <alsa-devel@alsa-project.org>; Sun,  7 Nov 2021 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636274021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L0/UX8XPWsYSj7xVy8mkovp+NuCAfOJ4f86FNZwXyiI=;
 b=AZbP4HFe59K4lZ1hK29KL1pAX3QxtMtkB6Ttacp8IuVbUy+cg0hQycCCKShpfeiNI41Xa8
 ouXQTIRWrUPH1nQaoQWnsSTqOvZKrxqrBAUjSnlSHqSaTEyzYiwEiq133HNxkMCc8KYxd8
 wuHTGjp2d0x6kR/HrMWlK+1nQC2OLcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636274021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L0/UX8XPWsYSj7xVy8mkovp+NuCAfOJ4f86FNZwXyiI=;
 b=j2UG/Wt/JTCbTDZGayCIYdzH9mLU1Hg6Kc/45avvulT6AltURtvtXficoV8+e20majojkp
 sNhMiBIbIgnZVQAg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 7435F2C144;
 Sun,  7 Nov 2021 08:33:41 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS UX550VE
Date: Sun,  7 Nov 2021 09:33:39 +0100
Message-Id: <20211107083339.18013-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

ASUS UX550VE (SSID 1043:1970) requires a similar workaround for
managing the routing of the 4 speakers like some other ASUS models.
Add a corresponding quirk entry for fixing it.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=212641
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3601749f2df6..a6098c942aeb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8698,6 +8698,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x194e, "ASUS UX563FD", ALC294_FIXUP_ASUS_HPE),
+	SND_PCI_QUIRK(0x1043, 0x1970, "ASUS UX550VE", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1982, "ASUS B1400CEPE", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
-- 
2.26.2

