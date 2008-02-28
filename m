From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: incorrect DAC mixer on 92hd71bxxx
Date: Thu, 28 Feb 2008 17:03:36 -0500
Message-ID: <47C72FB8.2070900@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.mud.yahoo.com (smtp102.biz.mail.mud.yahoo.com
	[68.142.200.237]) by alsa0.perex.cz (Postfix) with SMTP id C2EB7245D7
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 23:03:57 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

If there was two line_outs[] it would overrun into the dmic nid struct below
and create a phantom "Surround" mixer.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 54a51b975975 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Feb 28 12:46:32 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Feb 28 16:52:43 2008 -0500
@@ -246,8 +246,8 @@ static hda_nid_t stac92hd71bxx_dmux_nids
 	0x1c,
 };
 
-static hda_nid_t stac92hd71bxx_dac_nids[1] = {
-	0x10, /*0x11, */
+static hda_nid_t stac92hd71bxx_dac_nids[2] = {
+	0x10, 0x11
 };
 
 #define STAC92HD71BXX_NUM_DMICS	2
@@ -2345,10 +2345,10 @@ static int stac92xx_auto_create_multi_ou
 
 
 	for (i = 0; i < cfg->line_outs; i++) {
-		if (!spec->multiout.dac_nids[i])
+		
+		nid = spec->multiout.dac_nids[i];
+		if (!nid || nid == spec->multiout.hp_nid)
 			continue;
-
-		nid = spec->multiout.dac_nids[i];
 
 		if (i == 2) {
 			/* Center/LFE */
@@ -3550,7 +3550,7 @@ again:
 	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
 	spec->pwr_nids = stac92hd71bxx_pwr_nids;
 
-	spec->multiout.num_dacs = 1;
+	spec->multiout.num_dacs = ARRAY_SIZE(stac92hd71bxx_dac_nids);
 	spec->multiout.hp_nid = 0x11;
 	spec->multiout.dac_nids = stac92hd71bxx_dac_nids;
