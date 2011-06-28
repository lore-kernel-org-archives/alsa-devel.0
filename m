From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Acer aspire 3830TG and Conexant 506c/20588
Date: Tue, 28 Jun 2011 12:44:19 +0100
Message-ID: <4E09BE93.8060503@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000100060101070007060501"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id ECE1A245C5
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 13:44:22 +0200 (CEST)
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
--------------000100060101070007060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The new Conexant 5066 auto-parser is barely finished and already we 
might need a quirk system for it...

Anyway, in this bug, the internal speaker is not working (and was not 
working before the auto-parser either). I'm attaching two patches that 
are quite simple, and at least the first one (add ID 506c) I think 
should be applied right away.

The problem: The internal speaker is at node 0x1f and you need to turn 
on EAPD on node 0x1b for the speaker to sound. Now I'm not sure how to 
fix this in the best way. An "init verb" quirk, or a "use EAPD from this 
pin" quirk? Try to copy-paste realtek's quirk system, and if so, 
refactor it into hda_codec.c, or write something new?

What are your ideas?

Alsa-info reference: https://launchpadlibrarian.net/73966502/alsa-info
Bug reference: 
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/783582

-- 
David Henningsson
http://launchpad.net/~diwic

--------------000100060101070007060501
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-a-new-Conexant-codec-ID-506c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Add-a-new-Conexant-codec-ID-506c.patch"

>From 69bb710e13ae842d77d584a75088e008834a1722 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 21 Jun 2011 20:51:34 +0200
Subject: [PATCH 1/2] ALSA: HDA: Add a new Conexant codec ID (506c)

Conexant ID 506c was found on Acer Aspire 3830TG. As users report
no playback, sending to stable should be safe.

Cc: stable@kernel.org
BugLink: https://bugs.launchpad.net/bugs/783582
Reported-by: andROOM
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 6e86427..6c9b742 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -4390,6 +4390,8 @@ static const struct hda_codec_preset snd_hda_preset_conexant[] = {
 	  .patch = patch_cxt5066 },
 	{ .id = 0x14f15069, .name = "CX20585",
 	  .patch = patch_cxt5066 },
+	{ .id = 0x14f1506c, .name = "CX20588",
+	  .patch = patch_cxt5066 },
 	{ .id = 0x14f1506e, .name = "CX20590",
 	  .patch = patch_cxt5066 },
 	{ .id = 0x14f15097, .name = "CX20631",
@@ -4418,6 +4420,7 @@ MODULE_ALIAS("snd-hda-codec-id:14f15066");
 MODULE_ALIAS("snd-hda-codec-id:14f15067");
 MODULE_ALIAS("snd-hda-codec-id:14f15068");
 MODULE_ALIAS("snd-hda-codec-id:14f15069");
+MODULE_ALIAS("snd-hda-codec-id:14f1506c");
 MODULE_ALIAS("snd-hda-codec-id:14f1506e");
 MODULE_ALIAS("snd-hda-codec-id:14f15097");
 MODULE_ALIAS("snd-hda-codec-id:14f15098");
-- 
1.7.4.1


--------------000100060101070007060501
Content-Type: text/x-patch;
 name="0002-ALSA-HDA-Add-model-auto-quirk-for-Acer-Aspire-3830TG.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ALSA-HDA-Add-model-auto-quirk-for-Acer-Aspire-3830TG.pa";
 filename*1="tch"

>From 9505d48fb556f977c5247c9564481301de39b258 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 21 Jun 2011 21:01:52 +0200
Subject: [PATCH 2/2] ALSA: HDA: Add model=auto quirk for Acer Aspire 3830TG

Since we're not using the new auto parser as a fallback yet,
add it manually as a quirk.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 6c9b742..91c8c0c 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3075,6 +3075,7 @@ static const char * const cxt5066_models[CXT5066_MODELS] = {
 };
 
 static const struct snd_pci_quirk cxt5066_cfg_tbl[] = {
+	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT5066_AUTO),
 	SND_PCI_QUIRK_MASK(0x1025, 0xff00, 0x0400, "Acer", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1028, 0x02d8, "Dell Vostro", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x02f5, "Dell Vostro 320", CXT5066_IDEAPAD),
-- 
1.7.4.1


--------------000100060101070007060501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000100060101070007060501--
