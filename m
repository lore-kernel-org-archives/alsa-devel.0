Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256E2C7EE2D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 14:12:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 036AF852;
	Thu, 18 May 2023 16:11:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 036AF852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684419167;
	bh=EXCiVDg6DUvUXbxBS2iEv1dh72i9ZFkXftYNuSg4ofM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=q0PCgcq19iD91yteOoSh6pv/8vdWK9DGj0kZ/cHigHCDMvOCHpqQyljJgNLRtNlE/
	 uUPJzxbzf6EqyEWYtJrqBteaLsOCTdAEMHXUk66gNtrFycNYul/oZ4ddiVGdbraNBF
	 XoqmUTLBScbuaPdedD/xl0depRbNKnQFkXSWJduk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66328F805C8; Thu, 18 May 2023 16:10:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E340DF805C4;
	Thu, 18 May 2023 16:10:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 015B4F80272; Thu, 18 May 2023 16:10:00 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0FE15F80431
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 16:09:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FE15F80431
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 7B54923E9C;
	Thu, 18 May 2023 10:09:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzeKB-d9M-00; Thu, 18 May 2023 16:09:47 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 1/7] ALSA: emu10k1: simplify freeing synth voices
Date: Thu, 18 May 2023 16:09:41 +0200
Message-Id: <20230518140947.3725394-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230518140947.3725394-1-oswald.buddenhagen@gmx.de>
References: <20230518140947.3725394-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BTYYF777N57S7JQTLYNDNSESERPSHCZX
X-Message-ID-Hash: BTYYF777N57S7JQTLYNDNSESERPSHCZX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BTYYF777N57S7JQTLYNDNSESERPSHCZX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_emu10k1_voice_free() resets the hardware itself, so doing that
in the calling function as well is redundant.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emu10k1_callback.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_callback.c b/sound/pci/emu10k1/emu10k1_callback.c
index 06440b97b5d7..4a8b2df06a28 100644
--- a/sound/pci/emu10k1/emu10k1_callback.c
+++ b/sound/pci/emu10k1/emu10k1_callback.c
@@ -160,11 +160,6 @@ free_voice(struct snd_emux_voice *vp)
 	/* Problem apparent on plug, unplug then plug */
 	/* on the Audigy 2 ZS Notebook. */
 	if (hw && (vp->ch >= 0)) {
-		snd_emu10k1_ptr_write(hw, IFATN, vp->ch, 0xff00);
-		snd_emu10k1_ptr_write(hw, DCYSUSV, vp->ch, 0x807f | DCYSUSV_CHANNELENABLE_MASK);
-		// snd_emu10k1_ptr_write(hw, DCYSUSV, vp->ch, 0);
-		snd_emu10k1_ptr_write(hw, VTFT, vp->ch, 0xffff);
-		snd_emu10k1_ptr_write(hw, CVCF, vp->ch, 0xffff);
 		snd_emu10k1_voice_free(hw, &hw->voices[vp->ch]);
 		vp->emu->num_voices--;
 		vp->ch = -1;
-- 
2.40.0.152.g15d061e6df

