From: Alexander Tsoy <alexander@tsoy.me>
Subject: [PATCH] ALSA: hda - apply STAC_9200_DELL_M22 quirk for
 Dell Latitude D430
Date: Mon, 22 May 2017 20:58:11 +0300
Message-ID: <E1dCukS-0001g6-FK@puleglot.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from puleglot.ru (puleglot.ru [78.47.112.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F37F267049
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 23:20:16 +0200 (CEST)
Received: from root by puleglot.ru with local (Exim 4.89)
 (envelope-from <e142ded13302aefcf827cffe2e38f41dea371937@puleglot.ru>)
 id 1dCukS-0001g6-FK
 for alsa-devel@alsa-project.org; Tue, 23 May 2017 00:20:16 +0300
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

This model is actually called 92XXM2-8 in Windows driver. But since pin
configs for M22 and M28 are identical, just reuse M22 quirk.

Fixes external microphone (tested) and probably docking station ports
(not tested).

Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
---
 sound/pci/hda/patch_sigmatel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index faa3d38bac0b..6cefdf6c0b75 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1559,6 +1559,8 @@ static const struct snd_pci_quirk stac9200_fixup_tbl[] = {
 		      "Dell Inspiron 1501", STAC_9200_DELL_M26),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01f6,
 		      "unknown Dell", STAC_9200_DELL_M26),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0201,
+		      "Dell Latitude D430", STAC_9200_DELL_M22),
 	/* Panasonic */
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-74", STAC_9200_PANASONIC),
 	/* Gateway machines needs EAPD to be set on resume */
-- 
2.13.0
