Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1199AC77B7A
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 09:24:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF2FF7F8;
	Thu, 18 May 2023 11:23:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF2FF7F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684401867;
	bh=LjcWJCnaCbex+xOe1twsVi+rEomVpUVgKeJfh57U1dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jazKT8eOH7TM79WSBX4Ckpv4m5Ag/Y29Wed28l8bIYKv467GmlYuSRYZlryZaKNUt
	 qxXAp0gLDTHJezJnE9t1VTQmHV/EWa/X5SfPmkJYQMR2CfUtKFiHV6gYSXn4oSW9F3
	 rHk38s76bP3PuaF23ApSmYa8b+fmQUd5Ycet8cho=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 965F2F80587; Thu, 18 May 2023 11:22:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B382F80570;
	Thu, 18 May 2023 11:22:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5C8FF8053D; Thu, 18 May 2023 11:22:35 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F0AD2F802E8
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 11:22:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0AD2F802E8
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 8319B241CA;
	Thu, 18 May 2023 05:22:24 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzZq4-Vkp-00; Thu, 18 May 2023 11:22:24 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v2 3/9] ALSA: emu10k1: remove pointless displacement of the
 extra voices
Date: Thu, 18 May 2023 11:22:18 +0200
Message-Id: <20230518092224.3696958-3-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230518092224.3696958-1-oswald.buddenhagen@gmx.de>
References: <20230518092224.3696958-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KRYV3P7XJZPR43DOEXNX3SRYIZYU6FOZ
X-Message-ID-Hash: KRYV3P7XJZPR43DOEXNX3SRYIZYU6FOZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KRYV3P7XJZPR43DOEXNX3SRYIZYU6FOZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The idea is to make the extra voice lag behind the "real" voices, but
moving the buffer address around doesn't contribute to that, as the CCCA
write below uses the same address. The exact address is unimportant, as
the data is discarded anyway.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emupcm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 27977d03e323..16e7d0ff97a4 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -288,10 +288,6 @@ static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1 *emu,
 	
 	if (master) {
 		evoice->epcm->ccca_start_addr = start_addr + ccis;
-		if (extra) {
-			start_addr += ccis;
-			end_addr += ccis;
-		}
 	}
 	if (stereo && !extra) {
 		// Not really necessary for the slave, but it doesn't hurt
-- 
2.40.0.152.g15d061e6df

