From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 28/38] ALSA: hda/realtek - Rewrite ALC880
	model=asus-w1v with auto-parser
Date: Fri, 24 Feb 2012 17:36:21 +0100
Message-ID: <1330101391-8788-29-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 68812104324
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AC7AA92BE9
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

ASUS W1V has a sane pin-config table set by BIOS.  The only missing piece
is the setup of GPIO1.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 71acd9b..510ca92 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4438,6 +4438,7 @@ static const struct hda_amp_list alc880_loopbacks[] = {
  * ALC880 fix-ups
  */
 enum {
+	ALC880_FIXUP_GPIO1,
 	ALC880_FIXUP_GPIO2,
 	ALC880_FIXUP_MEDION_RIM,
 	ALC880_FIXUP_LG,
@@ -4461,6 +4462,10 @@ static void alc880_fixup_vol_knob(struct hda_codec *codec,
 }
 
 static const struct alc_fixup alc880_fixups[] = {
+	[ALC880_FIXUP_GPIO1] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = alc_gpio1_init_verbs,
+	},
 	[ALC880_FIXUP_GPIO2] = {
 		.type = ALC_FIXUP_VERBS,
 		.v.verbs = alc_gpio2_init_verbs,
@@ -4602,6 +4607,7 @@ static const struct alc_fixup alc880_fixups[] = {
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P", ALC880_FIXUP_W810),
+	SND_PCI_QUIRK(0x1043, 0x10b3, "ASUS W1V", ALC880_FIXUP_GPIO1),
 	SND_PCI_QUIRK(0x1043, 0x1964, "ASUS Z71V", ALC880_FIXUP_Z71V),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo", ALC880_FIXUP_EAPD_COEF),
 	SND_PCI_QUIRK(0x1584, 0x9050, "Uniwill", ALC880_FIXUP_UNIWILL_DIG),
-- 
1.7.9
