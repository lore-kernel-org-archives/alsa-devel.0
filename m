From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add fixup pins for Ideapad Y550
Date: Thu, 09 Sep 2010 09:04:10 +0200
Message-ID: <4C8886EA.1080103@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090907070406080900090002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CA19103801
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 09:04:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090907070406080900090002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

By adding the subwoofer as a speaker pin, it is treated correctly when 
auto-muting. I'm a little unsure of whether it should go to stable as 
well, because it needs yesterday's commit bb35febd to make sense (in 
fact, I developed parts of that patch in parallel). Any opinions?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090907070406080900090002
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-fixup-pins-for-Ideapad-Y550.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Add-fixup-pins-for-Ideapad-Y550.patch"

>From 906cfc95288d8ee4b1995a736e4e780e9f434cd0 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 9 Sep 2010 08:51:44 +0200
Subject: [PATCH] ALSA: HDA: Add fixup pins for Ideapad Y550

By adding the subwoofer as a speaker pin, it is treated correctly when auto-muting.

BugLink: https://launchpad.net/bugs/611803
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f11a9ca..0c25d22 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -18963,6 +18963,26 @@ static void alc662_auto_init(struct hda_codec *codec)
 		alc_inithook(codec);
 }
 
+enum {
+	ALC662_FIXUP_IDEAPAD,
+};
+
+static const struct alc_fixup alc662_fixups[] = {
+	[ALC662_FIXUP_IDEAPAD] = {
+		.pins = (const struct alc_pincfg[]) {
+			{ 0x17, 0x99130112 }, /* subwoofer */
+			{ }
+		}
+	},
+};
+
+static struct snd_pci_quirk alc662_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
+	{}
+};
+
+
+
 static int patch_alc662(struct hda_codec *codec)
 {
 	struct alc_spec *spec;
@@ -18995,6 +19015,7 @@ static int patch_alc662(struct hda_codec *codec)
 	}
 
 	if (board_config == ALC662_AUTO) {
+		alc_pick_fixup(codec, alc662_fixup_tbl, alc662_fixups, 1);
 		/* automatic parse from the BIOS config */
 		err = alc662_parse_auto_config(codec);
 		if (err < 0) {
@@ -19053,8 +19074,11 @@ static int patch_alc662(struct hda_codec *codec)
 	spec->vmaster_nid = 0x02;
 
 	codec->patch_ops = alc_patch_ops;
-	if (board_config == ALC662_AUTO)
+	if (board_config == ALC662_AUTO) {
 		spec->init_hook = alc662_auto_init;
+		alc_pick_fixup(codec, alc662_fixup_tbl, alc662_fixups, 0);
+	}
+
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	if (!spec->loopback.amplist)
 		spec->loopback.amplist = alc662_loopbacks;
-- 
1.7.1


--------------090907070406080900090002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090907070406080900090002--
