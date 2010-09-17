From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Two cleanup patches
Date: Fri, 17 Sep 2010 11:07:36 +0200
Message-ID: <4C932FD8.60305@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080203050801010400030502"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id F2BE3103926
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Sep 2010 11:07:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080203050801010400030502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It's just a boring day today.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080203050801010400030502
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-spelling-change-VOSTO-to-VOSTRO.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-spelling-change-VOSTO-to-VOSTRO.patch"

>From 3d7ac90d41fc609c03cfa59d7c58fde72f70af14 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 17 Sep 2010 10:52:50 +0200
Subject: [PATCH 1/2] ALSA: HDA: Fix spelling (change VOSTO to VOSTRO)

It was just a boring day.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7e22ed1..a12a9f6 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3075,7 +3075,7 @@ enum {
 	CXT5066_LAPTOP,		/* Laptops w/ EAPD support */
 	CXT5066_DELL_LAPTOP,	/* Dell Laptop */
 	CXT5066_OLPC_XO_1_5,	/* OLPC XO 1.5 */
-	CXT5066_DELL_VOSTO,	/* Dell Vostro 1015i */
+	CXT5066_DELL_VOSTRO,	/* Dell Vostro 1015i */
 	CXT5066_IDEAPAD,	/* Lenovo IdeaPad U150 */
 	CXT5066_THINKPAD,	/* Lenovo ThinkPad T410s, others? */
 	CXT5066_HP_LAPTOP,      /* HP Laptop */
@@ -3086,7 +3086,7 @@ static const char *cxt5066_models[CXT5066_MODELS] = {
 	[CXT5066_LAPTOP]	= "laptop",
 	[CXT5066_DELL_LAPTOP]	= "dell-laptop",
 	[CXT5066_OLPC_XO_1_5]	= "olpc-xo-1_5",
-	[CXT5066_DELL_VOSTO]    = "dell-vostro",
+	[CXT5066_DELL_VOSTRO]	= "dell-vostro",
 	[CXT5066_IDEAPAD]	= "ideapad",
 	[CXT5066_THINKPAD]	= "thinkpad",
 	[CXT5066_HP_LAPTOP]	= "hp-laptop",
@@ -3099,8 +3099,8 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 		      CXT5066_DELL_LAPTOP),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x1025, 0x040a, "Acer", CXT5066_IDEAPAD),
-	SND_PCI_QUIRK(0x1028, 0x02d8, "Dell Vostro", CXT5066_DELL_VOSTO),
-	SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTO),
+	SND_PCI_QUIRK(0x1028, 0x02d8, "Dell Vostro", CXT5066_DELL_VOSTRO),
+	SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x103c, 0x360b, "HP G60", CXT5066_HP_LAPTOP),
 	SND_PCI_QUIRK(0x1179, 0xff1e, "Toshiba Satellite C650D", CXT5066_IDEAPAD),
@@ -3207,7 +3207,7 @@ static int patch_cxt5066(struct hda_codec *codec)
 		spec->capture_prepare = cxt5066_olpc_capture_prepare;
 		spec->capture_cleanup = cxt5066_olpc_capture_cleanup;
 		break;
-	case CXT5066_DELL_VOSTO:
+	case CXT5066_DELL_VOSTRO:
 		codec->patch_ops.init = cxt5066_init;
 		codec->patch_ops.unsol_event = cxt5066_vostro_event;
 		spec->init_verbs[0] = cxt5066_init_verbs_vostro;
-- 
1.7.1


--------------080203050801010400030502
Content-Type: text/x-patch;
 name="0002-ALSA-HDA-Sort-CXT5066-quirk-table.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-ALSA-HDA-Sort-CXT5066-quirk-table.patch"

>From a35b415bd47fb1c597e037dc725cf4bb75f4f652 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 17 Sep 2010 10:58:03 +0200
Subject: [PATCH 2/2] ALSA: HDA: Sort CXT5066 quirk table

It was just a boring day.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a12a9f6..e501a85 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3093,19 +3093,19 @@ static const char *cxt5066_models[CXT5066_MODELS] = {
 };
 
 static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
-	SND_PCI_QUIRK(0x14f1, 0x0101, "Conexant Reference board",
-		      CXT5066_LAPTOP),
-	SND_PCI_QUIRK(0x1028, 0x02f5, "Dell",
-		      CXT5066_DELL_LAPTOP),
-	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x1025, 0x040a, "Acer", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1028, 0x02d8, "Dell Vostro", CXT5066_DELL_VOSTRO),
+	SND_PCI_QUIRK(0x1028, 0x02f5, "Dell",
+		      CXT5066_DELL_LAPTOP),
 	SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x103c, 0x360b, "HP G60", CXT5066_HP_LAPTOP),
 	SND_PCI_QUIRK(0x1179, 0xff1e, "Toshiba Satellite C650D", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1179, 0xff50, "Toshiba Satellite P500-PSPGSC-01800T", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x1179, 0xffe0, "Toshiba Satellite Pro T130-15F", CXT5066_OLPC_XO_1_5),
+	SND_PCI_QUIRK(0x14f1, 0x0101, "Conexant Reference board",
+		      CXT5066_LAPTOP),
+	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400s", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge 13 (197)", CXT5066_IDEAPAD),
-- 
1.7.1


--------------080203050801010400030502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080203050801010400030502--
