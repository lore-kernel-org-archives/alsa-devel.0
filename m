From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH] hda: realtek: Make dock sound work on ThinkPad
	L570
Date: Thu, 8 Mar 2018 13:17:54 +0100
Message-ID: <46c65214-2a41-77ce-6484-979b08fc44c1@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 6987C26742B
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 13:21:41 +0100 (CET)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hui Wang <hui.wang@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

One version of Lenovo Thinkpad T570 did not use ALC298
(like other Kaby Lake devices). Instead it uses ALC292.
In order to make the Lenovo dock working with that codec
the dock quirk for ALC292 will be used.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b9c93fa..b5d0f8c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6508,6 +6508,7 @@ enum {
 	SND_PCI_QUIRK(0x17aa, 0x2245, "Thinkpad T470", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2246, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2247, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2249, "Thinkpad", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
-- 
1.9.1
