From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] ALSA: hda/realtek: Enable internal speaker of
 ASUS UX362FA with ALC294
Date: Sat, 27 Apr 2019 19:54:41 +0200
Message-ID: <20190427175441.GA21587@lenoch>
References: <CAAqJ6B_FQK=nPHsxwOq4c0YsoBrxaX7gD0QC0L1T0cUVwcAmTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa1.perex.cz (Postfix) with ESMTP id 88667F897B6
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2019 19:54:44 +0200 (CEST)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23991216AbfD0Rymfm5J6 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Sat, 27 Apr 2019 19:54:42 +0200
Content-Disposition: inline
In-Reply-To: <CAAqJ6B_FQK=nPHsxwOq4c0YsoBrxaX7gD0QC0L1T0cUVwcAmTw@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Petr Nosek <petr.nosek@gmail.com>
List-Id: alsa-devel@alsa-project.org

The ASUS UX362FA with ALC294 cannot detect the outputs through the
internal speaker until ALC294_FIXUP_ASUS_SPK quirk applied.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=203443
Suggested-by: Petr Nosek <petr.nosek@gmail.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Hi Petr,

 I tried to verify information in your patch, but all links you provided
 are unpleasant to read and you also didn't provide bootlog, so I had to
 trust you that your machine comes with ALC294...
 Also, does it fix internal speaker only or also headphones? We need to
 get commit log right. Once verified, let's send v2 of this patch with
 your Tested-by tag and posibly Cc: stable. Thank you.

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 070749b50eff..490b42e3e3dc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6896,6 +6896,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x13e1, "ASUS UX362FA", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
-- 
2.20.1
