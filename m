From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Correct SPDIF out default config
Date: Fri, 11 Apr 2008 16:16:08 -0400
Message-ID: <47FFC708.1050908@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by alsa0.perex.cz (Postfix) with SMTP id 53F692453E
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Apr 2008 22:16:18 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>, Mario_Limonciello@Dell.com
List-Id: alsa-devel@alsa-project.org

Several laptops have have the SPDIF out defined as 'Digital other out'
when it should be 'SPDIF out' in the default config.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 0dd2b6cb1506 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Apr 09 08:16:33 2008 +0200
+++ b/pci/hda/patch_sigmatel.c	Fri Apr 11 16:02:57 2008 -0400
@@ -3778,6 +3778,13 @@ static int patch_stac927x(struct hda_cod
 		spec->mixer = stac927x_mixer;
 		break;
 	case STAC_DELL_BIOS:
+		switch (codec->subsystem_id) {
+		case 0x10280209:
+		case 0x1028022e:
+			/* correct the device field to SPDIF out */
+			stac92xx_set_config_reg(codec, 0x21, 0x01442070);
+			break;
+		};
 		/* configure the analog microphone on some laptops */
 		stac92xx_set_config_reg(codec, 0x0c, 0x90a79130);
 		/* correct the front output jack as a hp out */
