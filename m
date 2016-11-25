From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/ca0132 - Add quirk for Alienware 15
	R2 2016
Date: Fri, 25 Nov 2016 14:18:30 +0100
Message-ID: <20161125131830.26999-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9865E2671FF
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2016 14:18:33 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 60C1DAB03
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2016 13:18:32 +0000 (UTC)
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

From: Sven Hahne <hahne@zeitkunst.eu>

I'm using an Alienware 15 R2 and had to use the alienware quirks to
get my headphone output working.

I fixed it by adding, SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2
2016", QUIRK_ALIENWARE) to the patch.

Signed-off-by: Sven Hahne <hahne@zeitkunst.eu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ad06866d7c69..11b9b2f17a2e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -780,6 +780,7 @@ static const struct hda_pintbl alienware_pincfgs[] = {
 static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0688, "Alienware 17 2015", QUIRK_ALIENWARE),
+	SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
 	{}
 };
 
-- 
2.10.2
