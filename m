From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: lx6464es: Fix duplicated SSID entries
Date: Tue, 26 May 2015 14:41:49 +0200
Message-ID: <1432644112-16543-3-git-send-email-tiwai@suse.de>
References: <1432644112-16543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 034752619F0
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 14:41:54 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BC7FBAD21
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:41:53 +0000 (UTC)
In-Reply-To: <1432644112-16543-1-git-send-email-tiwai@suse.de>
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

PCI_DEVICE() macro itself defines SSID entries while we override them
after that.  Replace with a more appropriate macro, PCI_DEVICE_SUB()
to define all ID values properly.

Spotted by sparse:
  sound/pci/lx6464es/lx6464es.c:60:11: warning: Initializer entry defined twice
  sound/pci/lx6464es/lx6464es.c:61:12:   also defined here
  sound/pci/lx6464es/lx6464es.c:64:11: warning: Initializer entry defined twice
  sound/pci/lx6464es/lx6464es.c:65:12:   also defined here

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/lx6464es/lx6464es.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 32c6f6ba1442..611b9a88784e 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -57,13 +57,13 @@ static const char card_name[] = "LX6464ES";
 #define PCI_DEVICE_ID_PLX_LX6464ES		PCI_DEVICE_ID_PLX_9056
 
 static const struct pci_device_id snd_lx6464es_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_LX6464ES),
-	  .subvendor = PCI_VENDOR_ID_DIGIGRAM,
-	  .subdevice = PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_SERIAL_SUBSYSTEM
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_LX6464ES,
+			 PCI_VENDOR_ID_DIGIGRAM,
+			 PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_SERIAL_SUBSYSTEM),
 	},			/* LX6464ES */
-	{ PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_LX6464ES),
-	  .subvendor = PCI_VENDOR_ID_DIGIGRAM,
-	  .subdevice = PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_CAE_SERIAL_SUBSYSTEM
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_LX6464ES,
+			 PCI_VENDOR_ID_DIGIGRAM,
+			 PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_CAE_SERIAL_SUBSYSTEM),
 	},			/* LX6464ES-CAE */
 	{ 0, },
 };
-- 
2.4.1
