From: Conrad Kostecki <ck@conrad-kostecki.de>
Subject: [PATCH] ALSA: intel_hda - Add dock support for
	ThinkPad T460s
Date: Tue, 26 Apr 2016 12:10:22 +0200 (CEST)
Message-ID: <1726340993.4634.1461665422210__31069.7827874266$1461665467$gmane$org@office.mailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
The new ThinkPad T460s is the same way affected, as other current ThinkPads (e.G. X260) generations.
That means, you won't be able to get sound output, when using the Lenovo
CES 2013 docking station series (basic, pro, ultra).

It can be fixed the same way, as it was already done for X260,
as the T460s uses the same docking connector.
I am attaching a patch, which works for me.

Cheers
Conrad

------------------------------

Fixes audio output on a ThinkPad T460s, when using Lenovo CES 2013
docking station series (basic, pro, ultra).

Signed-off-by: Conrad Kostecki <ck+linuxkernel@bl4ckb0x.de>

--- linux-4.6-rc5-vanilla/sound/pci/hda/patch_realtek.c 2016-04-26 11:32:09.124832372 +0200
+++ linux-4.6-rc5/sound/pci/hda/patch_realtek.c 2016-04-26 11:32:52.123834807 +0200
@@ -5585,6 +5585,7 @@ static const struct snd_pci_quirk alc269
        SND_PCI_QUIRK(0x17aa, 0x5036, "Thinkpad T450s", ALC292_FIXUP_TPT440_DOCK),
        SND_PCI_QUIRK(0x17aa, 0x503c, "Thinkpad L450", ALC292_FIXUP_TPT440_DOCK),
        SND_PCI_QUIRK(0x17aa, 0x504b, "Thinkpad", ALC293_FIXUP_LENOVO_SPK_NOISE),
+       SND_PCI_QUIRK(0x17aa, 0x5050, "Thinkpad T460p", ALC292_FIXUP_TPT440_DOCK),
        SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
        SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
        SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),


------------------------------
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
