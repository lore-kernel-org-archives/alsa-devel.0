From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add internal mic for IDT 92HD88B
Date: Tue, 04 Jan 2011 06:57:27 +0100
Message-ID: <4D22B6C7.3060806@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050904050906070104050107"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id BFEAD1038C5
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 06:57:30 +0100 (CET)
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
--------------050904050906070104050107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BugLink: http://bugs.launchpad.net/bugs/696493

According to datasheet (and real-world testing), IDT 92HD88B can
have internal mics at NID 0x11 and 0x20, so enable them accordingly.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------050904050906070104050107
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-internal-mic-for-IDT-92HD88B.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Add-internal-mic-for-IDT-92HD88B.patch"

>From 4fdc8bb0ab1e786821003cb448559efea9d5081a Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 4 Jan 2011 06:30:53 +0100
Subject: [PATCH] ALSA: HDA: Add internal mic for IDT 92HD88B

BugLink: http://bugs.launchpad.net/bugs/696493

According to datasheet (and real-world testing), IDT 92HD88B can
have internal mics at NID 0x11 and 0x20, so enable them accordingly.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 6131a92..c8d812e 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -389,6 +389,9 @@ static hda_nid_t stac92hd83xxx_dmic_nids[STAC92HD83XXX_NUM_DMICS + 1] = {
 	0x11, 0x20, 0
 };
 
+#define STAC92HD88XXX_NUM_DMICS	STAC92HD83XXX_NUM_DMICS
+#define stac92hd88xxx_dmic_nids	stac92hd83xxx_dmic_nids
+
 #define STAC92HD87B_NUM_DMICS	 1
 static hda_nid_t stac92hd87b_dmic_nids[STAC92HD87B_NUM_DMICS + 1] = {
 	0x11, 0
@@ -5462,11 +5465,18 @@ again:
 		spec->num_dmics = stac92xx_connected_ports(codec,
 				stac92hd87b_dmic_nids,
 				STAC92HD87B_NUM_DMICS);
-		/* Fall through */
+		spec->num_pins = ARRAY_SIZE(stac92hd88xxx_pin_nids);
+		spec->pin_nids = stac92hd88xxx_pin_nids;
+		spec->mono_nid = 0;
+		spec->num_pwrs = 0;
+		break;
 	case 0x111d7666:
 	case 0x111d7667:
 	case 0x111d7668:
 	case 0x111d7669:
+		spec->num_dmics = stac92xx_connected_ports(codec,
+				stac92hd88xxx_dmic_nids,
+				STAC92HD88XXX_NUM_DMICS);
 		spec->num_pins = ARRAY_SIZE(stac92hd88xxx_pin_nids);
 		spec->pin_nids = stac92hd88xxx_pin_nids;
 		spec->mono_nid = 0;
-- 
1.7.1


--------------050904050906070104050107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050904050906070104050107--
