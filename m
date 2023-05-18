Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC19CC7EE2C
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 09:32:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4C63208;
	Thu, 18 May 2023 11:31:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4C63208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684402355;
	bh=AS1mSY/a4gpcWTr/6QIZmiODhEwWUaWnn6fAX4mE86E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=luxqPe4bf+4zSvUP69+Dlf1KReHugWLKzRcSSVqFc8SyNBEhJzmbALAqwu2G/oJca
	 E+pDr/RaprjYJBagu5HfeXgSmBq+2jXrEihi+eCaJgjoO0P43vtjHYa7ZKS4OOQ6/F
	 EA535Hdizow4w4UTUG07G9bZo9xG/QGVMNEoPDJo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69296F80553; Thu, 18 May 2023 11:30:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C4E18F8055B;
	Thu, 18 May 2023 11:30:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FE55F80431; Thu, 18 May 2023 11:30:52 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A3FEDF80272
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 11:30:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3FEDF80272
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 6F8C223E25;
	Thu, 18 May 2023 05:30:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzZyB-VzX-00; Thu, 18 May 2023 11:30:47 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 1/4] ALSA: emu10k1: simplify interrupt handler, part 1
Date: Thu, 18 May 2023 11:30:44 +0200
Message-Id: <20230518093047.3697887-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6C4XK6LFYHJGLU7KGHQFFNODDTD6CGEX
X-Message-ID-Hash: 6C4XK6LFYHJGLU7KGHQFFNODDTD6CGEX
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6C4XK6LFYHJGLU7KGHQFFNODDTD6CGEX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

IPR_CHANNELNUMBERMASK cannot be non-zero when IPR_CHANNELLOOP is unset,
so join marking them as handled.
This logically reverts part of commit f453e20d8a0 ("ALSA update
0.9.3a"), which made the inverse change with no explanation.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/irq.c b/sound/pci/emu10k1/irq.c
index dfb44e5e69a7..0cb89bd8c16b 100644
--- a/sound/pci/emu10k1/irq.c
+++ b/sound/pci/emu10k1/irq.c
@@ -79,9 +79,8 @@ irqreturn_t snd_emu10k1_interrupt(int irq, void *dev_id)
 				val >>= 1;
 				pvoice++;
 			}
-			status &= ~IPR_CHANNELLOOP;
+			status &= ~(IPR_CHANNELLOOP | IPR_CHANNELNUMBERMASK);
 		}
-		status &= ~IPR_CHANNELNUMBERMASK;
 		if (status & (IPR_ADCBUFFULL|IPR_ADCBUFHALFFULL)) {
 			if (emu->capture_interrupt)
 				emu->capture_interrupt(emu, status);
-- 
2.40.0.152.g15d061e6df

