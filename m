From: Brian Lindholm <brian_lindholm@users.sourceforge.net>
Subject: PATCH:  Fix snd-hda-intel boot hang on ASUS A8N-VM
Date: Tue, 16 Mar 2010 19:17:52 -0400
Message-ID: <4BA011A0.5020302@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes a regression in 2.6.33.x.  Was working in 2.6.32.x.

   Symptom:  Hang on boot at "HDA Intel".  Boots only if on-board sound 
is disabled or if "snd-hda-intel.enable_msi=0" is appended to boot 
parameters.

   Machine:  ASUS A8N-VM with Athlon-X2 processor.

   Relevant output from lspci -nn:

00:10.1 Audio device [0403]: nVidia Corporation MCP51 High Definition 
Audio [10de:026c] (rev a2)

   Relevant output from alsa-info.sh:

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio 
(rev a2)
00:10.1 0403: 10de:026c (rev a2)
         Subsystem: 10de:cb84

   Proposed patch (which has been confirmed to allow boot, with sound 
active):

diff -dru linux-2.6.33-orig/sound/pci/hda/hda_intel.c 
linux-2.6.33/sound/pci/hda/hda_intel.c
--- linux-2.6.33-orig/sound/pci/hda/hda_intel.c        2010-03-16 
17:33:23.487938000 -0400
+++ linux-2.6.33/sound/pci/hda/hda_intel.c      2010-03-16 
17:40:36.141225010 -0400
@@ -2354,6 +2354,7 @@ static void __devinit check_probe_mask(s
  static struct snd_pci_quirk msi_black_list[] __devinitdata = {
         SND_PCI_QUIRK(0x1043, 0x81f2, "ASUS", 0), /* Athlon64 X2 + 
nvidia */
         SND_PCI_QUIRK(0x1043, 0x81f6, "ASUS", 0), /* nvidia */
+       SND_PCI_QUIRK(0x10de, 0xcb84, "ASUS", 0), /* nvidia */
         {}
  };

Signed-off-by: Brian E Lindholm <brian_lindholm@users.sourceforge.net>
