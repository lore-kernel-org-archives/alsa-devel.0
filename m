Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8771BC6FD18
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Apr 2023 16:13:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EE27EE0;
	Sat, 22 Apr 2023 18:12:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EE27EE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682180004;
	bh=1AvZOBsu1Pw+Hzh8UIW0IgYQ9o5pCAYpygVet0KWHig=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DeEDfnEcPQRApWmWG8m72P+gejkhJQ3Hs+XKCJrsLpvGrONH8369t7Dq5gf0toQLn
	 Y43+KDuEuxBSuVBQ80Ee/tFLO8B+umifqSVaSP6MQdM4TgrByNTiog9guwBgtSx/nZ
	 adA0J7bkXXZcOjRw5TAvnI9eiV2jEuM1zvhv/iHk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10FE6F80570;
	Sat, 22 Apr 2023 18:10:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FD06F80570; Sat, 22 Apr 2023 18:10:50 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F0E44F8052D
	for <alsa-devel@alsa-project.org>; Sat, 22 Apr 2023 18:10:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0E44F8052D
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B223E24228;
	Sat, 22 Apr 2023 12:10:21 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pqFob-nbL-00; Sat, 22 Apr 2023 18:10:21 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: emu10k1: use high-level I/O in set_filterQ()
Date: Sat, 22 Apr 2023 18:10:21 +0200
Message-Id: <20230422161021.1143967-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230422161021.1143967-1-oswald.buddenhagen@gmx.de>
References: <20230422161021.1143967-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NNRS4CUXT5BECCCUSRE45XDLIIMRKPHX
X-Message-ID-Hash: NNRS4CUXT5BECCCUSRE45XDLIIMRKPHX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NNRS4CUXT5BECCCUSRE45XDLIIMRKPHX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 include/sound/emu10k1.h              | 3 ++-
 sound/pci/emu10k1/emu10k1_callback.c | 5 +----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 05a09826eef0..8fe80dcee71b 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -429,7 +429,8 @@
 #define DSL_LOOPENDADDR		0x18000007
 
 #define CCCA			0x08		/* Filter Q, interp. ROM, byte size, cur. addr register */
-#define CCCA_RESONANCE		0xf0000000	/* Lowpass filter resonance (Q) height			*/
+#define CCCA_RESONANCE_MASK	0xf0000000	/* Lowpass filter resonance (Q) height			*/
+#define CCCA_RESONANCE		0x041c0008
 #define CCCA_INTERPROM_MASK	0x0e000000	/* Selects passband of interpolation ROM		*/
 						/* 1 == full band, 7 == lowpass				*/
 						/* ROM 0 is used when pitch shifting downward or less	*/
diff --git a/sound/pci/emu10k1/emu10k1_callback.c b/sound/pci/emu10k1/emu10k1_callback.c
index 44f2a61c6be8..9455df18f7b2 100644
--- a/sound/pci/emu10k1/emu10k1_callback.c
+++ b/sound/pci/emu10k1/emu10k1_callback.c
@@ -532,8 +532,5 @@ set_fm2frq2(struct snd_emu10k1 *hw, struct snd_emux_voice *vp)
 static void
 set_filterQ(struct snd_emu10k1 *hw, struct snd_emux_voice *vp)
 {
-	unsigned int val;
-	val = snd_emu10k1_ptr_read(hw, CCCA, vp->ch) & ~CCCA_RESONANCE;
-	val |= (vp->reg.parm.filterQ << 28);
-	snd_emu10k1_ptr_write(hw, CCCA, vp->ch, val);
+	snd_emu10k1_ptr_write(hw, CCCA_RESONANCE, vp->ch, vp->reg.parm.filterQ);
 }
-- 
2.40.0.152.g15d061e6df

