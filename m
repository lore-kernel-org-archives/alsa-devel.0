From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Enable digital mic on IDT 92HD87B
Date: Tue, 09 Nov 2010 17:10:25 +0100
Message-ID: <4CD97271.6040709@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060701030507010507040605"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DCD1244A4
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 17:10:24 +0100 (CET)
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
--------------060701030507010507040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BugLink: http://launchpad.net/bugs/673075

According to the datasheet of 92HD87B, there is a digital mic
at nid 0x11, so enable it in order to be able to use the mic.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------060701030507010507040605
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Enable-digital-mic-on-IDT-92HD87B.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Enable-digital-mic-on-IDT-92HD87B.patch"

>From e6e70a42ef60fd81f8dcd1a87479ce9d6f6a0846 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 13 Oct 2010 15:48:24 +0200
Subject: [PATCH] ALSA: HDA: Enable digital mic on IDT 92HD87B

BugLink: http://launchpad.net/bugs/673075

According to the datasheet of 92HD87B, there is a digital mic
at nid 0x11, so enable it in order to be able to use the mic.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda/patch_sigmatel.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hda/patch_sigmatel.c b/hda/patch_sigmatel.c
index 0144519..6764100 100644
--- a/hda/patch_sigmatel.c
+++ b/hda/patch_sigmatel.c
@@ -388,6 +388,11 @@ static hda_nid_t stac92hd83xxx_dmic_nids[STAC92HD83XXX_NUM_DMICS + 1] = {
 	0x11, 0x20, 0
 };
 
+#define STAC92HD87B_NUM_DMICS	 1
+static hda_nid_t stac92hd87b_dmic_nids[STAC92HD87B_NUM_DMICS + 1] = {
+	0x11, 0
+};
+
 #define STAC92HD83XXX_NUM_CAPS	2
 static unsigned long stac92hd83xxx_capvols[] = {
 	HDA_COMPOSE_AMP_VAL(0x17, 3, 0, HDA_OUTPUT),
@@ -5370,12 +5375,17 @@ again:
 				stac92hd83xxx_brd_tbl[spec->board_config]);
 
 	switch (codec->vendor_id) {
+	case 0x111d76d1:
+	case 0x111d76d9:
+		spec->dmic_nids = stac92hd87b_dmic_nids;
+		spec->num_dmics = stac92xx_connected_ports(codec,
+				stac92hd87b_dmic_nids,
+				STAC92HD87B_NUM_DMICS);		
+		/* Fall through */
 	case 0x111d7666:
 	case 0x111d7667:
 	case 0x111d7668:
 	case 0x111d7669:
-	case 0x111d76d1:
-	case 0x111d76d9:
 		spec->num_pins = ARRAY_SIZE(stac92hd88xxx_pin_nids);
 		spec->pin_nids = stac92hd88xxx_pin_nids;
 		spec->mono_nid = 0;
-- 
1.7.1


--------------060701030507010507040605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060701030507010507040605--
