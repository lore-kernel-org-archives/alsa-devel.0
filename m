From: phiamo <phiamo@googlemail.com>
Subject: [PATCH] ALSA: hda - add dock support for Thinkpad T430s
Date: Mon,  6 Aug 2012 13:00:04 +0200
Message-ID: <1344250804-14022-1-git-send-email-phiamo@googlemail.com>
References: <s5h1ujkl2cv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 90C86265324
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 12:30:43 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so896498bkc.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 04:00:29 -0700 (PDT)
In-Reply-To: <s5h1ujkl2cv.wl%tiwai@suse.de>
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
Cc: tiwai@suse.de, phiamo <phiamo@googlemail.com>
List-Id: alsa-devel@alsa-project.org

    Based on commit 108cc108a3bb42fe4705df1317ff98e1e29428a6:

    Also add a model/fixup string "lenovo-dock", so that other Thinkpad
    users will be able to test this fixup easily, to see if it enables
    dock I/O for them as well.

    Tested on Lenovo T430s with ThinkPad Mini Dock Plus Series 3

    Cc: stable@kernel.org
    Signed-off-by: phiamo <phiamo@googlemail.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b9a5c45..bb93f92 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6207,6 +6207,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21ca, "Thinkpad L412", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21e9, "Thinkpad Edge 15", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21f6, "Thinkpad T530", ALC269_FIXUP_LENOVO_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x21fb, "Thinkpad T430s", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2203, "Thinkpad X230 Tablet", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_QUANTA_MUTE),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Lenovo Ideapd", ALC269_FIXUP_PCM_44K),
-- 
1.7.9.5
