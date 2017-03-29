From: Eugene Ganeev <easymodofrf@gmail.com>
Subject: [PATCH] ALSA: oxygen - Fix snd_oxygen module not loading for some
 (new?) Xonar DG SI cards.
Date: Wed, 29 Mar 2017 22:13:11 +0100
Message-ID: <20170329211311.GA4751@unit02.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

My Xonar DG SI card is showing up in lspci but no module is loaded for
it.

The patch just adds a new value with card's PCI ID to oxygen_ids array.

Signed-off-by: Eugene Ganeev <easymodofrf@gmail.com>
---
 sound/pci/oxygen/oxygen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/oxygen/oxygen.c b/sound/pci/oxygen/oxygen.c
index ada6c256378e..99ba0354d4cc 100644
--- a/sound/pci/oxygen/oxygen.c
+++ b/sound/pci/oxygen/oxygen.c
@@ -110,6 +110,7 @@ static DEFINE_PCI_DEVICE_TABLE(oxygen_ids) = {
 	{ OXYGEN_PCI_SUBID(0x1a58, 0x0910), .driver_data = MODEL_CMEDIA_REF },
 	/* Asus Xonar DG */
 	{ OXYGEN_PCI_SUBID(0x1043, 0x8467), .driver_data = MODEL_XONAR_DG },
+	{ OXYGEN_PCI_SUBID(0x1043, 0x855e), .driver_data = MODEL_XONAR_DG },
 	/* Asus Xonar DGX */
 	{ OXYGEN_PCI_SUBID(0x1043, 0x8521), .driver_data = MODEL_XONAR_DGX },
 	/* PCI 2.0 HD Audio */
-- 
2.11.1
