From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC9228 DMIC
Date: Thu, 01 Nov 2007 16:51:00 -0400
Message-ID: <472A3C34.2080503@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050800070307020304070208"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.biz.mail.re2.yahoo.com (smtp110.biz.mail.re2.yahoo.com
	[206.190.53.9]) by alsa0.perex.cz (Postfix) with SMTP id 338352444E
	for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2007 21:50:59 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>, Tim Gardner <tim.gardner@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050800070307020304070208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added support for the dmics and enabled EAPD for several laptops with 
STAC9228 cards.
---
Signed-off-by:  Matthew Ranostay <mranostay@gmail.com>

--------------050800070307020304070208
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9228_eapd_dmic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9228_eapd_dmic.patch"

diff -r 808153682813 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Oct 26 15:10:15 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Thu Nov 01 15:46:17 2007 -0500
@@ -2778,14 +2778,21 @@ static int patch_stac927x(struct hda_cod
 		spec->dmic_nids = stac927x_dmic_nids;
 		spec->num_dmics = STAC927X_NUM_DMICS;
 		spec->dmux_nid = 0x1b;
+		
+		/* Enable DMIC0 */
+		stac92xx_set_config_reg(codec, 0x13, 0x90a60040);
+		
+		/* GPIO2 High = Enable EAPD */
+		spec->gpio_mask = spec->gpio_data = 0x00000004;
 		break;
 	default:
-		spec->num_dmics = 0;	
+		spec->num_dmics = 0;
+		
+		/* GPIO0 High = Enable EAPD */
+		spec->gpio_mask = spec->gpio_data = 0x00000001;
 	}
 
 	spec->multiout.dac_nids = spec->dac_nids;
-	/* GPIO0 High = Enable EAPD */
-	spec->gpio_mask = spec->gpio_data = 0x00000001;
 	stac92xx_enable_gpio_mask(codec); 
 	
 	err = stac92xx_parse_auto_config(codec, 0x1e, 0x20);

--------------050800070307020304070208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050800070307020304070208--
