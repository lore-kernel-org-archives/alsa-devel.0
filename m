Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1727C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Dec 2021 16:43:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8BC31FB6;
	Tue, 14 Dec 2021 17:42:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8BC31FB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639500195;
	bh=+Bi2E0hmneJTfb52MXEAJ9SYW4RlrITGcZWn2eupjBM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EUJ4l69GwmqPUP6XoYeQXVvgQeWrIVruNB75gL8EqYbzMZwWAtHqoaqaBxc8asrXc
	 mpU/0rfCZEX7uFi72TyfelOMa04+VmPqXYIaW1JyVynmNoR5PCiEo6bLw4eOE2GzIV
	 IKDOBkMnfLyxUIBjGP4DPvC4SpRAoKr2qqGOHDHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28D75F801EC;
	Tue, 14 Dec 2021 17:42:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDD35F80246; Tue, 14 Dec 2021 17:42:23 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BE41F8016A
 for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2021 17:42:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BE41F8016A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="WronaXwg"
Received: from localhost (118-169-14-172.dynamic-ip.hinet.net [118.169.14.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0429C40078; 
 Tue, 14 Dec 2021 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1639500134;
 bh=K+yRgSpvTmfrvAWbE2pwn9hFz5pcnekh9nWPWqcrcso=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=WronaXwgpzzymZRsYX6m7VpaH7cDCkoDLknojE3E78fINOg/0DhR1cThBTHajXiz1
 h1f6cF+GDW6QV3TkbXf06oZPLPf6XZ9dg9SpGvFruWdQhtcZxBLGq15ZYnJ0tga/m7
 /pKP3+mWEXOrY7c0rDDr+d4pIu5Qor4364Yc00YtcKyNBhDlWDqMgXiYifA9uMLfnn
 xn/gkdzH6clcqIzrSGuVa7ebsMTrQs+tmrwybJJNifWdy5wzaNNFXFf4F29XfdsNJm
 vq7p5FTHqMLDn8ITJ6cVqtbAJs9MK5NPsmxEHJkMVJZ+V4W36Ej30/TsRfKvCKnDOa
 yUwnZG91wiaAQ==
From: Jeremy Szu <jeremy.szu@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP ProBook
Date: Wed, 15 Dec 2021 00:41:54 +0800
Message-Id: <20211214164156.49711-1-jeremy.szu@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, Jeremy Szu <jeremy.szu@canonical.com>,
 Elia Devito <eliadevito@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Werner Sembach <wse@tuxedocomputers.com>, Hui Wang <hui.wang@canonical.com>,
 Sami Loone <sami@loone.fi>, Cameron Berkenpas <cam@neo-zeon.de>
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

There is a HP ProBook which using ALC236 codec and need the
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED and
micmute LED work.

Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3599f4c85ebf..e97b3cd1577b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8705,6 +8705,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.33.0

