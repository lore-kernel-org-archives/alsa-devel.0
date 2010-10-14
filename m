From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: HDA: Apply SKU override for Acer
	aspire 7736z
Date: Thu, 14 Oct 2010 15:53:29 +0200
Message-ID: <4CB70B59.5070500@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010108070807070605080900"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A1BF103876
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 15:53:32 +0200 (CEST)
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
--------------010108070807070605080900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BugLink: http://launchpad.net/bugs/617647

The current SKU value disables playback, so ignore the SKU value.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010108070807070605080900
Content-Type: text/x-patch;
 name="0002-ALSA-HDA-Apply-SKU-override-for-Acer-aspire-7736z.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ALSA-HDA-Apply-SKU-override-for-Acer-aspire-7736z.patch"

>From cebe004745a54b5dec1cdfa2f8ce9708c301941a Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 14 Oct 2010 15:42:08 +0200
Subject: [PATCH 2/2] ALSA: HDA: Apply SKU override for Acer aspire 7736z

BugLink: http://launchpad.net/bugs/617647

The current SKU value disables playback, so ignore the SKU value.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f826bad..1c82c59 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10627,6 +10627,7 @@ static struct alc_config_preset alc882_presets[] = {
 enum {
 	PINFIX_ABIT_AW9D_MAX,
 	PINFIX_PB_M5210,
+	PINFIX_ACER_ASPIRE_7736,
 };
 
 static const struct alc_fixup alc882_fixups[] = {
@@ -10644,11 +10645,15 @@ static const struct alc_fixup alc882_fixups[] = {
 			{}
 		}
 	},
+	[PINFIX_ACER_ASPIRE_7736] = {
+		.sku = ALC_FIXUP_SKU_IGNORE,
+	},
 };
 
 static struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0155, "Packard-Bell M5120", PINFIX_PB_M5210),
 	SND_PCI_QUIRK(0x147b, 0x107a, "Abit AW9D-MAX", PINFIX_ABIT_AW9D_MAX),
+	SND_PCI_QUIRK(0x1025, 0x0296, "Acer Aspire 7736z", PINFIX_ACER_ASPIRE_7736),
 	{}
 };
 
-- 
1.7.1


--------------010108070807070605080900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010108070807070605080900--
