Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C07AC43334
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jul 2022 09:42:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA38216EB;
	Wed, 13 Jul 2022 11:42:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA38216EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657705371;
	bh=dp7PT8QeWF+U3Ua51Mk1XEOFiQ+4I1YVVNVLDgggZw4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sku/WbKXebL3N1C2gnWqJCb8aRMKPbl5D82j6Cw/L8rfyl5gSyrTE6Ll34Q9IL2+t
	 RTff3BNmrpDYkz92mCyWHxMy+by7altIsdN5UAicrx2dpuYmy3Grb1OC4wnzfrQrRl
	 tyF+AOGHGfqEXj1ZVLAex7FEA2FISUnnNzmZrB1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 520BAF8019B;
	Wed, 13 Jul 2022 11:42:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62D21F80249; Wed, 13 Jul 2022 11:42:00 +0200 (CEST)
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95325F8012B
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2022 11:41:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95325F8012B
X-QQ-mid: bizesmtp76t1657705300tjyq9kr6
Received: from localhost.localdomain ( [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 13 Jul 2022 17:41:34 +0800 (CST)
X-QQ-SSF: 01400000002000G0T000B00A0000000
X-QQ-FEAT: RrZlkntZBflHKmwQ9JnxJ+0cUviccNuWWA2UCoNooBspxFz4wUMc0pcX4AdHT
 7YBsLwZGo4x5aWl0oRiIAvFVTQ7WM1G4COQdMIun/coCnkREpN+wMCUStoC1E8D00W6qyUB
 JF/ztQnqKdA/J+q33vAW5dJMFd0yfkm/srBtoJFsUioC4nCikVPb/oA6V/CFA3AmgDUW64k
 7Pg69+3h5LPFPF6OjUqUial/RmELNkiR7lBFeQvk6ZlpH5kpSjYWbyv+xbHUAVsf9xGmyLE
 zd7EzsXL73HLyP2pxzFB/jkypmGOuG2GLJuARb312khRkLG+Dp4cbwejS2Hul3GFUNEpl3+
 ZWWYSY8l8BrZSD80Zd0fyLHKMi/d/J2xCqAamWXQu9oGWBtTrSv82qBP0Aq4kh3gxryHVAo
 3WGh0zz0TEx6U6R6i5v2bg==
X-QQ-GoodBg: 2
From: Meng Tang <tangmeng@uniontech.com>
To: perex@perex.cz, tiwai@suse.com, tcrawford@system76.com,
 wse@tuxedocomputers.com, kai.heng.feng@canonical.com,
 tangmeng@uniontech.com, tanureal@opensource.cirrus.com, cam@neo-zeon.de,
 kailang@realtek.com, sbinding@opensource.cirrus.com, yong.wu@mediatek.com,
 andy.chi@canonical.com
Subject: [PATCH] ALSA: hda/realtek - Enable the headset-mic on a Xiaomi's
 laptop
Date: Wed, 13 Jul 2022 17:41:33 +0800
Message-Id: <20220713094133.9894-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

The headset on this machine is not defined, after applying the quirk
ALC256_FIXUP_ASUS_HEADSET_MIC, the headset-mic works well

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 91cd58849ee8..383a814b8539 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9369,6 +9369,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
-- 
2.20.1



