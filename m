From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ALSA: hda - Fix EAPD to low on CZC P10T tablet
 computer with ALC662
Date: Thu, 20 Jan 2011 12:36:21 +0100
Message-ID: <20110120123621.0833a7c4@destiny.ordissimo>
References: <20110119182448.2c8dbf28@destiny.ordissimo>
	<4D37FB6B.9040701@canonical.com> <s5hzkqvkj2s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 42DC6103A2B
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 12:36:49 +0100 (CET)
Received: by wyi11 with SMTP id 11so481745wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 03:36:49 -0800 (PST)
In-Reply-To: <s5hzkqvkj2s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi Takashi, David,

Thanks for you feedback.
This patch is on top of sound-2.6/for-next branch.

Regards,
Anisse
---
 sound/pci/hda/patch_realtek.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d59d1db..43b2bcd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -19568,6 +19568,7 @@ enum {
 	ALC662_FIXUP_ASPIRE,
 	ALC662_FIXUP_IDEAPAD,
 	ALC272_FIXUP_MARIO,
+	ALC662_FIXUP_CZC_P10T,
 };
 
 static const struct alc_fixup alc662_fixups[] = {
@@ -19588,7 +19589,14 @@ static const struct alc_fixup alc662_fixups[] = {
 	[ALC272_FIXUP_MARIO] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc272_fixup_mario,
-	}
+	},
+	[ALC662_FIXUP_CZC_P10T] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{0x14, AC_VERB_SET_EAPD_BTLENABLE, 0},
+			{}
+		}
+	},
 };
 
 static struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -19596,6 +19604,7 @@ static struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc051, "Samsung R720", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
+	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
 	{}
 };
 
-- 
1.7.3.2
