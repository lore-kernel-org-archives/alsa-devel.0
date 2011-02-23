From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: HDA: Add a new Conexant codec 506e
	(20590)
Date: Wed, 23 Feb 2011 13:22:39 +0100
Message-ID: <4D64FC0F.6090002@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020500020206030309030703"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 96C71103800
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 13:22:42 +0100 (CET)
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
--------------020500020206030309030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm a little hesitant as of whether to send this one to stable or not, 
as the fallback of the 5066 parser can perform worse than the generic 
one. However, if we don't, we can't quirk them to work perfectly later. 
What do you think?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------020500020206030309030703
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-a-new-Conexant-codec-506e-20590.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Add-a-new-Conexant-codec-506e-20590.patch"

>From 7ba625cf57f80e124024fd46a1bfe1fb8f9c1558 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 8 Feb 2011 07:16:06 +0100
Subject: [PATCH 1/2] ALSA: HDA: Add a new Conexant codec 506e (20590)

Conexant 506e/20590 has the same graph as the rest of the 5066 family.

BugLink: http://bugs.launchpad.net/bugs/723672

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index dd7c5c1..909ce9e 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3937,6 +3937,8 @@ static struct hda_codec_preset snd_hda_preset_conexant[] = {
 	  .patch = patch_cxt5066 },
 	{ .id = 0x14f15069, .name = "CX20585",
 	  .patch = patch_cxt5066 },
+	{ .id = 0x14f1506e, .name = "CX20590",
+	  .patch = patch_cxt5066 },
 	{ .id = 0x14f15097, .name = "CX20631",
 	  .patch = patch_conexant_auto },
 	{ .id = 0x14f15098, .name = "CX20632",
@@ -3963,6 +3965,7 @@ MODULE_ALIAS("snd-hda-codec-id:14f15066");
 MODULE_ALIAS("snd-hda-codec-id:14f15067");
 MODULE_ALIAS("snd-hda-codec-id:14f15068");
 MODULE_ALIAS("snd-hda-codec-id:14f15069");
+MODULE_ALIAS("snd-hda-codec-id:14f1506e");
 MODULE_ALIAS("snd-hda-codec-id:14f15097");
 MODULE_ALIAS("snd-hda-codec-id:14f15098");
 MODULE_ALIAS("snd-hda-codec-id:14f150a1");
-- 
1.7.1


--------------020500020206030309030703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020500020206030309030703--
