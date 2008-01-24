From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC9205 GPIO line fix
Date: Thu, 24 Jan 2008 09:15:49 -0500
Message-ID: <47989D95.2040705@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.biz.mail.mud.yahoo.com (smtp103.biz.mail.mud.yahoo.com
	[68.142.200.238])
	by alsa0.perex.cz (Postfix) with SMTP id 011761038B2
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 15:15:56 +0100 (CET)
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

Fixed issue that the incorrect GPIO line was being pulled high for some STAC9205 based laptops.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 32b13f326915 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Jan 24 11:49:21 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Jan 24 09:08:23 2008 -0500
@@ -3661,11 +3661,11 @@ static int patch_stac9205(struct hda_cod
 		stac92xx_set_config_reg(codec, 0x1f, 0x01441030);
 		stac92xx_set_config_reg(codec, 0x20, 0x1c410030);
 
-		spec->gpio_mask = 0x00000007; /* GPIO0-2 */
-		/* GPIO0 High = EAPD, GPIO1 Low = DRM,
-		 * GPIO2 High = Headphone Mute
+		spec->gpio_mask = 0x0000000b;
+		/* GPIO0 High = EAPD, GPIO1 Low = Headphone Mute,
+		 * GPIO3 High = DRM
 		 */
-		spec->gpio_data = 0x00000005;
+		spec->gpio_data = 0x00000009;
 		break;
 	default:
 		/* GPIO0 High = EAPD */
