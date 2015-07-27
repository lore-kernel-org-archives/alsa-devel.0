From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Apply fixup for another Toshiba
	Satellite S50D
Date: Mon, 27 Jul 2015 10:19:20 +0200
Message-ID: <1437985160-19232-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B431261A03
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:19:23 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 45700AAC2
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 08:19:23 +0000 (UTC)
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

Toshiba Satellite S50D has another model with a different PCI SSID
(1179:fa93) while the previous fixup was for 1179:fa91.  Adjust the
fixup entry with SND_PCI_QUIRK_MASK() to match with both devices.

Reported-by: Tim Sample <timsample@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index dcc7fe91244c..9d947aef2c8b 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2920,7 +2920,8 @@ static const struct snd_pci_quirk stac92hd83xxx_fixup_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x148a,
 		      "HP Mini", STAC_92HD83XXX_HP_LED),
 	SND_PCI_QUIRK_VENDOR(PCI_VENDOR_ID_HP, "HP", STAC_92HD83XXX_HP),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_TOSHIBA, 0xfa91,
+	/* match both for 0xfa91 and 0xfa93 */
+	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_TOSHIBA, 0xfffd, 0xfa91,
 		      "Toshiba Satellite S50D", STAC_92HD83XXX_GPIO10_EAPD),
 	{} /* terminator */
 };
-- 
2.4.6
