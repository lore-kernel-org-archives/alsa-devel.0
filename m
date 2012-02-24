From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/38] ALSA: hda/realtek - Replace ALC880
	model=tcl with auto-parser
Date: Fri, 24 Feb 2012 17:36:13 +0100
Message-ID: <1330101391-8788-21-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 24375104318
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 79D6E915A2
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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

It needs a few extra setups for EAPD, but others look fairly
straightforward.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f8c362..e6eec9a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4407,6 +4407,7 @@ enum {
 	ALC880_FIXUP_LG,
 	ALC880_FIXUP_W810,
 	ALC880_FIXUP_EAPD_COEF,
+	ALC880_FIXUP_TCL_S700,
 };
 
 static const struct alc_fixup alc880_fixups[] = {
@@ -4453,6 +4454,17 @@ static const struct alc_fixup alc880_fixups[] = {
 			{}
 		},
 	},
+	[ALC880_FIXUP_TCL_S700] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* change to EAPD mode */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
+			{ 0x20, AC_VERB_SET_PROC_COEF,  0x3070 },
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_GPIO2,
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
@@ -4463,6 +4475,7 @@ static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1854, 0x003b, "LG", ALC880_FIXUP_LG),
 	SND_PCI_QUIRK(0x1854, 0x005f, "LG P1 Express", ALC880_FIXUP_LG),
 	SND_PCI_QUIRK(0x1854, 0x0068, "LG w1", ALC880_FIXUP_LG),
+	SND_PCI_QUIRK(0x19db, 0x4188, "TCL S700", ALC880_FIXUP_TCL_S700),
 	{}
 };
 
-- 
1.7.9
