Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AF8C6FD18
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Apr 2023 16:14:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FBFFF0D;
	Sat, 22 Apr 2023 18:13:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FBFFF0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682180040;
	bh=15GeZF22skHWEeX26gmx0F5tPhVo4KeH0O20AD3wDvA=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pwCgGvPnxCWRq0QjA2RWwTppHxfxQyFSl1rQS9MDspkkCk1mo5XHguJf2K/zZlR9G
	 x9a6rsZ7xesJB3IUZjLVSWIG4jdNsJNU2x6XcP+K/Zc9MrUpp0qFg5Y7Qbfd8gNv4u
	 Q4iyj4bVniYDdIc2B518HqKCHLYWsfNQiox8oLjA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EF71F8059F;
	Sat, 22 Apr 2023 18:11:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 466B0F8057A; Sat, 22 Apr 2023 18:10:58 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0C58DF8052E
	for <alsa-devel@alsa-project.org>; Sat, 22 Apr 2023 18:10:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C58DF8052E
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id EC2982422C;
	Sat, 22 Apr 2023 12:10:21 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pqFob-nbq-00; Sat, 22 Apr 2023 18:10:21 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: emu10k1: fix SNDRV_EMU10K1_IOCTL_SINGLE_STEP
Date: Sat, 22 Apr 2023 18:10:20 +0200
Message-Id: <20230422161021.1144004-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TWCLA3K7QMRP3VVUGLBQV3BGZJOOO5M2
X-Message-ID-Hash: TWCLA3K7QMRP3VVUGLBQV3BGZJOOO5M2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TWCLA3K7QMRP3VVUGLBQV3BGZJOOO5M2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

- Use correct address limit for Audigy
- Use the right constant to actually make a step on Audigy
- Don't store *_DBG_STEP and the address in emu->fx8010.dbg, as
  otherwise unrelated operations would make steps, too

This is untested. as10k1 was never ported to Audigy anyway.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emufx.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 6a51aed59238..70ec2cb9efe8 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -2646,17 +2646,19 @@ static int snd_emu10k1_fx8010_ioctl(struct snd_hwdep * hw, struct file *file, un
 			return -EPERM;
 		if (get_user(addr, (unsigned int __user *)argp))
 			return -EFAULT;
-		if (addr > 0x1ff)
-			return -EINVAL;
-		if (emu->audigy)
-			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg |= A_DBG_SINGLE_STEP | addr);
-		else
-			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg |= EMU10K1_DBG_SINGLE_STEP | addr);
-		udelay(10);
-		if (emu->audigy)
-			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg |= A_DBG_SINGLE_STEP | A_DBG_STEP_ADDR | addr);
-		else
-			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg |= EMU10K1_DBG_SINGLE_STEP | EMU10K1_DBG_STEP | addr);
+		if (emu->audigy) {
+			if (addr > A_DBG_STEP_ADDR)
+				return -EINVAL;
+			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg |= A_DBG_SINGLE_STEP);
+			udelay(10);
+			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg | A_DBG_STEP | addr);
+		} else {
+			if (addr > EMU10K1_DBG_SINGLE_STEP_ADDR)
+				return -EINVAL;
+			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg |= EMU10K1_DBG_SINGLE_STEP);
+			udelay(10);
+			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg | EMU10K1_DBG_STEP | addr);
+		}
 		return 0;
 	case SNDRV_EMU10K1_IOCTL_DBG_READ:
 		if (emu->audigy)
-- 
2.40.0.152.g15d061e6df

