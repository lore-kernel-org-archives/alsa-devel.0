Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72799C7EE22
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 16:31:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34B89107F;
	Wed, 10 May 2023 18:30:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34B89107F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683736286;
	bh=5Hp+6f5juogVnMNXKRg9wSHPtKKbRdab2j0U//lcrKI=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TKjkL/ECdNDyUYM5/UdjwdrZgstQQrArllP89emvpR69IuGDUQUSEDjcK+e3xbbEW
	 3KCZhQL4BmQNS2ks9XheCty8ZAVDs1vijS40edBn5/Sk3SOtEwFysAcmzWsuSBNiuQ
	 Tts8TNGwqOK7vAKAdDCbnUzYyyypwO/tTPhVPqd8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A7EDF80544;
	Wed, 10 May 2023 18:29:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CD15F80544; Wed, 10 May 2023 18:29:49 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D465CF8032D
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2023 18:29:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D465CF8032D
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 40BDB2423B;
	Wed, 10 May 2023 12:29:36 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pwmh5-r3U-00; Wed, 10 May 2023 18:29:35 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ALSA: emu10k1: optimize mask calculation in
 snd_emu10k1_ptr_read()
Date: Wed, 10 May 2023 18:29:35 +0200
Message-Id: <20230510162935.3063854-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230510162935.3063854-1-oswald.buddenhagen@gmx.de>
References: <20230510162935.3063854-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LVYTTUGJWDFA7KKSI4UTIXO6QGME5ATE
X-Message-ID-Hash: LVYTTUGJWDFA7KKSI4UTIXO6QGME5ATE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LVYTTUGJWDFA7KKSI4UTIXO6QGME5ATE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Unlike in snd_emu10k1_ptr_write(), we don't need to keep the value's
bits in place, so we can save one shift.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/io.c b/sound/pci/emu10k1/io.c
index 2d6bbb77c961..59b0f4d08c6b 100644
--- a/sound/pci/emu10k1/io.c
+++ b/sound/pci/emu10k1/io.c
@@ -50,9 +50,9 @@ unsigned int snd_emu10k1_ptr_read(struct snd_emu10k1 * emu, unsigned int reg, un
 		
 		size = (reg >> 24) & 0x3f;
 		offset = (reg >> 16) & 0x1f;
-		mask = ((1 << size) - 1) << offset;
+		mask = (1 << size) - 1;
 		
-		return (val & mask) >> offset;
+		return (val >> offset) & mask;
 	} else {
 		return val;
 	}
-- 
2.40.0.152.g15d061e6df

