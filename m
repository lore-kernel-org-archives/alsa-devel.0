From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix missing fixup for Mac Mini
	with STAC9221
Date: Fri,  2 Aug 2013 08:17:55 +0200
Message-ID: <1375424275-16408-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F29D9265628
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 08:16:21 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6D871A51BB
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 08:16:19 +0200 (CEST)
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

A fixup for Apple Mac Mini was lost during the adaption to the generic
parser because the fallback for the generic ID 8384:7680 was dropped,
and it resulted in the silence output (and maybe other problems).

Unfortunately, just adding the missing subsystem ID wasn't enough, in
this case.  The subsystem ID of this machine is 0000:0100 (what Apple
thought...?), and since snd_hda_pick_fixup() doesn't take the vendor
id zero into account, the driver ignored this entry.  Now it's fixed
to regard the vendor id zero as a valid value.

Reported-and-tested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <stable@vger.kernel.org> [v3.9+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 2 +-
 sound/pci/hda/patch_sigmatel.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 7c11d46..48a9d00 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -860,7 +860,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 		}
 	}
 	if (id < 0 && quirk) {
-		for (q = quirk; q->subvendor; q++) {
+		for (q = quirk; q->subvendor || q->subdevice; q++) {
 			unsigned int vendorid =
 				q->subdevice | (q->subvendor << 16);
 			unsigned int mask = 0xffff0000 | q->subdevice_mask;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 92b9b43..6d1924c 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2819,6 +2819,7 @@ static const struct hda_pintbl ecs202_pin_configs[] = {
 
 /* codec SSIDs for Intel Mac sharing the same PCI SSID 8384:7680 */
 static const struct snd_pci_quirk stac922x_intel_mac_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x0000, 0x0100, "Mac Mini", STAC_INTEL_MAC_V3),
 	SND_PCI_QUIRK(0x106b, 0x0800, "Mac", STAC_INTEL_MAC_V1),
 	SND_PCI_QUIRK(0x106b, 0x0600, "Mac", STAC_INTEL_MAC_V2),
 	SND_PCI_QUIRK(0x106b, 0x0700, "Mac", STAC_INTEL_MAC_V2),
-- 
1.8.3.1
