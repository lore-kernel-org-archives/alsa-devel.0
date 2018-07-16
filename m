From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Subject: [PATCH] ALSA: hda: add mute led support for HP ProBook
	455 G5
Date: Mon, 16 Jul 2018 15:50:08 +0800
Message-ID: <20180716075008.7272-1-po-hsu.lin@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9763E26720C
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 09:50:21 +0200 (CEST)
Received: from mail-pl0-f71.google.com ([209.85.160.71])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <po-hsu.lin@canonical.com>)
 id 1feyGy-000495-QI
 for alsa-devel@alsa-project.org; Mon, 16 Jul 2018 07:50:20 +0000
Received: by mail-pl0-f71.google.com with SMTP id e1-v6so24112192pld.23
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 00:50:20 -0700 (PDT)
Received: from Leggiero.taipei.internal ([175.41.48.77])
 by smtp.gmail.com with ESMTPSA id t186-v6sm20078628pgd.77.2018.07.16.00.50.17
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Jul 2018 00:50:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Audio mute led does not work on HP ProBook 455 G5,
this can be fixed by using CXT_FIXUP_MUTE_LED_GPIO to support it.

BugLink: https://bugs.launchpad.net/bugs/1781763
Reported-by: James Buren
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e7fcfc3..f641c20 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -964,6 +964,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x836e, "HP ProBook 455 G5", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8455, "HP Z2 G4", CXT_FIXUP_HP_MIC_NO_PRESENCE),
-- 
2.7.4
