From: Albert Pool <albertpool@solcon.nl>
Subject: [PATCH] snd-hda-intel: better Alienware M17x R3 quirk
Date: Thu, 19 Jan 2012 22:08:50 +0100
Message-ID: <1327007330.1980.0.camel@albert-ASUSTeK-P4P800SE>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I have been told that this way the rear headphone connector is
working as well; with model=alienware only laptop speakers work.
The subsystem of both controller and codec is 1028:0490.

Signed-off-by: Albert Pool <albertpool@solcon.nl>
---
 sound/pci/hda/patch_sigmatel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 87e684f..4071354 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1608,7 +1608,7 @@ static const struct snd_pci_quirk stac92hd73xx_codec_id_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x043a,
 		      "Alienware M17x", STAC_ALIENWARE_M17X),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0490,
-		      "Alienware M17x", STAC_ALIENWARE_M17X),
+		      "Alienware M17x R3", STAC_DELL_EQ),
 	{} /* terminator */
 };
 
-- 
1.7.4.1
