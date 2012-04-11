From: Albert Pool <albertpool@solcon.nl>
Subject: [PATCH] Fix for Asus A6Vm sound
Date: Wed, 11 Apr 2012 16:34:37 +0200
Message-ID: <4F85967D.4090902@solcon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I have been told that model=z71v is necessary for Asus A6Vm (1043:1173) sound to work.

Signed-off-by: Albert Pool<albertpool@solcon.nl>

---

  sound/pci/hda/alc880_quirks.c |    2 +-

  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/alc880_quirks.c b/sound/pci/hda/alc880_quirks.c

index 501501e..1b0358a 100644

--- a/sound/pci/hda/alc880_quirks.c

+++ b/sound/pci/hda/alc880_quirks.c

@@ -1375,7 +1375,7 @@ static const struct snd_pci_quirk alc880_cfg_tbl[] = {

      SND_PCI_QUIRK(0x1043, 0x10c3, "ASUS Wxx", ALC880_ASUS_DIG),

      SND_PCI_QUIRK(0x1043, 0x1113, "ASUS", ALC880_ASUS_DIG),

      SND_PCI_QUIRK(0x1043, 0x1123, "ASUS", ALC880_ASUS_DIG),

-    SND_PCI_QUIRK(0x1043, 0x1173, "ASUS", ALC880_ASUS_DIG),

+    SND_PCI_QUIRK(0x1043, 0x1173, "ASUS A6V", ALC880_Z71V),

      SND_PCI_QUIRK(0x1043, 0x1964, "ASUS Z71V", ALC880_Z71V),

      /* SND_PCI_QUIRK(0x1043, 0x1964, "ASUS", ALC880_ASUS_DIG), */

      SND_PCI_QUIRK(0x1043, 0x1973, "ASUS", ALC880_ASUS_DIG),

-- 

1.7.5.4
