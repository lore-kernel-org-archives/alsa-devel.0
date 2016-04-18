From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] ALSA: hda/realtek - Add ALC3234 headset mode
	for Optiplex 9020m
Date: Mon, 18 Apr 2016 11:10:42 +0200
Message-ID: <1460970642-18359-1-git-send-email-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slow1-d.mail.gandi.net (slow1-d.mail.gandi.net [217.70.178.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A378265019
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 11:15:23 +0200 (CEST)
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
Cc: Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.com>, David Henningsson <david.henningsson@canonical.com>, Bastien Nocera <hadess@hadess.net>
List-Id: alsa-devel@alsa-project.org

The Optiplex 9020m with Haswell-DT processor needs a quirk for the
headset jack at the front of the machine to be able to use microphones.

A quirk for this model was originally added in 3127899, but c77900e
removed it in favour of a more generic version.

Unfortunately, pin configurations can changed based on firmware/BIOS
versions, and the generic version doesn't have any effect on newer
versions of the machine/firmware anymore.

With help from David Henningsson <diwic@ubuntu.com>

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Tested-by: Bastien Nocera <hadess@hadess.net>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1402ba9..810bcee 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5449,6 +5449,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x064a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0665, "Dell XPS 13", ALC288_FIXUP_DELL_XPS_13),
+	SND_PCI_QUIRK(0x1028, 0x0669, "Dell Optiplex 9020m", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x069a, "Dell Vostro 5480", ALC290_FIXUP_SUBWOOFER_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x06c7, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x06d9, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
-- 
2.7.3
