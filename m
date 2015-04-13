From: Jo-Philipp Wich <jow@openwrt.org>
Subject: [PATCH] ALSA: hda/realtek - Enable the ALC292 dock
	fixup on the Thinkpad T450
Date: Mon, 13 Apr 2015 12:47:26 +0200
Message-ID: <1428922046-5087-1-git-send-email-jow@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout01.bytecamp.net (mxout01.bytecamp.net [212.204.60.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 7861C261ADE
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 12:45:10 +0200 (CEST)
Received: from mail.bytecamp.net (mailstore.bytecamp.net [212.204.60.20])
 by mxout01.bytecamp.net (Postfix) with ESMTP id E98CA30FD43
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 12:45:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Jo-Philipp Wich <jow@openwrt.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Lenovo Thinkpad T450 requires the ALC292_FIXUP_TPT440_DOCK as well in
order to get working sound output on the docking stations headphone jack.

Patch tested on a Thinkpad T450 (20BVCTO1WW) using kernel 4.0-rc7 in
conjunction with a ThinkPad Ultradock.

Signed-off-by: Jo-Philipp Wich <jow@openwrt.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f9d12c0..52aa8ae 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5053,6 +5053,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x501e, "Thinkpad L440", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x5026, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x17aa, 0x5034, "Thinkpad T450", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x5036, "Thinkpad T450s", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
-- 
1.7.10.4
