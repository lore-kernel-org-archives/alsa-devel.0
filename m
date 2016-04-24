From: "Conrad Kostecki" <ck@conrad-kostecki.de>
Subject: [PATCH] ALSA: intel_hda - Add dock support for
	ThinkPad X260
Date: Sun, 24 Apr 2016 01:48:21 +0000
Message-ID: <em7d1d6a23-64ae-4940-a3db-c26ad0f13c6b__33514.8888094865$1461651457$gmane$org@valkyrie>
Reply-To: Conrad Kostecki <ck@conrad-kostecki.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!
My shiny new ThinkPad X260 is the same way affected, as older ThinkPad 
(X*40, X*50) generations.
That means, I am unable to get sound output, when I am using the Lenovo 
CES 2013 docking station series (basic, pro, ultra).

It can be fixed the same way, as it was already done for X240 and X250, 
as the X260 uses the same docking connector.
I am attaching my patch, which works for me.

Cheers
Conrad

------------------------------

Fixes audio output on a ThinkPad X260, when using Lenovo CES 2013 
docking station series (basic, pro, ultra).

Signed-off-by: Conrad Kostecki <ck+linuxkernel@bl4ckb0x.de>

diff -uprN -X linux-4.6-rc4-vanilla/Documentation/dontdiff 
linux-4.6-rc4-vanilla/sound/pci/hda/patch_realtek.c 
linux-4.6-rc4/sound/pci/hda/patch_realtek.c
--- linux-4.6-rc4-vanilla/sound/pci/hda/patch_realtek.c 2016-04-24 
03:26:36.330983586 +0200
+++ linux-4.6-rc4/sound/pci/hda/patch_realtek.c 2016-04-24 
03:27:13.737981843 +0200
@@ -5570,6 +5570,7 @@ static const struct snd_pci_quirk alc269
         SND_PCI_QUIRK(0x17aa, 0x2218, "Thinkpad X1 Carbon 2nd", 
ALC292_FIXUP_TPT440_DOCK),
         SND_PCI_QUIRK(0x17aa, 0x2223, "ThinkPad T550", 
ALC292_FIXUP_TPT440_DOCK),
         SND_PCI_QUIRK(0x17aa, 0x2226, "ThinkPad X250", 
ALC292_FIXUP_TPT440_DOCK),
+       SND_PCI_QUIRK(0x17aa, 0x504a, "ThinkPad X260", 
ALC292_FIXUP_TPT440_DOCK),
         SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC292_FIXUP_TPT460),
         SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", 
ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
         SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", 
ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
------------------------------

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
