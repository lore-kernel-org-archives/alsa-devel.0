From: Jurica Vukadin <jurica.vukadin@rt-rk.com>
Subject: [PATCH] ALSA: hda - Add quirk for HP EliteBook 840 G5
Date: Thu,  7 Feb 2019 16:29:37 +0100
Message-ID: <20190207152938.3596-1-jurica.vukadin@rt-rk.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jurica Vukadin <jurica.vukadin@rt-rk.com>, Jaroslav Kysela <perex@perex.cz>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Park Ju Hyung <qkrwngud825@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This enables mute LED support and fixes switching jacks when the laptop
is docked.

Signed-off-by: Jurica Vukadin <jurica.vukadin@rt-rk.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexan=
t.c
index 152f54137082..a4ee7656d9ee 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -924,6 +924,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] =3D=
 {
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK)=
,
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK)=
,
+	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK)=
,
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK)=
,
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
--=20
2.20.1
