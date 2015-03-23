From: Sebastian Wicki <gandro@gmx.net>
Subject: [PATCH v2] ALSA: hda - Add dock support for Thinkpad
	T450s (17aa:5036)
Date: Mon, 23 Mar 2015 17:23:11 +0100
Message-ID: <1427127791-1245-1-git-send-email-gandro@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 499C5260421
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 17:23:26 +0100 (CET)
Received: from ThinkPad.ethz.ch ([195.176.111.10]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MJmcS-1YbB3x3ukO-0019gS for
 <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 17:23:26 +0100
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

This model uses the same dock port as the previous generation.

Signed-off-by: Sebastian Wicki <gandro@gmx.net>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eee4532..8775389 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4995,6 +4995,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x501e, "Thinkpad L440", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x5026, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x17aa, 0x5036, "Thinkpad T450s", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
-- 
2.3.3
