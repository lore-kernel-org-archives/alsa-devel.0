Return-Path: <SRS0=1gO0=P5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D7C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Nov 2021 14:42:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C846101C
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Nov 2021 14:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67C846101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CD2D1654;
	Wed, 10 Nov 2021 15:41:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CD2D1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636555346;
	bh=AxBxTSr7KZB4C0du8TwjEEIbfPXBYrwqcnrxd4xpn6Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uPR3eGCYAi42xyR4C2EoTt8l/4QAZpIu3T9QFIYkUgBNFFGwINctnNYcY1RpOnoH+
	 +P04nOg5+Qtgfhe2lar/mKF+nRc86vKhrxYGEsfrd4+4OCn6/dqgsT0+oXbCMgcDNp
	 K2ces+bw+Sf/G2cvM60rTiRZ7kBwnD1GhDhk+4DI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB86FF800C9;
	Wed, 10 Nov 2021 15:41:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71D28F8049E; Wed, 10 Nov 2021 15:41:34 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 401F3F800C9
 for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2021 15:41:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 401F3F800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="rAJ1bnji"
Received: from localhost.localdomain (unknown [10.101.196.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D448C3F197; 
 Wed, 10 Nov 2021 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1636555283;
 bh=AmOia6mFVXePE5lwo8LpCWa2Ymdv43SwCIz0a9emYu0=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=rAJ1bnjiSaLb0j5n09NYop4w/L9Q8P0VcaXV2OGa7ScfEte+XS6wglwb1CTID5kGt
 7DDlVRprwehlasN7bwg7Zc43RiSUWe1lgupLDDmvVoc42YDPu88rvUlkYVBx5gSiPz
 QWmbXOZ9bKQpR708jHaHzS0MA7X5ZBTUCoWCZDg5msy3vXPCmsx6Xzxm24WqGngHkM
 yv06yFRCF8Ms94/bi8lnRqk5zlIXiCqQ0zmGccR2oc5ePgekYnQE9goFIzoWuG5VNi
 3zRod26IfYouLeArlZo5YIcqG5ujHa+TpJWHfTRplgv9nbtmu9CzcvAEnnnhhG8+c7
 T2TqzBChZ5nEg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP EliteBook 840 G7 mute LED
Date: Wed, 10 Nov 2021 22:40:32 +0800
Message-Id: <20211110144033.118451-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chris Chiu <chris.chiu@canonical.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, Jeremy Szu <jeremy.szu@canonical.com>,
 Elia Devito <eliadevito@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Werner Sembach <wse@tuxedocomputers.com>, Hui Wang <hui.wang@canonical.com>,
 PeiSen Hou <pshou@realtek.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
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

The mute and micmute LEDs don't work on HP EliteBook 840 G7. The same
quirk for other HP laptops can let LEDs work, so apply it.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a6098c942aeb5..2f1727faec698 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8636,6 +8636,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8716, "HP Elite Dragonfly G2 Notebook PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8720, "HP EliteBook x360 1040 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8724, "HP EliteBook 850 G7", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8728, "HP EliteBook 840 G7", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8729, "HP", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8730, "HP ProBook 445 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.32.0

