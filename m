From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC927x analog mic
Date: Wed, 20 Feb 2008 21:49:59 -0500
Message-ID: <47BCE6D7.7000205@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216])
	by alsa0.perex.cz (Postfix) with SMTP id 860231037F9
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 03:50:02 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Some laptops have a internal analog microphone that is not setup by the BIOS.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 6b53fa114faa pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Feb 19 15:03:57 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Feb 20 17:11:51 2008 -0500
@@ -3629,6 +3629,8 @@ static int patch_stac927x(struct hda_cod
 		spec->mixer = stac927x_mixer;
 		break;
 	case STAC_DELL_BIOS:
+		/* configure the analog microphone on some laptops */
+		stac92xx_set_config_reg(codec, 0x0c, 0x90a79130);
 		/* correct the front output jack as a hp out */
 		stac92xx_set_config_reg(codec, 0x0f, 0x02270110);
 		/* correct the front input jack as a mic */
