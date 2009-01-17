From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: [PATCH] serato phono patch
Date: Sat, 17 Jan 2009 17:01:51 +0100
Message-ID: <497200EF.5010006@gmx.net>
References: <20090112175416.482cdc60.krzysztof.h1@poczta.fm>	<s5h63kkbgro.wl%tiwai@suse.de>	<496B94EA.8080109@gmx.net>
	<s5hbpub3cex.wl%tiwai@suse.de> <4971FFDE.8070609@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020108080609070208030604"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 5217524343
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 17:01:53 +0100 (CET)
In-Reply-To: <4971FFDE.8070609@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020108080609070208030604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> Could you give a more detailed patch description?
Yes, I should have splitted them into single patches in the first place.
So attached is the first one (including description ;)).



--------------020108080609070208030604
Content-Type: text/plain;
 name="commit-00092c5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="commit-00092c5"

commit 00092c5912ba7eb162599686388a2cac5c72c262
Author: LCID Fire <lcid-fire@gmx.net>
Date:   Sat Jan 17 16:47:06 2009 +0100

    Ignore errors (wrong usb interface data) found when using the serato scratch live box with alsa
    Thus the alsa controls can be accessed (beware: they don't work though - but at least it's one ugly error message less)
    
    Signed-off-by: LCID Fire <lcid-fire@gmx.net>

diff --git a/sound/usb/usbmixer_maps.c b/sound/usb/usbmixer_maps.c
index d755be0..87054af 100644
--- a/sound/usb/usbmixer_maps.c
+++ b/sound/usb/usbmixer_maps.c
@@ -261,6 +261,22 @@ static struct usbmix_name_map aureon_51_2_map[] = {
 	{} /* terminator */
 };
 
+static struct usbmix_name_map scratch_live_map[] = {
+	/* 1: IT Line 1 (USB streaming) */
+	/* 2: OT Line 1 (Speaker) */
+	/* 3: IT Line 1 (Line connector) */
+	{ 4, "Line 1 In" }, /* FU */
+	/* 5: OT Line 1 (USB streaming) */
+	/* 6: IT Line 2 (USB streaming) */
+	/* 7: OT Line 2 (Speaker) */
+	/* 8: IT Line 2 (Line connector) */
+	{ 9, "Line 2 In" }, /* FU */
+	/* 10: OT Line 2 (USB streaming) */
+	/* 11: IT Mic (Line connector) */
+	/* 12: OT Mic (USB streaming) */
+	{ 0 } /* terminator */
+};
+
 /*
  * Control map entries
  */
@@ -311,6 +327,11 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x0ccd, 0x0028),
 		.map = aureon_51_2_map,
 	},
+	{
+		.id = USB_ID(0x13e5, 0x0001),
+		.map = scratch_live_map,
+		.ignore_ctl_error = 1,
+	},
 	{ 0 } /* terminator */
 };
 

--------------020108080609070208030604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020108080609070208030604--
