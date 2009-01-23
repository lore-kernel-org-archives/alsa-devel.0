From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] atiixp: change parameter to macro define
Date: Thu, 22 Jan 2009 21:48:51 -0500
Message-ID: <49793013.30504@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 50FBD103804
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 03:49:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Change 0x15bd parameter to PCI_VENDOR_ID_DFI define.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 9ce8548..6baa6c4 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -297,7 +297,7 @@ static struct pci_device_id snd_atiixp_ids[] = {
 MODULE_DEVICE_TABLE(pci, snd_atiixp_ids);
 
 static struct snd_pci_quirk atiixp_quirks[] __devinitdata = {
-	SND_PCI_QUIRK(0x15bd, 0x3100, "DFI RS482", 0),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3100, "DFI RS482", 0),
 	{ } /* terminator */
 };
