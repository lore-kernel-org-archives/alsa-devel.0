From: Catalin Iacob <iacobcatalin@gmail.com>
Subject: [PATCH] ALSA: hda_intel: add position_fix quirk for
	Asus K53E
Date: Sun,  9 Sep 2012 21:41:11 +0000
Message-ID: <1347226871-2552-1-git-send-email-iacobcatalin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 34234264EF9
 for <alsa-devel@alsa-project.org>; Sun,  9 Sep 2012 23:42:02 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so986014wgb.20
 for <alsa-devel@alsa-project.org>; Sun, 09 Sep 2012 14:42:01 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Seth Heasley <seth.heasley@intel.com>, Catalin Iacob <iacobcatalin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit c20c5a841cbe47f5b7812b57bd25397497e5fbc0 changed some chipsets to
default to POS_FIX_COMBO so they now use POS_FIX_LPIB instead of
POS_FIX_POSBUF. Since then I've been getting artifacts on playback, including
repeated sounds on my Asus laptop.

My hardware is Cougar Point which the commit log of
c20c5a841cbe47f5b7812b57bd25397497e5fbc0 mentions as tested so POS_FIX_COMBO
probably works in general but apparently it doesn't on Asus K53E therefore the
need for the quirk.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 sound/pci/hda/hda_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 60882c6..228cdf9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2701,6 +2701,7 @@ static struct snd_pci_quirk position_fix_list[] __devinitdata = {
 	SND_PCI_QUIRK(0x1043, 0x813d, "ASUS P5AD2", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1043, 0x81b3, "ASUS", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS M2V", POS_FIX_LPIB),
+	SND_PCI_QUIRK(0x1043, 0x1b43, "ASUS K53E", POS_FIX_POSBUF),
 	SND_PCI_QUIRK(0x104d, 0x9069, "Sony VPCS11V9E", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x10de, 0xcb89, "Macbook Pro 7,1", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1297, 0x3166, "Shuttle", POS_FIX_LPIB),
-- 
1.7.11.5
