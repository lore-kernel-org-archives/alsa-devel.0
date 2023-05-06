Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCF4C77B7D
	for <alsa-devel@archiver.kernel.org>; Sat,  6 May 2023 02:28:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C58952CD0;
	Sat,  6 May 2023 04:27:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C58952CD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683340125;
	bh=RsMPKHSmhsPEWxMISqNT/zQWfaSLr9fA9Gp+69DSeL0=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=R7/EwPsyMqS/4TxEneGWPWFTg6TYxFQj2tJmeexdYivF79bqPDUDzv4FeL8Lvig2M
	 2p3n9krkap/+o5GDvUxfy4OVDuR2bL7Oi/216+zAt1XleAKB/fP8F99r3zZNzJTsC1
	 ++y6sywzX4c+UUCBEwS03KttWxS3UgKixKtHLXDY=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B393F8052D;
	Sat,  6 May 2023 04:27:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9085AF8052D; Sat,  6 May 2023 04:27:23 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21A6CF80114
	for <alsa-devel@alsa-project.org>; Sat,  6 May 2023 04:27:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21A6CF80114
X-UUID: 1b0396f14be747d7ab10c651639d7cbc-20230506
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_HamU
X-CID-O-INFO: VERSION:1.1.22,REQID:598fa335-b95e-4456-8747-c87e07d1ef21,IP:5,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:8
X-CID-INFO: VERSION:1.1.22,REQID:598fa335-b95e-4456-8747-c87e07d1ef21,IP:5,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
	release,TS:8
X-CID-META: VersionHash:120426c,CLOUDID:39cbe730-6935-4eab-a959-f84f8da15543,B
	ulkID:230506102704XXE5XP8C,BulkQuantity:0,Recheck:0,SF:38|24|16|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 1b0396f14be747d7ab10c651639d7cbc-20230506
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1713182569; Sat, 06 May 2023 10:27:03 +0800
From: Ai Chao <aichao@kylinos.cn>
To: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	tcrawford@system76.com,
	andy.chi@canonical.com,
	tangmeng@uniontech.com,
	luke@ljones.dev,
	yangyuchi66@gmail.com,
	p.jungkamp@gmx.net,
	kasper93@gmail.com,
	gabriele.mzt@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Add a quirk for HP EliteDesk 805
Date: Sat,  6 May 2023 10:26:53 +0800
Message-Id: <20230506022653.2074343-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7HCFKIQ3BSHF6MJESYBVAZOFZ6MWOEWJ
X-Message-ID-Hash: 7HCFKIQ3BSHF6MJESYBVAZOFZ6MWOEWJ
X-MailFrom: aichao@kylinos.cn
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Ai Chao <aichao@kylinos.cn>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7HCFKIQ3BSHF6MJESYBVAZOFZ6MWOEWJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add a quirk for HP EliteDesk 805 to fixup ALC3867 headset MIC no sound.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 068ce0db9562..cbb3c3f6d502 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11662,6 +11662,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x870c, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
-- 
2.25.1

