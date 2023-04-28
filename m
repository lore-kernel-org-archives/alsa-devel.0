Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817A0C77B60
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Apr 2023 10:02:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 523D8129F;
	Fri, 28 Apr 2023 12:01:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 523D8129F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682676123;
	bh=fFO5kH5ADL6Y6FzV9/mn+Q0e4H7P8xxXrtmBpg+PyT8=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hfSFiJzDxggrMFF8KL8YzBiRfG1bacaLPkcPOiVEyHvx79AhJh112n8ZdRcmo70ba
	 Pestp4e4H/pcxUqFse9TrjhYU9eeaaSpGVLQapQL0tYoKD4NhOmNBdEeBZVoNzYvs4
	 teFOHXo2LSO4vkOOMuMea9z6ar2fyByEbvnLylno=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B87B5F80551;
	Fri, 28 Apr 2023 12:00:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C016EF80544; Fri, 28 Apr 2023 12:00:12 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 37641F8049E
	for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2023 11:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37641F8049E
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id C3F8A24211;
	Fri, 28 Apr 2023 05:59:41 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1psKtB-9sx-00; Fri, 28 Apr 2023 11:59:41 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/6] ALSA: emu10k1: remove pointless locks from timer code
Date: Fri, 28 Apr 2023 11:59:36 +0200
Message-Id: <20230428095941.1706278-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230428095941.1706278-1-oswald.buddenhagen@gmx.de>
References: <20230428095941.1706278-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MVVLQVEIJQUTVBYOYVZMZUIQ3OXUHSZ7
X-Message-ID-Hash: MVVLQVEIJQUTVBYOYVZMZUIQ3OXUHSZ7
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.de>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MVVLQVEIJQUTVBYOYVZMZUIQ3OXUHSZ7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Contrary to its name, reg_lock locks the emu data structure, not the
registers. As the functions access only data which is set once at card
initialization, there is no point in locking it.

Actually locking the registers would be pointless as well, as
snd_emu10k1_intr_{en,dis}able() does its own locking, and TIMER is
accessed only in this one place.

Locking snd_emu10k1_timer_{start,stop}() against each other also
wouldn't buy us anything; the functions interleaving their I/O accesses
wouldn't introduce new problems.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/timer.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/pci/emu10k1/timer.c b/sound/pci/emu10k1/timer.c
index 2435d3ba68f7..993663fef885 100644
--- a/sound/pci/emu10k1/timer.c
+++ b/sound/pci/emu10k1/timer.c
@@ -18,29 +18,23 @@
 static int snd_emu10k1_timer_start(struct snd_timer *timer)
 {
 	struct snd_emu10k1 *emu;
-	unsigned long flags;
 	unsigned int delay;
 
 	emu = snd_timer_chip(timer);
 	delay = timer->sticks - 1;
 	if (delay < 5 ) /* minimum time is 5 ticks */
 		delay = 5;
-	spin_lock_irqsave(&emu->reg_lock, flags);
 	snd_emu10k1_intr_enable(emu, INTE_INTERVALTIMERENB);
 	outw(delay & TIMER_RATE_MASK, emu->port + TIMER);
-	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return 0;
 }
 
 static int snd_emu10k1_timer_stop(struct snd_timer *timer)
 {
 	struct snd_emu10k1 *emu;
-	unsigned long flags;
 
 	emu = snd_timer_chip(timer);
-	spin_lock_irqsave(&emu->reg_lock, flags);
 	snd_emu10k1_intr_disable(emu, INTE_INTERVALTIMERENB);
-	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return 0;
 }
 
-- 
2.40.0.152.g15d061e6df

