From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix automute for Gateway NV79
Date: Fri, 29 Apr 2011 14:17:46 +0200
Message-ID: <4DBAAC6A.2020904@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080108060303000102000501"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C316103A03
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 14:17:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080108060303000102000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The PCI SSID is 1025:031c and the codec SSID is 1025:031d,
so the driver mistakes this for a SKU value, but looking at
the numbers, this is obviously wrong.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080108060303000102000501
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-automute-for-Gateway-NV79.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Fix-automute-for-Gateway-NV79.patch"

>From a57dcea812c629ff341f48b531454557499de008 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 29 Apr 2011 14:10:55 +0200
Subject: [PATCH] ALSA: HDA: Fix automute for Gateway NV79

The PCI SSID is 1025:031c and the codec SSID is 1025:031d,
so the driver mistakes this for a SKU value, but looking at
the numbers, this is obviously wrong.

Cc: stable@kernel.org (2.6.38+)
BugLink: http://bugs.launchpad.net/bugs/761861
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6c94c4a..35efee6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -19486,6 +19486,7 @@ enum {
 	ALC272_FIXUP_MARIO,
 	ALC662_FIXUP_CZC_P10T,
 	ALC662_FIXUP_GIGABYTE,
+	ALC662_FIXUP_SKU_IGNORE,
 };
 
 static const struct alc_fixup alc662_fixups[] = {
@@ -19521,10 +19522,15 @@ static const struct alc_fixup alc662_fixups[] = {
 			{ }
 		}
 	},
+	[ALC662_FIXUP_SKU_IGNORE] = {
+		.type = ALC_FIXUP_SKU,
+		.v.sku = ALC_FIXUP_SKU_IGNORE,
+	},
 };
 
 static struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0308, "Acer Aspire 8942G", ALC662_FIXUP_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x031c, "Gateway NV79", ALC662_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
 	SND_PCI_QUIRK(0x144d, 0xc051, "Samsung R720", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte", ALC662_FIXUP_GIGABYTE),
-- 
1.7.4.1


--------------080108060303000102000501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080108060303000102000501--
