From: Mads Kiilerich <mads@kiilerich.com>
Subject: Support for ALC662 on FUJITSU SIEMENS AMILO Li3710
Date: Sun, 26 Jul 2009 00:54:24 +0200
Message-ID: <4A6B8D20.6070601@kiilerich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knis.dk (smtp.knis.dk [213.150.52.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 06F6D248C3
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Jul 2009 00:54:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [77.75.167.238])
	by smtp.knis.dk (Postfix) with ESMTP id A5A772C29E2
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Jul 2009 00:54:24 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

On a friends FUJITSU SIEMENS AMILO Li3710 10601011427 sound didn't work 
with kernel-PAE-2.6.29.6-213.fc11.i686

Out of the box we get no sound and
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64
hda_codec: Unknown model for ALC662, trying auto-probe from BIOS...
ALSA sound/pci/hda/hda_codec.c:3507: autoconfig: line_outs=1 
(0x14/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3511: speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3515: hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3516: mono: mono_out=0x0
ALSA sound/pci/hda/hda_codec.c:3524: inputs: mic=0x18, fmic=0x19, 
line=0x1a, fline=0x0, cd=0x0, aux=0x0

But with /etc/modprobe.d/local.conf (from 
http://ubuntuforums.org/archive/index.php/t-940689.html)
options snd-hda-intel model=3stack-dig
options snd-hda-intel single_cmd=1
options snd-hda-intel enable_msi=1

we get sound and
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: irq 32 for MSI/MSI-X
HDA Intel 0000:00:1b.0: setting latency timer to 64
ALSA sound/pci/hda/hda_codec.c:2698: hda_codec: model '3stack-dig' is 
selected


I would like to have this fixed so Linux sound works on my friends 
machine without manual configuration.

After having read some documentation I assume that single_cmd and 
enable_msi perhaps shouldn't be needed. I will test that next time I get 
access to that machine.

HAL reports the sound card as 
/org/freedesktop/Hal/devices/pci_8086_293e, so should this patch be 
sufficient?

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e1563f4..0385353 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -16699,6 +16699,8 @@ static struct snd_pci_quirk alc662_cfg_tbl[] = {
                                         ALC662_3ST_6ch_DIG),
         SND_PCI_QUIRK_MASK(0x1854, 0xf000, 0x2000, "ASUS H13-200x",
                            ALC663_ASUS_H13),
+       SND_PCI_QUIRK(0x8086, 0x293e, "FUJITSU SIEMENS AMILO Li3710",
+                      ALC662_3ST_2ch_DIG),
         {}
  };

Untested and hard to test because I don't have direct access to the machine.

This issue was also reported on 
https://bugzilla.redhat.com/show_bug.cgi?id=487889

Please CC me.

/Mads
