From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC927x VREF fix
Date: Fri, 04 Jan 2008 21:58:38 -0500
Message-ID: <477EF25E.2040207@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040706010304040008030001"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by alsa0.perex.cz (Postfix) with SMTP id 7BA76244A1
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 03:58:40 +0100 (CET)
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
Cc: "Tellman, Steven" <Steven.Tellman@idt.com>, Jose_De_La_Rosa@Dell.com, Tim Gardner <tim.gardner@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040706010304040008030001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some laptops incorrectly assume the front input jack as a line in 
instead of a microphone in. Which in turn disables the voltage 
reference, in which non-amplified input is not possible.  This patch 
enables VREF80 for the input jack.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------040706010304040008030001
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac927x_vref.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac927x_vref.patch"

diff -r eeed28ed6b7d pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Jan 04 09:22:20 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Fri Jan 04 19:41:06 2008 -0700
@@ -3344,6 +3344,7 @@ static int patch_stac927x(struct hda_cod
 		spec->mixer = stac927x_mixer;
 		break;
 	case STAC_DELL_BIOS:
+		stac92xx_set_config_reg(codec, 0x0e, 0x02a79130);
 	case STAC_DELL_3ST:
 		/* GPIO2 High = Enable EAPD */
 		spec->gpio_mask = spec->gpio_data = 0x00000004;

--------------040706010304040008030001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040706010304040008030001--
