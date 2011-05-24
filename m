From: Tony Vroon <tony@linx.net>
Subject: [PATCH] Force AD1988_6STACK_DIG for Asus M3N-HT Deluxe
Date: Tue, 24 May 2011 22:16:15 +0100 (BST)
Message-ID: <20110524211615.D75B810076@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2355E103861
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 23:16:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Doug Redlich <pbrigade@nxltech.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The microphone input on the back panel (pink connector) 
stopped operating correctly after an upgrade from 
2.6.35 to 2.6.38; the actual problem manifests itself 
as a lack of microphone bias voltage (VREF_HIZ) on 
node 0x17.
With AD1988_6STACK_DIG the maximum bias voltage (VREF_80) 
is applied and the headset operates correctly.

Signed-off-by: Tony Vroon <tony@linx.net>
Tested-by: Doug Redlich <pbrigade@nxltech.net>

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index f1b3875..696ac25 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -3159,6 +3159,7 @@ static const struct snd_pci_quirk ad1988_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x81ec, "Asus P5B-DLX", AD1988_6STACK_DIG),
 	SND_PCI_QUIRK(0x1043, 0x81f6, "Asus M2N-SLI", AD1988_6STACK_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8277, "Asus P5K-E/WIFI-AP", AD1988_6STACK_DIG),
+	SND_PCI_QUIRK(0x1043, 0x82c0, "Asus M3N-HT Deluxe", AD1988_6STACK_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8311, "Asus P5Q-Premium/Pro", AD1988_6STACK_DIG),
 	{}
 };
