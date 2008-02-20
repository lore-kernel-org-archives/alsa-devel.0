From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC927x invalid association value
Date: Wed, 20 Feb 2008 17:07:17 -0500
Message-ID: <47BCA495.5050201@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175])
	by alsa0.perex.cz (Postfix) with SMTP id DF7FA1037FC
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 23:07:21 +0100 (CET)
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

STAC_DELL_BIOS quirks were setting the association value wrong for port 0x0f, which prevented it from
being included in hp_outs[].

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 30701aaf404c pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Feb 20 12:13:29 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Feb 20 15:01:35 2008 -0700
@@ -3630,7 +3630,7 @@ static int patch_stac927x(struct hda_cod
 		break;
 	case STAC_DELL_BIOS:
 		/* correct the front output jack as a hp out */
-		stac92xx_set_config_reg(codec, 0x0f, 0x02270110);
+		stac92xx_set_config_reg(codec, 0x0f, 0x0227011f);
 		/* correct the front input jack as a mic */
 		stac92xx_set_config_reg(codec, 0x0e, 0x02a79130);
 		/* fallthru */
