Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149CAC54EE9
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Sep 2022 05:47:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6EA81694;
	Tue, 13 Sep 2022 07:46:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6EA81694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663048055;
	bh=PYqxCnNkewmZbctv9XV8Fnz7whlaTkBXFJWFK6Z4C44=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DbJWXYqEXAjqoeFyH8RI9Ugq+ohPdDJJZNAU/yy9HevwQ8ywSq5QwzMnh/rLTPZX6
	 mWvjhHItR57wkKQLVrCPD5TXcYYc0ZJ9ficDX2/FLCNpuq5clu4TYYVqCo6mKk7Fad
	 R8ikvp84UFW740h+FHxfPlaVDIIbAhpjPuTTHM1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2709BF800FE;
	Tue, 13 Sep 2022 07:46:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D494F80224; Tue, 13 Sep 2022 07:46:43 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3519FF800FE
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2022 07:46:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3519FF800FE
X-QQ-mid: bizesmtp74t1663047985tcen11ia
Received: from localhost.localdomain ( [113.57.152.160])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 13 Sep 2022 13:46:24 +0800 (CST)
X-QQ-SSF: 01400000000000B0O000000A0000000
X-QQ-FEAT: o819FCS+0JRTPs05EElOJLI/CrQekINZ5/Hjm1KQ/EL6h5TQThaZsY6LFGoUt
 +qv3N3nacqJCsisTE6OSwfshzRwU53qT0P1RiljUvtZBZrFao8IhgJhIjPAe7VRONr3BlwO
 APiBRYPU7Lz4hSvWnQAHGEAxdfIWdCGUTb5BgtVGJYYoCRZ2oUt58IfwYIS0VR/jEsGPnj5
 xAhVoiZyk2RuoF4eEH6X2lreVCxVbeIMb4x2RLQU20noRep/C4v4TH9Uw8hf6asFOjXWy/6
 +UPmNfBY+rVMKTHsdLY0DmeKwxTnSLKYzIsS2wA2zXP+n+jgHX+aehWsl0PMjbXokd3ir3Z
 3vPBKF/axenJ79CRD+4P9UwR5c1AlEwRPhg4RTibm0ycrOM6gucSdPOJAWt0jaWA8e0QKV/
X-QQ-GoodBg: 1
From: huangwenhui <huangwenhuia@uniontech.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Huawei WRT-WX9
Date: Tue, 13 Sep 2022 13:46:22 +0800
Message-Id: <20220913054622.15979-1-huangwenhuia@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
Cc: alsa-devel@alsa-project.org, kailang@realtek.com,
 tanureal@opensource.cirrus.com, jeremy.szu@canonical.com,
 linux-kernel@vger.kernel.org, wse@tuxedocomputers.com,
 huangwenhui <huangwenhuia@uniontech.com>, hui.wang@canonical.com,
 sami@loone.fi, cam@neo-zeon.de
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

Fixes headphone and headset microphone detection on Huawei WRT-WX9.

Signed-off-by: huangwenhui <huangwenhuia@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 38930cf5aace..0996a8fd008c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9569,6 +9569,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1849, 0x1233, "ASRock NUC Box 1100", ALC233_FIXUP_NO_AUDIO_JACK),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
+	SND_PCI_QUIRK(0x19e5, 0x320f, "Huawei WRT-WX9 ", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1b35, 0x1235, "CZC B20", ALC269_FIXUP_CZC_B20),
 	SND_PCI_QUIRK(0x1b35, 0x1236, "CZC TMI", ALC269_FIXUP_CZC_TMI),
 	SND_PCI_QUIRK(0x1b35, 0x1237, "CZC L101", ALC269_FIXUP_CZC_L101),
-- 
2.20.1

